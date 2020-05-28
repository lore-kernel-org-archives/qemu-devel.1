Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275D0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DEE208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jj5SbT4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DEE208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF8b-00063T-4g
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5a-0008UY-Vk; Thu, 28 May 2020 05:44:40 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5Z-0002k0-LJ; Thu, 28 May 2020 05:44:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haJXJc8jSVN/Ctlguio6DhXdv9VVtyLok5iFPft/ywFP+gvAYC4J3tC4kHMHn7fxsh0BSC0rIpEGlmRCnPo4gQzur6h+spjMnL4wOWi/OFjJgYE45XJ5o2Xm9DI9+XxQZkiY+ELf5B+6uwSB7wp/027jvD0TeBTHC7lvl5ral/BHLtZsKI12iB1XYuzGLEtJG0T05y//GyVsHOxaETzvP/I+p7o0vbak1KjsNkHw5rt1d/LaPqmyjIcT83MJ9uN5CVytzwLKuVoP6oOXwqFsMq/jG+nXGOcaBzMS3fuLdZdhY7U2/zPHNcY7jyWxPncz3EfcVjfSEIe+T58y/FbwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yccz3O5k943jonAMowBmqTccPbxV/xryPKKT4XoPbaY=;
 b=lrd9Lt6xb2euoYoUh+mRmLUShsCC9paeDrR5xBdd0PnaNF5yCYXQ8B384vsMPaPsK9V/wysX5lw9m4uYxzHbN7Ol4rkI/9tKzT9bf7bjMQEUdSTYI1txybZXN/9ZbXsDhRuBFqVQIJKaG17swbQ1Msu7geZRR3xGFAKCvWfeGv+KRx/Sa4p6+u1gigN69Z3X+ntn5biOqr9Q6pC31HAgtDNY+uo9Iwobxpz78lId54Op3uRwhpgigJrtjU3fzxmCOnn3NcHaxuxsVjIIHQXajCx1ocWwLdA5qBdtmkE19zXnx0SZXGkMKI9E6kabNu7XZRgkJkPcMDpQl17PDUU0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yccz3O5k943jonAMowBmqTccPbxV/xryPKKT4XoPbaY=;
 b=Jj5SbT4A7PG7y1y7elPaGaXu954aSMDpBarJXIQTstuIgpWtwjydJEj+z/fnUvlotjeP5LBFrOkMRfM+0qORCU9A+UxUUn2KtzGSFT2Wo3Eao3IJDbQYqzT7KTS/K5gA96L+u+5jylpXVPZrYOZRb6tAY/fmzd6AwgGMlAc4MTU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 09/10] block: drop unallocated_blocks_are_zero
Date: Thu, 28 May 2020 12:44:04 +0300
Message-Id: <20200528094405.145708-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528094405.145708-1-vsementsov@virtuozzo.com>
References: <20200528094405.145708-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:207:1::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.localdomain (185.215.60.178) by
 AM3PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:207:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:28 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddd06205-4a63-46ac-9f62-08d802ebb752
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53661E11F56BB1842B822F04C18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQ1QOpeI47QD+EF9w6gv1wG1AelhRY8xZ52b8M0Oem6uXHP4O9D+1+wjrWXRpRc0DIqXVMsgBMya1/nsX5IHJT+938utuPlRIPELzcifROVWQqOZBoyA4TlSvzX54MFTwUuU6i/Xxr3kacff+mnYAD887fIu3P4QukT1r0Jnr8uPyOgwsbUoznUwW1AX9nnin2KGSaPFvb7XvGI108rSZGUKsdHHJR0pr+2K7lFlOf7AqsHdCHPn8Tw8BuihRSkODR37tREgG9TivmMG7MN7G+i+wS33ishYsEfay8OxQK6by3xnadV7TIW6uzZLWoFGf4Mc2Lc5hqXY6IT6askXkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7ZRYpJXKPLYWe1wQQicoLKlMkdd/Tk7BdPCWB9RW5m8JB2ieuJO6xKnz3Se1Dpka675/bZBh6MH1CpR9zVJ5RVPX0cxRt+K07Qb5Bjroq7Qo+3nhZQ/XSN8u9RDTx8hRQKbeL9gpY8lHy9amhPdP1sqHIvr3mgXraXE4Ek2Fa11TSsS2nPMlTa+WsDGUIaSPGp3+C+R/j7BaCDF3/VwTn30qef/dJ5cdn640oQY07ZKQVnpwldjf915cJdJ3VtXhIBZ23H4tV2x9hDRutox6VFM/o8r6E5g2tnlqxy4C2n4M9+Drs/JMkpwexG0Uj40zbJsJDKofFr3dhTZNadqH2srxtT6iHkmeQkmkjCCuOsKlVCYE6WpnNH1JrPuOi8WZXhMt8AeWS51LgBpHMrg6xxecz2dAIEgIsw82JZv7aBacDdEX+ptQ43x8WAoJntBPzsQpITCI/fZnp7iusNzv2bvwxznskNbJINhl7t66kcY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd06205-4a63-46ac-9f62-08d802ebb752
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:29.1291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baXAGN4W8RX/9PuptongtuzDCdDYzTnMTH6q15+suQxGhr2SdcWQfHDwm43CKwo9O2bJIzanGm5ucm5WdeLsZwlZSYriWvVm5W5p39bqhGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.8.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:44:18
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ronniesahlberg@gmail.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently this field only set by qed and qcow2. But in fact, all
backing-supporting formats (parallels, qcow, qcow2, qed, vmdk) share
these semantics: on unallocated blocks, if there is no backing file they
just memset the buffer with zeroes.

