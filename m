Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3873BC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D40205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AiEMpeVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D40205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCNem-0000Au-Ea
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iCNbt-00063v-8Z
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iCNbr-0003Ga-V9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:38:32 -0400
Received: from mail-eopbgr40128.outbound.protection.outlook.com
 ([40.107.4.128]:55209 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1iCNbr-0003Fk-8S; Mon, 23 Sep 2019 08:38:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKz+MT10T3Y9YpA043QeFbGLNQ8lHtW5Gh3VS0DaEpwpLy9tdIax+RZHjWGWNg4m/oXX1UVvX2bbw+ibKbfQ7LXt+t/8Om6heHmdqbaKv5pvDPYj7wSuuMkmP7c8xBb8kXNBQYur9UYD+JtmCKd/msGtv7xaQGu7pQsnP04jt211BAyhX4Tr2RerxNt0SKLf0unSJeyIgdhqMY6pwlikUlE6ZnjAw+qSaT4bY/k7NjfXDyyeovfCj/ASu+wz3bPLSjw86eHpxbs17KRe71GHSavw5ismUvtMEB8o1HdaKFp4qZTZsCUpaywIKgx4FuzoJtR4O/EMRyv8AuecCvQkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS1jYCOcqazczm6LVE88WwqfprgajG4fsbmFBL9SEag=;
 b=YT20lA7aZSGSsXKtXN6PvaXJ3JVRDTnNJOYPpW5DTm2uytHr90mIbqmohakfF9JkOGOHEOdqlYdC66L9hbyCYO+BRixSo0OtaPm1Rh75Poc+P8WnjB1tN+vEPWQUswVM48Vs1XsR7YMYCAT9nfkFzvyyYmaIZkvplvQEjqTTX0itfpyKCNsU+Qd0o9y7vrN+0ljxJ9z0Ym0hYyK1me2ZdxMFsQtJyGH/877j2n/mWzX5pFnjm8ZYlEx4cmSyoCcnT8y9xvUDTJwsTm8f6dkxyV5Sv4qcizZcy3UHEx26699MSjC7Bo2XCVfNTJyMJby7QqmfsFaMxJGoAeV3unBtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS1jYCOcqazczm6LVE88WwqfprgajG4fsbmFBL9SEag=;
 b=AiEMpeVP32s5GuOHQFFOjqV7k+12XBSeoKbbySrtVyVjqWiv/hAZ63wh2ilDUkdRrtTJSEBVigLo+Qk7fQ2EzS4h3uAej5zNbP+RaSZ3TFNPCjkuK9lX2syARzQ1Tbk3qw3Ar+aJeqWvwfpPvGthBrI8t3UO4+DYW1loga22BTc=
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) by
 AM6PR08MB4439.eurprd08.prod.outlook.com (20.179.7.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Mon, 23 Sep 2019 12:38:28 +0000
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::243c:9ff6:e242:c550]) by AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::243c:9ff6:e242:c550%6]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 12:38:28 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v9 0/9] discard blockstats
Thread-Topic: [PATCH v9 0/9] discard blockstats
Thread-Index: AQHVZMxfg+HPfSnN606DpCBwMZ/jBac5MjYAgAAbxoA=
Date: Mon, 23 Sep 2019 12:38:27 +0000
Message-ID: <6a7cdf2a-06f1-f4fe-56b7-ef19caec83ba@virtuozzo.com>
References: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>
 <13885e81-16ae-f2f3-488c-b55fb76aaf4c@redhat.com>
