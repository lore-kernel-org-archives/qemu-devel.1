Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD895CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C5521D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S3TSSGGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C5521D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzAl-0005K9-Bo
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNz8X-0002Bo-RN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iNz8W-0004IA-9J
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:56:13 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:18062 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iNz8V-0004HH-Hp; Fri, 25 Oct 2019 08:56:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQe79+iTf4BcEO/eFOazTYivkLvYdXAZ16r8C3ci2mzlJgLuFAm50ZiBtJ7YMvCF1z85Vg+KJBBCPMcnxDcI7xJs2icM2vAmjZj41QN9nS4MXJ0BiLmPkY9tPqM0xwbV+4d1Y+x7xi0hAjqJIlfGfNNAGoaq4NBjvs8xdpuF/uM7D6Wij4VX0q0qyRa6eFjuZ61SrulXBdzEox46GoYqv0mgRjjmjkFy6zcG/yN+GGoVJeWryimMoSpguBrmLVlPtmsCSbjfqpXi0nmf50QnE7p81Ir4d4kkm45H+7kwd4f+vjZIlumhKJ4QiNbdCeapY5BCbm6jQu9fs088SEYIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v9P+QyPRac8d6hUeRWFmNh9GrDBQ5eJuXnFZjU6Jho=;
 b=HXL2LK/pazSbO2DIItDiTaiEcPD+SNl0X7FNrUyeDBRDzTib/eEXn0lmITYnAvDd5trp2hJRlPeMDehuq53SsR81F1uiHl5m8eYYvW34GW0bNux6FJ8HEown5BpdIICd+nK5e5/vEjlLYa4yQM5oA5gTsoON4HyHmJY31xyKgGDpbTxu1xwiGvvw6vl59qjzCTznh/dvzhiUYhdMPh8ZB2WDWWaKu8y7eOmeelA4C38CKyS9BOXDyo3PfUK5ZrQMd6QK6TbsJtfXLGWQsompx78mH4/cM3Nf3vIS2ntz2QqVTR0CaXJFQT/8fuzKKxfwI25y70IlySGQqK8Dkqa0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v9P+QyPRac8d6hUeRWFmNh9GrDBQ5eJuXnFZjU6Jho=;
 b=S3TSSGGN4zgDLE+Cnnc0PM4Q5LlrpcMg9HdmUutEGDOS3MVICvN8PDNaEZtP9XSFCCeJXpO9pVNkbamhO+H5zhteb+KgVVucDt2KBuCqepCsGqlZVHTTWBXNIDeyeHS+yMsPppvzJaQtgFlrMB5a5k52pyRNdGDSDsmcISzwWtU=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3684.eurprd08.prod.outlook.com (20.178.23.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 25 Oct 2019 12:56:07 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.029; Fri, 25 Oct 2019
 12:56:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 1/2] qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap
Thread-Topic: [PATCH v2 1/2] qcow2-bitmaps: fix
 qcow2_can_store_new_dirty_bitmap
Thread-Index: AQHVgoW50U3qZ/gL8kW7nArYG8x+Y6drYJoAgAABeoA=
Date: Fri, 25 Oct 2019 12:56:07 +0000
Message-ID: <7a88a111-8272-73fa-dc5e-a07c90a37972@virtuozzo.com>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
 <20191014115126.15360-2-vsementsov@virtuozzo.com>
 <e54561aa-d653-5df4-0379-083ddc7b9657@redhat.com>
