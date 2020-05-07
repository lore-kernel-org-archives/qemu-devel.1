Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B1C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BEA2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BLdMS1JH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BEA2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcGX-0007it-Cz
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDB-0001w5-GM; Thu, 07 May 2020 04:48:57 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com
 ([40.107.8.138]:13902 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcD9-0006Er-JQ; Thu, 07 May 2020 04:48:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw7tTrDKA9Y/W0+CxKbWzVSW14hEb+G7ADguZLCOaPf47m1xmmvNfHhg04+ML88OSLNa6ittAX0gwVXQdDsPGA4YP6onBTk7xzWNGomi2nBLnWLk6cSvHoG5b9Ak3VM6gxa8oGJwVr1ZNU+oMHuBvmuAIEhk7uP7zDEj7KoUGDddckXXCSBzESdPImVYd/o6zBhAKt7XYsArT5ZOwYhPPBWAErbCdMBOBlGUGVUVUc0sOJtAzyalXAKNA9cl46tvsYeftX8UzGMwX7zODr7wsuDYPPEDQzhkhFyI6zfxB19FfLNa6K1gJYQCnnf04FDTD2ry6/+wkcP+JEZuZKmDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO/M75YVJtl8je8wd45k4tiRsB6uC+AxB6yt81k+DWk=;
 b=adR3juPJ+2GRnE5r+uvzkLMhn1UzE06uq7AnceBo9YAYeLCZqwd/ihCx6i9tKz/GjamFtwdrgGEb9ouAIEHjXKbwcvpe+ZiTk+lwWyNJfcIUs58r567kOR17vFlK9yuvcdX0zyq3u6hP9pbGLY1K9R16dLJ8UN74MktbE17u95Igbq7jJJbf3VQDyNzA5vGezPIPRMznJG35PTzDIcynPPsMTzz+fnQpQBIwPF+jdIOejDCDeXO8x27uRMKhZzWiYGtrrgbS+eLSv8xqyuJKfMq8+pDAL+CFVaHIuldCMAgcvASdjDPqLy9gzHRmEf5039jNOsG0/lDFda6DngpFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO/M75YVJtl8je8wd45k4tiRsB6uC+AxB6yt81k+DWk=;
 b=BLdMS1JHIpwxv5g2GKP9GqOkmkrxcJQiTtaIKszm5ExL0WEhlWASZiaLakKHPXiRW27WSjh191GIXDqWvgE9twEy7mquL07z+SC2j9cj4LzQu2dWVcA5d+7ClAPZQUJF66PkA2d852edG2qqB3CkzqHBR8kAJWcummhPY3SuqZE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/9] block: inline bdrv_unallocated_blocks_are_zero()
