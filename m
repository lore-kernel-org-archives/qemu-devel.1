Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F549C74A3F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 00:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A1321019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 00:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oHvKG+Yi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vKKicKyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A1321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlNKI-0006l7-Bm
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 20:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57290)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0888c7807=Dmitry.Fomichev@wdc.com>)
 id 1hlNJm-0006F9-05
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 20:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0888c7807=Dmitry.Fomichev@wdc.com>)
 id 1hlNJk-0001X8-St
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 20:52:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62667)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0888c7807=Dmitry.Fomichev@wdc.com>)
 id 1hlNJh-0001CK-FX; Wed, 10 Jul 2019 20:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562806329; x=1594342329;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YmUi+uzyNZa70dQPgciTmJbWUmdfK1D5ETFv/YcMB8w=;
 b=oHvKG+YiHwiCJrwHhfUvbBFiWs8Bn1JPpkZ6uAMVT6MN2wBk6zyhHo7M
 UvrEJXxvZ6xpb9AhuSD93e78TRZ9p7+Oc9aMMEDa6jZV72j2ivdlbstfW
 vqpnZ38OaNFVDtKsBfcxRmfBNPLOpFPd1e39Ctv3sCMv15pzTdoCFSgAz
 wJ90Pch+/kDwxEb8Y1P1S7J752yA1PUgkKJWs5677aNwGpvcSDc58GrS/
 aYIPY82/CxoOn9THL/G5BThjU5OcHrrK1oTeKL8EDoVr8lCceVjKU7OWQ
 3s0nP4jXAWTJJu0YZQVE5PPrijyiEdb2ECLEnf1BMSD7eYHKUuXh0j1vg A==;
IronPort-SDR: KraixJb8IlNTPPttv05LQOrh+lqcmOIfdQ4Dgsg6E/YrijLB/mtxTQPrb1X7alKvLD6sluGoBt
 9iWUGr+3aDOwR3+ohm40izk3I+3egsqJMq4ZVIiaaDri8SC0dr17WgMMr6EHv8XjSMTfM87I7g
 dSRwBt/Yt3MRbGlnpB2tDvSe+Ckjod0W0diFVOXWh0BpAFqnZD5US7al2ui5tH1MVen+vtcspU
 dgUPHR58YrFh5VuAERPvFimc7K2FGLA7CNiRP5ygELHr8bicjb017declOGNlFxvpQ6Z8meB0p
 32s=
X-IronPort-AV: E=Sophos;i="5.63,476,1557158400"; d="scan'208";a="219134755"
Received: from mail-by2nam03lp2052.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.52])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2019 08:52:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmUi+uzyNZa70dQPgciTmJbWUmdfK1D5ETFv/YcMB8w=;
 b=vKKicKyZB4d7yc3EWaz0F9vVA08jv20jLHcmFVJ/Jq43oPDE8Q4jDZNOkWLiCnCbhoLd3l/Qk7ENqun9Toh2ZiNACNirbwpp8vjE4oxZ/qjUHnZMp4kkkRxb+KHjsNzyxwnDEeHyfoilaVzNVAQScXBF4tw3ETMlT23AFd0U3Sk=
Received: from CO2PR04MB2328.namprd04.prod.outlook.com (10.166.95.11) by
 CO2PR04MB2344.namprd04.prod.outlook.com (10.174.192.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Thu, 11 Jul 2019 00:52:01 +0000
Received: from CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::7d6b:e63d:1259:4df]) by CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::7d6b:e63d:1259:4df%8]) with mapi id 15.20.2052.020; Thu, 11 Jul 2019
 00:52:01 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "kwolf@redhat.com" <kwolf@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Thread-Topic: [PATCH 0/4] virtio: handle zoned backing devices
Thread-Index: AQHVNpZJ++R4TpQVEUSWT3WEhlCKrqbDodiAgAAO94CAAAiCAIAAoPYAgAA+PIA=
Date: Thu, 11 Jul 2019 00:52:01 +0000
Message-ID: <de7bea2d02f53845bcaa41b4bb7c10f42676755f.camel@wdc.com>
References: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
 <f790cb77-fa6a-c304-bc7f-62bbede78751@redhat.com>
 <20190710110241.GB6501@localhost.localdomain>
 <eea2bb4e-813e-456b-8aa9-514f63c5057e@redhat.com>
 <20190710210914.GC6501@localhost.localdomain>
