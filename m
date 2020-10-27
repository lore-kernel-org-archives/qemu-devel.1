Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12674C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C4921707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RCNz+UDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C4921707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXXyu-0005zk-DT
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 19:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kXXxe-0005BM-Ls; Tue, 27 Oct 2020 19:01:02 -0400
Received: from mail-mw2nam10on2040.outbound.protection.outlook.com
 ([40.107.94.40]:27282 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kXXxb-0000k1-4J; Tue, 27 Oct 2020 19:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAraJjzX/SKLkXO8DI6Cj4u7Iajs1ctfAPmdPc4kGyK9avT1vC76H/XaykcrEpiI47u5rpIdRvSwGePbQsldua146c81RV42hlK4wa4c6MvTSpEZ3YoJuLTgl4g9PB7lSGVn66fB7mZXu9WTZ7lN/QEsS98Ehl9O51WOiCz7cqzzdjrJvZqYKif76ZKhstbmfeYJ9eaFadOBCVIL7RgLGd4vysd6UmuI5/l1L1z/Vf8oC7oYd10yoxLP/05U0fak+f2FLu/7KfVvYQau+ZtpknUCaKTjJdopKaxRyvT3UU/PppzVukTdhbRzwFGqrBfzTGiNCfvHXku8izGPJvBDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAnS9v4F0JcHBh6VIBtiqJMWaIE4cObn+5hcLFIr9u4=;
 b=C5+pv2mgJPwWbFgTrgFe+eFhQbFu1kJHInsMG0h59wrSDeNnInvwqnDuHP6nwXknmh788woR+nvyMXLo/f6T8jCBQjvLN579LD5ioW0FVJHyTLx3ZMfjCkYs4ygRGwyCBZge8mM03YmVu9cGdem6DoMIfR+hFehkYw29pIfm4C7MvwbcnxX66sUASho51lJWGZvam75y1ggseHbiFm92QpU9TsykztoTGkFL3mlCAZlf2aWNCXBHPbaFOm26J2Nb3gnIQprpfBcpH9kFQu0ZKkovnYdUGYUPZU+JHirwnJp9K4g1OSF38T17lLKofL6Rz21NNt8s3ODajWd8UPPTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAnS9v4F0JcHBh6VIBtiqJMWaIE4cObn+5hcLFIr9u4=;
 b=RCNz+UDYblbCYH6kZ/TbHNlCagQv3W+NDpEgVL+ZOKHYjdyy8LORWcGuCzOJ7RC3WrMBPNS6mD5o01pJqKjvoEsKmN337q3cypxcAtqkbkIe+G5zfiq5vnyV1Yw8b30QhNdSte/9874MScm1uKCXTSghd/jFnN7F5YHy8m7erSA=
Received: from BY5PR02MB6033.namprd02.prod.outlook.com (2603:10b6:a03:1ff::10)
 by SJ0PR02MB7503.namprd02.prod.outlook.com (2603:10b6:a03:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 27 Oct
 2020 23:00:53 +0000
Received: from BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f5f3:83c4:cc49:d415]) by BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f5f3:83c4:cc49:d415%6]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 23:00:53 +0000
From: Joe Komlodi <komlodi@xilinx.com>
To: Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: RE: [PATCH 1/2] hw/block/m25p80: Fix Numonyx dummy cycle register
 behavior
Thread-Topic: [PATCH 1/2] hw/block/m25p80: Fix Numonyx dummy cycle register
 behavior
Thread-Index: AQHWlsDItPo4x1oxzUK7qgUv5+XgBqmgolmAgAuYo/A=
Date: Tue, 27 Oct 2020 23:00:53 +0000
Message-ID: <BY5PR02MB6033C593FA0DEF642A15CFBAD0160@BY5PR02MB6033.namprd02.prod.outlook.com>
References: <1601425716-204629-1-git-send-email-komlodi@xilinx.com>
 <1601425716-204629-2-git-send-email-komlodi@xilinx.com>
 <20201020135010.jwkkr4or6zs5fcm7@debian>
