Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA03EC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81ACD2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G/UdjgS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81ACD2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7ZK-0008DT-Sb
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD7WO-0006EE-Rx
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD7WF-00074t-7Y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:39:55 -0400
Received: from mail-eopbgr150110.outbound.protection.outlook.com
 ([40.107.15.110]:8573 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD7WE-00072g-HO; Wed, 25 Sep 2019 09:39:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnnFqdT2iDmdlNggjeikCi3LYDmiw3AUctwluWzWpLnXo4dwhUB62y8RgtOHClwdGxNuhLowBFziZfIEXgKS4Ll8PGLtdHCQHCrit+nA7UwYeSHNev8AT6yONKWLyIDyFqzdEHVDi3RSSgMAlRCS+jirGERMCuGVoNeKqlETv7vN9x5NAq4hK5kNiuiCsfZUVWQ2Nc6BWwKsXKPQ2XhCA7IN90ewSYfnXK2FWoIU+VpnfNN4FI85qQF7MEUahn2vXgLfeyhxlcSxlZkuRSqWDH5+DIeobljOpwrrx5vUs+rlwheNweB0pi9wBUYm3IeBCR+kCgGfPWzAz4snK2/ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmQ1xH9z0BtWJs6VFzoUdNgXyl9koV8vWKDymIEBjA4=;
 b=Wv/nBPtcUgqtO14rDFQ3cgGcx7FNG41hLqS9+XffbGAJe7ZhTDyZlHK4Kr7DqV2W1XtbDyAxh+BUrkGCl4lQuu4h1vyJeaY1fE7djhZP/AvaesP1yzFf7ZjIeIvyusjF31U/G6ezf+PQDwxo6vljjmZMlKVrHn9xkM+nSMKp8jZVka7MV5yApPQIFj8p0Kvkw2VNfvNB8/zD9FXmSv9pGfhHITt00whE32SB7qWrLqJIi92GJweIwOIQIA/oDMHE2IiV7nvasNHUiEUbMf/xRVAe/DiTYbJQ3JmzKPJ5u59DclqFYBg6l/qfjwUlt/DZtcp4gtGyuQ/An8ek6O/Mew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmQ1xH9z0BtWJs6VFzoUdNgXyl9koV8vWKDymIEBjA4=;
 b=G/UdjgS1vpu+ujcT9dEVWYL4sSD2h5sR9h08C/hE6ykK65ztq57pAY2OHaiXnHbI1Tc105EWB1RdFMT0lFL0e5zGKeupgKlJ5KGEDfrUWXPhCqurOMTs/3t3W4yoCUeqSm82Xo8GTtbCiOH7MQeJIXw/e3JPMw2qfQ0lHyZSPdc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4954.eurprd08.prod.outlook.com (20.179.15.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Wed, 25 Sep 2019 13:39:44 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 13:39:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 10/22] quorum: Implement .bdrv_recurse_can_replace()
Thread-Topic: [PATCH 10/22] quorum: Implement .bdrv_recurse_can_replace()
Thread-Index: AQHVb8x5FMRz3/odLkqUJ37f4pTVWac8bcSA
Date: Wed, 25 Sep 2019 13:39:44 +0000
Message-ID: <b8e5c18a-67a7-aa9c-e1c7-7aca1408926a@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-11-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-11-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0041.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::51) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925163941097
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09d4507e-48c3-4c49-a05d-08d741bdd300
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4954; 
x-ms-traffictypediagnostic: DB8PR08MB4954:
x-microsoft-antispam-prvs: <DB8PR08MB4954F3FE9D5B04983A109BBBC1870@DB8PR08MB4954.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(110136005)(66066001)(54906003)(66476007)(66556008)(64756008)(66446008)(66946007)(2501003)(99286004)(31696002)(316002)(478600001)(256004)(5660300002)(71200400001)(71190400001)(36756003)(81166006)(31686004)(6246003)(2906002)(6116002)(3846002)(4326008)(14454004)(6512007)(86362001)(102836004)(2616005)(305945005)(386003)(6506007)(186003)(229853002)(7736002)(26005)(81156014)(476003)(25786009)(52116002)(8676002)(11346002)(486006)(6436002)(76176011)(6486002)(8936002)(446003)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4954;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eL4bduYxtUPYMv2JkTMmoZDOZyGjN5AKRXStRb14z+gWsiRtGdd3uHJirBi0SCdre2xlyDEr57kBp+yFKwbK31Zs/V5eaCdZigvb2wfvhQP06+QXLsx2vhwyNf9kUS8icVpOXoyTR+vs9+FiKIgWog/lrIafX2fcnfoZVQBiImQHjMfSMLldv/bSsCvnqvz3z7lQvGRguB18Mtdm9xog3CaMyUEBK5dPtAKbdHnFt5g3fQ0kXh8ik0LlwUNDg1qBr7ejpGFnws2HuMo+LIqBER/B0LP1vE5DHciL5KKmngUqYMUxbL7Y4zPbLlOzGeJ+WVACrYlHP1ju8VusZ/rlFbFrktDoCeHrCJJZC5FNxR9CNrPRW2nI32+2hX3uVpMvoxZSYFknWKQVPYg5IkIMvRftYhqpO9wYs7FzDgxvpag=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F166384209E8244A1DBF16B4F6AE6DB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d4507e-48c3-4c49-a05d-08d741bdd300
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 13:39:44.2633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWtrwrfpGVWRujv5yjIv2FybuzCLrgDBul9HsD9/mHnHbdJkj/EAkCGj7/D4iRQWXMMn81+B+94gqhTf0PMU8U/dZQ3y0KDlDetXXyjqilw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4954
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.110
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9jay9xdW9ydW0uYyB8IDYy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9j
ay9xdW9ydW0uYyBiL2Jsb2NrL3F1b3J1bS5jDQo+IGluZGV4IDIwNzA1NGE2NGUuLjgxYjU3ZGJh
ZTIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3F1b3J1bS5jDQo+ICsrKyBiL2Jsb2NrL3F1b3J1bS5j
DQo+IEBAIC04MjUsNiArODI1LDY3IEBAIHN0YXRpYyBib29sIHF1b3J1bV9yZWN1cnNlX2lzX2Zp
cnN0X25vbl9maWx0ZXIoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgYm9vbCBxdW9ydW1fcmVjdXJzZV9jYW5fcmVwbGFj
ZShCbG9ja0RyaXZlclN0YXRlICpicywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKnRvX3JlcGxhY2UpDQo+ICt7DQo+ICsgICAgQkRS
VlF1b3J1bVN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4gKyAgICBpbnQgaTsNCj4gKw0KPiArICAg
IGZvciAoaSA9IDA7IGkgPCBzLT5udW1fY2hpbGRyZW47IGkrKykgew0KPiArICAgICAgICAvKg0K
PiArICAgICAgICAgKiBXZSBoYXZlIG5vIGlkZWEgd2hldGhlciBvdXIgY2hpbGRyZW4gc2hvdyB0
aGUgc2FtZSBkYXRhIGFzDQo+ICsgICAgICAgICAqIHRoaXMgbm9kZSAoQGJzKS4gIEl0IGlzIGFj
dHVhbGx5IGhpZ2hseSBsaWtlbHkgdGhhdA0KPiArICAgICAgICAgKiBAdG9fcmVwbGFjZSBkb2Vz
IG5vdCwgYmVjYXVzZSByZXBsYWNpbmcgYSBicm9rZW4gY2hpbGQgaXMNCj4gKyAgICAgICAgICog
b25lIG9mIHRoZSBtYWluIHVzZSBjYXNlcyBoZXJlLg0KPiArICAgICAgICAgKg0KPiArICAgICAg
ICAgKiBXZSBkbyBrbm93IHRoYXQgdGhlIG5ldyBCRFMgd2lsbCBtYXRjaCBAYnMsIHNvIHJlcGxh
Y2luZw0KPiArICAgICAgICAgKiBhbnkgb2Ygb3VyIGNoaWxkcmVuIGJ5IGl0IHdpbGwgYmUgc2Fm
ZS4gIEl0IGNhbm5vdCBjaGFuZ2UNCj4gKyAgICAgICAgICogdGhlIGRhdGEgdGhpcyBxdW9ydW0g
bm9kZSBwcmVzZW50cyB0byBpdHMgcGFyZW50cy4NCj4gKyAgICAgICAgICoNCj4gKyAgICAgICAg
ICogSG93ZXZlciwgcmVwbGFjaW5nIEB0b19yZXBsYWNlIGJ5IEBicyBpbiBhbnkgb2Ygb3VyDQoN
CkknbSBhIGJpdCBtaXNsZWFkZWQ6IGJ5IEBicywgb3IgYnkgbm9kZSBlcXVhbCB0byBAYnMgKGFj
Y29yZGluZ2x5IHRvDQpiZHJ2X3JlY3Vyc2VfY2FuX3JlcGxhY2Ugc3BlYyk/DQoNCj4gKyAgICAg
ICAgICogY2hpbGRyZW4ncyBjaGFpbnMgbWF5IGNoYW5nZSB2aXNpYmxlIGRhdGEgc29tZXdoZXJl
IGluDQo+ICsgICAgICAgICAqIHRoZXJlLiAgV2UgdGhlcmVmb3JlIGNhbm5vdCByZWN1cnNlIGRv
d24gdGhvc2UgY2hhaW5zIHdpdGgNCj4gKyAgICAgICAgICogYmRydl9yZWN1cnNlX2Nhbl9yZXBs
YWNlKCkuDQo+ICsgICAgICAgICAqIChNb3JlIGZvcm1hbGx5LCBiZHJ2X3JlY3Vyc2VfY2FuX3Jl
cGxhY2UoKSByZXF1aXJlcyB0aGF0DQo+ICsgICAgICAgICAqIEB0b19yZXBsYWNlIHdpbGwgYmUg
cmVwbGFjZWQgYnkgc29tZXRoaW5nIG1hdGNoaW5nIHRoZSBAYnMNCj4gKyAgICAgICAgICogcGFz
c2VkIHRvIGl0LiAgV2UgY2Fubm90IGd1YXJhbnRlZSB0aGF0LikNCg0KQWhhLCBhbmQgeW91IGFu
c3dlcmVkIGFscmVhZHkgOikgT0suDQoNCj4gKyAgICAgICAgICoNCj4gKyAgICAgICAgICogVGh1
cywgd2UgY2FuIG9ubHkgY2hlY2sgd2hldGhlciBhbnkgb2Ygb3VyIGltbWVkaWF0ZQ0KPiArICAg
ICAgICAgKiBjaGlsZHJlbiBtYXRjaGVzIEB0b19yZXBsYWNlLg0KPiArICAgICAgICAgKg0KPiAr
ICAgICAgICAgKiAoSW4gdGhlIGZ1dHVyZSwgd2UgbWlnaHQgYWRkIGEgZnVuY3Rpb24gdG8gcmVj
dXJzZSBkb3duIGENCj4gKyAgICAgICAgICogY2hhaW4gdGhhdCBjaGVja3MgdGhhdCBub3RoaW5n
IHRoZXJlIGNhcmVzIGFib3V0IGEgY2hhbmdlDQo+ICsgICAgICAgICAqIGluIGRhdGEgZnJvbSB0
aGUgcmVzcGVjdGl2ZSBjaGlsZCBpbiBxdWVzdGlvbi4gIEZvcg0KPiArICAgICAgICAgKiBleGFt
cGxlLCBtb3N0IGZpbHRlcnMgZG8gbm90IGNhcmUgd2hlbiB0aGVpciBjaGlsZCdzIGRhdGENCj4g
KyAgICAgICAgICogc3VkZGVubHkgY2hhbmdlcywgYXMgbG9uZyBhcyB0aGVpciBwYXJlbnRzIGRv
IG5vdCBjYXJlLikNCj4gKyAgICAgICAgICovDQo+ICsgICAgICAgIGlmIChzLT5jaGlsZHJlbltp
XS5jaGlsZC0+YnMgPT0gdG9fcmVwbGFjZSkgew0KDQpIbW0sIHN0aWxsLCB3aGF0IGlzIHdyb25n
IGlmIHdlIGp1c3QgcHV0IGJkcnZfcmVjdXJzZV9jYW5fcmVwbGFjZShzLT5jaGlsZHJlbltpXS5j
aGlsZC0+YnMsIHRvX3JlcGxhY2UpIGludG8gdGhpcyBpZiBjb25kaXRpb24/DQoob3IgbWF5IGJl
IG1vcmUgY29ycmVjdCB0byBjYWxsIGl0IGFmdGVyIHRha2luZyBwZXJtaXNzaW9ucykNCg0KPiAr
ICAgICAgICAgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ICsNCj4gKyAgICAgICAgICAg
IC8qDQo+ICsgICAgICAgICAgICAgKiBXZSBub3cgaGF2ZSB0byBlbnN1cmUgdGhhdCB0aGVyZSBp
cyBubyBvdGhlciBwYXJlbnQNCj4gKyAgICAgICAgICAgICAqIHRoYXQgY2FyZXMgYWJvdXQgcmVw
bGFjaW5nIHRoaXMgY2hpbGQgYnkgYSBub2RlIHdpdGgNCj4gKyAgICAgICAgICAgICAqIHBvdGVu
dGlhbGx5IGRpZmZlcmVudCBkYXRhLg0KPiArICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAg
ICBzLT5jaGlsZHJlbltpXS50b19iZV9yZXBsYWNlZCA9IHRydWU7DQo+ICsgICAgICAgICAgICBi
ZHJ2X2NoaWxkX3JlZnJlc2hfcGVybXMoYnMsIHMtPmNoaWxkcmVuW2ldLmNoaWxkLCAmbG9jYWxf
ZXJyKTsNCj4gKw0KPiArICAgICAgICAgICAgLyogUmV2ZXJ0IHBlcm1pc3Npb25zICovDQo+ICsg
ICAgICAgICAgICBzLT5jaGlsZHJlbltpXS50b19iZV9yZXBsYWNlZCA9IGZhbHNlOw0KPiArICAg
ICAgICAgICAgYmRydl9jaGlsZF9yZWZyZXNoX3Blcm1zKGJzLCBzLT5jaGlsZHJlbltpXS5jaGls
ZCwgJmVycm9yX2Fib3J0KTsNCj4gKw0KPiArICAgICAgICAgICAgaWYgKGxvY2FsX2Vycikgew0K
PiArICAgICAgICAgICAgICAgIGVycm9yX2ZyZWUobG9jYWxfZXJyKTsNCj4gKyAgICAgICAgICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAgICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgICAg
IHJldHVybiB0cnVlOw0KPiArICAgICAgICB9DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0dXJu
IGZhbHNlOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGludCBxdW9ydW1fdmFsaWRfdGhyZXNob2xk
KGludCB0aHJlc2hvbGQsIGludCBudW1fY2hpbGRyZW4sIEVycm9yICoqZXJycCkNCj4gICB7DQo+
ICAgDQo+IEBAIC0xMTk1LDYgKzEyNTYsNyBAQCBzdGF0aWMgQmxvY2tEcml2ZXIgYmRydl9xdW9y
dW0gPSB7DQo+ICAgDQo+ICAgICAgIC5pc19maWx0ZXIgICAgICAgICAgICAgICAgICAgICAgICAg
ID0gdHJ1ZSwNCj4gICAgICAgLmJkcnZfcmVjdXJzZV9pc19maXJzdF9ub25fZmlsdGVyICAgPSBx
dW9ydW1fcmVjdXJzZV9pc19maXJzdF9ub25fZmlsdGVyLA0KPiArICAgIC5iZHJ2X3JlY3Vyc2Vf
Y2FuX3JlcGxhY2UgICAgICAgICAgID0gcXVvcnVtX3JlY3Vyc2VfY2FuX3JlcGxhY2UsDQo+ICAg
DQo+ICAgICAgIC5zdHJvbmdfcnVudGltZV9vcHRzICAgICAgICAgICAgICAgID0gcXVvcnVtX3N0
cm9uZ19ydW50aW1lX29wdHMsDQo+ICAgfTsNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

