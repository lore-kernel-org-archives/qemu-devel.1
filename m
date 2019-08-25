Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC3C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 13:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7B12082F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 13:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VvRODWqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7B12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1sCs-0000Ht-Nb
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 09:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i1sBr-0008EP-Fc
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 09:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i1sBp-0004AT-Jb
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 09:04:15 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com
 ([40.107.8.114]:16061 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i1sBZ-00043h-AV; Sun, 25 Aug 2019 09:03:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHPWYErEgG/5FGEp9BEGtnXGbqltBoPqWhjwTuTfm0SKtR8hV+b4N2y+Whns4bX4Jnn1K3+TujfDGU9OgFOEjTUHXdiY1cJ8Aa1N3Jpmyjx+GS6DSlLICgP9fdlux09k1ntjs0rA98wEiDotgGT2qddJa6iuZjEqFCLghTceX8MdcHCizIfsTf5OsEmiZxUXe0hysR0LCZOzDoYu8XVaJEshKlKYH6w0Ux0WZ015EXCTXCOBxuLW/Yda0Ckw6OBEoeeTT2jgmCZ3zT0xCGxS8+cnAeYuwEkTXc0xeZVWfZI1EXaB96OYmL3DtQqVNiCnQAhgG867SRu8hsMf8agW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is6BouFFWmG8H6BUrEBmV0qpqO2rAK6QH1UoBibETTM=;
 b=Dxg974WNF3zuVVLhmlEXz/PmWfiuhwZ9xbqUaEXNQlxsTP68s4CeDP1zBenyJFi9IWP+BSzJ0ed9gYw93rapkKcQFUbHtVD9tWrlJmbz9eUnxcxFMyaK10WtFEdy24Um96UzJLQr8zwUAI+yz5xptA2LxB2XDLN2VpiVPKSn8mrNY33xmrmJQN8fX57dFLmvm+m02AKKNctYxE3uS2npWTT3CTzasoKlJdFj/sO9+Bf/r3KNxWuP4sNgSh94M7iEaQQ5XVdXGdYBQ81mP12IaVfDSlWBobw6UfK1Ey1bm+6V6t9zFYZLCYRH3HEZR77jCg4QEZBp/vKRRBawNW7+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is6BouFFWmG8H6BUrEBmV0qpqO2rAK6QH1UoBibETTM=;
 b=VvRODWqTghTOsbX9ntNRYpdEFvs4hnpmCa5BgWZpceIVe0j+wGNLRu9Tvqec+RKXS7xmCBMuCqRiK17L1jYmOHG0AIYKPzetrfPBImaTN9nj/EsyVUfHyci5T7vNjPMmvQme8X4gyzjhpDSOjJ82wMubTUuUtKNn2gcASHpPBDI=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4480.eurprd08.prod.outlook.com (20.179.27.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Sun, 25 Aug 2019 13:03:51 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Sun, 25 Aug 2019
 13:03:51 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Thread-Topic: [Qemu-block] [PATCH v5 3/6] iotests: Add casenotrun report to
 bash tests
Thread-Index: AQHVPk9LrLE+1b9ER0+E5PuuM6rSoKb9GtGAgAFMRgCADadbAA==
Date: Sun, 25 Aug 2019 13:03:50 +0000
Message-ID: <feedfc15-f719-d983-ae2c-419e50851e4d@virtuozzo.com>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563553816-148827-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <b7d55527-2a1a-c171-3a46-7723696d4aba@redhat.com>
 <20190816203326.GB20950@localhost.localdomain>
In-Reply-To: <20190816203326.GB20950@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0091.eurprd02.prod.outlook.com
 (2603:10a6:7:29::20) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22f48b07-4c8f-4646-6865-08d7295cacb1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4480; 
x-ms-traffictypediagnostic: VI1PR08MB4480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB4480F39A88D95F379032EDAEF4A60@VI1PR08MB4480.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(366004)(346002)(376002)(136003)(199004)(189003)(52116002)(26005)(305945005)(6246003)(256004)(66066001)(386003)(6506007)(76176011)(107886003)(53546011)(6436002)(81166006)(6486002)(53936002)(99286004)(6512007)(2906002)(110136005)(54906003)(31686004)(478600001)(2616005)(71190400001)(71200400001)(81156014)(86362001)(14454004)(316002)(31696002)(36756003)(446003)(6116002)(3846002)(8676002)(7736002)(8936002)(4326008)(66946007)(229853002)(186003)(66476007)(66556008)(44832011)(25786009)(486006)(64756008)(66446008)(476003)(102836004)(5660300002)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4480;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nUMx0xYMlhUxo4xg/i0fCFtASdbNiJKTfWSe8crL6qOFv7w43+UCxzR/blRMUlm3RpzIJvH1QnhhQpnX150StYJvosNk9e/1S3C9ey/CHhPigovwjU1O43oX9clwhIG6DxbW2E7CasC7mlxFYToilqSQIwREwIxMl0xk8tlc1o/6vsfhLFO5KcgP37bnT+4TXJA6bHghgRVJVD3XCXLwdEhIW6HOoiiaT22whj3bzzWUybdBoqn5Yq/9OLgDtCEhNmBsAlLUUddKNATpb8Z3KjI4Eo+banWjN87cPtEXl1gun+vD0uerxaBBun8norHcTn7cF3CAcCZU21oZdIK3HLSx5PqOXwU+OrjugC1+kOn+gCwT6TwOByp5XM2qgEDV/XVwaveFkPpI9Zjx3lU+qVAT21CAPFYzHnWwLHAipq0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B97E7CECB057A4DA353B0C1F9114E09@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f48b07-4c8f-4646-6865-08d7295cacb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 13:03:50.9491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAN/ZYhnvia1l44kfM+dx3v/p+45wUKQe4X/kc0IAnhreYWr7N1AsG50INgciJahO/4xlDhmgR6/SWd1Sm5iY2pZlQ7NcYMPJBDGHcpattk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.114
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 3/6] iotests: Add
 casenotrun report to bash tests
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE2LzA4LzIwMTkgMjM6MzMsIENsZWJlciBSb3NhIHdyb3RlOg0KPiBPbiBUaHUsIEF1
ZyAxNSwgMjAxOSBhdCAwODo0NDoxMVBNIC0wNDAwLCBKb2huIFNub3cgd3JvdGU6DQo+Pg0KPj4N
Cj4+IE9uIDcvMTkvMTkgMTI6MzAgUE0sIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4+IFRo
ZSBuZXcgZnVuY3Rpb24gX2Nhc2Vub3RydW4oKSBpcyB0byBiZSBpbnZva2VkIGlmIGEgdGVzdCBj
YXNlIGNhbm5vdA0KPj4+IGJlIHJ1biBmb3Igc29tZSByZWFzb24uIFRoZSB1c2VyIHdpbGwgYmUg
bm90aWZpZWQgYnkgYSBtZXNzYWdlIHBhc3NlZA0KPj4+IHRvIHRoZSBmdW5jdGlvbi4NCj4+Pg0K
Pj4NCj4+IE9oLCBJIGFzc3VtZSB0aGlzIGlzIGEgc3ViLXRlc3QgZ3JhbnVsYXJpdHk7IGlmIHdl
IG5lZWQgdG8gc2tpcA0KPj4gaW5kaXZpZHVhbCBpdGVtcy4NCj4+DQo+PiBJJ20gZ29vZCB3aXRo
IHRoaXMsIGJ1dCB3ZSBzaG91bGQgQ0MgQ2xlYmVyIFJvc2EsIHdobyBoYXMgc3RydWdnbGVkDQo+
PiBhZ2FpbnN0IHRoaXMgaW4gdGhlIHBhc3QsIHRvby4NCj4+DQo+IA0KPiBUaGUgZGlzY3Vzc2lv
biBJIHdhcyBpbnZvbHZlZCBpbiB3YXMgbm90IHRoYXQgbXVjaCBhYm91dCBza2lwcGluZw0KPiB0
ZXN0cyBwZXIgc2UsIGJ1dCBhYm91dCBob3cgdG8gZGV0ZXJtaW5lIGlmIGEgdGVzdCBzaG91bGQg
YmUgc2tpcHBlZA0KPiBvciBub3QuICBBdCB0aGF0IHRpbWUsIHdlIHByb3Bvc2VkIGFuIGludGVn
cmF0aW9uIHdpdGggdGhlIGJ1aWxkDQo+IHN5c3RlbSwgYnV0IHRoZSBkb3duc2lkZSAoYW5kIHRo
ZSByZWFzb24gZm9yIG5vdCBwdXNoaW5nIGl0IGZvcndhcmQpDQo+IHdhcyB0aGUgcmVxdWlyZW1l
bnQgdG8gcnVuIHRoZSBpb3Rlc3Qgb3V0c2lkZSBvZiBhIGJ1aWxkIHRyZWUuDQo+IA0KPj4+IFN1
Z2dlc3RlZC1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT4NCj4+PiBTaWduZWQtb2Zm
LWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4N
Cj4+PiAtLS0NCj4+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9jb21tb24ucmMgfCA3ICsrKysrKysN
Cj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1n
aXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9uLnJjIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2Nv
bW1vbi5yYw0KPj4+IGluZGV4IDZlNDYxYTEuLjEwODkwNTAgMTAwNjQ0DQo+Pj4gLS0tIGEvdGVz
dHMvcWVtdS1pb3Rlc3RzL2NvbW1vbi5yYw0KPj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9j
b21tb24ucmMNCj4+PiBAQCAtNDI4LDYgKzQyOCwxMyBAQCBfbm90cnVuKCkNCj4+PiAgICAgICBl
eGl0DQo+Pj4gICB9DQo+Pj4gICANCj4+PiArIyBiYWlsIG91dCwgc2V0dGluZyB1cCAuY2FzZW5v
dHJ1biBmaWxlDQo+Pj4gKyMNCj4+PiArX2Nhc2Vub3RydW4oKQ0KPj4+ICt7DQo+Pj4gKyAgICBl
Y2hvICIgICAgW2Nhc2Ugbm90IHJ1bl0gJCoiID4+IiRPVVRQVVRfRElSLyRzZXEuY2FzZW5vdHJ1
biINCj4+PiArfQ0KPj4+ICsNCj4+PiAgICMganVzdCBwbGFpbiBiYWlsIG91dA0KPj4+ICAgIw0K
Pj4+ICAgX2ZhaWwoKQ0KPj4+DQo+Pg0KPj4gc2VlbXMgZmluZSB0byBtZSBvdGhlcndpc2UuDQo+
Pg0KPj4gUmV2aWV3ZWQtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gDQo+IFll
YWgsIHRoaXMgYWxzbyBMR1RNLg0KPiANCj4gUmV2aWV3ZWQtYnk6IENsZWJlciBSb3NhIDxjcm9z
YUByZWRoYXQuY29tPg0KPiANCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciByZXZpZXdz
LiBQbGVhc2Ugbm90ZSB0aGF0IHRoZSBmdW5jdGlvbiANCl9jYXNlbm90cnVuKCkgd29ya3MgYXMg
YSBub3RpZmllciBvbmx5IGFzIGl0IHdhcyBkb25lIGZvciB0aGUgUHl0aG9uIA0KYmFzZWQgaW90
ZXN0cy4gSXQgaXMgYSBjYWxsZXIgcmVzcG9uc2liaWxpdHkgdG8gc2tpcCBydW5uaW5nIGEgDQpw
YXJ0aWN1bGFyIHRlc3Qgd2l0aCBhbGwgcmVsZXZhbnQgbG9naWMuIEkgd2lsbCBzdXBwbHkgdGhl
IGNvbW1lbnQgaW4gdjYgDQphbmQgd2lsbCBrZWVwIHlvdXIgJ1Jldmlld2VkLWJ5JyBpZiB0aGVy
ZSBhcmUgbm8gb2JqZWN0aW9ucyApKQ0KDQpBbmRyZXkNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdh
cmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

