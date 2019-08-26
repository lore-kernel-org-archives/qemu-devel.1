Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E9C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 21:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180F9206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 21:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RziICIjs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OXHLuaSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180F9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Mgi-00070y-61
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 17:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=134c9b0c6=Alistair.Francis@wdc.com>)
 id 1i2MfW-0006R8-T0
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 17:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=134c9b0c6=Alistair.Francis@wdc.com>)
 id 1i2MfU-0005Te-KP
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 17:36:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51688)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=134c9b0c6=Alistair.Francis@wdc.com>)
 id 1i2MfQ-0005Pt-I2; Mon, 26 Aug 2019 17:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566855409; x=1598391409;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=pwXOZ1VIzypR+/H9kRh4gkGHjXB0syP0svGBRntJS74=;
 b=RziICIjsAYfteWFVmKAhbsE/BHivijoW6XT7VtxK4l3x8Qej3NK9+XLh
 K3Cnhdm3ElW609vcz4j8xIyzX+qdZecyJLxz4PzEIxLhq0bHYcuXxMIlG
 zlNVuNNoF3hUzSTVWy+QjjjjKcBCbNbffqFGkUbq3H9Aa0eiwP5njpx4/
 GT7DTDTN+Km0ksxpHb9CeK/EP4w3HdVeTCfycdQKS2jvixBMXKcVyXPUB
 bEX/FtzFVHVxUIXHUshxSjEx4AKzN7WHmh0552oDISl0HL6XjZBGerxyZ
 wGH56Mrw6gNxecYVHX9bfgNBtD9SxuVcWB3bnf3BfJYnztXDde5chhjta g==;
IronPort-SDR: 6UKZj9awVxOMWiIPf0KY7VGynF8pKk9fqskbivjmUUFRhN9PkFbgNh7qZThLFogs0Nbv5JjDTc
 aEwdjHbepeqIUXHD1acXCEHZH1hb0p6cZjWpUXRUgiJlapiRtewyUphwR9lnzAAcRkrwA9Ud2t
 DCwTMBpuUqKYwrl5mtiwjHIs5WlXRC6u5iyD1t/YsFlCfLH2xj8OJN9vUvx7iPm9uP5aWkV50V
 yhxGnTcFZud6pIt/B8+uPbyKi1N4LeJmQO+4j+JtdYFXVppNt+v43V4LoM7ddlsknqHqtZtzMz
 O2o=
X-IronPort-AV: E=Sophos;i="5.64,433,1559491200"; d="scan'208";a="121284267"
Received: from mail-co1nam05lp2054.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.54])
 by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2019 05:36:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU7VwBlHXcPrugtYyHFr4Q7eWW+0tkbLWwVgphNCSVYNEkNERVkRWYcjEHXwld9NQ+rAN95LSiM9dNMBcurdbgyKaM7ay/PK1cZas10CjF4+yFDVY9kKOwrEhnFV8K/XtuxNMtOFHLuYDZnTiebR5umsLuRHZTsKy5fBNuVFyKwZkbOFWgfuowYSx+InzPz7Vphm9ICSBha8Mw6am/G5ITmA8lOjj14TtjCVCiBaobsWZYgzQOr1YbYWcZFvq1uni8F5JdLOSqA1zRHz0AW+lI5fPaiGwIA0MMslQdqt7aa7rVWu/GA6kGWCla8sEk3UY5gJpRiLsL0C5GDJ/re2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwXOZ1VIzypR+/H9kRh4gkGHjXB0syP0svGBRntJS74=;
 b=FguW70aDPfdsXj6cYBl3rMzawqwTpy0UsdNZxCbbpVtZl5Ifz6sOtl97CpFIe8hoBxIxaq1E9Ix3zw7bFe9uG8MX7Q9g5Wczlo7Uz+PPgDkcHcG81bhvPvcwihrpFqLV0yUwADZsit+lJNiVHxAXMLzGpoCZjT1YGJcpPXwRwKSN0VnTnLQTjcZ3j9KfU8i6osze5fz6UxNuRiVOvuqZea+ed9yeho27QMLTZqeloFaowJ75tkWM7Ee80NJFcXpcT0KbhoB3a+4Uo2VPoXMwYVBIpAhzeOa7PR/YWj/BvVRfNCZ986M/djxBdhqmoAos9LRgO56lO3VvMHg24263mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwXOZ1VIzypR+/H9kRh4gkGHjXB0syP0svGBRntJS74=;
 b=OXHLuaSWk9/ssgjOyWFkj2mAs9D/Q47ExZpu9+4h1aVFxfX8o9Iy6LcmxlFiAvA0hFj77qVlMECQPkMfNL7aFjuwK5z2ejs63v3FoOxwOTSW6XLw5eScI1UCVc2r3flpRXSxRXH6MGjiAKowhinem03BkOXtvQzpvWvciPzm1Cw=
