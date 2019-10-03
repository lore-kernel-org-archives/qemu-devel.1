Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E87C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A049920659
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AOmctaB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A049920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG2l2-0002bk-N9
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2ih-0000TP-SB
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG2ig-0002Td-6E
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:08:43 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:65091 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG2if-0002Rx-VL; Thu, 03 Oct 2019 11:08:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aabxlhy0qyffAvuo4G+pgJXFUA62REZEIHpPsembMFK06p4f/jmsM5tHkArYbL/bQ7l5m+8zkVAu053YUjDojqFZ9P17ra1FzGSidfq1PmApfacKU6134ImOFBjqB67ouWXa+3h/4MDstIdwELfhwSx/FMBkZmYDrU25tyM7PoizHgfrHi2bqc7f10TfOMzhKQjS6aT57u508rqasnL2Ed1HoPbBHAmllbVcCjm+kluDDuIARp9+AYh4SZ4pRB9pFwn/XAWUxsacg1pqU5i1a4ATpcUOiyEO+DxN0PfQAQmv6EgLstjtJpjbpebe/DzpRovgzkeMyQ5oXubFKqTz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5bEVnSx+j/fsJXX17MAbnrN1FHka2dkdh3lGaCXGts=;
 b=oOlr82v+njsL8sjgV0sbGg7zzG38HH3L2QTDQQ/xi5IT8O0N+D2FxiIECAjtX83Jwau30nYOh8+eoaaPQepfpMGZ5S1YNiWCf0oqgqnfD9tm073FofxsRrVYmrdVTWEUpVYwZ3atOZllMy4Aw1ORj5auI+o6U1sW9z8vl72abvSkCW/FVC1ObbBGO2QiybPqbgpOjezYpXRfVAtY7IjN38dR4I+8PtHMsCAcRKAfemzN4KleWXP8Bf257tzAjvMP09gj5xmF5smw1Vy44h0OcCfFwsAfdJ7ldtLizixmGa8veD85JY0HeD9vUEj9M66m0wgmFljS059F0J3LA4eFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5bEVnSx+j/fsJXX17MAbnrN1FHka2dkdh3lGaCXGts=;
 b=AOmctaB16VHMIZ79ad3yUcC4O73jWylpaPyd2B0VfeDyNtbJsJHgsMAOfFjRZMKVUMwBVqpKgKUQwlodmswrtTOhDf7xz00/rQWnsdU8WAVvk1rwn1SZs0uA/Ss1nTnQugzWtJdGj4gwR9D6yMNru7pYY+IvtkuJbzaU78uNTRg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5530.eurprd08.prod.outlook.com (52.133.243.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 3 Oct 2019 15:08:38 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 15:08:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 01/67] iotests.py: Read $IMGOPTS
