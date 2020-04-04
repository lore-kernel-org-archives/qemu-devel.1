Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C980DC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 03:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DE1206F6
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 03:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sq71Nh65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DE1206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKZdE-0001Mo-LE
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 23:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jKZcY-0000sl-TY
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 23:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jKZcV-0001Pl-4H
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 23:37:22 -0400
Received: from mail-eopbgr30095.outbound.protection.outlook.com
 ([40.107.3.95]:12376 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jKZcU-0001Nl-JV; Fri, 03 Apr 2020 23:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHgl3qCzYnhuUe67cLvZYVueVzhAiPZvn4lCDPdp1NGKTvSDqljagUXxQFhAWA9cUyZzNb3KdOwiyqoM+EkXtsX74fwZQp3XTm0k5KoWhW3WRz0QyygpJTv0aVJio6iJCxoGxa0R6aT0RxXrpzAuaiKlh8VTqXyAZLBQzMnA/JGvogW+KVIcrm1KdkRIQosME4Nh4wNRQUSfbbkfNqOtKMb3frGx67UsGWdoc+RkwhAXUN8jX/CzXpg+WsWfjOtRb/7DioPuTHbxhskAI6GMutwxPOJ3cUOWv4GL1IqsZ1Z9AotU/z9czM+EJqSIX5WKdc+K+KouTRkHvCbyPxMotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaXYBaKB+Q22rK01Wj2m+fdN3NZ7P9HOB7+W0d3rfDo=;
 b=iDHwKewtwEXI172JzyNUv1FkDlumXFRtkZOsXdDqMD/UmBgNPXOU5d938rnUtKIfslE1CmMo6M3Rjtu5cJIHpQIjOiVSU1k5fGK3FnHVyJlVsZjfzWCb6IrKE8vB+EdRc1RXn3V5ep2iPcLSzy2Nz0b9sKT91ECvP7131uz3UsDXKoVPts+9YDboemKOYh2/d8SEqFPtsI/oAkPLFjdiyhhTEDu1oZvuEj8XCwBhe7lSMps2agGm+D0WVxO+PWR63EUjJ2HP6W1AU7WStlvlpf3h3e6GfIHUz0acqJsJst8QkoY+qOOAS9l2SbZgxSkvGO+4bvcfbAKwe0Dp5e+gsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaXYBaKB+Q22rK01Wj2m+fdN3NZ7P9HOB7+W0d3rfDo=;
 b=sq71Nh65ZhufxugcsJBiO+mcNt9sQZcJ+AYDC1gKUfyfaEJ4AhRSfVIN/ZATacCWdw+y0RxUPcqlipTyqnAArFiXYwW58JIMnfXwaLvYTCPEWxck3V3nteLZNjALLM8Vjj53SKx6kik0zJeRCo2wFg5pW9dUclQ8DN5Xp0ymwEU=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4883.eurprd08.prod.outlook.com (10.255.96.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Sat, 4 Apr 2020 03:37:15 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5%7]) with mapi id 15.20.2878.017; Sat, 4 Apr 2020
 03:37:15 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH for-5.0] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
