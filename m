Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740EC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5279F20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S6kc84e8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5279F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dXY-0000uZ-9c
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2d2O-0000qF-Bl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2d2M-0007hK-8c
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:05:35 -0400
Received: from mail-eopbgr140131.outbound.protection.outlook.com
 ([40.107.14.131]:19845 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i2d2L-0007gV-Ez
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3ALg1/A3fxPQswwO1FCLPX62H0sG4cpb69mnCBGnEefKyVmnWfUGu4pSnh39HtfiweLi5gY4yqsrnRG9h3Iun0hessMsVucRRggZg4PHgXgwHO4IYV5FdWifwU5Z/BiLIYW16TLteUWjxfWPRTJ2ouRhHSyjWG4pt5D/iChPnDNfgSC0IRbcX/bfoA9yM6ptICWwLE13HVsZkCvxDsFwQokQuzLqaN3Qq3h2df97q89DQyIJwS2/+lR3MD4E1GHCvvvA5zvwsy6JMYKje4j0d7IFRPRyq9qTsUDZ+TksAPhFN9R/JapxislwzJXPL7ugNYNLXgs3O+99wIhZL4Afg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=felU5XkuWfAypGYjMeFGbuMv868JhHGXNv5+wq0OD1k=;
 b=FyKyXVYJivRRRgasETXW1cCEWtzMjUwmVho346sqH9aY1+pQB0qoIydmB4ml2pqBgSi7AKHNm3imsH27poY9cdK2K3TUxDQdxtIVVWZfGVaOswFt+T0kH/exqvY5ThudT+CmQfqlM5Kk2VUgJabiGudH4/a00ydkGjKvnXH/EcmtXkU90IcGO42jaDlNgFSOIGtaX9S1xbEr3T4tM8zjgxyDXDjnqebhg+2dTze8TKNoSzBZf4Bwg7dhEU3xAes7ik8aGummz7y7zp3DzCi4B1T2KDv9ivo15DkEZ01Lkg1o/l6JJ5WJ5/+TENqAfPFcFog43QhOkUX5OMNbH9fmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=felU5XkuWfAypGYjMeFGbuMv868JhHGXNv5+wq0OD1k=;
 b=S6kc84e87DtD15jcW8i7kApNIAizde3TahtBCGaO/nyJNW7PB5sJtLWmXWj+6VdRV+vW3THdeuX/O7lFbtBxTJ0uVJj8bsIMbXA8Ne9DGQ3Phu0LyGxsMo36kjBbqjJ2xKkYeAehhkTHKcIHIfD1pkHKViIQ+nxOK4d+lonIscw=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3024.eurprd08.prod.outlook.com (52.133.14.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 15:05:31 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 15:05:30 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH] Fix: fp-test uninitialized member
 floatX::exp
Thread-Index: AQHVRr9xspCki27n+kGlF3NZYO6Lkab5QwaA///S3QCAC4DUgIAKrYMA
Date: Tue, 27 Aug 2019 15:05:30 +0000
Message-ID: <f2e1122c-8221-7c7c-9c2b-a34ce8112008@virtuozzo.com>
References: <1564481593-776647-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <573f907d-5016-60c1-c727-c5444a418e1b@virtuozzo.com>
 <8736i5ntlp.fsf@linaro.org>
 <af72d680-f169-bdba-3b6e-d2da6b820aea@virtuozzo.com>
In-Reply-To: <af72d680-f169-bdba-3b6e-d2da6b820aea@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0206.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::30) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d23458cc-1f5a-452a-e1eb-08d72b00008f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3024; 
x-ms-traffictypediagnostic: VI1PR08MB3024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB30244DC054E39A710A6AB5AFF4A00@VI1PR08MB3024.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39850400004)(396003)(346002)(366004)(189003)(199004)(6116002)(3846002)(64756008)(2906002)(31686004)(446003)(36756003)(81156014)(229853002)(8676002)(54906003)(66556008)(102836004)(8936002)(305945005)(7736002)(14454004)(66066001)(478600001)(26005)(44832011)(99286004)(53936002)(52116002)(6506007)(25786009)(386003)(19627235002)(53546011)(71190400001)(71200400001)(66574012)(6246003)(256004)(316002)(6486002)(86362001)(4326008)(81166006)(6512007)(2616005)(66946007)(11346002)(76176011)(66446008)(6436002)(5660300002)(476003)(31696002)(486006)(6916009)(66476007)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3024;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fsGKlh8Ag69ALLAyrXItEL6UmnWcjf5xEHRT3Yj+fUKhgzkqzBq8qshYS3DgUfb4f6ysIEOKSbUzbe+0Fqx8wsD15AMEuu67fMe33uzwhGpOm7wQvbCSg7vbMhGQTJ1HzYgUQmBL7wKXkVEtw6ogFwueLSK9/cKhSTUuUCYlRFN6aybIg7EwQ0mq2TUymkMb1RpBLmYTUVWMJoNCSTgy3Sn0K0xA6kJuKKEmjPgcV0K/KjFJRsIKKJo92fRNf/0K6dNnnz+bj3cwyU5wOJ14zKWoC9nsBLVSBg3B0yO2DTsPgqwGChny0D89slC/OVntAdA3oS4d0lK/G/JAohP0bSt5wca7ltLmh+MU+O6rx7rZ/gK2KMRoJiLxnQvIS01khSIVjlkNqSIKtFOLVnibTjbi5Wp1B0DpYFlwyxt3n/g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA11C119655253468E63660B66E0AC91@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23458cc-1f5a-452a-e1eb-08d72b00008f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 15:05:30.7307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvg4knfB2bTeTFl4NcUvmiHQTl5j8FMNAvTP0g+IOVOsVFYVC/+gdl5jnXvlYd71L9wohwwzs/KLx8Cc/YNtVkXF5QTn8whhS+FTgPQNtFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.131
Subject: Re: [Qemu-devel] [PATCH] Fix: fp-test uninitialized member
 floatX::exp
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "jhauser@eecs.berkeley.edu" <jhauser@eecs.berkeley.edu>,
 Denis Lunev <den@virtuozzo.com>, "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSBqdXN0IHdvcnJ5IGFib3V0IHRoaXMgc2ltcGxlIHBhdGNoIHRvIGJlIGxvc3QgYmVjYXVzZSBJ
