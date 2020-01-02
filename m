Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497F9C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135DA20848
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="x3/hkxx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135DA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in2OH-0003pU-5Z
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1in2Na-0003Jh-AW
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1in2NY-00071I-UO
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:27:18 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:26918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>)
 id 1in2NV-0006yF-0b; Thu, 02 Jan 2020 10:27:13 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 002FQRYJ030007; Thu, 2 Jan 2020 07:27:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=s3AlU2yaU0MQnLKBuDvY/IDOhYYl2jQM831pucjeTsw=;
 b=x3/hkxx//qfyV5DH+wfuz+tLcfhnVBFpWF6jWF88jTioWTPlyK62A78oVkpKpih83Ed5
 c4/tbsbj4b1bChe5A2OR7xM0slAzs6sTgw8vujCIqkn9VEo/RFNgb/xBqpBmjuLzlEfk
 P8BY5ZcMpcjqUjnplmYz2dYH0/OHuX+AD0brvUDS1atCXWhSJgwoaQNPwCjPeS/OE5Fn
 j28clXMeWDQa+3roUqV0dRO6gTPEezQVrq9oUdcFFN1gtNHq42na2xGWNwtcsLIEuKsW
 uosN3F1zDak7TIWbRrN4cx7AGRe3wGiYpou2NxuV0o5rWo9lEvo5Hgs1WApFMXRlyMld iQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2x65fffnup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jan 2020 07:27:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRsnz/iZ4ciwRq2iNDL2zvjHOQp86+yOKugnktBxyj7caIjixbRPyae3gNUPCcLRtoOsu+IwTV9ALBEchd12fK7+uvvIpZJl5V8cC3oUY0a43/XCuEbWBlsUuTZsfuLpT9Vhgg6RAh+wVx3Fgl77AXi84z7TmRQK2s4Yk3hgdTffAZ4L4RbzEPr5kALs51vYStH96fJZ0e1nlFIYWaa4oaV7+XagehziKeo0eGKWie4G+C0No65xpweP1OTUQi1uUluykYGa9qOffVve1zf0CMdca34DLHH2nhtPpsyqbDzS3nHogapZX/sjPumfmAlzwPO4tEirtbO8yvXBwt1p5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3AlU2yaU0MQnLKBuDvY/IDOhYYl2jQM831pucjeTsw=;
 b=A64+UOvDMR35t+oR+XuShULqJBsyuZZe4ADFoWHtUKgLjHimzsVniuEbtBKx2ICAC12N7C/oQJT4hIGHncs7HhER3bUPTzuXwefhncQk8sHxtg+WBYMsYBEpqKenpnJdvuybhxYqlicKQcGqKt0OZjw6QaOO0pzQxo7LgHVznKIwLEfqB/t6UlORH2Zro/9geCisouXKAY0D3Oo2h8RQAZo+YQwJcRAj93UdRLNQsxPb+jhU+CV4dUYQsQi+fkggBxB5hNwVMq0gZSQKI1eBRr6Ij5pmkJMx0BABwVEs+HHvEeJ0Cy/bA1GsEzg99yi3Gfc+eYm9nC9o68JtqO430A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 2 Jan 2020 15:27:07 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c8f8:4820:a24c:3029%10]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 15:27:07 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?B?5byg5rW35paM?=
 <xtay.haibin@gmail.com>
Subject: Re: How to impove downtime of Live-Migration caused bdrv_drain_all()
Thread-Topic: How to impove downtime of Live-Migration caused bdrv_drain_all()
Thread-Index: AQHVu++NXTU6c/qbBk24i/GfEphW8afXhOmAgAAFZgA=
Date: Thu, 2 Jan 2020 15:27:07 +0000
Message-ID: <32BA0B57-4A2F-4C07-AAF5-466688B74249@nutanix.com>
References: <CAP0gKjUf4+Jf2GSZy8u5fwQAU2V9bk-viuSBByB5bo78NWHpbQ@mail.gmail.com>
 <20190328170759.GH18536@stefanha-x1.localdomain>
 <CAP0gKjVqMEKF2gq4Xq8hX=zo-cM3vw2Xw70pajfQOvFj4-wvbA@mail.gmail.com>
 <20200102150747.GO121208@stefanha-x1.localdomain>