In-Reply-To: <20190710210914.GC6501@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dmitry.Fomichev@wdc.com; 
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 382112cf-5489-46ed-3ada-08d70599fc15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:CO2PR04MB2344; 
x-ms-traffictypediagnostic: CO2PR04MB2344:
x-microsoft-antispam-prvs: <CO2PR04MB23445A12B2C4D94773DF625FE1F30@CO2PR04MB2344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(4636009)(376002)(366004)(396003)(39840400004)(136003)(346002)(51914003)(199004)(189003)(11346002)(6246003)(6512007)(476003)(25786009)(2616005)(486006)(66066001)(305945005)(478600001)(6436002)(118296001)(2906002)(229853002)(110136005)(14444005)(5024004)(446003)(7736002)(14454004)(6116002)(76176011)(256004)(3846002)(53936002)(8936002)(4326008)(36756003)(6486002)(81156014)(81166006)(66556008)(316002)(102836004)(26005)(53546011)(66476007)(5660300002)(6506007)(186003)(86362001)(66946007)(76116006)(91956017)(71200400001)(71190400001)(68736007)(99286004)(66446008)(64756008)(54906003)(2501003)(8676002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CO2PR04MB2344;
 H:CO2PR04MB2328.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tblv1zSkwdscxq80ZniwG6qgD/W/1vnMtyT2IuX0+DIBh+qdGA/+G+tWTzy8KF2OxGwNaCxKWPQI25NkKhmmhWxeQ8swBLifRFtpE9i8mVcxmDt3vWIQx4I4H91kiiKS0PH8k1gHzwqZJDgDZMwtClcqlPti35o4TipOqRpW4CFny/MFFKay+Q3PIqyja508sqDUK+3+nyUZkwiGgNmG8TZSvyJUzR96XxXxByRXbufZyUxMABEI2FjyABLcyBNb9iMvZnRQq4hcql3YCi1HPauaxoWZHfGFAP4A0LLqAyXcH16WpyiA0RD2HcOOeKOT6fPPk59X+Dk6WV+pdY2o9kHhoR76RVvzTfizMa3O1k43HKNIJ3R4QiECwgkMgyKHCqCFwCEJg+qo2zImzL73O5t/xwuvhGf/30XiGP9OajU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44FAA3104C01884E938A30D399E5A392@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382112cf-5489-46ed-3ada-08d70599fc15
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 00:52:01.1767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dmitry.Fomichev@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2344
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: Re: [Qemu-devel] [PATCH 0/4] virtio: handle zoned backing devices
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDE5LTA3LTEwIGF0IDIzOjA5ICswMjAwLCBLZXZpbiBXb2xmIHdyb3RlOg0KPiBB
bSAxMC4wNy4yMDE5IHVtIDEzOjMzIGhhdCBQYW9sbyBCb256aW5pIGdlc2NocmllYmVuOg0KPiA+
IE9uIDEwLzA3LzE5IDEzOjAyLCBLZXZpbiBXb2xmIHdyb3RlOg0KPiA+ID4gSG0uLi4gQWN0dWFs
bHksIGZpbGUtcG9zaXggaW1wbGVtZW50cyAuYmRydl9jaGVja19wZXJtIGFuZCBjb3VsZCBqdXN0
DQo+ID4gPiByZWZ1c2UgYXR0YWNoaW5nIGEgcGFyZW50IHRoZXJlIGlmIGl0IGRvZXNuJ3QgcmVx
dWVzdCBhIHNwZWNpZmljDQo+ID4gPiBwZXJtaXNzaW9uIGxpa2UgQkxLX1BFUk1fU1VQUE9SVF9a
T05FRC4gVGhhdCBzaG91bGQgZ2l2ZSB1cyB0aGUNCj4gPiA+IHdoaXRlbGlzdCBzZW1hbnRpY3Mg
dGhyb3VnaCBleGlzdGluZyBpbmZyYXN0cnVjdHVyZS4NCj4gPiANCj4gPiBJJ2QgbGlrZSBEbWl0
cnkgdG8gaGF2ZSBzb21ldGhpbmcgbW9yZSBwcmVjaXNlIHRvIGJhc2UgaGlzIHdvcmsgb24uICBU
aGUNCj4gPiBwZXJtaXNzaW9ucyBzeXN0ZW0gaXMgcmVhbGx5IGNvbXBsaWNhdGVkIGFuZCBJIG5l
dmVyIHJlYWxseSB3cmFwcGVkIG15DQo+ID4gaGVhZCBhcm91bmQgaXQsIHNvIEkgbmVlZCB5b3Vy
IGhlbHAuDQo+ID4gDQo+ID4gSUlVQywgYmxrY29uZl9hcHBseV9iYWNrZW5kX29wdGlvbnMgd291
bGQgZ3JvdyBhIG5ldyBhcmd1bWVudCAobGlrZQ0KPiA+ICJyZXNpemFibGUiKSBhbmQgdGhhdCBh
cmd1bWVudCB3b3VsZCBhZGQgQkxLX1BFUk1fU1VQUE9SVF9aT05FRCB0byB0aGUNCj4gPiBwZXJt
IHRoYXQgYmxrY29uZl9hcHBseV9iYWNrZW5kX29wdGlvbnMgcGFzc2VzIHRvIGJsa19zZXRfcGVy
bS4gIE9uIHRoZQ0KPiA+IG90aGVyIHNpZGUgcmF3X2NoZWNrX3Blcm0gd291bGQgc2F5IHNvbWV0
aGluZyBsaWtlDQo+ID4gDQo+ID4gICAgIGlmIChpc196b25lZChzKSAmJiAhKHBlcm0gJiBCTEtf
UEVSTV9TVVBQT1JUX1pPTkVEKSkgew0KPiA+ICAgICAgICAgZXJyb3Jfc2V0ZyguLi4uKTsNCj4g
PiAgICAgICAgIHJldHVybiAtRU5PVFNVUDsNCj4gPiAgICAgfQ0KPiA+IA0KPiA+IElzIHRoaXMg
Y29ycmVjdD8NCj4gDQo+IFllcywgSSB0aGluayB0aGlzIGlzIGhvdyB5b3UnZCBiZXN0IGltcGxl
bWVudCBpdC4NCj4gDQo+ID4gSW4gYWRkaXRpb24sIEJMS19QRVJNX1NVUFBPUlRfWk9ORUQgd291
bGQgaGF2ZSB0byBiZSBhIHNoYXJlZA0KPiA+IHBlcm1pc3Npb24sIHNpbmNlIGl0J3MgcG9zc2li
bGUgdG8gYXNzaWduIHRoZSBzYW1lIGJsb2NrIGRldmljZSB0bw0KPiA+IG11bHRpcGxlIHNjc2kt
YmxvY2sgZGV2aWNlcy4gIFNvIEJMS19QRVJNX1NVUFBPUlRfWk9ORUQgd291bGQgYmUgYWRkZWQN
Cj4gPiB1bmNvbmRpdGlvbmFsbHkgdG8gc2hhcmVkX3Blcm0uDQo+IA0KPiBSaWdodCwgdGhpcyBw
YXJ0IHNob3dzIHRoYXQgd2UncmUga2luZCBvZiBhYnVzaW5nIHRoZSBwZXJtaXNzaW9uIHN5c3Rl
bQ0KPiBoZXJlLiBJIHRoaW5rIHVuY29uZGl0aW9uYWxseSBhZGRpbmcgQkxLX1BFUk1fU1VQUE9S
VF9aT05FRCB0byB0aGUgc2V0DQo+IG9mIHNoYXJlZCBwZXJtaXNzaW9ucyBjb3VsZCBwcm9iYWJs
eSBoYXBwZW4gY2VudHJhbGx5IGluDQo+IGJkcnZfY2hpbGRfcGVybSgpLg0KPiANCj4gPiBwczog
SSBoYXZlIGFsd2F5cyB0aG91Z2h0IHRoYXQgc2hhcmVkX3Blcm0gaXMgZXhwcmVzc2VkIHRoZSB3
cm9uZyB3YXkNCj4gPiBhbmQgc2hvdWxkIGhhdmUgYmVlbiAiZGVuaWVkX3Blcm0iLiAgSG93IGhh
cmQgd291bGQgaXQgYmUgdG8gY2hhbmdlIHRoYXQNCj4gPiBub3c/DQo+IA0KPiBJJ20gbm90IHN1
cmUgaXQgd291bGQgYmUgYmV0dGVyLiBJdCBpcyBzaGFyZWRfcGVybSBiZWNhdXNlIHRoYXQgbWVh
bnMNCj4gdGhhdCB0aGUgZGVmYXVsdCBpcyByZXN0cmljdGl2ZSAoZXJyb3IgbW9kZTogb3BlcmF0
aW9uIHJlZnVzZWQsIGNsZWFybHkNCj4gcmVwb3J0ZWQsIGVhc3kgdG8gZml4KSByYXRoZXIgdGhh
biBwZXJtaXNzaXZlIChlcnJvciBtb2RlOiBpbWFnZQ0KPiBjb3JydXB0aW9uLCBoYXJkIHRvIGZp
Z3VyZSBvdXQgd2hlcmUgd2Ugd2VyZSB0b28gcGVybWlzc2l2ZSkuIEJhc2ljYWxseSwNCj4gd2hp
dGVsaXN0IGluc3RlYWQgb2YgYmxhY2tsaXN0LCBvbmNlIGFnYWluLg0KPiANCj4gQnV0IGlmIHdl
IGRpZCBpbmRlZWQgZGVjaWRlIHRvIGNoYW5nZSBpdCwgdGhlIG9ubHkgd2F5IHRvIGZpbmQgb3V0
IGhvdw0KPiBoYXJkIGl0IGlzIHdvdWxkIGJlIGRvaW5nIGl0LiBJIHN1c3BlY3Qgbm90IHRvbyBo
YXJkIGluIHByaW5jaXBsZSwgYnV0DQo+IG1ha2luZyBzdXJlIHRoYXQgd2UgY29udmVydGVkIGFs
bCBjYWxsZXJzIGFuZCBkb24ndCBpbnRyb2R1Y2Ugd3JvbmcNCj4gY2FsbGVycyBsYXRlciB0aHJv
dWdoIChzaWxlbnQpIG1lcmdlIGNvbmZsaWN0cyBpcyB0aGUgbW9yZSBjb25jZXJuaW5nDQo+IHBh
cnQuDQo+IA0KPiBLZXZpbg0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjaywgdGhlIHBlcm1pc3Np
b25zIGJhc2VkIGFwcHJvYWNoIGluZGVlZCBsb29rcw0KY2xlYW5lci4gSSBhbSBsb29raW5nIGlu
dG8gbW9kaWZ5aW5nIHRoZSBwYXRjaHNldCB0byBkbyB0aGUgY2hlY2sgaW4NCmJkcnZfY2hlY2tf
cGVybSBhbmQgd2lsbCBzZW5kIGEgVjIuDQoNClBhb2xvLA0KV1JUIHRvIEhvc3QgQXdhcmUgZHJp
dmVzLCB0aGVzZSBNQVkgd29yaywgYnV0IHdlIGRvbid0IGhhdmUgYW55IG9mIHRoZXNlDQphdmFp
bGFibGUgZm9yIHRlc3RpbmcgYW5kIGFyZSBub3QgYWJsZSB0byB2ZXJpZnkgd2hpY2ggZHJpdmVy
cyBkbyB3b3JrDQp3aXRoIHRoZW0gYW5kIHdoaWNoIGRvIG5vdC4gVGhpcyBpcyB0aGUgcmVhc29u
IGZvciBub3QgbGV0dGluZyB0aGVtIHBhc3MNCnRocnUuIElmIHlvdSBwcmVmZXIsIEkgY2FuIGVu
YWJsZSBwYXNzaW5nIEhBIGRyaXZlcyBpbiBWMi4NCg0KRG1pdHJ5DQoNCg==

