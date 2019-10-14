Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6431C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B164E206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oVj69dQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B164E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxOF-0005Qw-UD
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJxN3-0004pJ-TO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJxN2-00015U-TC
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:14:33 -0400
Received: from mail-eopbgr20091.outbound.protection.outlook.com
 ([40.107.2.91]:64359 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJxN0-00012U-2V; Mon, 14 Oct 2019 06:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjjRFBlakkVoRJDNRshDaI/2QaRtaYSQd2KDFuTgx5NzCyOxa/cZ5xtT8gaPS0kSJK28SPkB6MUIYZy/fHry6IdkBwF+p+nWz5J2h77XVH0uE6kFmUBaUT4oGxGGXjNUOjK81/hUdVbKAWZhJ2joIcU5kukiFpz1PRKA8OC7R9HFVAUFxT2Kp3/6dRgBHCoSXs4jcF3HkeC1+2Aq2VvtoTZuX2zDp8uheLLhKAGQJofMov4FkT4CCbmEGpAYySeXaZ1xAwQuJKnoW92/3svq1KKiml7svEv0+/dsojyXoKnv9JeePcsO3P6BDj5BOx5Hq/YGzlZdrSBYbXsHMnpH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq3cbqUth73rhSlv1/fL7pkdDfX/WLrfaAvIxth1DJk=;
 b=EEgAtdYz11dRSoLu0Pgz7gh/9DXXvapsXqu0pYpntE4cWAHfxRpqRD6W+zyKyS+RitwH5EneyabZMJb9+u19vC5ZGdj0GytJz/FetreLY8PXgWJdLKhC6l8pYXxwWsPpC6dtE1eo5LnmYEgSXvGFL5SjIoShUze91Jn6ys6QFQY+TrUg0eJr2ja3anKRjMScmgWaItvdOVT/CxrvMBeL6K4oN2kwErKVulLfRJVlL1wwlZi6d9iQrn4sS4vmBvaweA2I60Ch6rdMNFAYPlUWB8JDDbQCjtltN4qdcWR9+YdtL76E9AQprsT9QkmEpNWTE75uKOMUG1sHYYeW7gF0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq3cbqUth73rhSlv1/fL7pkdDfX/WLrfaAvIxth1DJk=;
 b=oVj69dQD6grHupuJitWhkOcdQ4vX+2whQGYXGQmjiGupaVA5AbL4HWBeAWjoLBYDqeI8DWIo8u/SPjNab8DVAtYvkIqCOclISj2Na9OMZLR/VE1I4PHC2HvXxb4gH8oG/6nqKlGEBEwvpwOKjG2oQa0DpqvzYjK+BopKFpUTvN4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3963.eurprd08.prod.outlook.com (20.179.10.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 14 Oct 2019 10:14:22 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 10:14:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] block: Reject misaligned write requests with
 BDRV_REQ_NO_FALLBACK
Thread-Topic: [PATCH] block: Reject misaligned write requests with
 BDRV_REQ_NO_FALLBACK
Thread-Index: AQHVgggiF38wa8WrGky2vaXA9FnGJqdZ64YAgAAAsYA=
Date: Mon, 14 Oct 2019 10:14:21 +0000
Message-ID: <feae8e1a-3f48-7598-03ec-bcdc2ffe8d18@virtuozzo.com>
References: <20191013204853.1046-1-berto@igalia.com>
 <6bbe4db2-a4fd-ee2b-1b79-879658b81753@virtuozzo.com>
In-Reply-To: <6bbe4db2-a4fd-ee2b-1b79-879658b81753@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::13) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191014131419757
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf27376a-ffd1-4051-ce06-08d7508f482b
x-ms-traffictypediagnostic: DB8PR08MB3963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB396384B33330F77352EE0529C1900@DB8PR08MB3963.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(39840400004)(366004)(396003)(189003)(199004)(229853002)(31696002)(11346002)(446003)(5660300002)(3846002)(14454004)(6116002)(71200400001)(71190400001)(6512007)(478600001)(4744005)(8936002)(66946007)(186003)(26005)(6436002)(36756003)(2906002)(81156014)(4326008)(64756008)(81166006)(8676002)(14444005)(31686004)(256004)(6486002)(25786009)(476003)(86362001)(66066001)(6246003)(66476007)(7736002)(305945005)(486006)(2616005)(316002)(102836004)(2501003)(6506007)(386003)(110136005)(99286004)(52116002)(54906003)(66556008)(76176011)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3963;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JvoF6/BbGtOf3M6M93VVxBkTxcMy/ySbeTATd+EVotAcw2WUaI6zFrYEkt3GZ4t7Fytdxeznt2xLVRelUHNeTJW2EmL9aeTapfwxiudIgI7sCq7YcKJb1/YPvaQuE6vjB4iRSsSFrwlGo1aAjkCk7fyHN/mJoafsSE4klD3VIpcMa+J08nzzErDCG/NAxRwPjS5pFM7zyrA8pS9hlIdeOXIBLmzlgfAORBEPtz8r7ZBPSnWKb4HhgEiu9NgaL16FN2LhSH978lGane8u0s+gC5hkQs+Iwp12K0lnPeEW1xNjeWTRYIifwtPLJuuoFztkaH0mdIaHeld/XgrYYQi73b09Rfr8iTlxC1oflua9PFfPa18yfWbfFk3oyO4Azgtj9UvqKvnV+1tXmZFvbccO6GZezFLtY8ObNUMnusmmWgg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A938AE670FC05419103F717A010C4DA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf27376a-ffd1-4051-ce06-08d7508f482b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 10:14:21.9321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78kC72Tl+tXWY6PGWrJIiYle0LuEq0KKB1FnKzUn0PdLAMx9ZinLypDhvhBvn1TkfCLMueZBGprN7J4sWmrQI23x1Tfs4DvTuMmnxIfob4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3963
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.91
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMTAuMjAxOSAxMzoxMSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTMuMTAuMjAxOSAyMzo0OCwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+PiBUaGUgQkRSVl9SRVFf
Tk9fRkFMTEJBQ0sgZmxhZyBtZWFucyB0aGF0IGFuIG9wZXJhdGlvbiBzaG91bGQgb25seSBiZQ0K
Pj4gcGVyZm9ybWVkIGlmIGl0IGNhbiBiZSBvZmZsb2FkZWQgb3Igb3RoZXJ3aXNlIHBlcmZvcm1l
ZCBlZmZpY2llbnRseS4NCj4gDQo+IEFzIEkga25vdywgQkRSVl9SRVFfTk9fRkFMTEJBQ0sgaXMg
Zm9yIHdyaXRlLXplcm9zIG9ubHksIG5vdCBhYm91dCBvZmZsb2FkaW5nLi4NCj4gDQo+Pg0KPj4g
SG93ZXZlciBhIG1pc2FsaWduZWQgd3JpdGUgcmVxdWVzdCByZXF1aXJlcyBhIFJNVyBzbyB3ZSBz
aG91bGQgcmV0dXJuDQo+PiBhbiBlcnJvciBhbmQgbGV0IHRoZSBjYWxsZXIgZGVjaWRlIGhvdyB0
byBwcm9jZWVkLg0KPiANCj4gQmVjYXVzZSB3ZSBjYW4gZmluaXNoIHVwIHdpdGggdHJ5aW5nIHRv
IHRvIG5vcm1hbCB3cml0ZSAobm90IHdyaXRlX3plcm8pIHdpdGgNCj4gQkRSVl9SRVFfTk9fRkFM
TEJBQ0sgZmxhZywgd2hpY2ggaXMgZm9yYmlkZGVuIGZvciBiZHJ2X2RyaXZlcl9wd3JpdGV2LCBh
cyBpdCdzDQo+IHNob3duIGluIGFzc2VydGlvbiBiZWxvdy4NCj4gDQoNCkhhaGEsIEknbSB0b28g
bGF0ZSwgc2VlIGl0J3MgYWxyZWFkeSBxdWV1ZWQsIHNvcnJ5Lg0KDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K

