Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CABFC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92982070E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="hwFtD6Eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92982070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA1B8-00057C-6G
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 19:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1jA1AO-0004PW-LV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1jA1AM-0007sM-Lc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:48:39 -0500
Received: from mail-eopbgr1280110.outbound.protection.outlook.com
 ([40.107.128.110]:1504 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>)
 id 1jA1AM-0007og-5f; Thu, 05 Mar 2020 19:48:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRf9UOzTLcc4sfMspDMsTjM1VbtGUqy/bvb3fkcQJaeqVnUts6CRMn6U7Vl+ix/yGe0UIZRBtvI+YV90tqUhb5Dro87XT2IysvfHH+0g+23yObMTA45GFpT0kSyguebXJjRMmbJcgoNlNowLM5xVR/YVcYJlTHXp7L8UzHqftywOaoaVvYEB7yABj89f5/rKoigCjpKdrQv2a6JsPS5tDQkdluNL3aSqfAnOGTfk8p0NMLd53Lw5X+6k2y7NSBi/QXlX6+OlxbE8DpgUKxB7aI6bYnV/WkqAY5vsm50bdAWa5FFgZgP3EHT6CjOSnoroWKNacZc2B47bXEAY52fB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whVacIJqX69qm5hWAQ3VNyifDe82FThU4/X4NX1pMbM=;
 b=KwSq+vzec/pl1AmKWxijnsvXSz1uPPaHvHvxf1jPg/8xba48CbbZNYwKbdfU6k7m2otyeaSQyDcWdi3tMTK0/N4INxPVtSf8may1PFsCoXj5PmUXn4akqzkwPXfwAYzMWmZPlBXNB1f6xOOcaAOwZlj4BxBjNwk/WIK0k6MJNbO8Hwsynxg+SUWAF05OOW9XWQFXKCfZBbDvVQcSj6NDPVzJ3KqGiynk91GyYfNL+UdZMwFxoQT+Ff4ZgV1tQFJm3hXFAMAibNR9No+KINubW470E+ZCm4mnjUbZT1gpM0pSRBZs3y5NR4u88xlSVBImGuBgBdSH0LjrKtC+ZHyDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whVacIJqX69qm5hWAQ3VNyifDe82FThU4/X4NX1pMbM=;
 b=hwFtD6Egr5bNKB20Om8k4ZYjy02FRiN97s+6QHMkRQAzGgzDW4UtLMimUWoIherYiAUJdYUCLiJBKTatscxcGUaJHG8afa9jaA/1BGuqQUjyAO72E7aOfZMzqieU6WU02+BxAG3JjzhJwoWPch+VppNUbffjsEFFm6CF3fSkE04=
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXP216MB0462.KORP216.PROD.OUTLOOK.COM (10.174.37.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Fri, 6 Mar 2020 00:48:33 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b%8]) with mapi id 15.20.2772.020; Fri, 6 Mar 2020
 00:48:33 +0000
From: Stephanos Ioannidis <root@stephanos.io>
To: 'Peter Maydell' <peter.maydell@linaro.org>, 'Alistair Francis'
 <alistair23@gmail.com>
Subject: RE: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation support
Thread-Topic: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation support
Thread-Index: AQHV7woHqkXTlwmtzEaPvIqQyhXhp6g6Z0OAgAADmICAAFcSsA==
Date: Fri, 6 Mar 2020 00:48:33 +0000
Message-ID: <SLXP216MB0285BF0CF1158A96DDABA736BDE30@SLXP216MB0285.KORP216.PROD.OUTLOOK.COM>
References: <20200229141011.58989-1-root@stephanos.io>
 <CAKmqyKP1QFiWSQzUsoV9TLWBQ8hrx+yg7UM2=DnAoCAanLRuwA@mail.gmail.com>
 <CAFEAcA_O6ScMF0fJgHORVXDQ+PvFNW4w6kBkeeB0vHixHo0zqA@mail.gmail.com>
