Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B88AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3C720826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WDuq4s5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3C720826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHzj-0008Pc-0x
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHgb-0000dA-2d; Fri, 03 Jul 2020 05:08:45 -0400
Received: from mail-eopbgr140133.outbound.protection.outlook.com
 ([40.107.14.133]:62071 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHgY-0005Bb-RQ; Fri, 03 Jul 2020 05:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6oV9TfJmKS5dlum39DSXeTi8XhooOjPpgGe3PFBePmLKfHBWvqhHVa9pVBJQ/4MUN/75DjOONWrZ2zph+nJ9teWNbMnEUlfTS5418qeTiMqnMsFKREzA7HGK0COwzgsX+CW4eE4yI8c4HWDuLQFJCf6MJ/CPZHWtzXYRyzjrI67YnbVSFPsnFxeBJDVCvjcrk27ckVedcxzZlQ8yfvdGwCGX9N7uX2Nll8o/tgrc09c00VwQtnO6NrkjS+3PPe4It9LjqwVmFqpDFwEaufJBMQDk8i6dLSmB6yWoryeFmXY3jBpgV7wL4oa7pztG4+tkyunIcP/QYyKXm3U7gstQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gROxmM85WksCQt4OE9w7dTkzc0OSiFHd0QycJQzZFRs=;
 b=OFR2Yi8lKp+jyTnUv/eUEbImlvijpvbWu5AkyABfZ2eFMhjeEW+W7EXL9YhkotzAokHv4ucZmZFd7Ms5d5j9T7rTbVRtUTfrBoSGI7KbZcarsOsh9hv1dueLvr8j66hCi4yo4BdPGCZW1rLRhUIiACyH9zTXkUW+mddpwltmf08LnDj7lKnLwXUx0gYaE8zzFGY5Sx1MbGmxwhwckiNBCKNrehqePgIvrivYLOUntwMu1VOwGEapves3l69WHuP7uqsAtBg1y/fIf3a4LIx8RNg3br5M4duE2n26P393opr7q8V3o4Kcvq0BZwV9zG+q0wKBpC04O+lSvwcrc+rksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gROxmM85WksCQt4OE9w7dTkzc0OSiFHd0QycJQzZFRs=;
 b=WDuq4s5OzUDV97F7aq9Iui0JJ4qG1vBG1dl0g37wmj0evN7RyfE2sdXr12OZcRa7+gbfHor/WPk/ws3AvRgFP6+a8b8wA3TJsRgVs+nnioeLJng7jjHcUbADKLpHfRkrVubWrIjU3aqlrKp38DujzlsOMakrRV86p+nHJ2p55Z8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 09:08:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 09:08:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 4/8] pflash: introduce ERRP_AUTO_PROPAGATE
Date: Fri,  3 Jul 2020 12:08:12 +0300
Message-Id: <20200703090816.3295-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200703090816.3295-1-vsementsov@virtuozzo.com>
References: <20200703090816.3295-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.15) by
 AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Fri, 3 Jul 2020 09:08:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2a67fb6-d655-48c9-c280-08d81f30a9a0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54484363028505D9E6B03FDAC16A0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: si0oHt09K0nIEiUSrOzaOKJ0DrQjZPCOGUOm+ZX09F3UF+Clc3FcWQhv3yYcy/o/AR03LDXdcesFGpj40who9Dc9oyS+fgXsLtAAidLDRFXwb7t3keJrneVGbCvPJwAoUNoSISsb9rawKpIbSeLWS6uZJK7WkUY6E2+/MycgsQG+4MyV46r7fumYf7ykT4OEGHV4sgAqKLiFCcOfSlVx1iocQd5KIZevI/yxMi3hc4ZjnxToV8F88FxDG4BmClaKh4VJLpSAeUQWvxBDGMYdzaGJ2LKuK2EkUdUDQvrLa2l4MMbFSplxq6RTrZvgvzSR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(376002)(136003)(396003)(346002)(66946007)(66476007)(66556008)(2906002)(86362001)(1076003)(8676002)(83380400001)(6512007)(5660300002)(8936002)(6666004)(186003)(36756003)(4326008)(6506007)(16526019)(6486002)(6916009)(26005)(478600001)(956004)(52116002)(316002)(54906003)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Iof8IOAxVE8Yh2hSpJ0Y0Dp9FMViDODx6bkxCfw1yYO7aD+WTWpV59xe4bYGEKt3dqsQ1hfOk9/5qPsIKyb/W/36ci/328/eOZ3QZZ2o/m3PAzbF0Z4ZhQbE0lWnhmyNLVVvb/t//vOndl3cpQNdvp1vt5Nw7GA2cm9FUlKn1u3tVqMLDW3CKyEIFUtSPcNLxKRAcgA1DQ1VADog0PiyyFVV1uIhLihXvJEitfOuxaTzHzf99O4jYqQKIa/zKB3nEIigQm8zs7AkNv75HzA03f5Lod6BJvzTymYyHwOeKEhbV5VOx4nh8j7oF2GGcR+OVI92+ib9Mo140xFLR/+a+ZIKPbZXOInhUemdRBX8mIsWEZH/0gy19554SV8WPxy0Ein+zovh3m/13jrT9eZSZYWBu17ZrBOp3uwh3P2WoK0NQCYZ1dUGjcoBuGwhHaZ5Ya9WjZPuo5YuJML9lSQ748IoXTShtZMtRkJqXd+NhtE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a67fb6-d655-48c9-c280-08d81f30a9a0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 09:08:33.8985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiUlv3aL0sB5Gt3vubAHGT/JlSDR+mLxSMakxbBfExk431pIikrxLitpWMSokFdHb3bvaCCs5if9Br6jO1GEO9fbdcMQH+K8mKJkk4Em/ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.14.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:08:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, groug@kaod.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp == &error_fatal
(the program will exit prior to the error_append_hint() or
error_prepend() call).  Fix such cases.

If we want to check error after errp-function call, we need to
introduce local_err and then propagate it to errp. Instead, use
ERRP_AUTO_PROPAGATE macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
   &error_fatal, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

This commit is generated by command

    sed -n '/^Parallel NOR Flash devices$/,/^$/{s/^F: //p}' \
        MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 7 +++----
 hw/block/pflash_cfi02.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index cddc3a5a0c..859cfeae14 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -696,12 +696,12 @@ static const MemoryRegionOps pflash_cfi01_ops = {
 
 static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     PFlashCFI01 *pfl = PFLASH_CFI01(dev);
     uint64_t total_len;
     int ret;
     uint64_t blocks_per_device, sector_len_per_device, device_len;
     int num_devices;
-    Error *local_err = NULL;
 
     if (pfl->sector_len == 0) {
         error_setg(errp, "attribute \"sector-length\" not specified or zero.");
@@ -735,9 +735,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
         &pfl->mem, OBJECT(dev),
         &pflash_cfi01_ops,
         pfl,
-        pfl->name, total_len, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+        pfl->name, total_len, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index b40ce2335a..15035ee5ef 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -724,9 +724,9 @@ static const MemoryRegionOps pflash_cfi02_ops = {
 
 static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     PFlashCFI02 *pfl = PFLASH_CFI02(dev);
     int ret;
-    Error *local_err = NULL;
 
     if (pfl->uniform_sector_len == 0 && pfl->sector_len[0] == 0) {
         error_setg(errp, "attribute \"sector-length\" not specified or zero.");
@@ -792,9 +792,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
 
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
                                   &pflash_cfi02_ops, pfl, pfl->name,
-                                  pfl->chip_len, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                                  pfl->chip_len, errp);
+    if (*errp) {
         return;
     }
 
-- 
2.21.0


