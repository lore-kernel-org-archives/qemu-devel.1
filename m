Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA597C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B5B20728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OrFG1Z02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B5B20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzBz-0003l9-Jv
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3a-0002Ml-Ic
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3Z-0007ap-2J
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:02 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
 ([40.107.7.114]:29366 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3X-0007Ta-Aq; Mon, 27 Apr 2020 04:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOSFqYuKdThJwPW5ZeY6q40sdhu9P3R/KC89BsjbHkZ/gZiggT5yLrrdI1VByBa49Gx/2gOH3SCyIrzJyFZclD4UozHIsEsv5ZkcNcemKVzIJqGtaSdKrDtFE47U92jJStwi+efQ4zBvRtQW27pWwwR62t5ePZLr4IHXLuzRmC+MFAlYa0ghch1K4j6b5jl7dguQLZqEwTiZ+3Tz6SpRXSK50AJy2GIwhM0OlZm5DlkRQH5PgRZOG0MqVqx3qruES/HbFhDLiChEYnsVUDHpU4ygw2710vbUyTesU4vSsOUT+ORydZb2GAn9PJrtd/3ATk9HTvu6Mwu6KHeeH0Jw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy3xXl85nwGEzmT9kVH+IntKelWJt78/C09WVYkUlHA=;
 b=ejWaTpb+JWbiFpCZkqzUo2UKyWm65kY1/4hLeq3VoRd+iYpXJXVO7UMA1XOeAq7E18/zo62u6ijmej6OpHKi2qXC4xbcmTDWa9WB5ykEihdytnqA8R7IWEx8pWK678YYvCktHC0hIw491EUH+dLDWqTbVSgofsnH7lYGzDWQIzs+dZZmRltH/IfQscosr08WC3Ya/9uOZdthVqmtfDPmAcngKMI1k1WbkvGf8AiJFreCC3i4Vx1mg26JKDVO9hq6WX3b0/l0AtcI3m5/falEkJuUs5/DvtnJDCsFaqhOWT6m2s6ZQ4G+wxyPMxyKp2oByds3wiy+cVtBpCuAQX2dew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy3xXl85nwGEzmT9kVH+IntKelWJt78/C09WVYkUlHA=;
 b=OrFG1Z02xrQMl6a3Pbfky2WWSJ9+EsygzOU3NmvDkwVkh4qQyXkDDiq+3PUVTJh5/YXg6/yf5DCQdddECScetn+hldg+SfBgrZiXAYgUGSioWhtDrXPFzZGmBea0C8WR+vgXcKR/lxB/mRHhkjRO9rIx1FnE1U6OmhGQ1b9Ux+I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:23:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:23:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 04/17] block/io: use int64_t bytes in driver wrappers
Date: Mon, 27 Apr 2020 11:23:12 +0300
Message-Id: <20200427082325.10414-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:23:56 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3599ac7-f9e4-44a9-a52a-08d7ea84548d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54636A55400A876506CACE4AC1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3suxYrpxirDY9boeVuHXGv8LtfEsENxsE62J7uQNEM1kOEhDIwwiZbcBikUH+xX3sIxiZqouCNPQ3UbDegQfjABTbZwzGw95IH5AYZobLsaiW/A9qSWBTuXQjdvIt4aCaglHpDvbgCYKZbapi+y2x5ngCg8WdH3wG3fagW7bmSdE8aAhuuAJXiVG4REYRZMV69Ll8ZRM7zMy8imARogEA3Ev3aD6tIH1jA8+tE3KCtjwrasJBIwHmxnbwkXPZDh6+ZEuRAjLT+ImWi+Jm50Is7jSgApp/FOHXotJhneibUM87Pw1A2KquE/ibDdrpxAD1nzXW1OjzX7rmk5xPi6WKytLn00EQM6m6PjQlCVNq6POfwZOFBz8TcLBIaAjwubjXVHLNBN8Is2gGUjpG5xvGUJSOnrFpX7/FPdVEjlAoknKsTKVm3DYHlRAJyMcODSppHdgalhvlG1piRystglVim8wjJMH50l+ojZYRc2c2cyM9Lbnb3t740A3h0DEIPUG
X-MS-Exchange-AntiSpam-MessageData: oeOi2QN7DdxV09FOTbqKuBdR161HC7rm5NYJEOmNmdrRtHO2pfY2SR+o3aoqxIVnxGxmg501OooSj740Bb+8veSP/1TTTa25MffXyHWcbNYT3Jr43McDWXs1b4Be/wo8Vxegj1Pm3BziCKTquHIMs0YOC/S8zACHPCC9eF/jKj5EwgJnjjd6hzFz4LUVnCD/i/Fjize9h2AU8tNL32G2eeTDcRqX4iXWIe/d9UtRvHff3P5GbkLxUIeHAV+hWrJ+RKBdYSYcxRjHxKLEXqgYqqqS9uxnKvtYKl5prp5icfNpaN0m2bxws7I2XL8A7zbPlV8EiLZ9oX+bkjhv16HGkxEPeSBD+EAVgVQxuw32vxZAXzakMBORpcjfHIchfuyk8jlIpmJpwCuhkqLDocTPz26Eon3WU4kafAhItuUUdA9TuuuK2aeiF6SzGrJUNA/6j7J3FRhsRAs4Ki9XnDdkPgs95tV7Rqz5Cwr0YFlSkHMOYRV2b4ktXcx9gkVFTHuBXYWAGnUvZKdI0KYLkzvtXLXiVtyH2fishfPSqVyI6RapH5lQC/+l0oxp/LsiIEORzHbvKCKU9nbRE26FgJq0cmm5MofiQG6O7rrubEnBmggt1+CfTLqDkfQ6UkuCWmX4LH7oR4xyXpEAKbRh++QTDSBEOzMB1PIczzRF15HMpWJBr2rHWxonCzInzG21K/UBiQVOf+DiKyc8V+TzUxNPjT4n3nKSYPPZpHoGcVgwNmsyVq6ou/7ERdd9R7CO1yW6lj+eDqI54FnbefE8Xx5JJFVKALhGXyGs+zuMYu4Dar8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3599ac7-f9e4-44a9-a52a-08d7ea84548d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:23:57.3208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxDplzNqwvjjvHXouxIFwf7KAN9+rBhMOr/SZGRY1gP4EdCdTpo3QXGfpKfNv7D5M7pGija/GKahOOyvOPk91NVt97U74h8ircM4SzLqcAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:23:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.114
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Convert driver wrappers parameters which are
already 64bit to signed type.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 1267918def..4796476835 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1086,7 +1086,7 @@ static void bdrv_co_io_em_complete(void *opaque, int ret)
 }
 
 static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
-                                           uint64_t offset, uint64_t bytes,
+                                           int64_t offset, int64_t bytes,
                                            QEMUIOVector *qiov,
                                            size_t qiov_offset, int flags)
 {
@@ -1155,7 +1155,7 @@ out:
 }
 
 static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
-                                            uint64_t offset, uint64_t bytes,
+                                            int64_t offset, int64_t bytes,
                                             QEMUIOVector *qiov,
                                             size_t qiov_offset, int flags)
 {
@@ -1235,8 +1235,8 @@ emulate_flags:
 }
 
 static int coroutine_fn
-bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                               uint64_t bytes, QEMUIOVector *qiov,
+bdrv_driver_pwritev_compressed(BlockDriverState *bs, int64_t offset,
+                               int64_t bytes, QEMUIOVector *qiov,
                                size_t qiov_offset)
 {
     BlockDriver *drv = bs->drv;
-- 
2.21.0