IGdvdCBzb21lIG1lc3MgDQp3aXRoIGl0IGluIG15IFRodW5kZXJiaXJkIGVtYWlsIHRocmVhZHMu
DQoNCkFuZHJleQ0KDQpPbiAyMC8wOC8yMDE5IDIwOjAxLCBBbmRyZXkgU2hpbmtldmljaCB3cm90
ZToNCj4gT24gMTMvMDgvMjAxOSAxNToyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4NCj4+IEFu
ZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPiB3cml0ZXM6
DQo+Pg0KPj4+IFBJTkdJTkcuLi4NCj4+DQo+PiBTb3JyeSBhYm91dCB0aGUgZGVsYXkuIEkgZGlk
IGF0dGVtcHQgc2VlIGlmIHRoZSBleGlzdGluZyBjb2RlIHRocmV3IHVwDQo+PiBhbnkgZXJyb3Jz
IHdoZW4gYnVpbHQgd2l0aCBjbGFuZydzIHVuZGVmaW5lZCBzYW5pdGl6ZXIuIEkgdGhpbmsgdGhp
cyBpcw0KPj4gYmVjYXVzZSB4UHRyLT5leHAgd2lsbCBvbmx5IGdldCByZWFkIGlmIG5vbmUgb2Yg
dGhlIHhQdHItPmlzRk9PIHJldHVybnMNCj4+IGZhbHNlLiBJbiBhbGwgdGhvc2UgY2FzZXMgeFB0
ci0+ZXhwIGlzIHNldC4NCj4+DQo+PiBXaGF0IHBvaW50ZWQgeW91IHRvd2FyZHMgdGhpcyBtaXNz
aW5nIGluaXRpYWxpc2F0aW9ucz8NCj4+DQo+IA0KPiBJIGFtIHNvcnJ5IGFib3V0IG1pc3Npbmcg
dGhlIG1lc3NhZ2UuIEl0IGFwcGVhcmVkIGluIG90aGVyIGVtYWlsIHRocmVhZA0KPiB3aGVyZSBJ
IGRpZG4ndCBleHBlY3QuIFNvLCBJIG1pc3NlZCB0aGUgcmVzcG9uc2UuDQo+IFdoZW4gSSByYW4g
dGhlIGZwLXRlc3RzIHVuZGVyIHRoZSBWYWxncmluZCwgSSBnb3QgbG90cyBvZiByZXBvcnRzIGFi
b3V0DQo+IHVzaW5nIHVuaW5pdGlhbGl6ZWQgbWVtb3J5LiBUaGV5IGFsbCBkaXNhcHBlYXJlZCBh
ZnRlciBhcHBseWluZyB0aGlzDQo+IHBhdGNoLiBJIGNvbmNsdWRlZCB0aGF0IHRoZXJlIGFyZSBw
YXRocyB0aGF0IHVzZSB4UHRyLT5leHAgdW5pbml0aWFsaXplZC4NCj4gDQo+ICQgL3Vzci9iaW4v
dmFsZ3JpbmQgLS1sZWFrLWNoZWNrPW5vIC0tdHJhY2UtY2hpbGRyZW49eWVzDQo+IC0ta2VlcC1z
dGFja3RyYWNlcz1hbGxvYy1hbmQtZnJlZSAtLXRyYWNrLW9yaWdpbnM9eWVzDQo+IC0tbG9nLWZp
bGU9bXlxZW11LSVwLmxvZyBtYWtlIGNoZWNrLXNvZnRmbG9hdA0KPiANCj4gPT03MjAyNjg9PSBD
b25kaXRpb25hbCBqdW1wIG9yIG1vdmUgZGVwZW5kcyBvbiB1bmluaXRpYWxpc2VkIHZhbHVlKHMp
DQo+ID09NzIwMjY4PT0gICAgYXQgMHgxMTJDNzI6IGZsb2F0WFJvdW5kVG9JbnQgKHNsb3dmbG9h
dC5jOjEzNzEpDQo+ID09NzIwMjY4PT0gICAgYnkgMHgxMTU5MjA6IHNsb3dfZjE2X3JvdW5kVG9J
bnQgKHNsb3dmbG9hdC5jOjI0MDgpDQo+ID09NzIwMjY4PT0gICAgYnkgMHgxMzNBODc6IHRlc3Rf
YXpfZjE2X3J4ICh0ZXN0X2F6X2YxNl9yeC5jOjczKQ0KPiA9PTcyMDI2OD09ICAgIGJ5IDB4MTBF
NjM1OiBkb190ZXN0ZmxvYXQgKGZwLXRlc3QuYzozMDQpDQo+ID09NzIwMjY4PT0gICAgYnkgMHgx
MEZEMDI6IHJ1bl90ZXN0IChmcC10ZXN0LmM6MTAwMykNCj4gPT03MjAyNjg9PSAgICBieSAweDEw
RkRBNDogbWFpbiAoZnAtdGVzdC5jOjEwMTcpDQo+ID09NzIwMjY4PT0gIFVuaW5pdGlhbGlzZWQg
dmFsdWUgd2FzIGNyZWF0ZWQgYnkgYSBzdGFjayBhbGxvY2F0aW9uDQo+ID09NzIwMjY4PT0gICAg
YXQgMHgxMTU4RDM6IHNsb3dfZjE2X3JvdW5kVG9JbnQgKHNsb3dmbG9hdC5jOjI0MDQpDQo+IA0K
PiA9PTcyMDMxMT09IENvbmRpdGlvbmFsIGp1bXAgb3IgbW92ZSBkZXBlbmRzIG9uIHVuaW5pdGlh
bGlzZWQgdmFsdWUocykNCj4gPT03MjAzMTE9PSAgICBhdCAweDExMkU1NDogZmxvYXRYQWRkIChz
bG93ZmxvYXQuYzoxNDExKQ0KPiA9PTcyMDMxMT09ICAgIGJ5IDB4MTE1QTJEOiBzbG93X2YxNl9z
dWIgKHNsb3dmbG9hdC5jOjI0MzEpDQo+ID09NzIwMzExPT0gICAgYnkgMHgxMzNDRUM6IHRlc3Rf
YWJ6X2YxNiAodGVzdF9hYnpfZjE2LmM6NzApDQo+ID09NzIwMzExPT0gICAgYnkgMHgxMEU2RDU6
IGRvX3Rlc3RmbG9hdCAoZnAtdGVzdC5jOjMyNikNCj4gPT03MjAzMTE9PSAgICBieSAweDEwRkQw
MjogcnVuX3Rlc3QgKGZwLXRlc3QuYzoxMDAzKQ0KPiA9PTcyMDMxMT09ICAgIGJ5IDB4MTBGREE0
OiBtYWluIChmcC10ZXN0LmM6MTAxNykNCj4gPT03MjAzMTE9PSAgVW5pbml0aWFsaXNlZCB2YWx1
ZSB3YXMgY3JlYXRlZCBieSBhIHN0YWNrIGFsbG9jYXRpb24NCj4gPT03MjAzMTE9PSAgICBhdCAw
eDExNTlDMDogc2xvd19mMTZfc3ViIChzbG93ZmxvYXQuYzoyNDI1KQ0KPiANCj4gPT03MjAyNzM9
PSBDb25kaXRpb25hbCBqdW1wIG9yIG1vdmUgZGVwZW5kcyBvbiB1bmluaXRpYWxpc2VkIHZhbHVl
KHMpDQo+ID09NzIwMjczPT0gICAgYXQgMHgxMTNENTQ6IGZsb2F0WEVxIChzbG93ZmxvYXQuYzox
NjYxKQ0KPiA9PTcyMDI3Mz09ICAgIGJ5IDB4MTE1RUFEOiBzbG93X2YxNl9lcV9zaWduYWxpbmcg
KHNsb3dmbG9hdC5jOjI1MzgpDQo+ID09NzIwMjczPT0gICAgYnkgMHgxMzQxRDM6IHRlc3RfYWJf
ZjE2X3pfYm9vbCAodGVzdF9hYl9mMTZfel9ib29sLmM6NzEpDQo+ID09NzIwMjczPT0gICAgYnkg
MHgxMEU3REU6IGRvX3Rlc3RmbG9hdCAoZnAtdGVzdC5jOjM1OCkNCj4gPT03MjAyNzM9PSAgICBi
eSAweDEwRkQwMjogcnVuX3Rlc3QgKGZwLXRlc3QuYzoxMDAzKQ0KPiA9PTcyMDI3Mz09ICAgIGJ5
IDB4MTBGREE0OiBtYWluIChmcC10ZXN0LmM6MTAxNykNCj4gPT03MjAyNzM9PSAgVW5pbml0aWFs
aXNlZCB2YWx1ZSB3YXMgY3JlYXRlZCBieSBhIHN0YWNrIGFsbG9jYXRpb24NCj4gPT03MjAyNzM9
PSAgICBhdCAweDExNUUzODogc2xvd19mMTZfZXFfc2lnbmFsaW5nIChzbG93ZmxvYXQuYzoyNTMw
KQ0KPiANCj4gRXZlbiBpZiBWYWxncmluZCBpcyB3cm9uZywgdGhlIHB1cnBvc2Ugb2YgdGhlIHBh
dGNoIGlzIHRvIHJlZHVjZSB0aGUNCj4gbnVtYmVyIG9mIGVycm9yIHJlcG9ydHMgZnJvbSB0aGUg
VmFsZ3JpbmQgdG8gbG9jYXRlIG90aGVyIG1lbW9yeSBzZXJpb3VzDQo+IGlzc3VlcywgaWYgYW55
Lg0KPiANCj4gQW5kcmV5DQo+IA0KPj4+DQo+Pj4gT24gMzAvMDcvMjAxOSAxMzoxMywgQW5kcmV5
IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pj4+IE5vdCBhbGwgdGhlIHBhdGhzIGluIHRoZSBmdW5jdGlv
bnMsIHN1Y2ggYXMgZjE2VG9GbG9hdFgoKSwgaW5pdGlhbGl6ZQ0KPj4+PiB0aGUgbWVtYmVyICdl
eHAnIG9mIHRoZSBzdHJ1Y3R1cmUgZmxvYXRYLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBB
bmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+ICAgICBzb3VyY2Uvc2xvd2Zsb2F0LmMgfCA0ICsrKysNCj4+Pj4gICAgIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL3Rlc3Rz
L2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zL3NvdXJjZS9zbG93ZmxvYXQuYyBiL3Rlc3RzL2ZwL2Jl
cmtlbGV5LXRlc3RmbG9hdC0zL3NvdXJjZS9zbG93ZmxvYXQuYw0KPj4+PiBpbmRleCA0ZTg0NjU2
Li42ZTBmMGE2IDEwMDY0NA0KPj4+PiAtLS0gYS90ZXN0cy9mcC9iZXJrZWxleS10ZXN0ZmxvYXQt
My9zb3VyY2Uvc2xvd2Zsb2F0LmMNCj4+Pj4gKysrIGIvdGVzdHMvZnAvYmVya2VsZXktdGVzdGZs
b2F0LTMvc291cmNlL3Nsb3dmbG9hdC5jDQo+Pj4+IEBAIC02MjMsNiArNjIzLDcgQEAgc3RhdGlj
IHZvaWQgZjE2VG9GbG9hdFgoIGZsb2F0MTZfdCBhLCBzdHJ1Y3QgZmxvYXRYICp4UHRyICkNCj4+
Pj4gICAgICAgICB4UHRyLT5pc0luZiA9IGZhbHNlOw0KPj4+PiAgICAgICAgIHhQdHItPmlzWmVy
byA9IGZhbHNlOw0KPj4+PiAgICAgICAgIHhQdHItPnNpZ24gPSAoKHVpQSAmIDB4ODAwMCkgIT0g
MCk7DQo+Pj4+ICsgICAgeFB0ci0+ZXhwID0gMDsNCj4+Pj4gICAgICAgICBleHAgPSB1aUE+PjEw
ICYgMHgxRjsNCj4+Pj4gICAgICAgICBzaWc2NCA9IHVpQSAmIDB4MDNGRjsNCj4+Pj4gICAgICAg
ICBzaWc2NCA8PD0gNDU7DQo+Pj4+IEBAIC03NTksNiArNzYwLDcgQEAgc3RhdGljIHZvaWQgZjMy
VG9GbG9hdFgoIGZsb2F0MzJfdCBhLCBzdHJ1Y3QgZmxvYXRYICp4UHRyICkNCj4+Pj4gICAgICAg
ICB4UHRyLT5pc0luZiA9IGZhbHNlOw0KPj4+PiAgICAgICAgIHhQdHItPmlzWmVybyA9IGZhbHNl
Ow0KPj4+PiAgICAgICAgIHhQdHItPnNpZ24gPSAoKHVpQSAmIDB4ODAwMDAwMDApICE9IDApOw0K
Pj4+PiArICAgIHhQdHItPmV4cCA9IDA7DQo+Pj4+ICAgICAgICAgZXhwID0gdWlBPj4yMyAmIDB4
RkY7DQo+Pj4+ICAgICAgICAgc2lnNjQgPSB1aUEgJiAweDAwN0ZGRkZGOw0KPj4+PiAgICAgICAg
IHNpZzY0IDw8PSAzMjsNCj4+Pj4gQEAgLTg5NSw2ICs4OTcsNyBAQCBzdGF0aWMgdm9pZCBmNjRU
b0Zsb2F0WCggZmxvYXQ2NF90IGEsIHN0cnVjdCBmbG9hdFggKnhQdHIgKQ0KPj4+PiAgICAgICAg
IHhQdHItPmlzSW5mID0gZmFsc2U7DQo+Pj4+ICAgICAgICAgeFB0ci0+aXNaZXJvID0gZmFsc2U7
DQo+Pj4+ICAgICAgICAgeFB0ci0+c2lnbiA9ICgodWlBICYgVUlOVDY0X0MoIDB4ODAwMDAwMDAw
MDAwMDAwMCApKSAhPSAwKTsNCj4+Pj4gKyAgICB4UHRyLT5leHAgPSAwOw0KPj4+PiAgICAgICAg
IGV4cCA9IHVpQT4+NTIgJiAweDdGRjsNCj4+Pj4gICAgICAgICBzaWc2NCA9IHVpQSAmIFVJTlQ2
NF9DKCAweDAwMEZGRkZGRkZGRkZGRkYgKTsNCj4+Pj4gICAgICAgICBpZiAoIGV4cCA9PSAweDdG
RiApIHsNCj4+Pj4gQEAgLTEyMjAsNiArMTIyMyw3IEBAIHN0YXRpYyB2b2lkIGYxMjhNVG9GbG9h
dFgoIGNvbnN0IGZsb2F0MTI4X3QgKmFQdHIsIHN0cnVjdCBmbG9hdFggKnhQdHIgKQ0KPj4+PiAg
ICAgICAgIHhQdHItPmlzWmVybyA9IGZhbHNlOw0KPj4+PiAgICAgICAgIHVpQTY0ID0gdWlBUHRy
LT52NjQ7DQo+Pj4+ICAgICAgICAgeFB0ci0+c2lnbiA9ICgodWlBNjQgJiBVSU5UNjRfQyggMHg4
MDAwMDAwMDAwMDAwMDAwICkpICE9IDApOw0KPj4+PiArICAgIHhQdHItPmV4cCA9IDA7DQo+Pj4+
ICAgICAgICAgZXhwID0gdWlBNjQ+PjQ4ICYgMHg3RkZGOw0KPj4+PiAgICAgICAgIHNpZy52NjQg
PSB1aUE2NCAmIFVJTlQ2NF9DKCAweDAwMDBGRkZGRkZGRkZGRkYgKTsNCj4+Pj4gICAgICAgICBz
aWcudjAgID0gdWlBUHRyLT52MDsNCj4+Pj4NCj4+DQo+Pg0KPj4gLS0NCj4+IEFsZXggQmVubsOp
ZQ0KPj4NCj4gDQoNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZp
Y2gNCg0K

