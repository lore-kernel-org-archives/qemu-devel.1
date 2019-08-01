Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD31C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3698D206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 11:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cwPGTitS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3698D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht9KK-0002CW-Gm
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 07:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33714)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ht9Jo-0001hl-Og
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ht9Jn-0002eC-Dv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 07:32:24 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com
 ([40.107.1.110]:52359 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ht9Jm-0002cV-K3; Thu, 01 Aug 2019 07:32:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWd++gnclj55/XZnx50ODw32dJ6bhnPord7xVovU3nwqd18Ho+NNuerRafy02LMa7rU84eG68uXqX9NBWAzl1dRNiubxxzHdhHSnTGRM4Mgwjf8irsk1xzxFpWYJ96k649yiPeTrtp2YqJzr3eNxJD34PogAFa+5XwXd1uOWOEGetBk00TLSqF03VUSxk4ZcMS1vWQRoWVFEbmL3GwrU2CVlK9eg+BH1l06ajlYtw1CRD6jUHU2kl5l1oBWRZt0agOGdZOKSjYP6zAciecnJCCf5V9aMViRvegbP7JjrVaKNbF1Z+pOiECuaJ1Qxuyidl10sCI2AxJYmKiHDbzDfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYQdAyWXlnv+vJYXxuF49u3mAVTxJt+3GRqtl/9ageg=;
 b=gb322/TMPOi9AXUgoL2LWHnZ7yCE6WoxqPG1lR+DBwBCVKUwGt2GSlRoZBF80033dhPwsOEPkQJ8Sx7DOu9fQ6M/9SXZa71i2LoGF5aSpqHQtfJGBruKxlkK2ISFbnCk2M17C3mWjFFBMoCDJN08abL1YnF6AOSDBdrbWjaZ3ww1ADZWc6PJXXDHsX00HWLEzI6O0M36kqDys3y+kN7anzTNX6tDERoDVTJEdor+cWzZ7aJbeHRnzjSb1mKD7U2GhKySz/n1SciZCFeRt5UETxDiLMUt8E6Qr+b+UiRMyBQzELxlCquC+FaYv8xjxdz+xq+T5XL2VfzslZgeN/NFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYQdAyWXlnv+vJYXxuF49u3mAVTxJt+3GRqtl/9ageg=;
 b=cwPGTitSEGwq5om9IdvvfwG01uQ9NAlrRunAU0GYH53lCdlOQXb5Lvjd3cJcdN01SlJIc8WAybFcjKxyFBj/lo3cPIEX1MSRAkICJhW64MraMOmXrS6vd7UnpXoLo3XznSocWY1ayBpetzoD5A/h6l8uG7KdoIQoWsJtN4xjLZU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4027.eurprd08.prod.outlook.com (20.179.9.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 1 Aug 2019 11:32:18 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 11:32:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/3] block/backup: refactor write_flags
Thread-Index: AQHVRvRyYDfKfvF2I0uqR/7Rutw88Kbje1sAgAFpCoCAAUYpgIAAARKA
Date: Thu, 1 Aug 2019 11:32:17 +0000
Message-ID: <29be5652-33d3-216c-a377-ed7d76c23c1b@virtuozzo.com>
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-4-vsementsov@virtuozzo.com>
 <2b034619-ab55-a5f1-a1f4-ea14c4c5c18c@redhat.com>
 <f6927c00-5708-e471-e768-ef9d1e0c2dc6@virtuozzo.com>
 <12efde81-7a17-56c0-e50d-080574faa9f9@redhat.com>
In-Reply-To: <12efde81-7a17-56c0-e50d-080574faa9f9@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0018.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801143215777
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cffb3c83-8f0b-4966-a39b-08d71673e8b0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4027; 
x-ms-traffictypediagnostic: DB8PR08MB4027:
x-microsoft-antispam-prvs: <DB8PR08MB4027674D687A719605D7F741C1DE0@DB8PR08MB4027.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(52314003)(3846002)(6116002)(52116002)(76176011)(486006)(2616005)(229853002)(102836004)(68736007)(14454004)(99286004)(8676002)(71190400001)(71200400001)(81156014)(81166006)(8936002)(446003)(31686004)(478600001)(476003)(11346002)(6436002)(316002)(5660300002)(54906003)(6506007)(186003)(53546011)(66946007)(6246003)(386003)(66446008)(66476007)(36756003)(110136005)(14444005)(256004)(66556008)(64756008)(31696002)(6512007)(26005)(6486002)(305945005)(7736002)(66066001)(2906002)(25786009)(86362001)(107886003)(53936002)(2501003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4027;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6WrE0O3suYQDBP9I3zL35sC4KJJk0FB4JA+jNWGcEXSWt160r+vd3HPKXPI8t4fPf/7dOC1gWJ0XearUpSkTix+QJOckXeWGICrty5ytogyUsB4Fqj6bhRMd+NBHatSkCBVIgi4phE7K+UM4vKIdMm2H8FV3Zgt6rY2M6v/tIyz3nMRANHnCCPeCSWBbTw/+dL9wEhfrkidFevXlo9uFAIuYZpYjvXTuK2IYa1XgiW05zhxuHY1zbD1oSodpgoJfQXEVoddxpzffDc5fKz3Kl0/9j0AwlCADFHO3l/wy9keCbRBXT+hvMNmpc54v41IReuqu6B6Zhw50GwGri5RE5NBEvBN8T4mQWS3kPtqKVItnuFY93kZ9dDJVWY7K0n0cQSosxSP2Uto7mCwdZPPjtvoYbSXUsFcU/eRTLqluB24=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F0E937C5F4B134A87FBF1BAAD14DD32@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffb3c83-8f0b-4966-a39b-08d71673e8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 11:32:17.8075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4027
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.110
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAxNDoyOCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAzMS4wNy4xOSAxODowMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDMwLjA3LjIwMTkgMjE6Mjgs
IEpvaG4gU25vdyB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24gNy8zMC8xOSAxMjozMiBQTSwgVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gd3JpdGUgZmxhZ3MgYXJlIGNv
bnN0YW50LCBsZXQncyBzdG9yZSBpdCBpbiBCYWNrdXBCbG9ja0pvYiBpbnN0ZWFkIG9mDQo+Pj4+
IHJlY2FsY3VsYXRpbmcuIEl0IGFsc28gbWFrZXMgdHdvIGJvb2xlYW4gZmllbGRzIHRvIGJlIHVu
dXNlZCwgc28sDQo+Pj4+IGRyb3AgdGhlbS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+
PiAtLS0NCj4+Pj4gICAgYmxvY2svYmFja3VwLmMgfCAyNCArKysrKysrKysrKystLS0tLS0tLS0t
LS0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9u
cygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmFja3VwLmMgYi9ibG9jay9iYWNr
dXAuYw0KPj4+PiBpbmRleCBjNWY5NDExMDFhLi40NjUxNjQ5ZTlkIDEwMDY0NA0KPj4+PiAtLS0g
YS9ibG9jay9iYWNrdXAuYw0KPj4+PiArKysgYi9ibG9jay9iYWNrdXAuYw0KPj4+PiBAQCAtNDcs
NyArNDcsNiBAQCB0eXBlZGVmIHN0cnVjdCBCYWNrdXBCbG9ja0pvYiB7DQo+Pj4+ICAgICAgICB1
aW50NjRfdCBsZW47DQo+Pj4+ICAgICAgICB1aW50NjRfdCBieXRlc19yZWFkOw0KPj4+PiAgICAg
ICAgaW50NjRfdCBjbHVzdGVyX3NpemU7DQo+Pj4+IC0gICAgYm9vbCBjb21wcmVzczsNCj4+Pj4g
ICAgICAgIE5vdGlmaWVyV2l0aFJldHVybiBiZWZvcmVfd3JpdGU7DQo+Pj4+ICAgICAgICBRTElT
VF9IRUFEKCwgQ293UmVxdWVzdCkgaW5mbGlnaHRfcmVxczsNCj4+Pj4gICAgDQo+Pj4+IEBAIC01
NSw3ICs1NCw3IEBAIHR5cGVkZWYgc3RydWN0IEJhY2t1cEJsb2NrSm9iIHsNCj4+Pj4gICAgICAg
IGJvb2wgdXNlX2NvcHlfcmFuZ2U7DQo+Pj4+ICAgICAgICBpbnQ2NF90IGNvcHlfcmFuZ2Vfc2l6
ZTsNCj4+Pj4gICAgDQo+Pj4+IC0gICAgYm9vbCBzZXJpYWxpemVfdGFyZ2V0X3dyaXRlczsNCj4+
Pj4gKyAgICBCZHJ2UmVxdWVzdEZsYWdzIHdyaXRlX2ZsYWdzOw0KPj4+PiAgICB9IEJhY2t1cEJs
b2NrSm9iOw0KPj4+PiAgICANCj4+Pj4gICAgc3RhdGljIGNvbnN0IEJsb2NrSm9iRHJpdmVyIGJh
Y2t1cF9qb2JfZHJpdmVyOw0KPj4+PiBAQCAtMTEwLDEwICsxMDksNiBAQCBzdGF0aWMgaW50IGNv
cm91dGluZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihCYWNrdXBCbG9ja0pvYiAq
am9iLA0KPj4+PiAgICAgICAgQmxvY2tCYWNrZW5kICpibGsgPSBqb2ItPmNvbW1vbi5ibGs7DQo+
Pj4+ICAgICAgICBpbnQgbmJ5dGVzOw0KPj4+PiAgICAgICAgaW50IHJlYWRfZmxhZ3MgPSBpc193
cml0ZV9ub3RpZmllciA/IEJEUlZfUkVRX05PX1NFUklBTElTSU5HIDogMDsNCj4+Pj4gLSAgICBp
bnQgd3JpdGVfZmxhZ3MgPQ0KPj4+PiAtICAgICAgICAgICAgKGpvYi0+c2VyaWFsaXplX3Rhcmdl
dF93cml0ZXMgPyBCRFJWX1JFUV9TRVJJQUxJU0lORyA6IDApIHwNCj4+Pj4gLSAgICAgICAgICAg
IChqb2ItPmNvbXByZXNzID8gQkRSVl9SRVFfV1JJVEVfQ09NUFJFU1NFRCA6IDApOw0KPj4+PiAt
DQo+Pj4+ICAgIA0KPj4+PiAgICAgICAgYXNzZXJ0KFFFTVVfSVNfQUxJR05FRChzdGFydCwgam9i
LT5jbHVzdGVyX3NpemUpKTsNCj4+Pj4gICAgICAgIGhiaXRtYXBfcmVzZXQoam9iLT5jb3B5X2Jp
dG1hcCwgc3RhcnQsIGpvYi0+Y2x1c3Rlcl9zaXplKTsNCj4+Pj4gQEAgLTEzMiw3ICsxMjcsNyBA
QCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihC
YWNrdXBCbG9ja0pvYiAqam9iLA0KPj4+PiAgICAgICAgfQ0KPj4+PiAgICANCj4+Pj4gICAgICAg
IHJldCA9IGJsa19jb19wd3JpdGUoam9iLT50YXJnZXQsIHN0YXJ0LCBuYnl0ZXMsICpib3VuY2Vf
YnVmZmVyLA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgd3JpdGVfZmxhZ3MpOw0KPj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgam9iLT53cml0ZV9mbGFncyk7DQo+Pj4+ICAgICAg
ICBpZiAocmV0IDwgMCkgew0KPj4+PiAgICAgICAgICAgIHRyYWNlX2JhY2t1cF9kb19jb3dfd3Jp
dGVfZmFpbChqb2IsIHN0YXJ0LCByZXQpOw0KPj4+PiAgICAgICAgICAgIGlmIChlcnJvcl9pc19y
ZWFkKSB7DQo+Pj4+IEBAIC0xNjAsNyArMTU1LDYgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4g
YmFja3VwX2Nvd193aXRoX29mZmxvYWQoQmFja3VwQmxvY2tKb2IgKmpvYiwNCj4+Pj4gICAgICAg
IEJsb2NrQmFja2VuZCAqYmxrID0gam9iLT5jb21tb24uYmxrOw0KPj4+PiAgICAgICAgaW50IG5i
eXRlczsNCj4+Pj4gICAgICAgIGludCByZWFkX2ZsYWdzID0gaXNfd3JpdGVfbm90aWZpZXIgPyBC
RFJWX1JFUV9OT19TRVJJQUxJU0lORyA6IDA7DQo+Pj4+IC0gICAgaW50IHdyaXRlX2ZsYWdzID0g
am9iLT5zZXJpYWxpemVfdGFyZ2V0X3dyaXRlcyA/IEJEUlZfUkVRX1NFUklBTElTSU5HIDogMDsN
Cj4+Pj4gICAgDQo+Pj4+ICAgICAgICBhc3NlcnQoUUVNVV9JU19BTElHTkVEKGpvYi0+Y29weV9y
YW5nZV9zaXplLCBqb2ItPmNsdXN0ZXJfc2l6ZSkpOw0KPj4+PiAgICAgICAgYXNzZXJ0KFFFTVVf
SVNfQUxJR05FRChzdGFydCwgam9iLT5jbHVzdGVyX3NpemUpKTsNCj4+Pj4gQEAgLTE2OCw3ICsx
NjIsNyBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfY293X3dpdGhfb2ZmbG9hZChC
YWNrdXBCbG9ja0pvYiAqam9iLA0KPj4+PiAgICAgICAgbnJfY2x1c3RlcnMgPSBESVZfUk9VTkRf
VVAobmJ5dGVzLCBqb2ItPmNsdXN0ZXJfc2l6ZSk7DQo+Pj4+ICAgICAgICBoYml0bWFwX3Jlc2V0
KGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LCBqb2ItPmNsdXN0ZXJfc2l6ZSAqIG5yX2NsdXN0ZXJz
KTsNCj4+Pj4gICAgICAgIHJldCA9IGJsa19jb19jb3B5X3JhbmdlKGJsaywgc3RhcnQsIGpvYi0+
dGFyZ2V0LCBzdGFydCwgbmJ5dGVzLA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlYWRfZmxhZ3MsIHdyaXRlX2ZsYWdzKTsNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZWFkX2ZsYWdzLCBqb2ItPndyaXRlX2ZsYWdzKTsNCj4+Pj4gICAgICAgIGlmIChyZXQg
PCAwKSB7DQo+Pj4+ICAgICAgICAgICAgdHJhY2VfYmFja3VwX2RvX2Nvd19jb3B5X3JhbmdlX2Zh
aWwoam9iLCBzdGFydCwgcmV0KTsNCj4+Pj4gICAgICAgICAgICBoYml0bWFwX3NldChqb2ItPmNv
cHlfYml0bWFwLCBzdGFydCwgam9iLT5jbHVzdGVyX3NpemUgKiBucl9jbHVzdGVycyk7DQo+Pj4+
IEBAIC02MzgsMTAgKzYzMiwxNiBAQCBCbG9ja0pvYiAqYmFja3VwX2pvYl9jcmVhdGUoY29uc3Qg
Y2hhciAqam9iX2lkLCBCbG9ja0RyaXZlclN0YXRlICpicywNCj4+Pj4gICAgICAgIGpvYi0+c3lu
Y19tb2RlID0gc3luY19tb2RlOw0KPj4+PiAgICAgICAgam9iLT5zeW5jX2JpdG1hcCA9IHN5bmNf
bW9kZSA9PSBNSVJST1JfU1lOQ19NT0RFX0lOQ1JFTUVOVEFMID8NCj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICBzeW5jX2JpdG1hcCA6IE5VTEw7DQo+Pj4+IC0gICAgam9iLT5jb21wcmVz
cyA9IGNvbXByZXNzOw0KPj4+PiAgICANCj4+Pj4gLSAgICAvKiBEZXRlY3QgaW1hZ2UtZmxlZWNp
bmcgKGFuZCBzaW1pbGFyKSBzY2hlbWVzICovDQo+Pj4+IC0gICAgam9iLT5zZXJpYWxpemVfdGFy
Z2V0X3dyaXRlcyA9IGJkcnZfY2hhaW5fY29udGFpbnModGFyZ2V0LCBicyk7DQo+Pj4+ICsgICAg
LyoNCj4+Pj4gKyAgICAgKiBTZXQgd3JpdGUgZmxhZ3M6DQo+Pj4+ICsgICAgICogIDEuIERldGVj
dCBpbWFnZS1mbGVlY2luZyAoYW5kIHNpbWlsYXIpIHNjaGVtZXMNCj4+Pj4gKyAgICAgKiAgMi4g
SGFuZGxlIGNvbXByZXNzaW9uDQo+Pj4+ICsgICAgICovDQo+Pj4+ICsgICAgam9iLT53cml0ZV9m
bGFncyA9DQo+Pj4+ICsgICAgICAgICAgICAoYmRydl9jaGFpbl9jb250YWlucyh0YXJnZXQsIGJz
KSA/IEJEUlZfUkVRX1NFUklBTElTSU5HIDogMCkgfA0KPj4+PiArICAgICAgICAgICAgKGNvbXBy
ZXNzID8gQkRSVl9SRVFfV1JJVEVfQ09NUFJFU1NFRCA6IDApOw0KPj4+PiArDQo+Pj4+ICAgICAg
ICBqb2ItPmNsdXN0ZXJfc2l6ZSA9IGNsdXN0ZXJfc2l6ZTsNCj4+Pj4gICAgICAgIGpvYi0+Y29w
eV9iaXRtYXAgPSBjb3B5X2JpdG1hcDsNCj4+Pj4gICAgICAgIGNvcHlfYml0bWFwID0gTlVMTDsN
Cj4+Pj4NCj4+Pg0KPj4+IFdoYXQgaGFwcGVucyBpZiB5b3UgZGlkIHBhc3MgQkRSVl9SRVFfV1JJ
VEVfQ09NUFJFU1NFRCB0bw0KPj4+IGJsa19jb19jb3B5X3JhbmdlPyBJcyB0aGF0IHJlamVjdGVk
IHNvbWV3aGVyZSBpbiB0aGUgc3RhY2s/DQo+Pg0KPj4NCj4+IEhtbSwgSSdtIGFmcmFpZCB0aGF0
IGl0IHdpbGwgYmUgc2lsZW50bHkgaWdub3JlZC4NCj4+DQo+PiBBbmQgSSBoYXZlIG9uZSBxdWVz
dGlvbiByZWxhdGVkIHRvIGNvcHkgb2ZmbG9hZCB0b28uDQo+Pg0KPj4gRG8gd2UgcmVhbGx5IG5l
ZWQgdG8gaGFuZGxlIG1heF90cmFuc2ZlciBpbiBiYWNrdXAgY29kZSBmb3IgY29weSBvZmZsb2Fk
Pw0KPj4gSXMgbWF4X3RyYW5zZmVyIHJlbGF0ZWQgdG8gaXQgcmVhbGx5Pw0KPj4NCj4+IEFueXdh
eSwgYmwubWF4X3RyYW5zZmVyIHNob3VsZCBiZSBoYW5kbGVkIGluIGdlbmVyaWMgY29weV9yYW5n
ZSBjb2RlIGluIGJsb2NrL2lvLmMNCj4+IChpZiBpdCBzaG91bGQgYXQgYWxsKSwgSSdtIGdvaW5n
IHRvIGZpeCBpdCwgYnV0IG1heSBiZSwgSSBjYW4ganVzdCBkcm9wIHRoaXMgbGltaXRhdGlvbg0K
Pj4gZnJvbSBiYWNrdXA/DQo+IA0KPiBPbiBhIHF1aWNrIGdsYW5jZSwgaXQgZG9lc27igJl0IGxv
b2sgbGlrZSBhIGxpbWl0YXRpb24gdG8gbWUgYnV0IGFjdHVhbGx5DQo+IGxpa2UgdGhlIG9wcG9z
aXRlLiAgYmFja3VwX2Nvd193aXRoX2JvdW5jZV9idWZmZXIoKSBvbmx5IGNvcGllcyB1cCB0bw0K
PiBjbHVzdGVyX3NpemUsIHdoZXJlYXMgYmFja3VwX2Nvd193aXRoX29mZmxvYWQoKSB3aWxsIGNv
cHkgdXAgdG8gdGhlDQo+IG1heGltdW0gdHJhbnNmZXIgc2l6ZSBwZXJtaXR0ZWQgYnkgYm90aCBz
b3VyY2UgYW5kIHRhcmdldCBmb3IgY29weQ0KPiBvZmZsb2FkaW5nLg0KPiANCg0KSSBtZWFuLCB3
aHkgbm90IHRvIGp1c3QgY29weSB0aGUgd2hvbGUgY2h1bmsgY29tZXMgaW4gbm90aWZpZXIgYW5k
IGRvbid0IGNhcmUgYWJvdXQNCm1heF90cmFuc2Zlcj8gQmFja3VwIGxvb3AgY29waWVzIGNsdXN0
ZXIgYnkgY2x1c3RlciBhbnl3YXksIHNvIG9ubHkgbm90aWZpZXIgbWF5IGNvcHkNCmxhcmdlciBj
aHVuay4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

