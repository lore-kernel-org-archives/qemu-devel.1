Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CDEC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F8020665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mw03Lrkx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mUoXLnRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F8020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3JP-0005Kj-CN
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 16:54:07 -0400
Received: from [209.51.188.92] (port=42588 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=078c2aed5=Alistair.Francis@wdc.com>)
 id 1hi39R-0007ew-5m
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=078c2aed5=Alistair.Francis@wdc.com>)
 id 1hi39G-0007cT-TC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:43:42 -0400
Received: from [216.71.154.45] (port=44702 helo=esa6.hgst.iphmx.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=078c2aed5=Alistair.Francis@wdc.com>)
 id 1hi31u-0003Eq-AL; Mon, 01 Jul 2019 16:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562013364; x=1593549364;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DahE47npIWS9ke4tWV84aYXhzXr+JE85An++stLyXcs=;
 b=Mw03LrkxDgI1OTdbIQTBvrjfGczdlMK4FonLUiHkYJ66wJ/ZdsGVQ3GG
 F8L4yR66Ijsnyylk/PUyul1JRvEWWAzoNdRMiZRhxMPdI6CghOxsJebAf
 C9e9XNX5ierchB7mtWBekVVi1pYDWUl2KoqKFh10g4BJSJcRqFtGrFXMU
 lP6O5ei7iFZK9vfZd048YpIa25wJvL/hJtZtWUG3BKJFGqQi/YxLf5p7U
 shlrNnva3vO7Fcy8kFR2alNS1GptQYJMAV1i5kczn45X1Qqst6VLwaVFc
 nXFr7QKL/I33629IehqNPEEo1mVFHAGe6ggS+a49MpaKP8olXt3RYHUAo A==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; d="scan'208";a="113601580"
Received: from mail-by2nam03lp2056.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.56])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 01:50:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DahE47npIWS9ke4tWV84aYXhzXr+JE85An++stLyXcs=;
 b=mUoXLnRzs/rQCfNLSuAJziEZBQTekw3spfQZJl4ce+iRu9qi7wxRIjtUWfJKSV6nJKXdcUViTobktU0qw3LZ2rIujqGe5D2HxPqtC3SzyMFV7r+OnOO/UXcJgPofEypjTC2yJ3ypoEkJlVu/ok9EVT3sCQ2UKJJY+p0vRN+hUJ4=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB5349.namprd04.prod.outlook.com (20.178.50.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 17:50:34 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::40b0:3c4b:b778:664d]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::40b0:3c4b:b778:664d%7]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 17:50:34 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "palmer@sifive.com"
 <palmer@sifive.com>
