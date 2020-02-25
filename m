Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A06C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DCD21D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aVMe2CPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DCD21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Td2-0000fu-VN
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 01:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1j6TcK-0000Fq-TB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 01:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fnuv@xilinx.com>) id 1j6TcI-0005WH-SL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 01:22:52 -0500
Received: from mail-eopbgr770058.outbound.protection.outlook.com
 ([40.107.77.58]:52711 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fnuv@xilinx.com>) id 1j6TcI-0005V6-Go
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 01:22:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIoR7w+YN41dbmgZpKWXjZc6NeID5+TXs2zbSvOE6dNs5ePNALZmm8R8evj3EDnlvKG92vkGvpA4ONNwqR97z5CcB7/5LIcyc0R9sCdRjXTQw4x/AJOI2JVaOWes+9oF5Fk6QtircKWguCE+bz4aHbMc433KRuFnyry/l5vPyaly5gkzWkawSCbhgXMYGduKoYwd7tDT2Bf3o7OXi3K3Y4Ll4LMilKRBv8oq0pNRcJhkt+HbgTXjUW8Vc+kF6TdD7gBuHxT/HbniLbUygC0ClKMDVrPyiI4FFCU7YQUh3lAMK6STf5Y9YU4KGZJGd74CYU7XFcMgphlhog8GaSoRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTJ8uLUerCeSpygbjbJTYuj+FRxhFba+QuOGzcYAt8k=;
 b=oWs39zEhfLWWZGucYdQqBI7aib+BKwrlJZ8sQm7VAIHMSGwliQUqqw/bPXfE9kuxyE9evqGuxbnxbGv+VzD40wdSbr4jZLOxDqf3QqsBmBGtyLUQzPRrWNa/hETFkmpMblMFWn1fusOy+22yFuJbtEmEUz0dSvJ4R1KmRMUbXq0wfKOMWdS0bySv4yw8aQsRZWG7axXGHzD+aS1RKs/BHwhwX4vLMmElphHa+TVMlLU3JQZoZa0Vmw5BLnQfG3IFFIBM3/CWbSeJHjmaTKJAOrVCItlWiGC2GGX5PFoETsr8cCcoa2dgZF4kSfKDfb4BSwetW889Og2DS3VFJ44MZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTJ8uLUerCeSpygbjbJTYuj+FRxhFba+QuOGzcYAt8k=;
 b=aVMe2CPqT+UOqraMy4ysVmF1LJadSx/LCPvbGk9yeSD0KYGYLcZu87f0chAVjhI3ZeAEBHjXN52Vnb8EJwySy0I/2NqXPgGqDI40xOzkNCntB4XZ7HZiM8JLz3QnEuMOeKVUVMTOHV/Zt6mIU0WcuUWZHpbV++CBLJfmAdvN2fo=
Received: from BYAPR02MB5638.namprd02.prod.outlook.com (2603:10b6:a03:9f::18)
 by BYAPR02MB4359.namprd02.prod.outlook.com (2603:10b6:a03:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.30; Tue, 25 Feb
 2020 06:22:47 +0000
Received: from BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::a0f2:bc3:62bd:e68]) by BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::a0f2:bc3:62bd:e68%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 06:22:47 +0000
From: Vikram Garhwal <fnuv@xilinx.com>
To: Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/1] hw/net/can: Introduce Xlnx ZynqMP CAN controller for
 QEMU
Thread-Topic: [PATCH 1/1] hw/net/can: Introduce Xlnx ZynqMP CAN controller for
 QEMU
Thread-Index: AQHV2+ex6bt4rBh6tUGf0DorXXlOrKgU9+UwgABhioCAEMZIQA==
Date: Tue, 25 Feb 2020 06:22:47 +0000
Message-ID: <BYAPR02MB5638E0507A08A3404D2AFB12BCED0@BYAPR02MB5638.namprd02.prod.outlook.com>
References: <1580764010-310744-1-git-send-email-fnu.vikram@xilinx.com>
 <1580764010-310744-2-git-send-email-fnu.vikram@xilinx.com>
 <8aabde0d-62e9-96d5-0614-0e0ebff549ae@redhat.com>
 <DM6PR02MB5643F9E19DC0590E14612477BC190@DM6PR02MB5643.namprd02.prod.outlook.com>
 <b1b9932a-5566-5d2b-c333-8c466dcd322b@redhat.com>
