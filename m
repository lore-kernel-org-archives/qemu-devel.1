Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78F1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6D820789
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vnf+mcya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6D820789
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTTQ-0007K6-4d
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGV-0003Qy-AB; Fri, 16 Oct 2020 13:11:39 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:42592 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGR-0007NG-1T; Fri, 16 Oct 2020 13:11:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrNKcAV7W1mw5oZdaBSpINlcyVRCh2X9mb1GuTGvNRZ3Kr/3cziuyZ+OmUu7B4I2HiXoqmT3iGcY6bzDmDjL6HzBqCCMNRaSUcG10qH0btv9RVxUjhCzBCNTLrZY9JdGb/hX/hvTNfZ/EUE0mAh+nJ4hGS0ilKrjHfqPE01p+bqz+UJAd7CHGNKEAALXyBiUXhBP0OPO9Ug07pu5Y5x1eZ2pOox96P9XT5PL2hUpPr/Il4eetEoDfYHLKXSNKawjvmxRhYEb9kzrwZahI1eWXg8H8glt/1f/TU2RIWoSXgSZDRF86D9D35jnutJXINoL/ZMnHy/zs0RNim8tJOQLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMy/mfhnyu0Cl+u89MxhZGZL0x6erq5dKOO20vhls1Q=;
 b=EKQG+H9I92XRNY0QMWZuyg7bY05CRD0YX7v+Ao6uZdE0nEUlA/CvkTXTnqGccl4StjRiNuyYwNQvqf0Tv0+s0Cb3oq2+IncmPhG7u+/44U5tTkeQ/li3y+SZNZbPeuO66mLzLdEiwaPIUOTRV7+dQblCK3yGz4aI2odx4J/4LeQtqQ1tGpn8N05U4BqqTpxHVDrEq8CJrhJzojT7UAPVtpT8hmtlPJHhsD3riFMU2x5BLmD4CTBoPF/6t53dcG2K2y1LG5tacuyqhajD3alvqUUowRHOLzcw4DgqV9FpYaATiZZR8v553G1Ji2oB+rrIFXT4535KmEXurRxsUgfMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMy/mfhnyu0Cl+u89MxhZGZL0x6erq5dKOO20vhls1Q=;
 b=vnf+mcyaL2A+ixIMgQ0fYFt7JoChHM2CWjDDAoa8xGaTLNio3qiTfF97iHFDLzZ/9taEF7Qakq0Hvu6bZZpxMAvipJlWiVNqWgCqcmwj+jgIWkeF9KEMFDxu6YkeL67daOtPuBR9Qz4aFXZSRpT9vITFxvYDTZPMS19PNRTjTGc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 17:11:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 10/13] block/qcow2-bitmap: return status from
 qcow2_store_persistent_dirty_bitmaps