In-Reply-To: <20200102150747.GO121208@stefanha-x1.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a49b5cb-e00f-4812-5729-08d78f983a84
x-ms-traffictypediagnostic: MWHPR02MB2656:
x-microsoft-antispam-prvs: <MWHPR02MB2656AD379C99DD9891CA05A8D7200@MWHPR02MB2656.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(36756003)(66446008)(966005)(76116006)(2906002)(5660300002)(26005)(478600001)(316002)(71200400001)(66476007)(66556008)(53546011)(64756008)(8936002)(54906003)(6486002)(81156014)(81166006)(86362001)(33656002)(8676002)(91956017)(186003)(2616005)(4326008)(66946007)(110136005)(6512007)(6506007)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2656;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U97GieOjGnXd6MTGS1acEeRl2bCy1IfPkbRGy7PfQJosREJzlT4GuGQImzZyPI/rfdKKgUL7OEAzceas4X1MMsnG87Uq93rh0UZXqPHnV4GZjOoNf0wnugO0Gg4KW24i7i3wEX/AoLsdVBBnTH+E6HJqFgL9NGTsadoljiKGViRswDdq1ejQw4didXEAHGIpy60JeBNJLWKP+Q94Zp0VIMWDIpzSfQ7ZgSg6zEGAOod46YKNt0IsLCZ202RKK11LOELbYKPzK91IFu/ozy5nR94OvTHZ1F8GDqjXnL9KqULgDRIj3bTMtZENOtDgGwqz7pzHurNJHj45lqPvvwJ8bgbRwOe45YLMHn729C77R9hXqAVhb+16ALh6A0ygTr2j+VQ5DmYX4nsNyMUqT8i0JoR8HKay5nxR7FOl3ukcScYgN5SHc6ps1tx2hNomHIWMhMlIKcq4f/TMDr8C6MxnXIdbr0UrBfpU40pz8/duriObBCBuyZcC7bVR9+WgP3Q/dEk4EagdCGQYxFRmTTpE4BSVjZs5vflW9YgjIrPKnu8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5F50EDED91E1943AD6242AECC2A15D5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a49b5cb-e00f-4812-5729-08d78f983a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 15:27:07.3288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siOI8z9M/V5zEJa/E1KkXC5bah2KsFiNXUcIxkRXb2UkJ8Mye/Wi7d50hX61czJ8ETceDKzq1ZLxalSIKjr7NEfAE9fKEP6kqxbPlj83d+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2656
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_04:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.155.12
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gT24gSmFuIDIsIDIwMjAsIGF0IDM6MDcgUE0sIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFu
aGFAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgRGVjIDI2LCAyMDE5IGF0IDA1OjQw
OjIyUE0gKzA4MDAsIOW8oOa1t+aWjCB3cm90ZToNCj4+IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFu
aGFAcmVkaGF0LmNvbT4g5LqOMjAxOeW5tDPmnIgyOeaXpeWRqOS6lCDkuIrljYgxOjA45YaZ6YGT
77yaDQo+Pj4gDQo+Pj4gT24gVGh1LCBNYXIgMjgsIDIwMTkgYXQgMDU6NTM6MzRQTSArMDgwMCwg
5byg5rW35paMIHdyb3RlOg0KPj4+PiBoaSwgc3RlZmFuDQo+Pj4+IA0KPj4+PiBJIGhhdmUgZmFj
ZWQgdGhlIHNhbWUgcHJvYmxlbSB5b3Ugd3JvdGUgaW4NCj4+Pj4gaHR0cHM6Ly9saXN0cy5nbnUu
b3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTYtMDgvbXNnMDQwMjUuaHRtbA0KPj4+PiAN
Cj4+Pj4gUmVwcm9kdWNlIGFzIGZvbGxvdzoNCj4+Pj4gMS4gQ2xvbmUgcWVtdSBjb2RlIGZyb20g
aHR0cHM6Ly9naXQucWVtdS5vcmcvZ2l0L3FlbXUuZ2l0LCBhZGQgc29tZQ0KPj4+PiBkZWJ1ZyBp
bmZvcm1hdGlvbiBhbmQgY29tcGlsZQ0KPj4+PiAyLiBTdGFydCBhIG5ldyBWTQ0KPj4+PiAzLiBJ
biBWTSwgdXNlIGZpbyByYW5kd3JpdGUgdG8gYWRkIHByZXNzdXJlIGZvciBkaXNrDQo+Pj4+IDQu
IExpdmUgbWlncmF0ZQ0KPj4+PiANCj4+Pj4gTG9nIHNob3cgYXMgZm9sbG93Og0KPj4+PiBbMjAx
OS0wMy0yOCAxNToxMDo0MC4yMDZdIC9kYXRhL3FlbXUvY3B1cy5jOjEwODY6IGVudGVyIGRvX3Zt
X3N0b3ANCj4+Pj4gWzIwMTktMDMtMjggMTU6MTA6NDAuMjEyXSAvZGF0YS9xZW11L2NwdXMuYzox
MDk3OiBjYWxsIGJkcnZfZHJhaW5fYWxsDQo+Pj4+IFsyMDE5LTAzLTI4IDE1OjEwOjQwLjk4OV0g
L2RhdGEvcWVtdS9jcHVzLmM6MTA5OTogY2FsbCByZXBsYXlfZGlzYWJsZV9ldmVudHMNCj4+Pj4g
WzIwMTktMDMtMjggMTU6MTA6NDAuOTg5XSAvZGF0YS9xZW11L2NwdXMuYzoxMTAxOiBjYWxsIGJk
cnZfZmx1c2hfYWxsDQo+Pj4+IFsyMDE5LTAzLTI4IDE1OjEwOjQxLjAwNF0gL2RhdGEvcWVtdS9j
cHVzLmM6MTEwNDogZG9uZSBkb192bV9zdG9wDQo+Pj4+IA0KPj4+PiBDYWxsaW5nIGJkcnZfZHJh
aW5fYWxsKCkgY29zdHMgNzkyIG1pbmktc2Vjb25kcy4NCj4+Pj4gSSBqdXN0IGFkZCBhIGJkcnZf
ZHJhaW5fYWxsKCkgYXQgc3RhcnQgb2YgZG9fdm1fc3RvcCgpIGJlZm9yZQ0KPj4+PiBwYXVzZV9h
bGxfdmNwdXMoKSwgYnV0IGl0IGRvZXNuJ3Qgd29yay4NCj4+Pj4gSXMgdGhlcmUgYW55IHdheSB0
byBpbXByb3ZlIGxpdmUtbWlncmF0aW9uIGRvd250aW1lIGNhdXNlIGJ5IGJkcnZfZHJhaW5fYWxs
KCk/DQo+IA0KPiBJIGJlbGlldmUgdGhlcmUgd2VyZSBpZGVhcyBhYm91dCB0aHJvdHRsaW5nIHN0
b3JhZ2UgY29udHJvbGxlciBkZXZpY2VzDQo+IGR1cmluZyB0aGUgbGF0ZXIgcGhhc2VzIG9mIGxp
dmUgbWlncmF0aW9uIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mDQo+IHBlbmRpbmcgSS9Pcy4NCj4g
DQo+IEluIG90aGVyIHdvcmRzLCBpZiBRRU1VJ3MgdmlydGlvLWJsay9zY3NpIGVtdWxhdGlvbiBj
b2RlIHJlZHVjZXMgdGhlDQo+IHF1ZXVlIGRlcHRoIGFzIGxpdmUgbWlncmF0aW9uIG5lYXJzIHRo
ZSBoYW5kb3ZlciBwb2ludCwgYmRydl9kcmFpbl9hbGwoKQ0KPiBzaG91bGQgYmVjb21lIGNoZWFw
ZXIgYmVjYXVzZSBmZXdlciBJL08gcmVxdWVzdHMgd2lsbCBiZSBpbi1mbGlnaHQuDQo+IA0KPiBB
IHNpbXBsZSBzb2x1dGlvbiB3b3VsZCByZWR1Y2UgdGhlIHF1ZXVlIGRlcHRoIGR1cmluZyBsaXZl
IG1pZ3JhdGlvbg0KPiAoZS5nLiBxdWV1ZSBkZXB0aCAxKS4gIEEgc21hcnQgc29sdXRpb24gd291
bGQgbG9vayBhdCBJL08gcmVxdWVzdA0KPiBsYXRlbmN5IHRvIGRlY2lkZSB3aGF0IHF1ZXVlIGRl
cHRoIGlzIGFjY2VwdGFibGUuICBGb3IgZXhhbXBsZSwgaWYNCj4gcmVxdWVzdHMgYXJlIHRha2lu
ZyA0IG1zIHRvIGNvbXBsZXRlIHRoZW4gd2UgbWlnaHQgYWxsb3cgMiBvciAzIHJlcXVlc3RzDQo+
IHRvIGFjaGlldmUgYSB+MTAgbXMgYmRydl9kcmFpbl9hbGwoKSBkb3dudGltZSB0YXJnZXQuDQo+
IA0KPiBBcyBmYXIgYXMgSSBrbm93IHRoaXMgaGFzIG5vdCBiZWVuIGltcGxlbWVudGVkLg0KPiAN
Cj4gRG8geW91IHdhbnQgdG8gdHJ5IGltcGxlbWVudGluZyB0aGlzPw0KPiANCj4gU3RlZmFuDQoN
Ckl0IGlzIGEgcmVhbGx5IGhhcmQgcHJvYmxlbSB0byBzb2x2ZS4gVWx0aW1hdGVseSwgaWYgZ3Vh
cmFudGVlcyBhcmUNCm5lZWRlZCBhYm91dCB0aGUgYmxhY2tvdXQgcGVyaW9kLCBJIGRvbid0IHNl
ZSBhbnkgdmlhYmxlIHNvbHV0aW9uDQpvdGhlciB0aGFuIGFib3J0aW5nIGFsbCBwZW5kaW5nIHN0
b3JhZ2UgY29tbWFuZHMuDQoNClN0YXJ0aW5nIHdpdGggYSAiZ28gdG8gUUQ9MSBtb2RlIiBhcHBy
b2FjaCBpcyBwcm9iYWJseSBzZW5zaWJsZS4NClZob3N0LWJhc2VkIGJhY2tlbmRzIGNvdWxkIGV2
ZW4gZG8gdGhhdCBvZmYgdGhlICJ5b3UgbmVlZCB0byBsb2ciDQptZXNzYWdlLCBnaXZlbiB0aGF0
IHRoZXNlIGFyZSBvbmx5IHVzZWQgZHVyaW5nIG1pZ3JhdGlvbi4NCg0KSGF2aW5nIGEgInlvdSBh
cmUgdGFraW5nIHRvbyBsb25nLCBhYm9ydCBldmVyeXRoaW5nIiBjb21tYW5kIG1pZ2h0IGJlDQpz
b21ldGhpbmcgd29ydGggbG9va2luZyBpbnRvLCBzcGVjaWFsbHkgaWYgd2UgY2FuICpzYWZlbHkq
IHJlcGxheSB0aGVtDQpvbiB0aGUgb3RoZXIgc2lkZS4gKFRoYXQgbWF5IGJlIGJhY2tlbmQtZGVw
ZW5kZW50LikNCg0KRi4=

