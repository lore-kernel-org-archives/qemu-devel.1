Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13502C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D531020838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="pIfTNGp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D531020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iye61-0007bG-2j
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <felipe@nutanix.com>) id 1iye44-0005Le-M2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <felipe@nutanix.com>) id 1iye43-0003yB-Ez
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:55:08 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:56834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1iye43-0003xn-A7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:55:07 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 013Fi5Me024187; Mon, 3 Feb 2020 07:55:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=bjZi/BmFcdh/rMpAdKNYPbj8yJi9dkRDN0Ll7um2+eU=;
 b=pIfTNGp0H0HotZHfrWWnllHmn68YqaWWHjyuXtkMSmkWikpv9TNglS/wLnemrKCSj7dL
 3Ls7Lyqx4Fngmm00lHC6kr0XzE64XaLspIKTP1Szg89tZYzNYqncjFLWHwc5YzQYcCT/
 /dei2s/CAWFFsdc+53DEQJfBJrwFRyG+55Rl4mUUOWmu7dYwi6NuqjjmjdIUAMxdpHeE
 unesrYd5WLdTfzD1y/6V5W3Rb6F6mI2tAlwxmJ8go0+uIv8j42o+pOoScEJ6UasTlCpw
 iDyiUdBHJtD76n83sngvfyLU19hvPDZk/W5WqYxYQ7qdwpq/MAUn2TpeDF3EaLsfeEWq HA== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xx3ejsws2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Feb 2020 07:55:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUvQxN6hbdvxestzw5qAzlQvA7Vv9CT1xLSOupc3TQUVriMwWlUnMHdv7iQnTezyZMwcHoms0Fu1L9e18rduRXBE4TMqjxCAyPNKPA16p/pmyV5Va6g5A0vrn/MXsKAjkWjStIgohLv+Z8VQSj+OrlT/z1gjTz3w5+6l5Q/QmGpPIZnHWTXzg/xFPSS6ZHkPjTysbWtyrnwpXSEd8SjN4urfl65BLNa/RT3CWrsk/6zbIdgm5ktCPCMoAVfKsk7vg0w9z9vyU4oLome0OPcvJCyD4/lWArJWwlmoMwsNTCzmtx/hzJaNdlz8/Q7ANRJ6QKH8aI0fLVcvLL2sVuXnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjZi/BmFcdh/rMpAdKNYPbj8yJi9dkRDN0Ll7um2+eU=;
 b=KC9Qc2eMilm1Nhks2+hY/q+Eg0Og6NLs7WH1JeM7aGacIIYQuK56tEGDREBWmGR8A7RQroJjdw09E+/AE81ehd5f5qc1FRMVZTVENw4OtN5KvcI71umjI2jr4IOrBikJPcnx7WMS9gJ/90mT9aDAjXbXTPLasF2CXL1oITzmcJyypwmIVNM1Y9kjyH8WvIX9j7lv8ofO52YcZVDlcF+k4kGqo2Nel+14j50c4zR4gGpnmvEz1J3kbdeLwbzlujcRKm+q4ohsVGeFEb+HyMtba9KDKyOpFVT1wJBqTz3Obv5qIt96UJUCvqDmfUwuL86QqcS0MhjVJ4LVLtmujRE7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MWHPR02MB2656.namprd02.prod.outlook.com (10.168.206.142) by
 MWHPR02MB2512.namprd02.prod.outlook.com (10.168.204.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Mon, 3 Feb 2020 15:55:04 +0000
Received: from MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b]) by MWHPR02MB2656.namprd02.prod.outlook.com
 ([fe80::c4c8:b406:7827:8a2b%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 15:55:04 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Topic: [PATCH v4 0/4] Improve default object property_add uint helpers
Thread-Index: AQHVtpZ6lIuRGF0HJ0OIoqz7XKz+uqfDI2WAgDa3bgCABp6EAIAJbhOA
Date: Mon, 3 Feb 2020 15:55:04 +0000
Message-ID: <2CC296B4-1AF9-4C67-B527-F779B75E0C6F@nutanix.com>
References: <20191219180205.25191-1-felipe@nutanix.com>
 <CAJ+F1C+YmQFnMmWrJOZpKrqp9pEzUqLF7yP-yB2hwsz6h3L3cA@mail.gmail.com>
 <A7FBEA28-7FDD-46BA-87DD-3EDB5B101571@nutanix.com>
 <CAJ+F1CKPnCBkyA5Ep98+ug0NG5wgfZFkt7vDe-FN_25S0hQm3w@mail.gmail.com>
In-Reply-To: <CAJ+F1CKPnCBkyA5Ep98+ug0NG5wgfZFkt7vDe-FN_25S0hQm3w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5f33bd6-0fd2-4b30-ef14-08d7a8c16f1c
x-ms-traffictypediagnostic: MWHPR02MB2512:
x-microsoft-antispam-prvs: <MWHPR02MB251238C976AA686D2EAA518BD7000@MWHPR02MB2512.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(6506007)(86362001)(26005)(4326008)(186003)(8676002)(81156014)(54906003)(81166006)(71200400001)(53546011)(478600001)(33656002)(8936002)(316002)(5660300002)(6512007)(2616005)(2906002)(36756003)(66946007)(6916009)(66446008)(66556008)(64756008)(6486002)(66476007)(76116006)(91956017);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR02MB2512;
 H:MWHPR02MB2656.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BNGOv6dMjwuAN/aR3YHGCFfpXitNSLn87BaWSC2Lpxo4C50NWwuO1vsD9SYuQTP8J/XuZOuhtrComnip4zitRjAagQi8Vh0bm8BIQpcf72I11ePYXKNdRzFirfaI5sUfTOJUiZpsDd6MU7Z5vled48OtBwhWITPKdteARe6ALmw4J8vjpHCvslmqHEjBS2JKtIgIh9o2x0orWgAIak5aBN9nRceBqDWKfC6q8fC16Z6rTZkiG5HOjUrYqAEg4YtQ35GVIgij8ix6FeDF8+skxw/lCCGCJQvo9rwqh4NS7UOjQGhwnzkkk6l/5e1DhvpFgURvcMU8UbBFHL6GNfp4+QeRXhggY5JpNHNZuTPH3fNp1/iLOHC5bqzPOoqnO0h69xC4QUGsGzd+eu/4B2hK1s/0Y7p9Z/Rxf764oMq+mqC4PE/ZvSEqQPxoGgI4VUFl
x-ms-exchange-antispam-messagedata: 6SPuumA4Hx1m/a2WzaM4T5iDCgtZfoQVXIlO0Jx9ZO+lkrtg/NB+sglZuWlIwlKPmtc/DNhEuJccBQtU7sRU7Ii8nPy1DCtqLtdg1PVyxTUoLioGIFhYrds5oyFAQbHyXbg8yWxHWKiAOMVnKQGKRw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D033E402FDD6A4B915089272588848D@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f33bd6-0fd2-4b30-ef14-08d7a8c16f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 15:55:04.0507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46WEWXarc4oKkx/235b2Xi2O0Psx3hyzGNnQd9hHAZsz7E2yD5vIi92hxH9inBF15B8Tq1Kgclz/8D9bg3kSt19C1qWORNxK73ZLyvI/cJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2512
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-03_05:2020-02-02,
 2020-02-03 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGV5YSwNCg0KPiBPbiBKYW4gMjgsIDIwMjAsIGF0IDM6NTQgUE0sIE1hcmMtQW5kcsOpIEx1cmVh
dSA8bWFyY2FuZHJlLmx1cmVhdUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGkgRmVsaXBlLA0K
PiANCj4gT24gRnJpLCBKYW4gMjQsIDIwMjAgYXQgMTE6NDkgQU0gRmVsaXBlIEZyYW5jaW9zaSA8
ZmVsaXBlQG51dGFuaXguY29tPiB3cm90ZToNCj4+IA0KPj4gSGkgTWFyYy1BbmRyZSBhbmQgUGFv
bG8sDQo+PiANCj4+PiBPbiBEZWMgMjAsIDIwMTksIGF0IDM6MTUgUE0sIE1hcmMtQW5kcsOpIEx1
cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEhpDQo+
Pj4gDQo+Pj4gT24gVGh1LCBEZWMgMTksIDIwMTkgYXQgMTA6MDIgUE0gRmVsaXBlIEZyYW5jaW9z
aSA8ZmVsaXBlQG51dGFuaXguY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IFRoaXMgaW1wcm92ZXMg
dGhlIGZhbWlseSBvZiBvYmplY3RfcHJvcGVydHlfYWRkX3VpbnRYWF9wdHIgaGVscGVycyBieSBl
bmFibGluZw0KPj4+PiBhIGRlZmF1bHQgZ2V0dGVyL3NldHRlciBvbmx5IHdoZW4gZGVzaXJlZC4g
VG8gcHJldmVudCBhbiBBUEkgYmVoYXZpb3VyYWwgY2hhbmdlDQo+Pj4+IChmcm9tIGNsaWVudHMg
dGhhdCBhbHJlYWR5IHVzZWQgdGhlc2UgaGVscGVycyBhbmQgZGlkIG5vdCB3YW50IGEgc2V0dGVy
KSwgd2UNCj4+Pj4gYWRkIGEgT0JKX1BST1BfRkxBR19SRUFEIGZsYWcgdGhhdCBhbGxvdyBjbGll
bnRzIHRvIG9ubHkgaGF2ZSBhIGdldHRlci4gUGF0Y2ggMQ0KPj4+PiBlbmhhbmNlcyB0aGUgQVBJ
IGFuZCBtb2RpZnkgY3VycmVudCB1c2Vycy4NCj4+Pj4gDQo+Pj4+IFdoaWxlIG1vZGlmeWluZyB0
aGUgY2xpZW50cyBvZiB0aGUgQVBJLCBhIGNvdXBsZSBvZiBpbXByb3ZlbWVudCBvcHBvcnR1bml0
aWVzDQo+Pj4+IHdlcmUgb2JzZXJ2ZWQgaW4gaWNoOS4gVGhlc2Ugd2VyZSBhZGRlZCBpbiBzZXBh
cmF0ZSBwYXRjaGVzICgyIGFuZCAzKS4NCj4+Pj4gDQo+Pj4+IFBhdGNoIDMgY2xlYW5zIHVwIGEg
bG90IG9mIGV4aXN0aW5nIGNvZGUgYnkgbW92aW5nIHZhcmlvdXMgb2JqZWN0cyB0byB0aGUNCj4+
Pj4gZW5oYW5jZWQgQVBJLiBQcmV2aW91c2x5LCB0aG9zZSBvYmplY3RzIGhhZCB0aGVpciBvd24g
Z2V0dGVycy9zZXR0ZXJzIHRoYXQgb25seQ0KPj4+PiB1cGRhdGVkIHRoZSB2YWx1ZXMgd2l0aG91
dCBmdXJ0aGVyIGNoZWNrcy4gU29tZSBvZiB0aGVtIGFjdHVhbGx5IGxhY2tlZCBhIGNoZWNrDQo+
Pj4+IGZvciBzZXR0aW5nIG92ZXJmbG93cywgd2hpY2ggY291bGQgaGF2ZSByZXN1bHRlZCBpbiB1
bmRlc2lyZWQgdmFsdWVzIGJlaW5nIHNldC4NCj4+Pj4gVGhlIG5ldyBkZWZhdWx0IHNldHRlcnMg
aW5jbHVkZSBhIGNoZWNrIGZvciB0aGF0LCBub3QgdXBkYXRpbmcgdGhlIHZhbHVlcyBpbg0KPj4+
PiBjYXNlIG9mIGVycm9ycyAoYW5kIHByb3BhZ2F0aW5nIHRoZW0pLiBJZiB0aGV5IGRpZCBub3Qg
cHJvdmlkZSBhbiBlcnJvcg0KPj4+PiBwb2ludGVyLCB0aGVuIHRoYXQgYmVoYXZpb3VyIHdhcyBt
YWludGFpbmVkLg0KPj4+PiANCj4+Pj4gRmVsaXBlIEZyYW5jaW9zaSAoNCk6DQo+Pj4+IHFvbS9v
YmplY3Q6IGVuYWJsZSBzZXR0ZXIgZm9yIHVpbnQgdHlwZXMNCj4+Pj4gaWNoOTogZml4IGdldHRl
ciB0eXBlIGZvciBzY2lfaW50IHByb3BlcnR5DQo+Pj4+IGljaDk6IFNpbXBsaWZ5IGljaDlfbHBj
X2luaXRmbg0KPj4+PiBxb20vb2JqZWN0OiBVc2UgY29tbW9uIGdldC9zZXQgdWludCBoZWxwZXJz
DQo+Pj4+IA0KPj4+PiBody9hY3BpL2ljaDkuYyAgICAgICB8ICA5OSArKy0tLS0tLS0tLS0tLS0t
LS0tLQ0KPj4+PiBody9hY3BpL3BjaWhwLmMgICAgICB8ICAgNyArLQ0KPj4+PiBody9hY3BpL3Bp
aXg0LmMgICAgICB8ICAxMiArLS0NCj4+Pj4gaHcvaXNhL2xwY19pY2g5LmMgICAgfCAgMjcgKyst
LS0tDQo+Pj4+IGh3L21pc2MvZWR1LmMgICAgICAgIHwgIDEzICstLQ0KPj4+PiBody9wY2ktaG9z
dC9xMzUuYyAgICB8ICAxNCArLS0NCj4+Pj4gaHcvcHBjL3NwYXByLmMgICAgICAgfCAgMTggKy0t
LQ0KPj4+PiBody9wcGMvc3BhcHJfZHJjLmMgICB8ICAgMyArLQ0KPj4+PiBpbmNsdWRlL3FvbS9v
YmplY3QuaCB8ICA0NCArKysrKysrLS0NCj4+Pj4gbWVtb3J5LmMgICAgICAgICAgICAgfCAgMTUg
Ky0tDQo+Pj4+IHFvbS9vYmplY3QuYyAgICAgICAgIHwgMjE2ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0NCj4+Pj4gdGFyZ2V0L2FybS9jcHUuYyAgICAgfCAgMjIg
Ky0tLS0NCj4+Pj4gdGFyZ2V0L2kzODYvc2V2LmMgICAgfCAxMDYgKystLS0tLS0tLS0tLS0tLS0t
LS0tDQo+Pj4+IHVpL2NvbnNvbGUuYyAgICAgICAgIHwgICA0ICstDQo+Pj4+IDE0IGZpbGVzIGNo
YW5nZWQsIDI4MiBpbnNlcnRpb25zKCspLCAzMTggZGVsZXRpb25zKC0pDQo+Pj4gDQo+Pj4gSXQg
Y29uZmxpY3RzIHdpdGggc29tZSByZWNlbnQgY2hhbmdlcywgc28geW91J2xsIG5lZWQgdG8gc2Vu
ZCBhIG5ldw0KPj4+IHZlcnNpb24sIGJ1dCB0aGF0IG9uZSBsb29rcyBnb29kIHRvIG1lOg0KPj4+
IFJldmlld2VkLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0
LmNvbT4NCj4+PiANCj4+PiBQYW9sbywgaXMgaXQgZ29pbmcgdGhyb3VnaCB5b3VyIHF1ZXVlPw0K
Pj4gDQo+PiBJIGRpZG4ndCBzZWUgYW55IHJlc3BvbnNlIGFmdGVyIHRoaXMuIERpZCB0aGUgc2Vy
aWVzIGdldCBsb3N0Pw0KPiANCj4gQ2FuIHlvdSBzZW5kIGEgcmViYXNlZCB2ZXJzaW9uPw0KDQpT
b3JyeSBmb3IgdGhlIGRlbGF5IGFzIEkgd2FzIG9uIHRyYXZlbHMuIERvbmUuDQoNCkYuDQoNCj4g
DQo+IHRoYW5rcw0KPiANCj4gDQo+IA0KPiAtLSANCj4gTWFyYy1BbmRyw6kgTHVyZWF1DQoNCg==