In-Reply-To: <13885e81-16ae-f2f3-488c-b55fb76aaf4c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0285.eurprd05.prod.outlook.com
 (2603:10a6:7:93::16) To AM6PR08MB5208.eurprd08.prod.outlook.com
 (2603:10a6:20b:eb::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c62ec845-259c-4f76-a1dc-08d74022ee7b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM6PR08MB4439; 
x-ms-traffictypediagnostic: AM6PR08MB4439:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB443988AEE3F66684D991CCE3F8850@AM6PR08MB4439.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(366004)(39840400004)(346002)(189003)(199004)(229853002)(6436002)(81166006)(8676002)(6306002)(6486002)(81156014)(66066001)(66476007)(66556008)(64756008)(66446008)(966005)(52116002)(6512007)(4326008)(31686004)(2906002)(2501003)(53546011)(386003)(256004)(6506007)(36756003)(478600001)(76176011)(3846002)(486006)(71190400001)(44832011)(86362001)(31696002)(446003)(71200400001)(476003)(2616005)(11346002)(107886003)(6246003)(7736002)(99286004)(4744005)(25786009)(102836004)(305945005)(26005)(6116002)(5660300002)(186003)(316002)(66946007)(110136005)(54906003)(14454004)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4439;
 H:AM6PR08MB5208.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hVwFeWkcJwPaUADo3np5EuUxBqbLXkWiwCJ8cZ9jpS2M2T20W4k0TKhJ4EtPwnno2+dGY9rOdTo580w6mFbq3q2uEz888VLcjFlvnLsgFsMciVwVvznmrje5rvajFvIONUp2wUp8TV3N1SG6d0OESDpldcfEzIEuhj1pxlZaCZWdbEFEdwos+6HdUBnbnxmauPpcQYt2R0wIDCgbbA7nFE+uf9z0VqTTHoTAhhHrhJzfhxTdw3L4oV+bdE2DXg/xpXPnQAp+DJgDP3vx6ztY5xEUef41bLfCRxQ5MksEhxGXUYgfdvTayq5rA+BgMBU1Yq7RFs517rz6mJzWmUsvf6MKjW8aRe3oSk7vz1Q+N0p7ZYXNoEtX0AZUeEwNwZRlArqfwhYePJSgC5z9nmxph0Srct6yXsvF62MmbxnZTWU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9725BB46EF037469162CF5AA989E51D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62ec845-259c-4f76-a1dc-08d74022ee7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 12:38:28.1463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWH+U0ifBv39cTb45DjqpFAZYwhcB9kBO+A1H9iYC7zpda/Abgp1Ucjye3rrqg4kXOuvTK1koHlSitBGjlar9FBAWjpOBAWsXW2mL7cLC/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4439
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.128
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
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMjMvOS8yMDE5IDE6NTkgUE0sIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMDYuMDkuMTkgMTg6
MDEsIEFudG9uIE5lZmVkb3Ygd3JvdGU6DQo+PiB2OToNCj4+ICAgLSBmaXhlZCBwYXRjaCA1IHNv
IHRoZSBmaWVsZHMgYXJlIGFjdHVhbGx5IG51bWJlcmVkIGluIHNlY3RvcnMgbm90IGJsb2Nrcw0K
Pj4gICAtIGZpeGVkIHBhdGNoIDcgYWNjb3JkaW5nbHkNCj4+ICAgLSBwYXRjaCA4OiBtYWtlIHN0
YXQgZmllbGRzIHVuc2lnbmVkDQo+PiAgIC0gcWFwaSBwYXRjaGVzOiAic2luY2UgNC4xIiAtPiAi
c2luY2UgNC4yIg0KPj4NCj4+IHY4OiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1s
L3FlbXUtZGV2ZWwvMjAxOS0wNS9tc2cwMzcwOS5odG1sDQo+IA0KPiBGb3IgdGhlIHJlY29yZDog
TG9va3MgT0sgdG8gbWUsIGJ1dCBJIHN1cHBvc2UgeW91IHN0aWxsIHdhbnRlZCB0byBjaGFuZ2UN
Cj4gcGF0Y2ggM+KAmXMgY29tbWl0IG1lc3NhZ2UuDQo+IA0KPiAoSSBzdGlsbCBkb27igJl0IGxp
a2UgcGF0Y2ggOSB2ZXJ5IG11Y2gsIGJ1dCB0aGF0IHdvbuKAmXQgc3RvcCBtZSBmcm9tDQo+IHRh
a2luZyBpdC4pDQo+IA0KDQpoaSwNCkkndmUgbm93IHJlc2VudCB0aGUgc2VyaWVzIHdpdGggdGhl
IHVwZGF0ZWQgcGF0Y2ggMyBjb21taXQgbWVzc2FnZQ0KDQpodHRwczovL2xpc3RzLm5vbmdudS5v
cmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0wOS9tc2cwNTA1MC5odG1sDQoNCnRoYW5r
cywNCg==