Thread-Topic: [PULL 33/34] roms: Add OpenSBI version 0.3
Thread-Index: AQHVLPx3D6cSVSLMSUSkcnC2JIn/F6a2AV8AgAAO5QA=
Date: Mon, 1 Jul 2019 17:50:34 +0000
Message-ID: <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
In-Reply-To: <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d649c1f7-13ff-4d42-25e0-08d6fe4c9e34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB5349; 
x-ms-traffictypediagnostic: BYAPR04MB5349:
x-ms-exchange-purlcount: 3
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5349962C97C535D301B40DCD90F90@BYAPR04MB5349.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(24433001)(199004)(189003)(54906003)(99286004)(76176011)(966005)(110136005)(316002)(2616005)(66066001)(102836004)(86362001)(2906002)(476003)(118296001)(186003)(72206003)(229853002)(305945005)(26005)(4326008)(71200400001)(256004)(36756003)(71190400001)(6116002)(6436002)(76116006)(8676002)(81156014)(6486002)(68736007)(3846002)(7736002)(53936002)(486006)(2501003)(66946007)(66476007)(73956011)(81166006)(66446008)(64756008)(5660300002)(25786009)(6512007)(14454004)(66556008)(6506007)(11346002)(478600001)(6246003)(8936002)(6306002)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5349;
 H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AEjkJOm2jTJwaOJkPZTCY3CyEUeDLFTnYMqqX5gYwH536qaLFrhAuQidd9BOz0asjweT9+mqRxK2HGDOcO54J5MoZ0RSOMnfQlHOu+zKMfVAVEZwk/7ddgqvN4IYjWD4/y/MlwU2TFGqTvzqrRc5wWAqJKkyUiHX+fqiuuFZ6ugxGLmIJzbEqGA2UZVWe+SZ8QffHd/S5CxFrW/d4YB+Pa8VLSReBf8ID+FWV1MVmAFVIL+UPexE6jgn4I/2P9fWzPVAf6Dglnz5EIfxA70Dnn+e5rl0lADoXLJ/RUiu0L4M0EvGfS+EF/XFrHllHbS1jUq5n1b1AKGA+Ufe++njMetmEf4hhgyz6+lPCcEJ1Cc3O+oa2PDuK88zQrdJ25CDkV22kVVASmtCAWUwNS/AFmRg7/ZStM+j+MGQthjo6G4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3434667945590344A58899CCB4334DBF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d649c1f7-13ff-4d42-25e0-08d6fe4c9e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 17:50:34.3192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Alistair.Francis@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5349
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.45
Subject: Re: [Qemu-devel] [PULL 33/34] roms: Add OpenSBI version 0.3
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
Cc: "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDE5LTA3LTAxIGF0IDE3OjU0ICswMTAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0K
PiBPbiBUaHUsIDI3IEp1biAyMDE5IGF0IDE2OjI0LCBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQHNp
Zml2ZS5jb20+DQo+IHdyb3RlOg0KPiA+IEZyb206IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbT4NCj4gPiANCj4gPiBBZGQgT3BlblNCSSB2ZXJzaW9uIDAuMyBhcyBh
IGdpdCBzdWJtb2R1bGUgYW5kIGFzIGEgcHJlYnVsdCBiaW5hcnkuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBCaW4gTWVuZyA8Ym1lbmcuY25AZ21haWwuY29tPg0KPiA+IFRlc3RlZC1i
eTogQmluIE1lbmcgPGJtZW5nLmNuQGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYWxt
ZXIgRGFiYmVsdCA8cGFsbWVyQHNpZml2ZS5jb20+DQo+ID4gLS0tDQo+ID4gIC5naXRtb2R1bGVz
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsrDQo+ID4gIE1ha2VmaWxl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICstDQo+ID4gIHBjLWJp
b3Mvb3BlbnNiaS1yaXNjdjMyLXZpcnQtZndfanVtcC5iaW4gICAgIHwgQmluIDAgLT4gMjg4NDgN
Cj4gPiBieXRlcw0KPiA+ICBwYy1iaW9zL29wZW5zYmktcmlzY3Y2NC1zaWZpdmVfdS1md19qdW1w
LmJpbiB8IEJpbiAwIC0+IDI4OTA0DQo+ID4gYnl0ZXMNCj4gPiAgcGMtYmlvcy9vcGVuc2JpLXJp
c2N2NjQtdmlydC1md19qdW1wLmJpbiAgICAgfCBCaW4gMCAtPiAyODkwNA0KPiA+IGJ5dGVzDQo+
ID4gIHJvbXMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQ4ICsr
KysrKysrKysrKysrLQ0KPiA+IC0tLS0NCj4gPiAgcm9tcy9vcGVuc2JpICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICA3IGZpbGVzIGNoYW5nZWQsIDQ0IGluc2Vy
dGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgcGMtYmlv
cy9vcGVuc2JpLXJpc2N2MzItdmlydC1md19qdW1wLmJpbg0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgcGMtYmlvcy9vcGVuc2JpLXJpc2N2NjQtc2lmaXZlX3UtZndfanVtcC5iaW4NCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHBjLWJpb3Mvb3BlbnNiaS1yaXNjdjY0LXZpcnQtZndfanVtcC5iaW4N
Cj4gPiAgY3JlYXRlIG1vZGUgMTYwMDAwIHJvbXMvb3BlbnNiaQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS8uZ2l0bW9kdWxlcyBiLy5naXRtb2R1bGVzDQo+ID4gaW5kZXggMjg1N2VlYzc2Mzc3Li43
YTEwZTcyZTA5Y2QgMTAwNjQ0DQo+ID4gLS0tIGEvLmdpdG1vZHVsZXMNCj4gPiArKysgYi8uZ2l0
bW9kdWxlcw0KPiA+IEBAIC01NSwzICs1NSw2IEBADQo+ID4gIFtzdWJtb2R1bGUgInNsaXJwIl0N
Cj4gPiAgICAgICAgIHBhdGggPSBzbGlycA0KPiA+ICAgICAgICAgdXJsID0gaHR0cHM6Ly9naXQu
cWVtdS5vcmcvZ2l0L2xpYnNsaXJwLmdpdA0KPiA+ICtbc3VibW9kdWxlICJyb21zL29wZW5zYmki
XQ0KPiA+ICsgICAgICAgcGF0aCA9IHJvbXMvb3BlbnNiaQ0KPiA+ICsgICAgICAgdXJsID0gaHR0
cHM6Ly9naXRodWIuY29tL3Jpc2N2L29wZW5zYmkuZ2l0DQo+IA0KPiBJdCB3b3VsZCBiZSBuaWNl
IHRvIHN0YXRlIHRoZSBsaWNlbnNlIGZvciBuZXcgYmxvYnMgd2UncmUNCj4gYWRkaW5nIHRvIHRo
ZSBzb3VyY2UgdHJlZS4uLiBJbiBwYXJ0aWN1bGFyLCBJIGZpbmQgdGhlDQo+IHJlYWRtZSBhdCBo
dHRwczovL2dpdGh1Yi5jb20vcmlzY3Yvb3BlbnNiaSBhIGJpdCBjb25mdXNpbmcNCj4gYmVjYXVz
ZSBpdCBzYXlzIGl0J3MgMi1CU0QgYnV0IGFsc28gdGhhdCBzb21lIHBhcnRzIGFyZSBBcGFjaGUt
Mi4wOw0KPiB0aGUgbGF0dGVyIGlzICpub3QqIEdQTC0yLjAgY29tcGF0aWJsZS4gVGhhdCBtYWtl
cyBpdCBub3QgY29tcGxldGVseQ0KPiBvYnZpb3VzIHRvIG1lIHRoYXQgd2UgY2FuIHNoaXAgdGhp
cyB3aXRoIFFFTVUuDQoNCkFoLCBJIGRpZG4ndCByZWFsaXNlIHRoZXJlIGlzIEFwYWNoZS0yLjAg
Y29kZSBpbiB0aGVyZS4NCg0KSW4gdGhpcyBjYXNlIGFsbCBvZiB0aGUgY29kZSB3ZSBhcmUgdXNp
bmcgKHdlIGFyZW4ndCB1c2luZyB0aGUgS2VuZHJ5dGUNCmNvZGUgd2l0aCBRRU1VKSBpcyBCU0Qt
Mi1DbGF1c2UuIEV2ZW4gdGhlbiB0aG91Z2ggZG9lcyBpdCBtYXR0ZXIgaWYgaXQNCmlzIEdQTCBj
b21wYXRpYmxlPyBUaGlzIGlzbid0IGJlaW5nIGxpbmtlZCB3aXRoIFFFTVUgaXQgaXMganVzdCBi
ZWluZw0KaW5jbHVkZWQgd2l0aCBRRU1VLg0KDQpJIGNhbiBhZGQgZGV0YWlscyBvZiB0aGUgbGlj
ZW5zZSBpbiB0aGUgc291cmNlIHRyZWUsIHdoZXJlIHNob3VsZCBpdCBiZQ0KYWRkZWQ/DQoNCj4g
DQo+IEFsc28sIG5ldyBnaXQgbW9kdWxlcyBpbiAuZ2l0bW9kdWxlcyBzaG91bGQgYmUgcWVtdS5v
cmcNCj4gVVJMcywgbm90IHJhbmRvbSBleHRlcm5hbCBvbmVzLiAoaWUsIHdlIHNob3VsZCBzZXQg
dXANCj4gbWlycm9yaW5nIG9mIGFueSBuZXcgZXh0ZXJuYWwgcmVwbyB3ZSBzdGFydCBzaGlwcGlu
Zw0KPiBjb2RlIGFuZCBiaW5hcmllcyBmb3IpLiBXZSBjYW4gc2V0IHRoaXMgdXAgYW5kIGZpeCB1
cCB0aGUNCj4gZ2l0bW9kdWxlcyBmaWxlIGFmdGVyIHRoZSBmYWN0LCBidXQgdGhlIGlkZWFsIGlz
IHRvIGRvDQo+IGl0IGluIGFkdmFuY2UgcmF0aGVyIHRoYW4gYWZ0ZXJ3YXJkcy4NCg0KT2ssIHdo
byBjYW4gc2V0dXAgYSBnaXQgbWlycm9yIGZvciB0aGUgUUVNVSByZXBvPw0KDQpQUzogSXQgc2Vl
bXMgbGlrZSB0aGVyZSBhcmUgc3RpbGwgc29tZSBpc3N1ZXMgd2l0aCB0aGlzIHBhdGNoIHNvIG1h
eWJlDQppdCdzIHdvcnRoIGRyb3BwaW5nIHRoaXMgcGF0Y2ggZnJvbSB0aGUgUFIgc28gdGhhdCB3
ZSBjYW4gZ2V0DQpldmVyeXRoaW5nIGVsc2UgbWVyZ2VkLg0KDQpBbGlzdGFpcg0KDQo+IA0KPiB0
aGFua3MNCj4gLS0gUE1NDQo=

