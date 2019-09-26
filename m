Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB58C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF5421655
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SUHLyblG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF5421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDUU4-0004ML-0i
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDUSp-0003r1-2A
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDUSo-0000NE-0R
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:09:46 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:25305 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDUSn-0000MV-Om; Thu, 26 Sep 2019 10:09:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF5btBxFSbPDcrNymS/UFx7wkKlt2sTHGohLjIGlCbG6hiJ8QQ1bekm30YeiF8YZ503m5pMUD2eaZef9e2TkLZ6xaaa7yOupDG1ekwfDBnXybt0DO2r/rM1mf+qx4L0R4fAbIeMgL9hWBKpcc7/T2pyMXTFbbEFOONoCERSrML2U0wlR+8NIesAE/M0QvSv/ZLxlaE8gLqZu6ec5J3WulVFfFl0nV/EoNsXmf0EaaL/X7O88QFv9GcgUJ0FaPXMLMVmeUHbMw3jDZ2GF6Z5k67OgqOrTOt2WnPjyVa9Vz+JZZKVWMQvilJYPuJvaIG2Z/GHzcp9DnhnKrbHZixtcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb7Ku4zce6y703dWCfv9ip8spZobVykX0IsJRuIGf4Y=;
 b=Ocy/FMW7FL83d5Gnq7r/B2Dg9hjj07h9k3bE+Z5xC3GrKTBtvgLT9EMEhNu9FJ5MdgL2exUaBwwUtKUVUcV5mMhdsJXiRIClfHTbllauTdAjF3yk/42QE+uLnQg0hmVrvR2ibMcI4UFhLLdaZjgTdSKljZhF5fPTuJT3LqXYCTw5GqKIdFl/bK3C/RVAu50fHFAhRZgbLpgUkCNZl2UzZuo5JC4J+svFBBrimLZyckfsAIvA+a3k2Pg0d22X64uQQT2Drj+XMdRCx4k6yRbhkPLt9hpL6xsn43H9XlJNG3kX0ZVcwbpSEShpMBbHPxhMMPl2mlhYOoA6GkSr1M8Qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb7Ku4zce6y703dWCfv9ip8spZobVykX0IsJRuIGf4Y=;
 b=SUHLyblGMankV/8WsWaj/EhjXVfL0fSIo0+pfhJm5mcsGd+TxGQK9E8tZvnbh71VfMHE6gLMxR5N5RWXH+N/QGnI2H1cy+izYni9nZOq//2JUIOC3Lf4or1zh++1tVS0sfGhdcfL1ayIoEhzAGtyAn6ScoKGM6KsPgsOLBfy/pk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3964.eurprd08.prod.outlook.com (20.179.9.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 26 Sep 2019 14:09:43 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 14:09:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 18/22] iotests: Resolve TODOs in 041
Thread-Topic: [PATCH 18/22] iotests: Resolve TODOs in 041
Thread-Index: AQHVb8tsNrBtR7e5gEim7TeXonQBsKc+CHsA
Date: Thu, 26 Sep 2019 14:09:42 +0000
Message-ID: <ba5d6bd3-41d3-9905-765e-f13a2c9ab961@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-19-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-19-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::11) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926170940202
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22fadd1d-c28c-45a2-8a7e-08d7428b2d71
x-ms-traffictypediagnostic: DB8PR08MB3964:
x-microsoft-antispam-prvs: <DB8PR08MB3964AFACBCF8B1024345C522C1860@DB8PR08MB3964.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(376002)(136003)(346002)(199004)(189003)(8676002)(6506007)(86362001)(229853002)(386003)(4326008)(66476007)(76176011)(14454004)(66446008)(64756008)(66556008)(66946007)(31696002)(6246003)(36756003)(52116002)(316002)(110136005)(54906003)(81166006)(6486002)(81156014)(6436002)(476003)(2906002)(256004)(6512007)(186003)(31686004)(486006)(66066001)(11346002)(5660300002)(2616005)(446003)(25786009)(6116002)(8936002)(478600001)(305945005)(102836004)(3846002)(7736002)(71190400001)(71200400001)(99286004)(26005)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3964;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lYyzP4bpaY70o0rCHODEleFSJHznDgfl8KU5isyZ+/AIFGFHcie/2iZE9h0Sj2T+Dn6DJFuoqUYYc9cq11ps49ULAEU7+h68ZErFcc1TzMAUI3IinwAwo+n7RkvNUHCf3ZputVsewjbkOGGY7NS/dOzCLSOb3G4OMDoL7rXJbGIByOHC0tnY7C5onH6nvD5NlGe+MB9sReLTWzhPuZP1xtI9j/xf+P95QDHraUNmc575e1pjpr47v9ROnKSz02cnWVYK44BvYgre2rbfdlsntVjsnBfchExWzAUiJdEIiq/jWj0j4eE3Xj07za4XUDlRHGnM4ZV6/SCGQ3ziPBx8GDBAZ/i+oLcYgtfccMZOKsvB4cxV9FsA/lEvo9Q6m1Rt9nOe9kF6B4pXOGD+t07qJXoPmGWX3jeCxQkctqBhdCI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <02DE16EF0E621249A01730723BDEF251@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fadd1d-c28c-45a2-8a7e-08d7428b2d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 14:09:42.8809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1S0FfPvlARpGgdyK/COve6ksLhpHgLbEEHaVG7RuZN+UOFb5NLJbGnccOHaSRpOAMljdzyqGVX+Zyy1CM4WljEFMHRyAh/PY2wbZBzsDAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3964
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.118
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

MjAuMDkuMjAxOSAxODoyOCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
MDQxIHwgNyArKy0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMDQxIGIv
dGVzdHMvcWVtdS1pb3Rlc3RzLzA0MQ0KPiBpbmRleCBkOTFmNTM4Mjc2Li5jYTEyNmRlM2ZmIDEw
MDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDQxDQo+ICsrKyBiL3Rlc3RzL3FlbXUt
aW90ZXN0cy8wNDENCj4gQEAgLTkyMSw4ICs5MjEsNyBAQCBjbGFzcyBUZXN0UmVwYWlyUXVvcnVt
KGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgIA0KPiAgICAgICAgICAgc2VsZi5jb21wbGV0ZV9h
bmRfd2FpdChkcml2ZT0iam9iMCIpDQo+ICAgICAgICAgICBzZWxmLmFzc2VydF9oYXNfYmxvY2tf
bm9kZSgicmVwYWlyMCIsIHF1b3J1bV9yZXBhaXJfaW1nKQ0KPiAtICAgICAgICAjIFRPRE86IGEg
YmV0dGVyIHRlc3QgcmVxdWlyaW5nIHNvbWUgUUVNVSBpbmZyYXN0cnVjdHVyZSB3aWxsIGJlIGFk
ZGVkDQo+IC0gICAgICAgICMgICAgICAgdG8gY2hlY2sgdGhhdCB0aGlzIGZpbGUgaXMgcmVhbGx5
IGRyaXZlbiBieSBxdW9ydW0NCj4gKyAgICAgICAgc2VsZi52bS5hc3NlcnRfYmxvY2tfcGF0aCgn
cXVvcnVtMC9jaGlsZHJlbi4xJywgJ3JlcGFpcjAnKQ0KPiAgICAgICAgICAgc2VsZi52bS5zaHV0
ZG93bigpDQo+ICAgICAgICAgICBzZWxmLmFzc2VydFRydWUoaW90ZXN0cy5jb21wYXJlX2ltYWdl
cyhxdW9ydW1faW1nMiwgcXVvcnVtX3JlcGFpcl9pbWcpLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICd0YXJnZXQgaW1hZ2UgZG9lcyBub3QgbWF0Y2ggc291cmNlIGFmdGVyIG1pcnJvcmlu
ZycpDQo+IEBAIC0xMDc0LDkgKzEwNzMsNyBAQCBjbGFzcyBUZXN0UmVwYWlyUXVvcnVtKGlvdGVz
dHMuUU1QVGVzdENhc2UpOg0KPiAgIA0KPiAgICAgICAgICAgc2VsZi5jb21wbGV0ZV9hbmRfd2Fp
dCgnam9iMCcpDQo+ICAgICAgICAgICBzZWxmLmFzc2VydF9oYXNfYmxvY2tfbm9kZSgicmVwYWly
MCIsIHF1b3J1bV9yZXBhaXJfaW1nKQ0KPiAtICAgICAgICAjIFRPRE86IGEgYmV0dGVyIHRlc3Qg
cmVxdWlyaW5nIHNvbWUgUUVNVSBpbmZyYXN0cnVjdHVyZSB3aWxsIGJlIGFkZGVkDQo+IC0gICAg
ICAgICMgICAgICAgdG8gY2hlY2sgdGhhdCB0aGlzIGZpbGUgaXMgcmVhbGx5IGRyaXZlbiBieSBx
dW9ydW0NCj4gLSAgICAgICAgc2VsZi52bS5zaHV0ZG93bigpDQo+ICsgICAgICAgIHNlbGYudm0u
YXNzZXJ0X2Jsb2NrX3BhdGgoJ3F1b3J1bTAvY2hpbGRyZW4uMScsICdyZXBhaXIwJykNCj4gICAN
Cj4gICAjIFRlc3QgbWlycm9yaW5nIHdpdGggYSBzb3VyY2UgdGhhdCBkb2VzIG5vdCBoYXZlIGFu
eSBwYXJlbnRzIChub3QgZXZlbiBhDQo+ICAgIyBCbG9ja0JhY2tlbmQpDQo+IA0KDQoNClJldmll
d2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