In-Reply-To: <CAFEAcA_O6ScMF0fJgHORVXDQ+PvFNW4w6kBkeeB0vHixHo0zqA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
x-originating-ip: [1.214.196.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f071a58e-2dec-4bb7-6ec6-08d7c16818e3
x-ms-traffictypediagnostic: SLXP216MB0462:
x-microsoft-antispam-prvs: <SLXP216MB04626D4753220BE76213C6F9BDE30@SLXP216MB0462.KORP216.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39830400003)(189003)(199004)(8676002)(186003)(110136005)(66476007)(66446008)(26005)(54906003)(66556008)(81156014)(64756008)(316002)(33656002)(76116006)(9686003)(81166006)(52536014)(2906002)(8936002)(55016002)(66946007)(5660300002)(71200400001)(6506007)(4326008)(508600001)(53546011)(86362001)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SLXP216MB0462;
 H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gu6suonqA4hl49nUnPLmyzeezl1cfVxWQaEhxams9D2aWNNrQJ160W911YKeufBmyIZUyYJtuEcgwuOdHvXDmQ9aCQe+H3dhUrS5es/aV7PxwzGe4JHmcn3RE25s09BypDqZU7Ch5Hme2QDTz1wkhzEuZymvZJu6obzsTNRIu7b5zAcDXI1bSYqnukljbWiGX+qkOavzhtzRG/gt61Q8qj1ZDzvEwkoL+CTw8xY3xjM9gI6kM7OgqprJAXXgCINbBfYRvYavMpmqSLfwRXdTrjbID4PIpVmmmOCysM7OrGSN9/IP0/SHWSbceq0IvSDtSq45BceVaogllwkfxx+IXBlUFWDf6ILN+wdtd1ConVb93MRQo7wIsAhSFd8VEehZNvA2IRODRa13eLrYuSiD1ZqgdLBPdDSmThU0qbMl/S2gWp9LIGwEzUOS3450yfrH
x-ms-exchange-antispam-messagedata: KIJ04hb6BOOC35IiPkZCDDdTaRjvSxEdkxujnefz6Ql1a44Qmq6FsMPVnibIxMyNWAv1GdKb+oAgANLXNMVYXTbhMRY2R8kun3e76hahWf86Sj3gY3FVruqhWBBy5OO5sxJJZQSz4Eoa1GDZioYNjw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f071a58e-2dec-4bb7-6ec6-08d7c16818e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 00:48:33.3422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPcrYAcGcUdt51qhTxktEOs5gV+yYrXelJLpGx/GhV/Hl4fjfP7lLM00lICUGfjWvyikd8BFPCejepaJOin0aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0462
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.110
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
Cc: 'Alistair Francis' <alistair@alistair23.me>, "'open list:All patches CC
 here'" <qemu-devel@nongnu.org>,
 "'open list:ARM TCG CPUs'" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBJcyBpdCBwb3J0YWJsZSwgdGhvdWdoPyBJIHRob3VnaHQgQyBiaXRmaWVsZCBvcmRlciBhbmQg