So, document this behavior for .supports_backing and drop
.unallocated_blocks_are_zero

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h     |  5 -----
 include/block/block_int.h | 12 +++++++++++-
 block/io.c                |  9 ++-------
 block/qcow2.c             |  1 -
 block/qed.c               |  1 -
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 68699ebbfa..ceb9defb58 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -21,11 +21,6 @@ typedef struct BlockDriverInfo {
     /* offset at which the VM state can be saved (0 if not possible) */
     int64_t vm_state_offset;
     bool is_dirty;
-    /*
-     * True if unallocated blocks read back as zeroes. This is equivalent
-     * to the LBPRZ flag in the SCSI logical block provisioning page.
-     */
-    bool unallocated_blocks_are_zero;
     /*
      * True if this block driver only supports compressed writes
      */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 791de6a59c..faeeef1706 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -123,7 +123,17 @@ struct BlockDriver {
      */
     bool bdrv_needs_filename;
 
-    /* Set if a driver can support backing files */
+    /*
+     * Set if a driver can support backing files. This also implies the
+     * following semantics:
+     *
+     *  - Return status 0 of .bdrv_co_block_status means that corresponding
+     *    blocks are not allocated in this layer of backing-chain
+     *  - For such (unallocated) blocks, read will:
+     *    - fill buffer with zeros if there is no backing file
+     *    - read from the backing file otherwise, where the block layer
+     *      takes care of reading zeros beyond EOF if backing file is short
+     */
     bool supports_backing;
 
     /* For handling image reopen for split or non-split files */
diff --git a/block/io.c b/block/io.c
index 6f9507f718..ddcd533c5d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2386,7 +2386,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
-    } else if (want_zero) {
+    } else if (want_zero && bs->drv->supports_backing) {
         if (bs->backing) {
             BlockDriverState *bs2 = bs->backing->bs;
             int64_t size2 = bdrv_getlength(bs2);
@@ -2395,12 +2395,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
                 ret |= BDRV_BLOCK_ZERO;
             }
         } else {
-            BlockDriverInfo bdi;
-            int ret2 = bdrv_get_info(bs, &bdi);
-
-            if (ret2 == 0 && bdi.unallocated_blocks_are_zero) {
-                ret |= BDRV_BLOCK_ZERO;
-            }
+            ret |= BDRV_BLOCK_ZERO;
         }
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index dfab8d2f6c..72ed3bf305 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4973,7 +4973,6 @@ err:
 static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
-    bdi->unallocated_blocks_are_zero = true;
     bdi->cluster_size = s->cluster_size;
     bdi->vm_state_offset = qcow2_vm_state_offset(s);
     return 0;
diff --git a/block/qed.c b/block/qed.c
index c0c65015c7..a2dd952699 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1514,7 +1514,6 @@ static int bdrv_qed_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     memset(bdi, 0, sizeof(*bdi));
     bdi->cluster_size = s->header.cluster_size;
     bdi->is_dirty = s->header.features & QED_F_NEED_CHECK;
-    bdi->unallocated_blocks_are_zero = true;
     return 0;
 }
 
-- 
2.18.0