Thread-Topic: [PATCH for-5.0] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
Thread-Index: AQHWCdkWb/Viu575KUagEAeNTTMcb6hoTmFD
Date: Sat, 4 Apr 2020 03:37:15 +0000
Message-ID: <AM6PR08MB50482A2E371C9AF7EDFA2E7CF4C40@AM6PR08MB5048.eurprd08.prod.outlook.com>
References: <20200403165752.18009-1-berto@igalia.com>
In-Reply-To: <20200403165752.18009-1-berto@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-originating-ip: [109.252.115.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 037aa331-705c-49c1-39ad-08d7d84977e5
x-ms-traffictypediagnostic: AM6PR08MB4883:
x-ld-processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB48832AF9CEC292231A0A6C3AF4C40@AM6PR08MB4883.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:268;
x-forefront-prvs: 03630A6A4A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB5048.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(376002)(346002)(366004)(39840400004)(396003)(8676002)(66556008)(186003)(7696005)(86362001)(5660300002)(2906002)(9686003)(107886003)(81166006)(71200400001)(44832011)(66446008)(478600001)(53546011)(81156014)(26005)(4326008)(55016002)(54906003)(316002)(52536014)(66946007)(110136005)(64756008)(66476007)(8936002)(33656002)(6506007)(76116006)(586874002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VuMAIlq/pN9TrA425qQFODgZI0eLla5KcUCM3+2rFJHHHqIOxfH4ftRA2JmWGD5Hp1PySJlO/8zQ+SnP0EM/FJ0Pdp1/Ce2AGml1VBiGHtqQoxdMOK2DITKb/vFdAim3i7I2QNCXBUkd4W6O45+xRlGhUvQwCqWiHDdSSmAg8m8/TevtkjKL5LDXP0GM/+qW+VoLVZLyCjdoDS1cvMmzGv9ccHHYCMy781rfRrRvhfm3AIafD5ahlCZvJuggnQ3YOLsjjXekbc//OggbK1ozz9Bkj8iF/GPP2liOkoOkIcWluTMlRqjjHzfBfA54HgNx8ES+LQbQ8BjlsGY0f6po/v46G1gf8wGkbaw1h1ADgfu2cs/7K/KGpPctXQ2SQf5xgfr/pz2QbYBFhP8Mld1ZKpCGFcO51N3Op62k0DFyFDXnwCqp4x2zMeswe8GJc7VZPDFm8K41F+Xa3/5yfj+991SSCN5FZhm8l8KOVdZPthTg6PwMwzAVqCiwBOWO8mU+
x-ms-exchange-antispam-messagedata: ZSIatapKlZ2ox3jyZbg0PukmoeDqq4P9hIcK5sPZqdqH91PvAp+GxnmIniyHtoI2kx5SQeI/8VSFZVaQRCwyD1CWc/P1kBxNtDwPI4unLuCSL4dMxu1HGMN0TUQ/HCPblfLiAykry5faB6dV+d8H1w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037aa331-705c-49c1-39ad-08d7d84977e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2020 03:37:15.0678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4VtYqbyvVhqFpRrdFQ4daZpPMY/KQBN4284J6GCJaSPpTbPyO/AR6ukn0C369lBdP93eok7Jsemg+Q/7dj4aFolomSfYig3uT5CqmICIxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4883
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.95
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
=0A=
________________________________________=0A=
From: Alberto Garcia <berto@igalia.com>=0A=
Sent: Friday, April 3, 2020 7:57 PM=0A=
To: qemu-devel@nongnu.org=0A=
Cc: Alberto Garcia; qemu-block@nongnu.org; Andrey Shinkevich; Max Reitz; Ke=
vin Wolf; Vladimir Sementsov-Ogievskiy; Pavel Butsykin=0A=
Subject: [PATCH for-5.0] qcow2: Check request size in qcow2_co_pwritev_comp=
ressed_part()=0A=
=0A=
When issuing a compressed write request the number of bytes must be a=0A=
multiple of the cluster size.=0A=
=0A=
With the current code such requests are allowed and we hit an=0A=
assertion:=0A=
=0A=
   $ qemu-img create -f qcow2 img.qcow2 1M=0A=
   $ qemu-io -c 'write -c 0 32k' img.qcow2=0A=
=0A=
   qemu-io: block/qcow2.c:4257: qcow2_co_pwritev_compressed_task:=0A=
   Assertion `bytes =3D=3D s->cluster_size || (bytes < s->cluster_size &&=
=0A=
              (offset + bytes =3D=3D bs->total_sectors << BDRV_SECTOR_BITS)=
)' failed.=0A=
   Aborted=0A=
=0A=
This patch fixes a regression introduced in 0d483dce38=0A=
=0A=
The condition that QEMU supports writing compressed data of the size equal =
to one cluster was introduced with earlier patches.=0A=
=0A=
Andrey=0A=
=0A=
Signed-off-by: Alberto Garcia <berto@igalia.com>=0A=
---=0A=
 block/qcow2.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/block/qcow2.c b/block/qcow2.c=0A=
index 2bb536b014..923ad428f0 100644=0A=
--- a/block/qcow2.c=0A=
+++ b/block/qcow2.c=0A=
@@ -4345,7 +4345,7 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs=
,=0A=
         return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, N=
ULL);=0A=
     }=0A=
=0A=
-    if (offset_into_cluster(s, offset)) {=0A=
+    if (offset_into_cluster(s, offset | bytes)) {=0A=
         return -EINVAL;=0A=
     }=0A=
=0A=
--=0A=
2.20.1=0A=
=0A=