In-Reply-To: <20201020135010.jwkkr4or6zs5fcm7@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [76.217.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 269e0edf-70d7-4d54-7075-08d87acc27dc
x-ms-traffictypediagnostic: SJ0PR02MB7503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB75031B107F476E5B04780569D0160@SJ0PR02MB7503.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:170;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c4fP3mhBS2NdKsVlTcErMq2JLNoimaBSoqjyknICIqCS/O6JqRTXUzne0fwLjhEi0Jhg4r1YFPnCuBKY/g3KnjM+ni0LEYJQz1Mc1HjiUIk9wNHCfsvvWWWqlvmM9onM1ZDg0iQBF7o3d6UdCKA0Ej50zzFBmYE4Q8cPqtu2h1xQiHH5whc3IAvXbvqfzDwNGFzwtL0VBGfyFi0SCU589Oab3Y6cCRi9YBnAz/r6IwWnC6mbRs6bukmD2a+l+hm1d7wV4rfPQdvOZUqOXcmIW9FGzLxCK4BCKzcYKldkQnQM5hLP5HIXKt9QQZIaxYlcxcjQ/HniJ3hA58HUupD9EvSuY2WEgA5wBjfEvKeFuI3fdsSlhh62+oCwHvmW1av3/fw23sxZzdFyLryDxnyxqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6033.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(7696005)(53546011)(6506007)(4326008)(8936002)(6862004)(2906002)(186003)(6636002)(26005)(54906003)(83380400001)(9686003)(8676002)(86362001)(55016002)(33656002)(66946007)(478600001)(66446008)(64756008)(66556008)(966005)(66476007)(316002)(5660300002)(52536014)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EEozkxNlY7Y+79GyHGUN5WHBnCk5xYE19pReuPnn7kw9pKPGZu2KNuPDPJw94F4LFiSS/zwk1hO0zJbQ6htWYVjZ6A5uINQvL5fNIZR8mKadR6+PFhXpVt5JslbJLMsU1pJCJTAYSqurUxvaoI0ZeronIcshb4izDgn0t/hDG08TCQCVOz508gyz0zQ7bDNEvi4t49pjDZPGZxXv0+cho1IzfpI+NKcwE78qL6OhTr1UZh4oNIiuGkKl3eAc+Kj6cOzPWOwa1ZDezgu2Adrqr12GDsE6NrJQQWj/3MepIoWLj8+CiMTkJqVs4yVOxpHUYkXm14sQFuOi1KS1SmSgNJs0oMo9J5ivgQPD6+sAN2rZluvrwtYFPgLVT/RhBPZh5wV4E6s2G/uxqcqmdMi2LXDmPT+95w4w7bbe4HFn1Www7mexU1PmTIJtMXNlq2aKNfN1vFTtYL5w4r4Iu+//DhjOr9GoPA2jCqdwoTBgM+lpQW4WH5CqSIkjNgJFXw4RteOt8hhaLQEZVL/aw1TiK2WGYEcHmg3qDlb5i2GcP6pXW5Lj/z6dShkeFLh+gkIttYageEqlqdWRW8MgTXF+z2OEt18GNcaDddYiTwzhc2IIkHteVGZGJad9anMAduPBMACWR/ktcq2YLO1Y5YJq8A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6033.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269e0edf-70d7-4d54-7075-08d87acc27dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 23:00:53.2760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roHNamIswkgHGx+89c12dl4yn5MYDmg6n7/PdrLxYpvvdExq/huCYWI6nHs9G/+mMYaj2BlApnXnwqoD4etzLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7503
Received-SPF: pass client-ip=40.107.94.40; envelope-from=komlodi@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 19:00:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRnJhbmNpc2NvLA0KDQpDb21tZW50cyBtYXJrZWQgd2l0aCBbSm9lXQ0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRnJhbmNpc2NvIElnbGVzaWFzIDxmcmFuY2lzY28uaWds
ZXNpYXNAeGlsaW54LmNvbT4gDQpTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIwLCAyMDIwIDY6NTAg
QU0NClRvOiBKb2UgS29tbG9kaSA8a29tbG9kaUB4aWxpbnguY29tPg0KQ2M6IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsgYWxpc3RhaXJAYWxpc3RhaXIyMy5tZTsga3dvbGZAcmVkaGF0LmNvbTsgbXJl
aXR6QHJlZGhhdC5jb207IHFlbXUtYmxvY2tAbm9uZ251Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRD
SCAxLzJdIGh3L2Jsb2NrL20yNXA4MDogRml4IE51bW9ueXggZHVtbXkgY3ljbGUgcmVnaXN0ZXIg
YmVoYXZpb3INCg0KSGkgSm9lLA0KDQpPbiBUdWUsIFNlcCAyOSwgMjAyMCBhdCAwNToyODozNVBN
IC0wNzAwLCBKb2UgS29tbG9kaSB3cm90ZToNCj4gTnVtb255eCBjaGlwcyBkZXRlcm1pbmUgdGhl
IG51bWJlciBvZiBjeWNsZXMgdG8gd2FpdCBiYXNlZCBvbiBiaXRzIDc6NCANCj4gaW4gdGhlIHZv
bGF0aWxlIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIuDQo+IA0KPiBIb3dldmVyLCBpZiB0aGVzZSBi
aXRzIGFyZSAweDAgb3IgMHhGLCB0aGUgbnVtYmVyIG9mIGR1bW15IGN5Y2xlcyB0byANCj4gd2Fp
dCBpcw0KPiAxMCBvbiBhIFFJT1Igb3IgUUlPUjQgY29tbWFuZCwgb3IgOCBvbiBhbnkgb3RoZXIg
Y3VycmVudGx5IHN1cHBvcnRlZCANCj4gZmFzdCByZWFkIGNvbW1hbmQuIFsxXQ0KPiANCj4gWzFd
IGh0dHA6Ly93d3cubWljcm9uLmNvbS8tL21lZGlhL2NsaWVudC9nbG9iYWwvZG9jdW1lbnRzL3By
b2R1Y3RzLw0KPiBkYXRhLXNoZWV0L25vci1mbGFzaC9zZXJpYWwtbm9yL24yNXEvbjI1cV81MTJt
Yl8xXzh2XzY1bm0ucGRmDQo+IA0KPiBQYWdlIDIyIG5vdGUgMiwgYW5kIHBhZ2UgMzAgbm90ZXMg
NSBhbmQgMTAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2UgS29tbG9kaSA8a29tbG9kaUB4aWxp
bnguY29tPg0KPiAtLS0NCj4gIGh3L2Jsb2NrL20yNXA4MC5jIHwgMjYgKysrKysrKysrKysrKysr
KysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL20yNXA4MC5jIGIvaHcvYmxvY2sv
bTI1cDgwLmMgaW5kZXggDQo+IDQ4MzkyNWYuLjQzODMwYzkgMTAwNjQ0DQo+IC0tLSBhL2h3L2Js
b2NrL20yNXA4MC5jDQo+ICsrKyBiL2h3L2Jsb2NrL20yNXA4MC5jDQo+IEBAIC04MjAsNiArODIw
LDI2IEBAIHN0YXRpYyB2b2lkIHJlc2V0X21lbW9yeShGbGFzaCAqcykNCj4gICAgICB0cmFjZV9t
MjVwODBfcmVzZXRfZG9uZShzKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHVpbnQ4X3QgbnVtb255
eF9mYXN0X3JlYWRfbnVtX2R1bW1pZXMoRmxhc2ggKnMpDQoNClNob3VsZCB3ZSByZW5hbWUgdGhl
IGZ1bmN0aW9uIHRvIHNvbWV0aGluZyBsaWtlICdudW1vbnl4X2V4dHJhY3RfY2ZnX251bV9kdW1t
aWVzJyAoc2luY2UgaXQgaXMgbm90IG9ubHkgdXNlZCBpbnNpZGUgJ2RlY29kZV9mYXN0X3JlYWRf
Y21kJyk/DQoNCltKb2VdIFllYWgsIHRoYXQgbmFtZSBtYWtlcyBtb3JlIHNlbnNlLg0KDQo+ICt7
DQo+ICsgICAgdWludDhfdCBjeWNsZV9jb3VudDsNCj4gKyAgICB1aW50OF90IG51bV9kdW1taWVz
Ow0KPiArICAgIGFzc2VydChnZXRfbWFuKHMpID09IE1BTl9OVU1PTllYKTsNCj4gKw0KPiArICAg
IGN5Y2xlX2NvdW50ID0gZXh0cmFjdDMyKHMtPnZvbGF0aWxlX2NmZywgNCwgNCk7DQo+ICsgICAg
aWYgKGN5Y2xlX2NvdW50ID09IDB4MCB8fCBjeWNsZV9jb3VudCA9PSAweDBGKSB7DQo+ICsgICAg
ICAgIGlmIChzLT5jbWRfaW5fcHJvZ3Jlc3MgPT0gUUlPUiB8fCBzLT5jbWRfaW5fcHJvZ3Jlc3Mg
PT0gDQo+ICsgUUlPUjQpIHsNCg0KUU9SIGFuZCBRT1I0IGFsc28gaGFzIDEwIGR1bW15IGN5Y2xl
cyBvbiBkZWZhdWx0IHNvIHdlIHdpbGwgaGF2ZSB0byBjaGVjayBmb3IgdGhvc2UgYXN3ZWxsLCBw
ZXJoYXBzIHNvbWV0aGluZyBzaW1pbGFyIGxpa2UgYmVsb3cgbWlndGggd29yazogIA0KDQp1aW50
OF90IG5fZHVtbWllcyA9IGV4dHJhY3QzMihzLT52b2xhdGlsZV9jZmcsIDQsIDQpOw0KDQppZiAo
IW5fZHVtbWllcyB8fCBuX2R1bW1pZXMgPT0gMHhGKSB7DQogICAgc3dpdGNoKHMtPmNtZF9pbl9w
cm9ncmVzcyl7DQogICAgY2FzZSBRT1I6DQogICAgY2FzZSBRT1I0DQogICAgY2FzZSBRSU9SOg0K
ICAgIGNhc2UgUUlPUjQ6DQogICAgICAgIG5fZHVtbWllcyA9IDEwOw0KICAgICAgICBicmVhazsN
CiAgICBkZWZhdWx0Og0KICAgICAgICBuX2R1bW1pZXMgPSA4Ow0KICAgICAgICBicmVhazsNCiAg
ICB9DQp9DQoNCnJldHVybiBuX2R1bW1pZXM7DQoNCltKb2VdIEFzIHRhbGtlZCBhYm91dCBvZmZs
aW5lLCB0aGUgZGF0YXNoZWV0IGluIHRoZSBjb21taXQgbWVzc2FnZSBqdXN0IGhhcyBjb25mdXNp
bmcgd29yZGluZy4NCjggZHVtbWllcyBmb3IgUU9SIHNlZW1zIHRvIGJlIGNvcnJlY3QsIGFuZCBJ
J2xsIHVwZGF0ZSB0aGUgZGF0YXNoZWV0IGluIHRoZSBjb21taXQgbWVzc2FnZSB3aXRoIG9uZSB0
aGF0J3MgbW9yZSBjbGVhci4NCg0KVGhhbmtzIQ0KSm9lDQoNCkJlc3QgcmVnYXJkcywNCkZyYW5j
aXNjbyBJZ2xlc2lhcw0KDQo+ICsgICAgICAgICAgICBudW1fZHVtbWllcyA9IDEwOw0KPiArICAg
ICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgbnVtX2R1bW1pZXMgPSA4Ow0KPiArICAgICAg
ICB9DQo+ICsgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgbnVtX2R1bW1pZXMgPSBjeWNsZV9jb3Vu
dDsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICByZXR1cm4gbnVtX2R1bW1pZXM7DQo+ICt9DQo+ICsN
Cj4gIHN0YXRpYyB2b2lkIGRlY29kZV9mYXN0X3JlYWRfY21kKEZsYXNoICpzKSAgew0KPiAgICAg
IHMtPm5lZWRlZF9ieXRlcyA9IGdldF9hZGRyX2xlbmd0aChzKTsgQEAgLTgyOSw3ICs4NDksNyBA
QCBzdGF0aWMgDQo+IHZvaWQgZGVjb2RlX2Zhc3RfcmVhZF9jbWQoRmxhc2ggKnMpDQo+ICAgICAg
ICAgIHMtPm5lZWRlZF9ieXRlcyArPSA4Ow0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBjYXNl
IE1BTl9OVU1PTllYOg0KPiAtICAgICAgICBzLT5uZWVkZWRfYnl0ZXMgKz0gZXh0cmFjdDMyKHMt
PnZvbGF0aWxlX2NmZywgNCwgNCk7DQo+ICsgICAgICAgIHMtPm5lZWRlZF9ieXRlcyArPSBudW1v
bnl4X2Zhc3RfcmVhZF9udW1fZHVtbWllcyhzKTsNCj4gICAgICAgICAgYnJlYWs7DQo+ICAgICAg
Y2FzZSBNQU5fTUFDUk9OSVg6DQo+ICAgICAgICAgIGlmIChleHRyYWN0MzIocy0+dm9sYXRpbGVf
Y2ZnLCA2LCAyKSA9PSAxKSB7IEBAIC04NjgsNyArODg4LDcgDQo+IEBAIHN0YXRpYyB2b2lkIGRl
Y29kZV9kaW9fcmVhZF9jbWQoRmxhc2ggKnMpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICApOw0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBjYXNlIE1BTl9OVU1PTllY
Og0KPiAtICAgICAgICBzLT5uZWVkZWRfYnl0ZXMgKz0gZXh0cmFjdDMyKHMtPnZvbGF0aWxlX2Nm
ZywgNCwgNCk7DQo+ICsgICAgICAgIHMtPm5lZWRlZF9ieXRlcyArPSBudW1vbnl4X2Zhc3RfcmVh
ZF9udW1fZHVtbWllcyhzKTsNCj4gICAgICAgICAgYnJlYWs7DQo+ICAgICAgY2FzZSBNQU5fTUFD
Uk9OSVg6DQo+ICAgICAgICAgIHN3aXRjaCAoZXh0cmFjdDMyKHMtPnZvbGF0aWxlX2NmZywgNiwg
MikpIHsgQEAgLTkwOCw3ICs5MjgsNyANCj4gQEAgc3RhdGljIHZvaWQgZGVjb2RlX3Fpb19yZWFk
X2NtZChGbGFzaCAqcykNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICk7
DQo+ICAgICAgICAgIGJyZWFrOw0KPiAgICAgIGNhc2UgTUFOX05VTU9OWVg6DQo+IC0gICAgICAg
IHMtPm5lZWRlZF9ieXRlcyArPSBleHRyYWN0MzIocy0+dm9sYXRpbGVfY2ZnLCA0LCA0KTsNCj4g
KyAgICAgICAgcy0+bmVlZGVkX2J5dGVzICs9IG51bW9ueXhfZmFzdF9yZWFkX251bV9kdW1taWVz
KHMpOw0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBjYXNlIE1BTl9NQUNST05JWDoNCj4gICAg
ICAgICAgc3dpdGNoIChleHRyYWN0MzIocy0+dm9sYXRpbGVfY2ZnLCA2LCAyKSkgew0KPiAtLQ0K
PiAyLjcuNA0KPiANCg==

