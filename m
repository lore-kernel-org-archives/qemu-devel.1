Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FDDC06510
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5956B206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ApqzqE1K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HzTzhqMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5956B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4H4-0007yO-DN
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:55:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=078c2aed5=Alistair.Francis@wdc.com>)
 id 1hi3JU-0006Dj-OE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=078c2aed5=Alistair.Francis@wdc.com>)
 id 1hi3JP-0003tr-8u
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=078c2aed5=Alistair.Francis@wdc.com>)
 id 1hi3JH-0003nA-ID; Mon, 01 Jul 2019 16:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562014441; x=1593550441;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=sRZQGemFhJcGaiaqalz9evSv7ZCo+bZ6qNmy3ckWB48=;
 b=ApqzqE1KMtv4kB61jjxgsL74EuboaVRCskZeja/13Y0W828mliOF3ZwL
 sCNU5wDDsgEE/07ytEzu6FcaIUS34yhq5ATjTDhTKQ2MOC0uzUfnbg1xV
 Cuq2V4WLoz00pkmA6TzXuKG8aVQjOS08peSAPOGOWApBl/WfUxpnPrdwH
 VRw4P8WlIyIDnwkNeLBHYSBqzXYqvkroDshVorZJFQgn3Dgsn8Av+Nw2o
 IxdqKR20SawIp6gsW0L1KDWzoIqvKGkyzYEZlMHJOrupG/uyz3bwIp9dP
 OISvOAnDCfzzQ98KkbvGULYQIait129CiBshbvFMEtlFgWO2HPc6VU5+G w==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; d="scan'208";a="111980239"
Received: from mail-by2nam03lp2053.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.53])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 02:09:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRZQGemFhJcGaiaqalz9evSv7ZCo+bZ6qNmy3ckWB48=;
 b=HzTzhqMW4PGy/I76KoHqEVDTDTt8AHkUOr5rdC2v/Y5NyI2jNMsDzoTUFQTUJLpYOqOvL6BlyEqLouhJ9aj4+mGf4BQ/LgukW737LrD7FlVdUor73laWZfSQ4JOy+tvvroVVSulv0+ekOy1CJSLexQJYJ76E5sr0SnoYSLGj1Vs=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB3989.namprd04.prod.outlook.com (52.135.215.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 18:09:19 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::40b0:3c4b:b778:664d]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::40b0:3c4b:b778:664d%7]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 18:09:19 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Thread-Topic: [PULL 33/34] roms: Add OpenSBI version 0.3
Thread-Index: AQHVLPx3D6cSVSLMSUSkcnC2JIn/F6a2AV8AgAAO5QCAAAOyAIAAAYuA
Date: Mon, 1 Jul 2019 18:09:19 +0000
Message-ID: <efaaaa7aabddfb8481af4c5b2eeec23513f8fcb8.camel@wdc.com>
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
 <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
 <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
