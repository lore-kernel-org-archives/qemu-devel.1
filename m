Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C780EC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0D5206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FxYa28/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0D5206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsr5j-0008Pz-QI
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hsr2Q-0004mK-8G
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hsr2O-0006VU-8a
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:01:14 -0400
Received: from mail-eopbgr130090.outbound.protection.outlook.com
 ([40.107.13.90]:65411 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hsr2L-0006S1-Ld; Wed, 31 Jul 2019 12:01:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIF4jaNG2AYEJblx3++/cCaNN//tNsO0nqmVl4f3Z6odblYT8pVZ+dtVVqpwwekHf9gdP9hYpJ6UvtWxTwTrGlv4ZvLKXWvFPbNdJIXFocJPWsDBTTrQPcfFmGinbTiw8xVYGEAEVMY2NaYizgzgNrPNvbatjEPXZAXRvXcmRP8b3qnucccazoEKVhcrwPvwkMG77Ww+o4M2NDsCA1lMgHabTBKZsTu4h596L+y8kbmPf924UWSbWkH2QGo/CDEqjKEUKEFXzM8UoVoUjYbWdVr/6fHrYGmdGrULOqxhkudKVzlPkWHEhUDRSJo40TxZUnPXO+5dzd4bKsFejdhNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHZqJF1Piw1hyejbNJJ66Eey5jakDuQs/VN/PlgGq2s=;
 b=juw0I8UDU9bUfi8MBpoIkdAJyoGAInlCIku+4boIyb4SNQQmxUiOjeocboV1VsiqWdZ0RNp90EZqV1M7hQJO0o/bEqd9ju86omea++owh1bmBTlCV/G3AwD+i7PZqBc3p/F4B39pQqRaPngg8Uu4MB2l9ds7LR5mseCKlXAvAPvSq0FQ1eftCx66ACTjpWmF0jKLKoV1Ssufs6+MssxFAfS6+SzIxand5YLhXQIscYJjIPlqkJWgkqnBop60CaaJywyw/EWKMpf10R3eBcictz3YsSUEh8S9OkiNv3wx9e1NruaM1sDiqMVcxlUOfwCIoYr1Hgmoa2jLx/9Nuuv5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHZqJF1Piw1hyejbNJJ66Eey5jakDuQs/VN/PlgGq2s=;
 b=FxYa28/QpQ2jSkTTjI0/F1QeaEofn7qEzFl9apDY8lCwW3KeV7Xxi2GtzH/QJBtYdXCVuDVClKfKzqinWkC2iKocM1KxYaGYmaJHQ/ksqnVG50OZPJjppPSWOJhiOgtJtcPgWSFEPYq/nasdzotPQ73wuoJEPl82nM4Z1wAiDvA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5020.eurprd08.prod.outlook.com (10.255.16.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Wed, 31 Jul 2019 16:01:05 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 16:01:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/3] block/backup: refactor write_flags
Thread-Index: AQHVRvRyYDfKfvF2I0uqR/7Rutw88Kbje1sAgAFpCoA=
Date: Wed, 31 Jul 2019 16:01:05 +0000
Message-ID: <f6927c00-5708-e471-e768-ef9d1e0c2dc6@virtuozzo.com>
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-4-vsementsov@virtuozzo.com>
 <2b034619-ab55-a5f1-a1f4-ea14c4c5c18c@redhat.com>
In-Reply-To: <2b034619-ab55-a5f1-a1f4-ea14c4c5c18c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0236.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::12) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190731190103354
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f71a270-26f0-4c94-ea8d-08d715d04b33
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5020; 
x-ms-traffictypediagnostic: DB8PR08MB5020:
x-microsoft-antispam-prvs: <DB8PR08MB5020F2BC8FF98820B9A46B53C1DF0@DB8PR08MB5020.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(396003)(39850400004)(366004)(52314003)(189003)(199004)(14454004)(486006)(107886003)(68736007)(6246003)(86362001)(31686004)(8936002)(81166006)(316002)(52116002)(11346002)(5660300002)(2501003)(81156014)(2616005)(4326008)(476003)(31696002)(446003)(25786009)(76176011)(99286004)(102836004)(53936002)(186003)(6512007)(54906003)(110136005)(53546011)(6506007)(386003)(26005)(66556008)(229853002)(66446008)(66946007)(64756008)(66476007)(2906002)(7736002)(305945005)(71200400001)(6436002)(71190400001)(3846002)(6116002)(66066001)(8676002)(36756003)(478600001)(6486002)(14444005)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5020;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sbNKUWM32hHCiC3NMZB3YmDtKEwVCiMuXg58tg2m+briMgUZuzDeeUd1/+zI76mOZq4H//ilZ4UQ+Em3TYF0YmgTfR59ovD+RHmMhIza+OReDw5txTWn/dB0Dhr6ShTkEMbIc7QYItQp7xGUe1AOpIsuoavdaQwpEpnOermMIOh+rVmYF2OjE82J+NtnaZRSL93rxewgY/o5lvjtkpyAyJTa3KJqHwuLmM3sO1JcYMr19XXM7j9KurmTbsTXeXMT1fxTEraJuk1+7y4/8g1N4DHjT20cMIYoG6RC1Yfh0EBnA3eEBTIFQXCavEolSDryHJ9dm6/xtPU+2Xgci10fAbeuqCvOhSDX0YpNWGcUbcvqJzNmE/f64wkZ9g+ArExhUOtPnZ+JIm0PmceUs7LaKlQUFegZehGvZlSUzKMHhgA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3B2F7A09E53DF4380ADD97D19633899@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f71a270-26f0-4c94-ea8d-08d715d04b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 16:01:05.8021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5020
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.90
Subject: Re: [Qemu-devel] [PATCH 3/3] block/backup: refactor write_flags
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMDcuMjAxOSAyMToyOCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDcvMzAvMTkg
MTI6MzIgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiB3cml0ZSBm
bGFncyBhcmUgY29uc3RhbnQsIGxldCdzIHN0b3JlIGl0IGluIEJhY2t1cEJsb2NrSm9iIGluc3Rl
YWQgb2YNCj4+IHJlY2FsY3VsYXRpbmcuIEl0IGFsc28gbWFrZXMgdHdvIGJvb2xlYW4gZmllbGRz
IHRvIGJlIHVudXNlZCwgc28sDQo+PiBkcm9wIHRoZW0uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0K
Pj4gLS0tDQo+PiAgIGJsb2NrL2JhY2t1cC5jIHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0t
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmFja3VwLmMgYi9ibG9jay9iYWNrdXAuYw0KPj4g
aW5kZXggYzVmOTQxMTAxYS4uNDY1MTY0OWU5ZCAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL2JhY2t1
cC5jDQo+PiArKysgYi9ibG9jay9iYWNrdXAuYw0KPj4gQEAgLTQ3LDcgKzQ3LDYgQEAgdHlwZWRl
ZiBzdHJ1Y3QgQmFja3VwQmxvY2tKb2Igew0KPj4gICAgICAgdWludDY0X3QgbGVuOw0KPj4gICAg
ICAgdWludDY0X3QgYnl0ZXNfcmVhZDsNCj4+ICAgICAgIGludDY0X3QgY2x1c3Rlcl9zaXplOw0K
Pj4gLSAgICBib29sIGNvbXByZXNzOw0KPj4gICAgICAgTm90aWZpZXJXaXRoUmV0dXJuIGJlZm9y
ZV93cml0ZTsNCj4+ICAgICAgIFFMSVNUX0hFQUQoLCBDb3dSZXF1ZXN0KSBpbmZsaWdodF9yZXFz
Ow0KPj4gICANCj4+IEBAIC01NSw3ICs1NCw3IEBAIHR5cGVkZWYgc3RydWN0IEJhY2t1cEJsb2Nr
Sm9iIHsNCj4+ICAgICAgIGJvb2wgdXNlX2NvcHlfcmFuZ2U7DQo+PiAgICAgICBpbnQ2NF90IGNv
cHlfcmFuZ2Vfc2l6ZTsNCj4+ICAgDQo+PiAtICAgIGJvb2wgc2VyaWFsaXplX3RhcmdldF93cml0
ZXM7DQo+PiArICAgIEJkcnZSZXF1ZXN0RmxhZ3Mgd3JpdGVfZmxhZ3M7DQo+PiAgIH0gQmFja3Vw
QmxvY2tKb2I7DQo+PiAgIA0KPj4gICBzdGF0aWMgY29uc3QgQmxvY2tKb2JEcml2ZXIgYmFja3Vw
X2pvYl9kcml2ZXI7DQo+PiBAQCAtMTEwLDEwICsxMDksNiBAQCBzdGF0aWMgaW50IGNvcm91dGlu
ZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihCYWNrdXBCbG9ja0pvYiAqam9iLA0K
Pj4gICAgICAgQmxvY2tCYWNrZW5kICpibGsgPSBqb2ItPmNvbW1vbi5ibGs7DQo+PiAgICAgICBp
bnQgbmJ5dGVzOw0KPj4gICAgICAgaW50IHJlYWRfZmxhZ3MgPSBpc193cml0ZV9ub3RpZmllciA/
IEJEUlZfUkVRX05PX1NFUklBTElTSU5HIDogMDsNCj4+IC0gICAgaW50IHdyaXRlX2ZsYWdzID0N
Cj4+IC0gICAgICAgICAgICAoam9iLT5zZXJpYWxpemVfdGFyZ2V0X3dyaXRlcyA/IEJEUlZfUkVR
X1NFUklBTElTSU5HIDogMCkgfA0KPj4gLSAgICAgICAgICAgIChqb2ItPmNvbXByZXNzID8gQkRS
Vl9SRVFfV1JJVEVfQ09NUFJFU1NFRCA6IDApOw0KPj4gLQ0KPj4gICANCj4+ICAgICAgIGFzc2Vy
dChRRU1VX0lTX0FMSUdORUQoc3RhcnQsIGpvYi0+Y2x1c3Rlcl9zaXplKSk7DQo+PiAgICAgICBo
Yml0bWFwX3Jlc2V0KGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LCBqb2ItPmNsdXN0ZXJfc2l6ZSk7
DQo+PiBAQCAtMTMyLDcgKzEyNyw3IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9j
b3dfd2l0aF9ib3VuY2VfYnVmZmVyKEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+PiAgICAgICB9DQo+
PiAgIA0KPj4gICAgICAgcmV0ID0gYmxrX2NvX3B3cml0ZShqb2ItPnRhcmdldCwgc3RhcnQsIG5i
eXRlcywgKmJvdW5jZV9idWZmZXIsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgd3JpdGVf
ZmxhZ3MpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIGpvYi0+d3JpdGVfZmxhZ3MpOw0K
Pj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4+ICAgICAgICAgICB0cmFjZV9iYWNrdXBfZG9fY293
X3dyaXRlX2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+ICAgICAgICAgICBpZiAoZXJyb3JfaXNf
cmVhZCkgew0KPj4gQEAgLTE2MCw3ICsxNTUsNiBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBi
YWNrdXBfY293X3dpdGhfb2ZmbG9hZChCYWNrdXBCbG9ja0pvYiAqam9iLA0KPj4gICAgICAgQmxv
Y2tCYWNrZW5kICpibGsgPSBqb2ItPmNvbW1vbi5ibGs7DQo+PiAgICAgICBpbnQgbmJ5dGVzOw0K
Pj4gICAgICAgaW50IHJlYWRfZmxhZ3MgPSBpc193cml0ZV9ub3RpZmllciA/IEJEUlZfUkVRX05P
X1NFUklBTElTSU5HIDogMDsNCj4+IC0gICAgaW50IHdyaXRlX2ZsYWdzID0gam9iLT5zZXJpYWxp
emVfdGFyZ2V0X3dyaXRlcyA/IEJEUlZfUkVRX1NFUklBTElTSU5HIDogMDsNCj4+ICAgDQo+PiAg
ICAgICBhc3NlcnQoUUVNVV9JU19BTElHTkVEKGpvYi0+Y29weV9yYW5nZV9zaXplLCBqb2ItPmNs
dXN0ZXJfc2l6ZSkpOw0KPj4gICAgICAgYXNzZXJ0KFFFTVVfSVNfQUxJR05FRChzdGFydCwgam9i
LT5jbHVzdGVyX3NpemUpKTsNCj4+IEBAIC0xNjgsNyArMTYyLDcgQEAgc3RhdGljIGludCBjb3Jv
dXRpbmVfZm4gYmFja3VwX2Nvd193aXRoX29mZmxvYWQoQmFja3VwQmxvY2tKb2IgKmpvYiwNCj4+
ICAgICAgIG5yX2NsdXN0ZXJzID0gRElWX1JPVU5EX1VQKG5ieXRlcywgam9iLT5jbHVzdGVyX3Np
emUpOw0KPj4gICAgICAgaGJpdG1hcF9yZXNldChqb2ItPmNvcHlfYml0bWFwLCBzdGFydCwgam9i
LT5jbHVzdGVyX3NpemUgKiBucl9jbHVzdGVycyk7DQo+PiAgICAgICByZXQgPSBibGtfY29fY29w
eV9yYW5nZShibGssIHN0YXJ0LCBqb2ItPnRhcmdldCwgc3RhcnQsIG5ieXRlcywNCj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVhZF9mbGFncywgd3JpdGVfZmxhZ3MpOw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZWFkX2ZsYWdzLCBqb2ItPndyaXRlX2ZsYWdzKTsN
Cj4+ICAgICAgIGlmIChyZXQgPCAwKSB7DQo+PiAgICAgICAgICAgdHJhY2VfYmFja3VwX2RvX2Nv
d19jb3B5X3JhbmdlX2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+ICAgICAgICAgICBoYml0bWFw
X3NldChqb2ItPmNvcHlfYml0bWFwLCBzdGFydCwgam9iLT5jbHVzdGVyX3NpemUgKiBucl9jbHVz
dGVycyk7DQo+PiBAQCAtNjM4LDEwICs2MzIsMTYgQEAgQmxvY2tKb2IgKmJhY2t1cF9qb2JfY3Jl
YXRlKGNvbnN0IGNoYXIgKmpvYl9pZCwgQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAgICAgICBq
b2ItPnN5bmNfbW9kZSA9IHN5bmNfbW9kZTsNCj4+ICAgICAgIGpvYi0+c3luY19iaXRtYXAgPSBz
eW5jX21vZGUgPT0gTUlSUk9SX1NZTkNfTU9ERV9JTkNSRU1FTlRBTCA/DQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3luY19iaXRtYXAgOiBOVUxMOw0KPj4gLSAgICBqb2ItPmNvbXByZXNz
ID0gY29tcHJlc3M7DQo+PiAgIA0KPj4gLSAgICAvKiBEZXRlY3QgaW1hZ2UtZmxlZWNpbmcgKGFu
ZCBzaW1pbGFyKSBzY2hlbWVzICovDQo+PiAtICAgIGpvYi0+c2VyaWFsaXplX3RhcmdldF93cml0
ZXMgPSBiZHJ2X2NoYWluX2NvbnRhaW5zKHRhcmdldCwgYnMpOw0KPj4gKyAgICAvKg0KPj4gKyAg
ICAgKiBTZXQgd3JpdGUgZmxhZ3M6DQo+PiArICAgICAqICAxLiBEZXRlY3QgaW1hZ2UtZmxlZWNp
bmcgKGFuZCBzaW1pbGFyKSBzY2hlbWVzDQo+PiArICAgICAqICAyLiBIYW5kbGUgY29tcHJlc3Np
b24NCj4+ICsgICAgICovDQo+PiArICAgIGpvYi0+d3JpdGVfZmxhZ3MgPQ0KPj4gKyAgICAgICAg
ICAgIChiZHJ2X2NoYWluX2NvbnRhaW5zKHRhcmdldCwgYnMpID8gQkRSVl9SRVFfU0VSSUFMSVNJ
TkcgOiAwKSB8DQo+PiArICAgICAgICAgICAgKGNvbXByZXNzID8gQkRSVl9SRVFfV1JJVEVfQ09N
UFJFU1NFRCA6IDApOw0KPj4gKw0KPj4gICAgICAgam9iLT5jbHVzdGVyX3NpemUgPSBjbHVzdGVy
X3NpemU7DQo+PiAgICAgICBqb2ItPmNvcHlfYml0bWFwID0gY29weV9iaXRtYXA7DQo+PiAgICAg
ICBjb3B5X2JpdG1hcCA9IE5VTEw7DQo+Pg0KPiANCj4gV2hhdCBoYXBwZW5zIGlmIHlvdSBkaWQg
cGFzcyBCRFJWX1JFUV9XUklURV9DT01QUkVTU0VEIHRvDQo+IGJsa19jb19jb3B5X3JhbmdlPyBJ
cyB0aGF0IHJlamVjdGVkIHNvbWV3aGVyZSBpbiB0aGUgc3RhY2s/DQoNCg0KSG1tLCBJJ20gYWZy
YWlkIHRoYXQgaXQgd2lsbCBiZSBzaWxlbnRseSBpZ25vcmVkLg0KDQpBbmQgSSBoYXZlIG9uZSBx
dWVzdGlvbiByZWxhdGVkIHRvIGNvcHkgb2ZmbG9hZCB0b28uDQoNCkRvIHdlIHJlYWxseSBuZWVk
IHRvIGhhbmRsZSBtYXhfdHJhbnNmZXIgaW4gYmFja3VwIGNvZGUgZm9yIGNvcHkgb2ZmbG9hZD8N
CklzIG1heF90cmFuc2ZlciByZWxhdGVkIHRvIGl0IHJlYWxseT8NCg0KQW55d2F5LCBibC5tYXhf
dHJhbnNmZXIgc2hvdWxkIGJlIGhhbmRsZWQgaW4gZ2VuZXJpYyBjb3B5X3JhbmdlIGNvZGUgaW4g
YmxvY2svaW8uYw0KKGlmIGl0IHNob3VsZCBhdCBhbGwpLCBJJ20gZ29pbmcgdG8gZml4IGl0LCBi
dXQgbWF5IGJlLCBJIGNhbiBqdXN0IGRyb3AgdGhpcyBsaW1pdGF0aW9uDQpmcm9tIGJhY2t1cD8N
Cg0KDQo+IA0KPiBJIGhhZCBqdXN0IGFzc3VtZWQgaXQgd291bGRuJ3Qgd29yayBxdWl0ZSByaWdo
dCBiZWNhdXNlIG9mIHRoZSBuYXR1cmUgb2YNCj4gY29weSBvZmZsb2FkaW5nLCBidXQgSSBkb24n
dCBhY3R1YWxseSBrbm93IHdoYXQgaXQgZG9lcyBkby4NCj4gDQo+IFRoaXMgc2VlbXMgbGlrZSBh
IHByZXR0eSBtaW5vciBjbGVhbnVwLCBidXQgd2h5IG5vdC4gSSBsaWtlIGRyb3BwaW5nDQo+IGV4
dHJhIGZpZWxkcyB3aGVuIEkgY2FuOg0KPiANCj4gUmV2aWV3ZWQtYnk6IEpvaG4gU25vdyA8anNu
b3dAcmVkaGF0LmNvbT4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