Date: Thu,  7 May 2020 11:47:53 +0300
Message-Id: <20200507084800.20596-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200507084800.20596-1-vsementsov@virtuozzo.com>
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:35 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec9787d9-be24-4553-d151-08d7f2636e8f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495F7B1F6BB3E2A04AAF112C1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asrqZ7HfeXrDiUJBtQ1ytAtA9On9gjjGJeVVf/keKtaXpi+cF86lMmGg1oV7zNp1aIWm0D1dXs7OxnO4WotQzNKDq1Ahgdewt2gB0SziRVCcQ1ahO4pigkO43N9n9gBcUDfzoNJNvPDsIj1bswBpglhbxFTKDaGIK7LGEqPpPaf9B0dr8kqGiZ8g+SO1NPma9VwEd06XgrHTMkKPcg+Lara3s1LGhO+d02jWkTma+jx1eUgv1VMdOuzqSp2DR2MtwcywJD6swlDy7b8j2Do7uKubI7uQdGvTkHv23ws1WGPUertDYVyprEGZj7P5XJEj9q/AYl1Nm7ESxQMhale2VaOt6zY4gKFVmlpsxBIzreQaJLlMqGqjYl+BFC4dQbE4xfq1d2E3WyyHoJEQdsZ+aeTEwf0Kf1GMJ/6FhBdyJBxPwpVvTcfDexGS2PjFECAGmD+ladkW83s0vmtQ8Ie32Kvg6HddEgus5KQmVxmteP8Bl/30hulqP+HvcHvCzlIaOAyS3p37HbIl1VI7qEfBmjBHQ/6C2naqGjXjcwqzpndeFpBgUJCB7uaNdXwMvZOh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(107886003)(66476007)(66946007)(66556008)(5660300002)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: W5B4SAzvUtoYl0kD6mXE+l5HYonuN5lQXE+puUxbqzFd1keFJd68iDukjzxpzc7NO7iuEv0fFV4TxDQEGtvIwHGHsbw9a1niuJLhmxzPf4Nr1f1vVNWgFghQzCZVAfIJexIi2T6ckW+HJ83i32MJT46fFgd6DOOBkz0lc/6NiDgKPf94u8Huru0XKj11uiMacA/IolKa/oOJUh5KNHDnN89jWPNsZtGjjsWefgezksqTz5ReAR5fKdYmQVQ2LaeZei3+sASpBX1f29cdMeCzsYILiDry4QsFd+BhHjGqIgSfSa8JFyPjL5q0lK8gdzPZ5tpvusFCmrwiPTQ6nZ9nJkkvZiWWLe/57OIV1HBBWjcgz1iWK9Ow0pSGyXaO0deFj/zeZGOiTqERDWOupq4+F+rQPMVO1tRQBZ/4+9NpKCIAGPKsyb930oX0L7lJ7hnUN+XfEzfVJnOECCa+bybWYSWXT8V1TdbHFaklNnKCoIAu55jBAvsNQDmly9gstcTxOQyPSKU6fidtvMU/yQ7OcgMTjpOISidiRdt9hDY92RM23NrpdlUIRkuKcC47ei6dhCZ+B91lcsj0V/glJD2YNHgQ8EdfCW0wYlL4m1BqP6o4wR3w2nFq2/epBfcHOy0Z1ngaYzkyEmSEQBnPJj4IuZHCXBF50AW67WfsAeDQhDruJIw632cAEqK6WEElD8i8B6jd1Xqf8QEZvXM0ePzsBM/iDXSvRT5VLMXOuj3hGQf1hy3VFPy6ZhTVu5oUX2iiLrwkExEx+G8wKDyJigtRsV9CjzwEFoni2SLfOJHRf2w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9787d9-be24-4553-d151-08d7f2636e8f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:36.9127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4O8832rIOZpEGhWo9YELOAyOUyA1PHeZc9/WrtURbduvSQrTl0UO2O1mdhYEWqMyJtrWZrqUzy/U97AxIYwpw/hu4JI/p9egu5HjZ4Lj6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.8.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function has the only user: bdrv_co_block_status(). Inline it to
simplify reviewing of the following patches, which will finally drop
unallocated_blocks_are_zero field too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  1 -
 block.c               | 15 ---------------
 block/io.c            | 11 ++++++++---
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 8b62429aa4..931003a476 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -431,7 +431,6 @@ int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 int bdrv_has_zero_init_truncate(BlockDriverState *bs);
-bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 int bdrv_block_status(BlockDriverState *bs, int64_t offset,
                       int64_t bytes, int64_t *pnum, int64_t *map,
diff --git a/block.c b/block.c
index cf5c19b1db..0283fdecbc 100644
--- a/block.c
+++ b/block.c
@@ -5305,21 +5305,6 @@ int bdrv_has_zero_init_truncate(BlockDriverState *bs)
     return 0;
 }
 
-bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)
-{
-    BlockDriverInfo bdi;
-
-    if (bs->backing) {
-        return false;
-    }
-
-    if (bdrv_get_info(bs, &bdi) == 0) {
-        return bdi.unallocated_blocks_are_zero;
-    }
-
-    return false;
-}
-
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs)
 {
     if (!(bs->open_flags & BDRV_O_UNMAP)) {
diff --git a/block/io.c b/block/io.c
index a4f9714230..00e7371d50 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2386,15 +2386,20 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
     } else if (want_zero) {
-        if (bdrv_unallocated_blocks_are_zero(bs)) {
-            ret |= BDRV_BLOCK_ZERO;
-        } else if (bs->backing) {
+        if (bs->backing) {
             BlockDriverState *bs2 = bs->backing->bs;
             int64_t size2 = bdrv_getlength(bs2);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
             }
+        } else {
+            BlockDriverInfo bdi;
+            int ret2 = bdrv_get_info(bs, &bdi);
+
+            if (ret2 == 0 && bdi.unallocated_blocks_are_zero) {
+                ret |= BDRV_BLOCK_ZERO;
+            }
         }
     }
 
-- 
2.21.0