In-Reply-To: <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 592e0622-0be3-4192-6ed5-08d6fe4f3cb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB3989; 
x-ms-traffictypediagnostic: BYAPR04MB3989:
x-ms-exchange-purlcount: 3
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB39896087B532542F883540DB90F90@BYAPR04MB3989.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(24433001)(199004)(189003)(26005)(36756003)(2616005)(316002)(6486002)(4326008)(68736007)(476003)(81156014)(2351001)(966005)(6506007)(86362001)(486006)(102836004)(14454004)(6916009)(2501003)(53936002)(8676002)(72206003)(305945005)(478600001)(11346002)(8936002)(81166006)(446003)(25786009)(186003)(6436002)(66476007)(6246003)(2906002)(66946007)(64756008)(66446008)(6512007)(66556008)(76116006)(5660300002)(73956011)(5640700003)(6306002)(229853002)(3846002)(7736002)(6116002)(118296001)(99286004)(76176011)(66066001)(71200400001)(71190400001)(54906003)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3989;
 H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w0bh6lIYSBVDTALtc4f08rn+L1zxer9Go/QzAEK5nxS8xDqbZfOAeHv0j2f7kUcc7TT7MWzT8dY35XaBhX6SvbAbe4mw0/1/uhHd1coD+jVKoTXXnEvs7NmEKO2dkcOyGpOHx4kw8AIjjiP3h6ohLNG0V/5OnEIMnJ5ZpzZp003xqswxUkiAFEoTaPKtvxwyhwcmEu6YDN9OxpCM9HFhph0JlIE3LhvEqrk0PS8NudeAJyb85KJjjZa1YOyF+D0rKDB/38VGtgBSlWxrvkd3rhbL4e/tIWjFYZuOSTYDeTQqtrC/FnAApvwvjI2CE6Jlpht7zTyNhy/tlnYo9tdq0R7yX+U8q82lTQPjD2jO75QN+0kVMbGzFs6djtSh6x9y+etMFyCp0Abwtuf8GF2OO8lTk553F786w1xxZbfkOSE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F4A81D1D3788F47809604D3618356A1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592e0622-0be3-4192-6ed5-08d6fe4f3cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 18:09:19.2535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Alistair.Francis@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3989
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDE5LTA3LTAxIGF0IDE5OjAxICswMTAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0K
PiBPbiBNb24sIDEgSnVsIDIwMTkgYXQgMTg6NTAsIEFsaXN0YWlyIEZyYW5jaXMgPA0KPiBBbGlz
dGFpci5GcmFuY2lzQHdkYy5jb20+IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxOS0wNy0wMSBhdCAx
Nzo1NCArMDEwMCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gPiA+IE9uIFRodSwgMjcgSnVuIDIw
MTkgYXQgMTY6MjQsIFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAc2lmaXZlLmNvbT4NCj4gPiA+IHdy
b3RlOg0KPiA+ID4gPiBGcm9tOiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdk
Yy5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBBZGQgT3BlblNCSSB2ZXJzaW9uIDAuMyBhcyBhIGdp
dCBzdWJtb2R1bGUgYW5kIGFzIGEgcHJlYnVsdA0KPiA+ID4gPiBiaW5hcnkuDQo+ID4gPiA+IA0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lz
QHdkYy5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBCaW4gTWVuZyA8Ym1lbmcuY25AZ21haWwu
Y29tPg0KPiA+ID4gPiBUZXN0ZWQtYnk6IEJpbiBNZW5nIDxibWVuZy5jbkBnbWFpbC5jb20+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAc2lmaXZlLmNvbT4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuZ2l0bW9kdWxlcyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMyArKw0KPiA+ID4gPiAgTWFrZWZpbGUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDUgKy0NCj4gPiA+ID4gIHBjLWJpb3Mvb3BlbnNiaS1yaXNj
djMyLXZpcnQtZndfanVtcC5iaW4gICAgIHwgQmluIDAgLT4gMjg4NDgNCj4gPiA+ID4gYnl0ZXMN
Cj4gPiA+ID4gIHBjLWJpb3Mvb3BlbnNiaS1yaXNjdjY0LXNpZml2ZV91LWZ3X2p1bXAuYmluIHwg
QmluIDAgLT4gMjg5MDQNCj4gPiA+ID4gYnl0ZXMNCj4gPiA+ID4gIHBjLWJpb3Mvb3BlbnNiaS1y
aXNjdjY0LXZpcnQtZndfanVtcC5iaW4gICAgIHwgQmluIDAgLT4gMjg5MDQNCj4gPiA+ID4gYnl0
ZXMNCj4gPiA+ID4gIHJvbXMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDQ4DQo+ID4gPiA+ICsrKysrKysrKysrKysrLQ0KPiA+ID4gPiAtLS0tDQo+ID4gPiA+ICBy
b21zL29wZW5zYmkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4g
PiA+ICA3IGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0K
PiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHBjLWJpb3Mvb3BlbnNiaS1yaXNjdjMyLXZpcnQt
ZndfanVtcC5iaW4NCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBwYy1iaW9zL29wZW5zYmkt
cmlzY3Y2NC1zaWZpdmVfdS0NCj4gPiA+ID4gZndfanVtcC5iaW4NCj4gPiA+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBwYy1iaW9zL29wZW5zYmktcmlzY3Y2NC12aXJ0LWZ3X2p1bXAuYmluDQo+ID4g
PiA+ICBjcmVhdGUgbW9kZSAxNjAwMDAgcm9tcy9vcGVuc2JpDQo+ID4gPiA+IA0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvLmdpdG1vZHVsZXMgYi8uZ2l0bW9kdWxlcw0KPiA+ID4gPiBpbmRleCAyODU3
ZWVjNzYzNzcuLjdhMTBlNzJlMDljZCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvLmdpdG1vZHVsZXMN
Cj4gPiA+ID4gKysrIGIvLmdpdG1vZHVsZXMNCj4gPiA+ID4gQEAgLTU1LDMgKzU1LDYgQEANCj4g
PiA+ID4gIFtzdWJtb2R1bGUgInNsaXJwIl0NCj4gPiA+ID4gICAgICAgICBwYXRoID0gc2xpcnAN
Cj4gPiA+ID4gICAgICAgICB1cmwgPSBodHRwczovL2dpdC5xZW11Lm9yZy9naXQvbGlic2xpcnAu
Z2l0DQo+ID4gPiA+ICtbc3VibW9kdWxlICJyb21zL29wZW5zYmkiXQ0KPiA+ID4gPiArICAgICAg
IHBhdGggPSByb21zL29wZW5zYmkNCj4gPiA+ID4gKyAgICAgICB1cmwgPSBodHRwczovL2dpdGh1
Yi5jb20vcmlzY3Yvb3BlbnNiaS5naXQNCj4gPiA+IA0KPiA+ID4gSXQgd291bGQgYmUgbmljZSB0
byBzdGF0ZSB0aGUgbGljZW5zZSBmb3IgbmV3IGJsb2JzIHdlJ3JlDQo+ID4gPiBhZGRpbmcgdG8g
dGhlIHNvdXJjZSB0cmVlLi4uIEluIHBhcnRpY3VsYXIsIEkgZmluZCB0aGUNCj4gPiA+IHJlYWRt
ZSBhdCBodHRwczovL2dpdGh1Yi5jb20vcmlzY3Yvb3BlbnNiaSBhIGJpdCBjb25mdXNpbmcNCj4g
PiA+IGJlY2F1c2UgaXQgc2F5cyBpdCdzIDItQlNEIGJ1dCBhbHNvIHRoYXQgc29tZSBwYXJ0cyBh
cmUgQXBhY2hlLQ0KPiA+ID4gMi4wOw0KPiA+ID4gdGhlIGxhdHRlciBpcyAqbm90KiBHUEwtMi4w
IGNvbXBhdGlibGUuIFRoYXQgbWFrZXMgaXQgbm90DQo+ID4gPiBjb21wbGV0ZWx5DQo+ID4gPiBv
YnZpb3VzIHRvIG1lIHRoYXQgd2UgY2FuIHNoaXAgdGhpcyB3aXRoIFFFTVUuDQo+ID4gDQo+ID4g
QWgsIEkgZGlkbid0IHJlYWxpc2UgdGhlcmUgaXMgQXBhY2hlLTIuMCBjb2RlIGluIHRoZXJlLg0K
PiA+IA0KPiA+IEluIHRoaXMgY2FzZSBhbGwgb2YgdGhlIGNvZGUgd2UgYXJlIHVzaW5nICh3ZSBh
cmVuJ3QgdXNpbmcgdGhlDQo+ID4gS2VuZHJ5dGUNCj4gPiBjb2RlIHdpdGggUUVNVSkgaXMgQlNE
LTItQ2xhdXNlLiBFdmVuIHRoZW4gdGhvdWdoIGRvZXMgaXQgbWF0dGVyIGlmDQo+ID4gaXQNCj4g
PiBpcyBHUEwgY29tcGF0aWJsZT8gVGhpcyBpc24ndCBiZWluZyBsaW5rZWQgd2l0aCBRRU1VIGl0
IGlzIGp1c3QNCj4gPiBiZWluZw0KPiA+IGluY2x1ZGVkIHdpdGggUUVNVS4NCj4gDQo+IFllYWgs
IGlmIHdlJ3JlIG5vdCBidWlsZGluZyB0aGUgYXBhY2hlLTIuMCBwYXJ0cyB0aGVuIEkgdGhpbmsN
Cj4gd2UncmUgT0ssIGFuZCBhcyB5b3Ugc2F5IHRoZXJlJ3MgdGhlIHF1ZXN0aW9uIG9mIHdoZXRo
ZXIgUUVNVSdzDQo+IEdQTCBhZmZlY3RzIHdoYXQgd2Ugc2hpcCBhcyBtZXJlIGJpb3MgYmxvYnMg
dG8gcnVuIGFzIGd1ZXN0DQo+IGNvZGUgYW55d2F5LiBCdXQgaXQncyBzdWZmaWNpZW50bHkgbm90
IGEgInJlYWxseSBvYnZpb3VzbHkgb2siDQo+IHRoYXQgSSdkIGxpa2UgYSBzZWNvbmQgb3Bpbmlv
bjsgY2MnZCBzb21lIHBlb3BsZSB3aG8gbWlnaHQgaGF2ZQ0KPiBzZWNvbmQgb3BpbmlvbnMuDQo+
IA0KPiA+IEkgY2FuIGFkZCBkZXRhaWxzIG9mIHRoZSBsaWNlbnNlIGluIHRoZSBzb3VyY2UgdHJl
ZSwgd2hlcmUgc2hvdWxkDQo+ID4gaXQgYmUNCj4gPiBhZGRlZD8NCj4gDQo+IEkgd2FzIHRoaW5r
aW5nIGluIHRoZSBjb21taXQgbWVzc2FnZS4gV2UgYWxzbyBzZWVtIHRvDQo+IGhhdmUgaHVtYW4t
cmVhZGFibGUgaW5mb3JtYXRpb24gaW4gcGMtYmlvcy9SRUFETUUgZm9yDQo+IHRoZSB2YXJpb3Vz
IGJsb2JzLCB3aGljaCBzZWVtcyB0byBiZSBhIGdvb2QgcGxhY2UgZm9yIGEgYnJpZWYNCj4gb25l
LXBhcmEgc3VtbWFyeSBvZiB3aGF0IE9wZW5TQkkgaXMsIGEgVVJMIGZvciBpdHMgdXBzdHJlYW0s
DQo+IGFuZCBhIGJyaWVmIG5vdGUgb2YgdGhlIGxpY2Vuc2UuDQoNCk9rLCBJJ2xsIGFkZCB0aGF0
Lg0KDQo+IA0KPiA+ID4gQWxzbywgbmV3IGdpdCBtb2R1bGVzIGluIC5naXRtb2R1bGVzIHNob3Vs
ZCBiZSBxZW11Lm9yZw0KPiA+ID4gVVJMcywgbm90IHJhbmRvbSBleHRlcm5hbCBvbmVzLiAoaWUs
IHdlIHNob3VsZCBzZXQgdXANCj4gPiA+IG1pcnJvcmluZyBvZiBhbnkgbmV3IGV4dGVybmFsIHJl
cG8gd2Ugc3RhcnQgc2hpcHBpbmcNCj4gPiA+IGNvZGUgYW5kIGJpbmFyaWVzIGZvcikuIFdlIGNh
biBzZXQgdGhpcyB1cCBhbmQgZml4IHVwIHRoZQ0KPiA+ID4gZ2l0bW9kdWxlcyBmaWxlIGFmdGVy
IHRoZSBmYWN0LCBidXQgdGhlIGlkZWFsIGlzIHRvIGRvDQo+ID4gPiBpdCBpbiBhZHZhbmNlIHJh
dGhlciB0aGFuIGFmdGVyd2FyZHMuDQo+ID4gDQo+ID4gT2ssIHdobyBjYW4gc2V0dXAgYSBnaXQg
bWlycm9yIGZvciB0aGUgUUVNVSByZXBvPw0KPiANCj4gVGhhdCB3b3VsZCBiZSBKZWZmIG9yIFN0
ZWZhbiAoY2MnZCkuDQo+IA0KPiA+IFBTOiBJdCBzZWVtcyBsaWtlIHRoZXJlIGFyZSBzdGlsbCBz
b21lIGlzc3VlcyB3aXRoIHRoaXMgcGF0Y2ggc28NCj4gPiBtYXliZQ0KPiA+IGl0J3Mgd29ydGgg
ZHJvcHBpbmcgdGhpcyBwYXRjaCBmcm9tIHRoZSBQUiBzbyB0aGF0IHdlIGNhbiBnZXQNCj4gPiBl
dmVyeXRoaW5nIGVsc2UgbWVyZ2VkLg0KPiANCj4gWWVhaCwgdGhhdCB3b3VsZCBiZSBteSBzdWdn
ZXN0aW9uLg0KDQpDYW4geW91IGRvIHRoYXQgd2hlbiB5b3UgbWVyZ2UgaXQgb3IgZG9lcyBQYWxt
ZXIgaGF2ZSB0byBzZW5kIHRoZSBQUg0KYWdhaW4/DQoNCkFsaXN0YWlyDQoNCj4gDQo+IHRoYW5r
cw0KPiAtLSBQTU0NCg==