In-Reply-To: <e54561aa-d653-5df4-0379-083ddc7b9657@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::28) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191025155605287
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 568000e5-f3a7-4396-9392-08d7594ab3b6
x-ms-traffictypediagnostic: AM0PR08MB3684:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB36846A73686453D79A754464C1650@AM0PR08MB3684.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(396003)(39850400004)(376002)(199004)(189003)(14454004)(6486002)(31696002)(11346002)(476003)(36756003)(71200400001)(71190400001)(102836004)(2616005)(6506007)(478600001)(2906002)(7736002)(305945005)(53546011)(256004)(14444005)(446003)(386003)(5660300002)(86362001)(486006)(186003)(25786009)(3846002)(6116002)(26005)(110136005)(54906003)(316002)(66556008)(64756008)(76176011)(99286004)(66946007)(52116002)(66446008)(8676002)(81156014)(4326008)(2501003)(8936002)(31686004)(81166006)(107886003)(6246003)(229853002)(66066001)(6512007)(6436002)(66476007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3684;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CnWXtiZZcLGbSGoNOfcGRB3hEX8pgSNcqmE8wEVUpRj9ccplNGR+Z9YTN0F1vrifqOUytvZJvSqaqM4uw70jESYxeQBR5kM5n4j76QcPuRt7+7pdmQGjL6hZWeisOqt4/ct2q5R6zuO0i8qy1gZ/kKl4a4yyAEo3c15UEuc8BCLbRcu7XjbngBuphtGwD3cTsrnCroMEwS4+Mu+GN60y4AFJW73M8rnIfpfDOG17sEuup8fZB3nboUmCYiiINQvLoTurgGiJ6RgALg9riH4Mse41L9+e/4FQ1DbWQTzL079LJV4ocFqfBqTXOuI347NON98bEpkm9tkoFTZypN17FL0Q7bhFWHY4Zo8FZBowdUYzSgMpiHEEFS5GLlJEZJamkGtv3C86yJF+fYfgKjFEXM/rEftA85fRtq75Q9lHzcz+bntcKrk3twyTSvHOuxhI
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E336671C4B724448602304E52C1FBEA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568000e5-f3a7-4396-9392-08d7594ab3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 12:56:07.4652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xO71UN0hlRudmV9HZL1NSnh5CY3LvhT0P7+t2CQSos943Qddu+9qU64hbxiM94OVDs1GvB8Lvdl+yhktMAEAarFImVdG1R/y32dBJItjN/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3684
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.121
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMTAuMjAxOSAxNTo1MCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4xMC4xOSAxMzo1MSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IHFjb3cyX2Nhbl9zdG9yZV9u
ZXdfZGlydHlfYml0bWFwIHdvcmtzIHdyb25nLCBhcyBpdCBjb25zaWRlcnMgb25seQ0KPj4gYml0
bWFwcyBhbHJlYWR5IHN0b3JlZCBpbiB0aGUgcWNvdzIgaW1hZ2UgYW5kIGlnbm9yZXMgcGVyc2lz
dGVudA0KPj4gQmRydkRpcnR5Qml0bWFwIG9iamVjdHMuDQo+Pg0KPj4gU28sIGxldCdzIGluc3Rl
YWQgY291bnQgcGVyc2lzdGVudCBCZHJ2RGlydHlCaXRtYXBzLiBXZSBsb2FkIGFsbCBxY293Mg0K
Pj4gYml0bWFwcyBvbiBvcGVuLCBzbyB0aGVyZSBzaG91bGQgbm90IGJlIGFueSBiaXRtYXAgaW4g
dGhlIGltYWdlIGZvcg0KPj4gd2hpY2ggd2UgZG9uJ3QgaGF2ZSBCZHJ2RGlydHlCaXRtYXBzIHZl
cnNpb24uIElmIGl0IGlzIC0gaXQncyBhIGtpbmQgb2YNCj4+IGNvcnJ1cHRpb24sIGFuZCBubyBy
ZWFzb24gdG8gY2hlY2sgZm9yIGNvcnJ1cHRpb25zIGhlcmUgKG9wZW4oKSBhbmQNCj4+IGNsb3Nl
KCkgYXJlIGJldHRlciBwbGFjZXMgZm9yIGl0KS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAt
LS0NCj4+ICAgYmxvY2svcWNvdzItYml0bWFwLmMgfCA0MSArKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgMjMgZGVsZXRpb25zKC0pDQo+IA0KPiBBbSBJIHJpZ2h0IGluIGludGVycHJldGluZyBxY293
Ml9sb2FkX2RpcnR5X2JpdG1hcHMoKSBpbiBzdWNoIGEgd2F5IHRoYXQNCj4gZXZlcnkgcGVyc2lz
dGVudCBkaXJ0eSBiaXRtYXAgd2lsbCBjYXVzZSBhIHJ1bnRpbWUgZGlydHkgYml0bWFwIHRvIGJl
DQo+IGNyZWF0ZWQ/DQoNClllcywgd2UgbG9hZCBhbGwgdGhlIGJpdG1hcHMuDQoNCkV2ZXJ5IGJp
dG1hcCBzdG9yZWQgaW4gcWNvdzIgaW1hZ2UgaXMgbG9hZGVkIGFuZCBjb3JyZXNwb25kaW5nIEJk
cnZEaXJ0eUJpdG1hcA0KaXMgY3JlYXRlZC4gSWYgYml0bWFwIGhhcyBJTl9VU0UgZmxhZyBpbiB0
aGUgaW1hZ2UsIGNyZWF0ZWQgQmRydkRpcnR5Qml0bWFwIGlzDQptYXJrZWQgaW5jb25zaXN0ZW50
LCBidXQgaXQgaXMgc3RpbGwgdGhlcmUuIElmIGJpdG1hcCBkb2Vzbid0IGhhdmUgQVVUTyBmbGFn
LA0KaXQgYmVjb21lcyBkaXNhYmxlZCBiaXRtYXAuDQoNCj4gDQo+IElmIHNvOg0KPiANCj4gUmV2
aWV3ZWQtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IA0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