Thread-Topic: [PATCH 01/67] iotests.py: Read $IMGOPTS
Thread-Index: AQHVeJG1z28GWtBMO0uFaVhyXaBVUadJB7eA
Date: Thu, 3 Oct 2019 15:08:37 +0000
Message-ID: <a7937252-edd6-00fe-1baa-2c0f83aec37e@virtuozzo.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
 <20191001194715.2796-2-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-2-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0094.eurprd02.prod.outlook.com
 (2603:10a6:7:29::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003180835261
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20f6aa23-50f5-41d9-34d5-08d74813914f
x-ms-traffictypediagnostic: DB8PR08MB5530:
x-microsoft-antispam-prvs: <DB8PR08MB5530A60B1F7308D5718974ACC19F0@DB8PR08MB5530.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39840400004)(199004)(189003)(110136005)(66066001)(4326008)(316002)(25786009)(478600001)(14454004)(54906003)(229853002)(76176011)(66946007)(2501003)(8936002)(86362001)(81156014)(8676002)(81166006)(6486002)(52116002)(99286004)(36756003)(486006)(71200400001)(386003)(6506007)(71190400001)(3846002)(6116002)(31686004)(476003)(2616005)(66446008)(66556008)(64756008)(7736002)(2906002)(102836004)(11346002)(446003)(5660300002)(26005)(186003)(66476007)(6246003)(6436002)(6512007)(256004)(305945005)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5530;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZvEq20XsKvwxDoRDZ4ttfZyTE902e9MD4pIUVffnm/IVDuuejFpROjuuaUHs/EuOBmMUWUDi8Mj5w4DClX2czQGzphfJsfHlVW+4v3HqnxONiqQJEWpdVOrS3EaaEJ4wU2eh/d2FK1gTfkpr96/u2mZf9uM96yZCmLm89kcrSMBRVvjtpARJTP4G687lccDQMvprjMMVhLW9w+D6b31aj8q1lFucLZ6mexdEHpne1CILQ20Bq04rhORogIN3OIZJU7xYdyl1iu7oI689UPkEHefWhjJ4GDR3If7Mv7EoFt1LnYrTzRarS/kfNIz2WKLc2E695sSsFDjy6XR4QvmVj2KglEKmwBlL2blqvHlwdDCXjIur+VdCaDl7UHq/hP0Tt14/qX6nXjxcrDJ4ZcPh764EYBam6aozkxw8Cyy3T4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A540FDBB6CD5334B879D2B3267DE72D7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f6aa23-50f5-41d9-34d5-08d74813914f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 15:08:37.9002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msL6lo/JkQgx56xW+fYtU1SlF1lQNIHfuDsD+Sq8Zkut0VgGrfx7i0N11p6uXOxajmwaPrLPgra4WUi0GDnqptd4PmOXrxawew9V5Gfqk7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5530
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.91
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAyMjo0NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBXZSBkbyBub3QgZG8gYW55dGhp
bmcgd2l0aCB5ZXQsIGJ1dCB0aGlzIGlzIHRoZSBmaXJzdCBzdGVwLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvcWVt
dS1pb3Rlc3RzL2lvdGVzdHMucHkgfCA2ICsrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0
cy5weSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+IGluZGV4IDFjNWZjZTNlOWUu
LjcwMzA5MDA4MDcgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5
DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+IEBAIC02OSw2ICs2OSwx
MiBAQCBvdXRwdXRfZGlyID0gb3MuZW52aXJvbi5nZXQoJ09VVFBVVF9ESVInLCAnLicpDQo+ICAg
Y2FjaGVtb2RlID0gb3MuZW52aXJvbi5nZXQoJ0NBQ0hFTU9ERScpDQo+ICAgcWVtdV9kZWZhdWx0
X21hY2hpbmUgPSBvcy5lbnZpcm9uLmdldCgnUUVNVV9ERUZBVUxUX01BQ0hJTkUnKQ0KPiAgIA0K
PiAraW1nb3B0cyA9IG9zLmVudmlyb24uZ2V0KCdJTUdPUFRTJywgJycpDQo+ICtpZiBsZW4oaW1n
b3B0cykgPT0gMDoNCj4gKyAgICBpbWdvcHRzID0gW10NCj4gK2Vsc2U6DQo+ICsgICAgaW1nb3B0
cyA9IGltZ29wdHMuc3BsaXQoJywnKQ0KPiArDQo+ICAgc29ja2V0X3NjbV9oZWxwZXIgPSBvcy5l
bnZpcm9uLmdldCgnU09DS0VUX1NDTV9IRUxQRVInLCAnc29ja2V0X3NjbV9oZWxwZXInKQ0KPiAg
IA0KPiAgIGx1a3NfZGVmYXVsdF9zZWNyZXRfb2JqZWN0ID0gJ3NlY3JldCxpZD1rZXlzZWMwLGRh
dGE9JyArIFwNCj4gDQoNCk5vdGUsIHRoYXQgZW1wdHkgc2VxdWVuY2VzIGFyZSBhbHdheXMgZmFs
c2UsIHNvIHlvdSBtYXkgdXNlIGp1c3QgImlmIG5vdCBpbWdvcHRzIg0KDQpSZXZpZXdlZC1ieTog
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

