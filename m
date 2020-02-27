Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD4C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D682469C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 16:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="s26yb8h2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D682469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Lec-0004lS-EB
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 11:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1j7Ldw-0004J7-MJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fnuv@xilinx.com>) id 1j7Ldu-0004dC-IV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:04:07 -0500
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com
 ([40.107.244.53]:6028 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fnuv@xilinx.com>) id 1j7Ldu-0004cC-9u
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 11:04:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGMlMfdZUNsoG9MgDE7U0w+qE383ugYd37G5Oj7jI/tPxh8PIG44As6+3W9RB/qu2vyyI0wliMqcx5lXR/BET05Mr5wIdff/7hIqdkvnUUX9UZzEsyFMwC4ADjxeoOph4UA2HoPUaEinlyyMZLeO6xI/RWxpdL+eKKxbkrspeLJhEjvgKzJEUe5nAEfU3URGw91RRd5jEF/wdPSnQTDcs76dKlxnBmy+aJJTN0mlkOmDb6Wqk+MtVGJVAU6RiXD2Nb145sy1nAr4mjeRIm0o3BsQZ9JRpafOCXJ1hPCWYvPUAhkG7tkgOSsLewjPXqN0JH4HX0+jOHbK3jC+U9ejbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCdIGhniNvO0FX1o3qB7lzrSLs2qwNwemmHJ0Hb3d4o=;
 b=oeBwMUw0lQs5a+R+fLulfuOy/XUpr/r/A8TSWNOWOU6BFjZIQwZWeEfuUrngmkYVUL4fZiziqqgMfv6YNbI1UzpitMbYFGz5LEGIS9mqtf9r6CA3uGx1GiNB2rKlsqDTOkWGzClC1mursDLAT/VqAxvgC8ktC6C9BZqH9bwIe2ErGoKUa0U+mW7vquWd8boHLjkMZtA62th0Ka4m/GIaEmE2KdNd3vvrkRT74i0Zm7/0DaLxdQe7vcbLDeXRPUGUGQ6CA0K294SoNN/cQQLpXFW67SVFMyMrsEmaA1FTQ+Ru8XcidAkrnYIthBSqQQ0eofBCKH1lTZFDNahB2lz70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCdIGhniNvO0FX1o3qB7lzrSLs2qwNwemmHJ0Hb3d4o=;
 b=s26yb8h2chkm1JpQSwABUjVegiZnoMFf6L0slL/NBBpT+pxCKjzCOb2o17ynxr17TK8crjHK400WLsfcJfSug8JOLc+xNcZtmNW++IR5mDkpOCzJ+bdWQ/DoY6FGVFB6bvq2v7J/dZ3du41ES9pnsekjoUxxyR+DBeYdTqbf8UY=
Received: from BYAPR02MB5638.namprd02.prod.outlook.com (2603:10b6:a03:9f::18)
 by BYAPR02MB5429.namprd02.prod.outlook.com (2603:10b6:a03:99::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 16:04:02 +0000
Received: from BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::a0f2:bc3:62bd:e68]) by BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::a0f2:bc3:62bd:e68%5]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 16:04:02 +0000
From: Vikram Garhwal <fnuv@xilinx.com>
To: Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/1] hw/net/can: Introduce Xlnx ZynqMP CAN controller for
 QEMU
Thread-Topic: [PATCH 1/1] hw/net/can: Introduce Xlnx ZynqMP CAN controller for
 QEMU