Received: from DM6PR04MB4908.namprd04.prod.outlook.com (20.176.109.81) by
 DM6PR04MB5099.namprd04.prod.outlook.com (20.176.110.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 21:36:41 +0000
Received: from DM6PR04MB4908.namprd04.prod.outlook.com
 ([fe80::99f2:1c81:ffbd:c597]) by DM6PR04MB4908.namprd04.prod.outlook.com
 ([fe80::99f2:1c81:ffbd:c597%7]) with mapi id 15.20.2178.022; Mon, 26 Aug 2019
 21:36:41 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "bmeng.cn@gmail.com"
 <bmeng.cn@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 12/30] riscv: sifive_e: Drop sifive_mmio_emulate()
Thread-Index: AQHVWXE78kRDI2NAY0qGXOUGVJ7VVacN+MoA
Date: Mon, 26 Aug 2019 21:36:41 +0000
Message-ID: <9802ed171372b72228fb12b1d225a43fd064d694.camel@wdc.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
 <1566537069-22741-13-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566537069-22741-13-git-send-email-bmeng.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 140ca820-c75b-4fc3-aba8-08d72a6d7c0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR04MB5099; 
x-ms-traffictypediagnostic: DM6PR04MB5099:
x-microsoft-antispam-prvs: <DM6PR04MB5099811AF7033AFA7413E99390A10@DM6PR04MB5099.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(71200400001)(71190400001)(66946007)(66446008)(64756008)(66556008)(66476007)(81166006)(5660300002)(2906002)(256004)(91956017)(76116006)(14454004)(36756003)(305945005)(66066001)(7736002)(478600001)(2501003)(26005)(316002)(53936002)(6512007)(186003)(2201001)(2616005)(446003)(486006)(476003)(11346002)(86362001)(6436002)(6486002)(76176011)(6116002)(118296001)(102836004)(229853002)(25786009)(8936002)(6506007)(99286004)(8676002)(6246003)(3846002)(110136005)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB5099;
 H:DM6PR04MB4908.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VA3eQWbFvoIDPImFlcCg1iD4WTDHMuMmGeejcVn7gnBUqpBDCXkGC9MOCbEX0/mF4+cnanwI7OeKelmHNO/EHlrVHi0IfKXQ8Mr9ocGbyxTaPwhLYuOFDd4FQQSgZglTS7TP47FXFv0EIzVrTONVX2RE6s8XENanZjKCnH6Hh8goCYBP9JjP6fVp8Ev1CA3UVypMjcNmUIDRMF/mfOuzyyB5An/c0TWZtMZY9mJodhh2hFE69TM1RSnI39NRnYaBXSKAGsdh9RlMZG9Sszix9Obiys0KcKQQCDc9EWjr0KCNQbWg2lYWOdmqckjclTCKdYETWp/NdgPs5U0WDJC+jhBPK1v4R6b6x6NXaORp0Z7Ag8JbJNiyzX73qW4Ef4i+BovzJ7LQnTiPQVzHsDgqyqGc6wcTsJqlJpEKQP6hX6w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BD0F70F53AD9C44869D40CCFFA01245@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140ca820-c75b-4fc3-aba8-08d72a6d7c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 21:36:41.5817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzjBm2ZRUo6TVJNeiyZjmOZXB77zCD8xgFMexullMtXqHiO3BtP3aBB3OHQBtU4IJjlgKuViIJKaRTacdTI7Z9ITorlFt9ekvHOyXihMPmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5099
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: Re: [Qemu-devel] [PATCH v5 12/30] riscv: sifive_e: Drop
 sifive_mmio_emulate()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDIyOjEwIC0wNzAwLCBCaW4gTWVuZyB3cm90ZToNCj4gVXNl
IGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgpIGluc3RlYWQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBCaW4gTWVuZyA8Ym1lbmcuY25AZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3Rh
aXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IA0K
PiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjU6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2NDogTm9uZQ0K
PiBDaGFuZ2VzIGluIHYzOiBOb25lDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gZHJvcCBwYXRjaCAi
cmlzY3Y6IHNpZml2ZTogTW92ZSBzaWZpdmVfbW1pb19lbXVsYXRlKCkgdG8gYSBjb21tb24NCj4g
cGxhY2UiDQo+IC0gbmV3IHBhdGNoICJyaXNjdjogc2lmaXZlX2U6IERyb3Agc2lmaXZlX21taW9f
ZW11bGF0ZSgpIg0KPiANCj4gIGh3L3Jpc2N2L3NpZml2ZV9lLmMgfCAyMyArKysrKysrKy0tLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3Yvc2lmaXZlX2UuYyBiL2h3L3Jpc2N2
L3NpZml2ZV9lLmMNCj4gaW5kZXggMmQ2NzY3MC4uMDQwZDU5ZiAxMDA2NDQNCj4gLS0tIGEvaHcv
cmlzY3Yvc2lmaXZlX2UuYw0KPiArKysgYi9ody9yaXNjdi9zaWZpdmVfZS5jDQo+IEBAIC0zNyw2
ICszNyw3IEBADQo+ICAjaW5jbHVkZSAiaHcvbG9hZGVyLmgiDQo+ICAjaW5jbHVkZSAiaHcvc3lz
YnVzLmgiDQo+ICAjaW5jbHVkZSAiaHcvY2hhci9zZXJpYWwuaCINCj4gKyNpbmNsdWRlICJody9t
aXNjL3VuaW1wLmgiDQo+ICAjaW5jbHVkZSAidGFyZ2V0L3Jpc2N2L2NwdS5oIg0KPiAgI2luY2x1
ZGUgImh3L3Jpc2N2L3Jpc2N2X2hhcnQuaCINCj4gICNpbmNsdWRlICJody9yaXNjdi9zaWZpdmVf
cGxpYy5oIg0KPiBAQCAtNzQsMTQgKzc1LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBNZW1tYXBF
bnRyeSB7DQo+ICAgICAgW1NJRklWRV9FX0RUSU1dID0gICAgIHsgMHg4MDAwMDAwMCwgICAgIDB4
NDAwMCB9DQo+ICB9Ow0KPiAgDQo+IC1zdGF0aWMgdm9pZCBzaWZpdmVfbW1pb19lbXVsYXRlKE1l
bW9yeVJlZ2lvbiAqcGFyZW50LCBjb25zdCBjaGFyDQo+ICpuYW1lLA0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50cHRyX3Qgb2Zmc2V0LCB1aW50cHRyX3QgbGVuZ3RoKQ0KPiAt
ew0KPiAtICAgIE1lbW9yeVJlZ2lvbiAqbW9ja19tbWlvID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAx
KTsNCj4gLSAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKG1vY2tfbW1pbywgTlVMTCwgbmFtZSwg
bGVuZ3RoLA0KPiAmZXJyb3JfZmF0YWwpOw0KPiAtICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbihwYXJlbnQsIG9mZnNldCwgbW9ja19tbWlvKTsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIHZv
aWQgcmlzY3Zfc2lmaXZlX2VfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ICB7DQo+ICAg
ICAgY29uc3Qgc3RydWN0IE1lbW1hcEVudHJ5ICptZW1tYXAgPSBzaWZpdmVfZV9tZW1tYXA7DQo+
IEBAIC0xNzIsNyArMTY1LDcgQEAgc3RhdGljIHZvaWQNCj4gcmlzY3Zfc2lmaXZlX2Vfc29jX3Jl
YWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiAgICAgIHNpZml2ZV9jbGlu
dF9jcmVhdGUobWVtbWFwW1NJRklWRV9FX0NMSU5UXS5iYXNlLA0KPiAgICAgICAgICBtZW1tYXBb
U0lGSVZFX0VfQ0xJTlRdLnNpemUsIG1zLT5zbXAuY3B1cywNCj4gICAgICAgICAgU0lGSVZFX1NJ
UF9CQVNFLCBTSUZJVkVfVElNRUNNUF9CQVNFLCBTSUZJVkVfVElNRV9CQVNFKTsNCj4gLSAgICBz
aWZpdmVfbW1pb19lbXVsYXRlKHN5c19tZW0sICJyaXNjdi5zaWZpdmUuZS5hb24iLA0KPiArICAg
IGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgicmlzY3Yuc2lmaXZlLmUuYW9uIiwNCj4gICAg
ICAgICAgbWVtbWFwW1NJRklWRV9FX0FPTl0uYmFzZSwgbWVtbWFwW1NJRklWRV9FX0FPTl0uc2l6
ZSk7DQo+ICAgICAgc2lmaXZlX2VfcHJjaV9jcmVhdGUobWVtbWFwW1NJRklWRV9FX1BSQ0ldLmJh
c2UpOw0KPiAgDQo+IEBAIC0xOTksMTkgKzE5MiwxOSBAQCBzdGF0aWMgdm9pZA0KPiByaXNjdl9z
aWZpdmVfZV9zb2NfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ICAN
Cj4gICAgICBzaWZpdmVfdWFydF9jcmVhdGUoc3lzX21lbSwgbWVtbWFwW1NJRklWRV9FX1VBUlQw
XS5iYXNlLA0KPiAgICAgICAgICBzZXJpYWxfaGQoMCksIHFkZXZfZ2V0X2dwaW9faW4oREVWSUNF
KHMtPnBsaWMpLA0KPiBTSUZJVkVfRV9VQVJUMF9JUlEpKTsNCj4gLSAgICBzaWZpdmVfbW1pb19l
bXVsYXRlKHN5c19tZW0sICJyaXNjdi5zaWZpdmUuZS5xc3BpMCIsDQo+ICsgICAgY3JlYXRlX3Vu
aW1wbGVtZW50ZWRfZGV2aWNlKCJyaXNjdi5zaWZpdmUuZS5xc3BpMCIsDQo+ICAgICAgICAgIG1l
bW1hcFtTSUZJVkVfRV9RU1BJMF0uYmFzZSwgbWVtbWFwW1NJRklWRV9FX1FTUEkwXS5zaXplKTsN
Cj4gLSAgICBzaWZpdmVfbW1pb19lbXVsYXRlKHN5c19tZW0sICJyaXNjdi5zaWZpdmUuZS5wd20w
IiwNCj4gKyAgICBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoInJpc2N2LnNpZml2ZS5lLnB3
bTAiLA0KPiAgICAgICAgICBtZW1tYXBbU0lGSVZFX0VfUFdNMF0uYmFzZSwgbWVtbWFwW1NJRklW
RV9FX1BXTTBdLnNpemUpOw0KPiAgICAgIHNpZml2ZV91YXJ0X2NyZWF0ZShzeXNfbWVtLCBtZW1t
YXBbU0lGSVZFX0VfVUFSVDFdLmJhc2UsDQo+ICAgICAgICAgIHNlcmlhbF9oZCgxKSwgcWRldl9n
ZXRfZ3Bpb19pbihERVZJQ0Uocy0+cGxpYyksDQo+IFNJRklWRV9FX1VBUlQxX0lSUSkpOw0KPiAt
ICAgIHNpZml2ZV9tbWlvX2VtdWxhdGUoc3lzX21lbSwgInJpc2N2LnNpZml2ZS5lLnFzcGkxIiwN
Cj4gKyAgICBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoInJpc2N2LnNpZml2ZS5lLnFzcGkx
IiwNCj4gICAgICAgICAgbWVtbWFwW1NJRklWRV9FX1FTUEkxXS5iYXNlLCBtZW1tYXBbU0lGSVZF
X0VfUVNQSTFdLnNpemUpOw0KPiAtICAgIHNpZml2ZV9tbWlvX2VtdWxhdGUoc3lzX21lbSwgInJp
c2N2LnNpZml2ZS5lLnB3bTEiLA0KPiArICAgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgi
cmlzY3Yuc2lmaXZlLmUucHdtMSIsDQo+ICAgICAgICAgIG1lbW1hcFtTSUZJVkVfRV9QV00xXS5i
YXNlLCBtZW1tYXBbU0lGSVZFX0VfUFdNMV0uc2l6ZSk7DQo+IC0gICAgc2lmaXZlX21taW9fZW11
bGF0ZShzeXNfbWVtLCAicmlzY3Yuc2lmaXZlLmUucXNwaTIiLA0KPiArICAgIGNyZWF0ZV91bmlt
cGxlbWVudGVkX2RldmljZSgicmlzY3Yuc2lmaXZlLmUucXNwaTIiLA0KPiAgICAgICAgICBtZW1t
YXBbU0lGSVZFX0VfUVNQSTJdLmJhc2UsIG1lbW1hcFtTSUZJVkVfRV9RU1BJMl0uc2l6ZSk7DQo+
IC0gICAgc2lmaXZlX21taW9fZW11bGF0ZShzeXNfbWVtLCAicmlzY3Yuc2lmaXZlLmUucHdtMiIs
DQo+ICsgICAgY3JlYXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKCJyaXNjdi5zaWZpdmUuZS5wd20y
IiwNCj4gICAgICAgICAgbWVtbWFwW1NJRklWRV9FX1BXTTJdLmJhc2UsIG1lbW1hcFtTSUZJVkVf
RV9QV00yXS5zaXplKTsNCj4gIA0KPiAgICAgIC8qIEZsYXNoIG1lbW9yeSAqLw0K