cGFja2luZyB3YXMgaW1wbGVtZW50YXRpb24tZGVmaW5lZCwgd2hpY2ggd291bGQgbWVhbiB0aGF0
IHlvdSBjYW4ndCBndWFyYW50ZWUgdGhhdCB0aGlzIHVuaW9uIHdpbGwgZ2l2ZSB5b3UgdGhlIHJl
cXVpcmVkIHRoaW5nIGluIHRoZSB1aW50MzJfdCBoYWxmLg0KDQpUaGV5IGFyZSBpbmRlZWQgaW1w
bGVtZW50YXRpb24gZGVmaW5lZC4gQXMgZm9yIHBhY2tpbmcsIGl0IGlzIG9mdGVuIGNvbnRyb2xs
YWJsZTsgYXMgZm9yIG9yZGVyLCBJIGRvIG5vdCByZWNhbGwgc2VlaW5nIGEgY29tcGlsZXIgdGhh
dCBkYXJlcyB0byBjaGFuZ2UgdGhlIG9yZGVyIGJ5IHdoaWNoIHRoZSBmaWVsZHMgYXJlIHNwZWNp
ZmllZDsgdGhvdWdoDQpJIHVuZGVyc3RhbmQgdGhlIGNvbmNlcm4gaWYgUUVNVSBwb2xpY3kgaXMg
dG8gYmUgYXMgcG9ydGFibGUgYXMgcG9zc2libGUuDQoNCkRvZXMgUUVNVSBoYXZlIGFueSBmb3Jt
IG9mIGJpdCBmaWVsZCBtYW5pcHVsYXRpb24gbWFjcm9zIChlLmcuIEdFVF9CSVRfUkFOR0UoYSwg
YiksIFNFVF9CSVRfUkFOR0UoYSwgYiksIC4uLik/DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+IA0KU2Vu
dDogRnJpZGF5LCBNYXJjaCA2LCAyMDIwIDQ6MzAgQU0NClRvOiBBbGlzdGFpciBGcmFuY2lzIDxh
bGlzdGFpcjIzQGdtYWlsLmNvbT4NCkNjOiBTdGVwaGFub3MgSW9hbm5pZGlzIDxyb290QHN0ZXBo
YW5vcy5pbz47IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBvcGVu
IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgb3BlbiBs
aXN0OkFSTSBUQ0cgQ1BVcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGh3L2FybS9zdG0zMmY0MDU6IEFkZCBwcmVsaW1pbmFyeSBSQ0MgZW11bGF0aW9uIHN1cHBv
cnQNCg0KT24gVGh1LCA1IE1hciAyMDIwIGF0IDE5OjI0LCBBbGlzdGFpciBGcmFuY2lzIDxhbGlz
dGFpcjIzQGdtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IE9uIFNhdCwgRmViIDI5LCAyMDIwIGF0IDY6
MTIgQU0gU3RlcGhhbm9zIElvYW5uaWRpcyA8cm9vdEBzdGVwaGFub3MuaW8+IHdyb3RlOg0KDQo+
ID4gK3R5cGVkZWYgdW5pb24gew0KPiA+ICsgICAgc3RydWN0IHsNCj4gPiArICAgICAgICB1aW50
MzJfdCBoc2lvbiA6IDE7DQo+ID4gKyAgICAgICAgdWludDMyX3QgaHNpcmR5IDogMTsNCj4gPiAr
ICAgICAgICB1aW50MzJfdCByZXNlcnZlZDAgOiAxOw0KPiA+ICsgICAgICAgIHVpbnQzMl90IGhz
aXRyaW0gOiA1Ow0KPiA+ICsgICAgICAgIHVpbnQzMl90IGhzaWNhbCA6IDg7DQo+ID4gKyAgICAg
ICAgdWludDMyX3QgaHNlb24gOiAxOw0KPiA+ICsgICAgICAgIHVpbnQzMl90IGhzZXJkeSA6IDE7
DQo+ID4gKyAgICAgICAgdWludDMyX3QgaHNlYnlwIDogMTsNCj4gPiArICAgICAgICB1aW50MzJf
dCBjc3NvbiA6IDE7DQo+ID4gKyAgICAgICAgdWludDMyX3QgcmVzZXJ2ZWQxIDogNDsNCj4gPiAr
ICAgICAgICB1aW50MzJfdCBwbGxvbiA6IDE7DQo+ID4gKyAgICAgICAgdWludDMyX3QgcGxscmR5
IDogMTsNCj4gPiArICAgICAgICB1aW50MzJfdCBwbGxpMnNvbiA6IDE7DQo+ID4gKyAgICAgICAg
dWludDMyX3QgcGxsaTJzcmR5IDogMTsNCj4gPiArICAgICAgICB1aW50MzJfdCByZXNlcnZlZDIg
OiA0Ow0KPiA+ICsgICAgfTsNCj4gPiArICAgIHVpbnQzMl90IHJlZzsNCj4gPiArfSBSY2NDclR5
cGU7DQo+DQo+IFRoaXMgaXMgYSBwcmV0dHkgaW50ZXJlc3Rpbmcgd2F5IHRvIHJlcHJlc2VudCB0
aGUgcmVnaXN0ZXJzDQoNCklzIGl0IHBvcnRhYmxlLCB0aG91Z2g/IEkgdGhvdWdodCBDIGJpdGZp
ZWxkIG9yZGVyIGFuZCBwYWNraW5nIHdhcyBpbXBsZW1lbnRhdGlvbi1kZWZpbmVkLCB3aGljaCB3
b3VsZCBtZWFuIHRoYXQgeW91IGNhbid0IGd1YXJhbnRlZSB0aGF0IHRoaXMgdW5pb24gd2lsbCBn
aXZlIHlvdSB0aGUgcmVxdWlyZWQgdGhpbmcgaW4gdGhlIHVpbnQzMl90IGhhbGYuDQoNCkkgdGhp
bmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIGRvIHRoaXMgdGhlIHdheSB0aGF0IG90aGVyIGRldmlj
ZSBtb2RlbHMgZG8gaXQsIGFuZCBhdm9pZCBiaXRmaWVsZHMuDQoNCnRoYW5rcw0KLS0gUE1NDQo=