In-Reply-To: <b1b9932a-5566-5d2b-c333-8c466dcd322b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fnuv@xilinx.com; 
x-originating-ip: [73.202.69.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: adb28f4e-5304-499e-b408-08d7b9bb21d6
x-ms-traffictypediagnostic: BYAPR02MB4359:|BYAPR02MB4359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4359E54BD2F9FAA119A98E9CBCED0@BYAPR02MB4359.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(6506007)(26005)(76116006)(71200400001)(8936002)(81166006)(81156014)(66946007)(52536014)(64756008)(478600001)(66556008)(8676002)(2906002)(5660300002)(66476007)(66446008)(186003)(316002)(55016002)(9686003)(86362001)(107886003)(53546011)(110136005)(7696005)(966005)(33656002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4359;
 H:BYAPR02MB5638.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iV097+QSwklHiSU28sIJmGiQ81vVKIyapEKLbrHLVpY3DwcYUamnYHCQMfo5j4dg3cqoFbMUrHzJWdWuDuPdtzvMTSrSfVukWh8RjzNqdpJFTh4T75joBm2l0KB5XSl3mII29n4oWiVFDflLkbXvk9KCQWhVnb9chYm7CFVEgDC5U6GE/nl2TuMnpMrZvagRHtF2QyX2Pn0JBAuliVomRfxyQ80N7nv59/IvYjmTONB0CpvJpFaJ9fIwcXD8O8N+qzMDUJM6xGTsiCKImoVFMuA3PHZhb+iiijQY9brq1723x+fuEAIYsO5gz+1QLBYoJfnh0fUAadArXR1sk/WAHiXlj3xmqOULa+8sgaIHtBYmMZkSo/5/ncKpjGWeJXsgC/ZwSr+Fx4JWD9VEaFXohChZF2BqSh46rGaKWCZ7GtrD6KSA/GO5geLIkNu44avCVmlSd1aWdpGAk6bb8e37fKtD61gG9oGEyb/8f5OLImOkqLH97b/2CQIWCVq7NDF6DwGyEl801DipvaSzbIWK9w==
x-ms-exchange-antispam-messagedata: RG5RUrShfJGl0hazWVDreNzFk3ufsUul7G7/rbRFbwL4QLwovMdgjOEnYlq6apPyT7b0WxQOPTCx1vzyAnTOiYSUgLveojpEuiMmAEqDS4ZTZ5ZbFTO3lGncepNvj8HVOJM6tOvmY57Xluj/Hc7OZA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb28f4e-5304-499e-b408-08d7b9bb21d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 06:22:47.2976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HH1WTKcMbiLZVjT7uQIoJo4GrOcOafxADXLoFXM/x0HSxoDKFOsUTRK41zJbfV+h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4359
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.58
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgSmFzb24sDQpBcG9sb2dpZXMgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLiBJIHRyaWVkIHBs
dWdnaW5nIE5ldENsaWVudFN0YXRlIGluIHRoZSBDQU4gd2hpY2ggaXMgcmVxdWlyZWQgaWYgd2Ug
dXNlIHFlbXVfc2VuZF9wYWNrZXQgYnV0IHRoaXMgd2lsbCBjaGFuZ2UgdGhlIHVuZGVybHlpbmcg
YXJjaGl0ZWN0dXJlIG9mIGNhbi1jb3JlLCBjYW4tc29ja2V0Y2FuIGEgbG90LiBUaGlzIG1lYW5z
IGNoYW5nZXMgdGhlIHdheSBDQU4gYnVzIGlzIGNyZWF0ZWQvd29ya3MgYW5kIHNvY2tldCBDQU4g
d29ya3MuIENBTiBTb2NrZXQoQ0FOIFJhdyBzb2NrZXQpIGlzIG11Y2ggZGlmZmVyZW50IGZyb20g
RXRoZXJuZXQgc28gcGx1Z2dpbmcvdXNpbmcgTmV0Q2xpZW50IHN0YXRlIGlzIG5vdCB3b3JraW5n
IGhlcmUuDQoNCkkgYXBvbG9naXplIGZvciBzdGlsbCBiZWluZyBhIGxpdHRsZSBjb25mdXNlZCBh
Ym91dCB0aGUgZmlsdGVycyBidXQgd2hlbiBsb29raW5nIGludG8gdGhlIGNvZGUsIEkgY2FuIG9u
bHkgZmluZCB0aGVtIGJlaW5nIHVzZWQgd2l0aCBldGhlcm5ldCBmcmFtZXMuIFNpbmNlIG5vIG90
aGVyIGNhbiBjb250cm9sbGVyIHVzZXMgTmV0Q2xpZW50U3RhdGUgaXQgbWFrZXMgbWUgd29uZGVy
IGlmIHRoaXMgbW9kZWwgcGVyaGFwcyB3YXMgdGhvdWdodCBvZiBiZWluZyBhbiBldGhlcm5ldCBO
SUM/IE9yIGhhcyB0aGUgY29kZSBpbiBuZXQvY2FuLyB3aGljaCBJIHJlZmVyZW5jZWQgYmVlbiBv
YnNvbGV0ZWQ/DQoNClNoYXJpbmcgdGhpcyBsaW5rIGZvciBTb2NrZXRDQU4oaW4gY2FzZSB5b3Ug
d2FudCB0byBoYXZlIGEgbG9vayk6IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50
YXRpb24vbmV0d29ya2luZy9jYW4udHh0LiBTZWN0aW9uIDQgdGFsa3Mgb24gaG93IENBTiBTb2Nr
ZXQgaXMgaW50ZW5kZWQgdG8gd29yay4gRXF1aXZhbGVudCBmaWxlIGlzIGxvY2F0ZWQgYXMgbmV0
L2Nhbi1zb2NrZXRjYW4uYy4NCiANClJlZ2FyZHMsDQpWaWtyYW0NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0K
PiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDEwLCAyMDIwIDc6MDkgUE0NCj4gVG86IFZpa3JhbSBH
YXJod2FsIDxmbnV2QHhpbGlueC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzFdIGh3L25ldC9jYW46IEludHJvZHVjZSBYbG54IFp5bnFNUCBDQU4g
Y29udHJvbGxlcg0KPiBmb3IgUUVNVQ0KPiANCj4gDQo+IE9uIDIwMjAvMi8xMSDkuIrljYg1OjQ1
LCBWaWtyYW0gR2FyaHdhbCB3cm90ZToNCj4gPj4+ICsgICAgICAgICAgICAgICAgfQ0KPiA+Pj4g
KyAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4+PiArICAgICAgICAgICAgICAgIC8qIE5vcm1hbCBt
b2RlIFR4LiAqLw0KPiA+Pj4gKyAgICAgICAgICAgICAgICBnZW5lcmF0ZV9mcmFtZSgmZnJhbWUs
IGRhdGEpOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgICAgICAgICAgICBjYW5fYnVzX2NsaWVudF9z
ZW5kKCZzLT5idXNfY2xpZW50LCAmZnJhbWUsIDEpOw0KPiA+PiBJIGhhZCBhIHF1aWNrIGdsYW5j
ZSBhdCBjYW5fYnVzX2NsaWVudF9zZW5kKCk6DQo+ID4+DQo+ID4+IEl0IGRpZDoNCj4gPj4NCj4g
Pj4gICDCoMKgwqAgUVRBSUxRX0ZPUkVBQ0gocGVlciwgJmJ1cy0+Y2xpZW50cywgbmV4dCkgew0K
PiA+PiAgIMKgwqDCoMKgwqDCoMKgIGlmIChwZWVyLT5pbmZvLT5jYW5fcmVjZWl2ZShwZWVyKSkg
ew0KPiA+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHBlZXIgPT0gY2xpZW50KSB7DQo+
ID4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE5vIGxvb3BiYWNrIHN1cHBv
cnQgZm9yIG5vdyAqLw0KPiA+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250
aW51ZTsNCj4gPj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPj4gICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChwZWVyLT5pbmZvLT5yZWNlaXZlKHBlZXIsIGZyYW1lcywgZnJhbWVz
X2NudCkgPiAwKSB7DQo+ID4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IDE7DQo+ID4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4+ICAgwqDCoMKgwqDCoMKg
wqAgfQ0KPiA+PiAgIMKgwqDCoCB9DQo+ID4+DQo+ID4+IHdoaWNoIGxvb2tzIG5vdCBjb3JyZWN0
LiBXZSBuZWVkIHRvIHVzZSBxZW11X3NlbmRfcGFja2V0KCkgaW5zdGVhZCBvZg0KPiA+PiBjYWxs
aW5nIHBlZXItPmluZm8tPnJlY2VpdmUoKSBkaXJlY3RseSB3aGljaCBieXBhc3NlcyBmaWx0ZXJz
IGNvbXBsZXRlbHkuDQo+ID4gW1Zpa3JhbSBHYXJod2FsXSBDYW4geW91IHBsZWFzZSBlbGFib3Jh
dGUgaXQgYml0IG1vcmUgb24gd2h5IGRvIHdlIG5lZWQNCj4gdG8gZmlsdGVyIG91dGdvaW5nIG1l
c3NhZ2U/IFNvLCBJIGNhbiBlaXRoZXIgYWRkIGEgZmlsdGVyIGJlZm9yZSBzZW5kaW5nIHRoZQ0K
PiBwYWNrZXRzLiBJIGFtIHVuYWJsZSB0byB1bmRlcnN0YW5kIHRoZSB1c2UgY2FzZSBmb3IgaXQu
IEZvciBhbnkgbWVzc2FnZSB3aGljaA0KPiBpcyBpbmNvbWluZywgd2UgYXJlIGZpbHRlcmluZyBp
dCBmb3Igc3VyZSBiZWZvcmUgc3RvcmluZyBpbiB1cGRhdGVfcnhfZmlmbygpLg0KPiANCj4gDQo+
IEkgbWlnaHQgYmUgbm90IGNsZWFyLCBJIG1lYW50IHRoZSBuZXRmaWx0ZXJzIHN1cHBvcnRlZCBi
eSBxZW11IHdoaWNoIGFsbG93cw0KPiB5b3UgdG8gYXR0YWNoIGEgZmlsdGVyIHRvIGEgc3BlY2lm
aWMgTmV0Q2xpZW50U3RhdGUsIHNlZQ0KPiBxZW11X3NlbmRfcGFja2V0X2FzeW5jX3dpdGhfZmxh
Z3MuIEl0IGRvZXNuJ3QgbWVhbiB0aGUgZmlsdGVyIGltcGxlbWVudGVkDQo+IGluIHlvdXIgb3du
IE5JQyBtb2RlbC4NCj4gDQo+IFRoYW5rcw0KPiANCj4gDQo+ID4gQWxzbywgSSBjYW4gc2VlIGV4
aXN0aW5nIENBTiBtb2RlbHMgbGlrZSBDQU4gc2phMTAwMCBhbmQgQ0FOIEthdnNlciBhcmUNCj4g
dXNpbmcgaXQgc2FtZSBjYW5fYnVzX2NsaWVudF9zZW5kKCkgZnVuY3Rpb24uIEhvd2V2ZXIsIHRo
aXMgZG9lc24ndCBtZWFuDQo+IHRoYXQgaXQgaXMgdGhlIGNvcnJlY3Qgd2F5IHRvIHNlbmQgJiBy
ZWNlaXZlIHBhY2tldHMuDQoNCg==