Thread-Index: AQHV2+ex6bt4rBh6tUGf0DorXXlOrKgU9+UwgABhioCAEMZIQIAG0RsAgAJlqhA=
Date: Thu, 27 Feb 2020 16:04:02 +0000
Message-ID: <BYAPR02MB5638263F409024D5838E8E7CBCEB0@BYAPR02MB5638.namprd02.prod.outlook.com>
References: <1580764010-310744-1-git-send-email-fnu.vikram@xilinx.com>
 <1580764010-310744-2-git-send-email-fnu.vikram@xilinx.com>
 <8aabde0d-62e9-96d5-0614-0e0ebff549ae@redhat.com>
 <DM6PR02MB5643F9E19DC0590E14612477BC190@DM6PR02MB5643.namprd02.prod.outlook.com>
 <b1b9932a-5566-5d2b-c333-8c466dcd322b@redhat.com>
 <BYAPR02MB5638E0507A08A3404D2AFB12BCED0@BYAPR02MB5638.namprd02.prod.outlook.com>
 <e20c4dbc-98d8-8a13-78fb-e203f4dbae71@redhat.com>
In-Reply-To: <e20c4dbc-98d8-8a13-78fb-e203f4dbae71@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fnuv@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d781d512-c001-4f12-734b-08d7bb9ea9cd
x-ms-traffictypediagnostic: BYAPR02MB5429:|BYAPR02MB5429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB542947001F706A6E33C4C5B6BCEB0@BYAPR02MB5429.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(52536014)(966005)(478600001)(5660300002)(107886003)(9686003)(55016002)(86362001)(316002)(110136005)(53546011)(6506007)(8936002)(66946007)(66446008)(7696005)(76116006)(26005)(186003)(2906002)(81156014)(81166006)(33656002)(8676002)(71200400001)(4326008)(66476007)(66556008)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB5429;
 H:BYAPR02MB5638.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSWpNCP7Po1YvPy94gvC8B1zI9Ax+DdpQ37M4fL8IovOErRdfZoRrFvkh6GJWZzsRV3XahmUKo4FF2dm32c2SwqNGvzMQbeDiBY1+DppqswaZd3xPC2IF5pdfDmyZC0djDHEF5wycvp46m1RX4RLvHq+JvL6rjORCtMgEJnoH6cBZ2kFsFrqPgx6iu6sZyEMhhL1MQbdkVxdod/7DR1wQ9Z6tXDQV9ZstzW6Z/Gg1s1xhLBQbPfuAIWSpW7Vw/lg3TYKCz/baQ+uGeAeJgigRtRKIQoAFgiY4hRN7/N1tFVtJ2j4Z/NlAqlY55Ns4e+FGg9BKUHhN1bOZn4N+obr3d0ve7V9Zg47GNU1xK0J+0h+CvFuFz7sR3ZEP5D2UKMvhIVNtnPR9n9vRd9R0vsgPqxvAw/+ha/OvAmgyBxaSMPhGZzIEmVjNlkz9tCYBbt4QwGsN2tEixvopSL/WXkkrN6pFbBwvLZz4b/rIkDThoyGDDNXR21BdeusUD0uwom6ZYxWyW60RE6fBk6CJaydcA==
x-ms-exchange-antispam-messagedata: MBVlf5k/ncgiZn4qWkUpF2niqNdF0o8b401ZltNH7BPfSZ6oDxi5s57GhxPfUOkIKSdo2/cXKH6GEI32u8tXzWmLV8hkdTg/dxUZHLxqUFLRykVD7ADKk88CDz6H1jZ6RYySXJ1UNYQNiHhUBP/Svg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d781d512-c001-4f12-734b-08d7bb9ea9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 16:04:02.2676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vhN58zxAIgZApbri0dQaoNTTF22a8nUStc5098fv942jyr4bBxkVHkoT+1LojYq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5429
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.53
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