Date: Fri, 16 Oct 2020 20:10:54 +0300
Message-Id: <20201016171057.6182-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016171057.6182-1-vsementsov@virtuozzo.com>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33686f66-75c1-4c08-f4f5-08d871f68188
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495B2AC8D5067F279E24372C1030@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:246;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGofrrqBr4g6f+Si1Noe4mC+kGb5xyut5WgXf05aHsk4MwnuEx97TlHrOYyXBpAYSFSa6Meq0OrVPLDQR5NOH5i13UrZ+0EfLE+iZ/r00W+Cb9qnBfSTYC2Fz2qdfgVGkYzkRdJUECo+wXry8ZFLK/OjKmge2oITC0dadT+jkqBIDlU1pboDsvCj/ydVd8NB/aRkrMC11hs23+RnOog/CrkZ1GnUj4mgh/Bfj0BUrYmO7oMgFLpDfCA3nCmfZBJHagr9cplc0HI1oO6JtNGBc1tOybbTJ2yI4FuQ3M9JuZ/Iq4/stPmXC0+LsmK5iJr3mrkVPrdzpqlvc6xkk2baBAIXsKGSuWb3pV1xBITod+goLJM03xwObogWpwajRw3S1FBv8AkJAUoU1o/fp/u6cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(66556008)(316002)(8936002)(36756003)(26005)(5660300002)(2616005)(6506007)(19627235002)(66946007)(86362001)(16526019)(7416002)(6916009)(66476007)(478600001)(34490700002)(6666004)(186003)(6486002)(2906002)(52116002)(956004)(83380400001)(1076003)(4326008)(8676002)(6512007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: P5FaPXi5iv37zZN9hyoe5dZyklEarI3an0gUn9VnTQR4adn9F2Xt+7Gf9dCfyhC2po9fQASvBu0EdL72ThDQcUw/PaLFrj5g8zIlbdxEU++Q3IXr4JMl46wtjPQhxgT0Dya1phP0SGvpImIP+2XN3COcVTa1maS4LXSaGqXdQGEDBjaQNOZ4Wt68M8nZFP9aq+RkrRR253/gI0oo20ki0nHtD/xeCYbAs0/LCGE72eipbVvuW8LnNk0/tdfJ18Tom+hY0bGeUgpV0+YLZoiA0JviA7ky01tNtGJ6XGsXBv9Se4LcTYhn2rdVeU1G+VRqRa2vbUF11mwAurV20bWzhtp4Xvi8y8PTIIqhZNrdBy1465uVN0jyTyf2+Pfw4Wh3BjVAOmsWYWeebM1WrXZ+gFd8kVSV37uuswFtEnZOdX0jUa2kdvq5tpg+HPu4V0rD73fxgiRcYpNYYru3KM9sZB9ovCHWh6em3XKHWDUp99jNoOlB5S7v1blNPWPgyclYg9j5Pg+ukEWHzkknBnYCNkJc2/puN7CfPYRzGZ7IHAb8dCGjsQbyLA2LPB/f/HFTt4ihyUmeAOWeVSQk/uv5KItM+eD66Gk/x3CoMKXQZ2ZPe1qcdg9jLMBhyeC+ZfW8vinuzARVGtHWCfc/muH4rA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33686f66-75c1-4c08-f4f5-08d871f68188
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:22.3508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxmP2Nhd8RkBFk9C5ow+WBvW8azfSH9Sh++ya3xZzkM7/oc+TwZ2WkY0cjI86PFrmsYqLZJoEzO/DEZu5AxbuzlFrYFPdAbzLfER4Iib2lQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's better to return status together with setting errp. It makes
possible to avoid error propagation.

While being here, put ERRP_GUARD() to fix error_prepend(errp, ...)
usage inside qcow2_store_persistent_dirty_bitmaps() (see the comment
above ERRP_GUARD() definition in include/qapi/error.h)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h        |  2 +-
 block/qcow2-bitmap.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 4c994739ed..467cfd4779 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -981,7 +981,7 @@ bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                 Qcow2BitmapInfoList **info_list, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
                                           bool release_stored, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index ca01f08bac..9eccaab7f8 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1536,9 +1536,10 @@ out:
  * readonly to begin with, and whether we opened directly or reopened to that
  * state shouldn't matter for the state we get afterward.
  */
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
                                           bool release_stored, Error **errp)
 {
+    ERRP_GUARD();
     BdrvDirtyBitmap *bitmap;
     BDRVQcow2State *s = bs->opaque;
     uint32_t new_nb_bitmaps = s->nb_bitmaps;
@@ -1558,7 +1559,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
         bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
                                    s->bitmap_directory_size, errp);
         if (bm_list == NULL) {
-            return;
+            return false;
         }
     }
 
@@ -1673,7 +1674,7 @@ success:
     }
 
     bitmap_list_free(bm_list);
-    return;
+    return true;
 
 fail:
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
@@ -1691,16 +1692,14 @@ fail:
     }
 
     bitmap_list_free(bm_list);
+    return false;
 }
 
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
-    Error *local_err = NULL;
 
-    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    if (!qcow2_store_persistent_dirty_bitmaps(bs, false, errp)) {
         return -EINVAL;
     }
 
-- 
2.21.3