SGkgSmFzb24sDQpUaGFua3MgZm9yIHJlcGx5aW5nLiANClllYWgsIHdlIGNhbiBzdGFydCBsb29r
aW5nIGludG8gY29tYmluaW5nIE5ldENsaWVudCBhbmQgQ2FuQnVzQ2xpZW50IGluIG5lYXIgZnV0
dXJlLg0KDQpNZWFud2hpbGUgc2VuZGluZyBhIFYyIHRvZGF5IHdpdGggaW5jb3Jwb3JhdGluZyB5
b3VyIHN1Z2dlc3Rpb24uLiANClJlZ2FyZHMsDQpWaWtyYW0NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBT
ZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyNSwgMjAyMCA3OjI1IFBNDQo+IFRvOiBWaWtyYW0gR2Fy
aHdhbCA8Zm51dkB4aWxpbnguY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBGcmFu
Y2lzY28gRWR1YXJkbyBJZ2xlc2lhcyA8ZmlnbGVzaWFAeGlsaW54LmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzFdIGh3L25ldC9jYW46IEludHJvZHVjZSBYbG54IFp5bnFNUCBDQU4NCj4g
Y29udHJvbGxlciBmb3IgUUVNVQ0KPiANCj4gDQo+IE9uIDIwMjAvMi8yNSDkuIvljYgyOjIyLCBW
aWtyYW0gR2FyaHdhbCB3cm90ZToNCj4gPiBIaSBKYXNvbiwNCj4gPiBBcG9sb2dpZXMgZm9yIHRo
ZSBkZWxheWVkIHJlc3BvbnNlLiBJIHRyaWVkIHBsdWdnaW5nIE5ldENsaWVudFN0YXRlIGluIHRo
ZQ0KPiBDQU4gd2hpY2ggaXMgcmVxdWlyZWQgaWYgd2UgdXNlIHFlbXVfc2VuZF9wYWNrZXQgYnV0
IHRoaXMgd2lsbCBjaGFuZ2UgdGhlDQo+IHVuZGVybHlpbmcgYXJjaGl0ZWN0dXJlIG9mIGNhbi1j
b3JlLCBjYW4tc29ja2V0Y2FuIGEgbG90LiBUaGlzIG1lYW5zDQo+IGNoYW5nZXMgdGhlIHdheSBD
QU4gYnVzIGlzIGNyZWF0ZWQvd29ya3MgYW5kIHNvY2tldCBDQU4gd29ya3MuIENBTg0KPiBTb2Nr
ZXQoQ0FOIFJhdyBzb2NrZXQpIGlzIG11Y2ggZGlmZmVyZW50IGZyb20gRXRoZXJuZXQgc28gcGx1
Z2dpbmcvdXNpbmcNCj4gTmV0Q2xpZW50IHN0YXRlIGlzIG5vdCB3b3JraW5nIGhlcmUuDQo+IA0K
PiANCj4gSSBnZXQgeW91Lg0KPiANCj4gDQo+ID4NCj4gPiBJIGFwb2xvZ2l6ZSBmb3Igc3RpbGwg
YmVpbmcgYSBsaXR0bGUgY29uZnVzZWQgYWJvdXQgdGhlIGZpbHRlcnMgYnV0IHdoZW4NCj4gbG9v
a2luZyBpbnRvIHRoZSBjb2RlLCBJIGNhbiBvbmx5IGZpbmQgdGhlbSBiZWluZyB1c2VkIHdpdGgg
ZXRoZXJuZXQgZnJhbWVzLg0KPiBTaW5jZSBubyBvdGhlciBjYW4gY29udHJvbGxlciB1c2VzIE5l
dENsaWVudFN0YXRlIGl0IG1ha2VzIG1lIHdvbmRlciBpZiB0aGlzDQo+IG1vZGVsIHBlcmhhcHMg
d2FzIHRob3VnaHQgb2YgYmVpbmcgYW4gZXRoZXJuZXQgTklDPw0KPiANCj4gDQo+IE5vcGUgTmV0
Y2xpZW50U3RhdGUgaXMgbm90IG5lY2Vzc2FyaWx5IGEgTklDLCBpdCBjYW4gYmUgYSBwZWVyIG9m
IHRoZSBOSUMgKGUuZw0KPiBuZXR3b3JrIGJhY2tlbmQgbGlrZSB0YXAsIGh1YnBvcnQgZXRjKS4N
Cj4gDQo+IA0KPiA+IE9yIGhhcyB0aGUgY29kZSBpbiBuZXQvY2FuLyB3aGljaCBJIHJlZmVyZW5j
ZWQgYmVlbiBvYnNvbGV0ZWQ/DQo+IA0KPiANCj4gTm8gOikNCj4gDQo+IA0KPiA+DQo+ID4gU2hh
cmluZyB0aGlzIGxpbmsgZm9yIFNvY2tldENBTihpbiBjYXNlIHlvdSB3YW50IHRvIGhhdmUgYSBs
b29rKToNCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvRG9jdW1lbnRhdGlvbi9uZXR3b3Jr
aW5nL2Nhbi50eHQuIFNlY3Rpb24gNA0KPiB0YWxrcyBvbiBob3cgQ0FOIFNvY2tldCBpcyBpbnRl
bmRlZCB0byB3b3JrLiBFcXVpdmFsZW50IGZpbGUgaXMgbG9jYXRlZCBhcw0KPiBuZXQvY2FuLXNv
Y2tldGNhbi5jLg0KPiANCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHBvaW50ZXIuDQo+IA0KPiBJIGFn
cmVlIHRoYXQgdGhlcmUncyBubyBuZWVkIHRvIGNoYW5nZSB0aGF0IHBhcnQuIEJ1dCB3ZSBtYXkg
Y29uc2lkZXIgdG8NCj4gdW5pZnkgdGhlIENhbkJ1c0NsaWVudFN0YXRlIGFuZCBOZXRDbGllbnRT
dGF0ZSBpbiB0aGUgZnV0dXJlLg0KPiANCj4gDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IFZpa3Jh
bQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkg
MTAsIDIwMjAgNzowOSBQTQ0KPiA+PiBUbzogVmlrcmFtIEdhcmh3YWwgPGZudXZAeGlsaW54LmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0g
aHcvbmV0L2NhbjogSW50cm9kdWNlIFhsbnggWnlucU1QIENBTg0KPiBjb250cm9sbGVyDQo+ID4+
IGZvciBRRU1VDQo+ID4+DQo+ID4+DQo+ID4+IE9uIDIwMjAvMi8xMSDkuIrljYg1OjQ1LCBWaWty
YW0gR2FyaHdhbCB3cm90ZToNCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICB9DQo+ID4+Pj4+ICsg
ICAgICAgICAgICB9IGVsc2Ugew0KPiA+Pj4+PiArICAgICAgICAgICAgICAgIC8qIE5vcm1hbCBt
b2RlIFR4LiAqLw0KPiA+Pj4+PiArICAgICAgICAgICAgICAgIGdlbmVyYXRlX2ZyYW1lKCZmcmFt
ZSwgZGF0YSk7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICBjYW5fYnVzX2Ns
aWVudF9zZW5kKCZzLT5idXNfY2xpZW50LCAmZnJhbWUsIDEpOw0KPiA+Pj4+IEkgaGFkIGEgcXVp
Y2sgZ2xhbmNlIGF0IGNhbl9idXNfY2xpZW50X3NlbmQoKToNCj4gPj4+Pg0KPiA+Pj4+IEl0IGRp
ZDoNCj4gPj4+Pg0KPiA+Pj4+ICAgIMKgwqDCoCBRVEFJTFFfRk9SRUFDSChwZWVyLCAmYnVzLT5j
bGllbnRzLCBuZXh0KSB7DQo+ID4+Pj4gICAgwqDCoMKgwqDCoMKgwqAgaWYgKHBlZXItPmluZm8t
PmNhbl9yZWNlaXZlKHBlZXIpKSB7DQo+ID4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAocGVlciA9PSBjbGllbnQpIHsNCj4gPj4+PiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLyogTm8gbG9vcGJhY2sgc3VwcG9ydCBmb3Igbm93ICovDQo+ID4+Pj4gICAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPiA+Pj4+ICAgIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQ0KPiA+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHBlZXIt
PmluZm8tPnJlY2VpdmUocGVlciwgZnJhbWVzLCBmcmFtZXNfY250KSA+IDApIHsNCj4gPj4+PiAg
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gMTsNCj4gPj4+PiAgICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPj4+PiAgICDCoMKgwqDCoMKgwqDCoCB9DQo+ID4+Pj4g
ICAgwqDCoMKgIH0NCj4gPj4+Pg0KPiA+Pj4+IHdoaWNoIGxvb2tzIG5vdCBjb3JyZWN0LiBXZSBu
ZWVkIHRvIHVzZSBxZW11X3NlbmRfcGFja2V0KCkgaW5zdGVhZA0KPiBvZg0KPiA+Pj4+IGNhbGxp
bmcgcGVlci0+aW5mby0+cmVjZWl2ZSgpIGRpcmVjdGx5IHdoaWNoIGJ5cGFzc2VzIGZpbHRlcnMN
Cj4gY29tcGxldGVseS4NCj4gPj4+IFtWaWtyYW0gR2FyaHdhbF0gQ2FuIHlvdSBwbGVhc2UgZWxh
Ym9yYXRlIGl0IGJpdCBtb3JlIG9uIHdoeSBkbyB3ZQ0KPiBuZWVkDQo+ID4+IHRvIGZpbHRlciBv
dXRnb2luZyBtZXNzYWdlPyBTbywgSSBjYW4gZWl0aGVyIGFkZCBhIGZpbHRlciBiZWZvcmUgc2Vu
ZGluZw0KPiB0aGUNCj4gPj4gcGFja2V0cy4gSSBhbSB1bmFibGUgdG8gdW5kZXJzdGFuZCB0aGUg
dXNlIGNhc2UgZm9yIGl0LiBGb3IgYW55IG1lc3NhZ2UNCj4gd2hpY2gNCj4gPj4gaXMgaW5jb21p
bmcsIHdlIGFyZSBmaWx0ZXJpbmcgaXQgZm9yIHN1cmUgYmVmb3JlIHN0b3JpbmcgaW4gdXBkYXRl
X3J4X2ZpZm8oKS4NCj4gPj4NCj4gPj4NCj4gPj4gSSBtaWdodCBiZSBub3QgY2xlYXIsIEkgbWVh
bnQgdGhlIG5ldGZpbHRlcnMgc3VwcG9ydGVkIGJ5IHFlbXUgd2hpY2gNCj4gYWxsb3dzDQo+ID4+
IHlvdSB0byBhdHRhY2ggYSBmaWx0ZXIgdG8gYSBzcGVjaWZpYyBOZXRDbGllbnRTdGF0ZSwgc2Vl
DQo+ID4+IHFlbXVfc2VuZF9wYWNrZXRfYXN5bmNfd2l0aF9mbGFncy4gSXQgZG9lc24ndCBtZWFu
IHRoZSBmaWx0ZXINCj4gaW1wbGVtZW50ZWQNCj4gPj4gaW4geW91ciBvd24gTklDIG1vZGVsLg0K
PiA+Pg0KPiA+PiBUaGFua3MNCj4gPj4NCj4gPj4NCj4gPj4+IEFsc28sIEkgY2FuIHNlZSBleGlz
dGluZyBDQU4gbW9kZWxzIGxpa2UgQ0FOIHNqYTEwMDAgYW5kIENBTiBLYXZzZXINCj4gYXJlDQo+
ID4+IHVzaW5nIGl0IHNhbWUgY2FuX2J1c19jbGllbnRfc2VuZCgpIGZ1bmN0aW9uLiBIb3dldmVy
LCB0aGlzIGRvZXNuJ3QNCj4gbWVhbg0KPiA+PiB0aGF0IGl0IGlzIHRoZSBjb3JyZWN0IHdheSB0
byBzZW5kICYgcmVjZWl2ZSBwYWNrZXRzLg0KDQo=

