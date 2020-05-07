Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511BDC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1892E2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IVrfCsqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1892E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcHY-0001SV-6b
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDK-00026D-6D; Thu, 07 May 2020 04:49:06 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:2308 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDJ-0006ET-4r; Thu, 07 May 2020 04:49:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6pmF64j7uHEuEEEBMBPRsh3XGO43FA2YZyC/SBt5SfysVLQ/MK+2jojedAuzZ6P8Ovil/i3g62vZMRjvI5Ypbss+nCmX+nt7DENKI3PkyphFENjfOy59hshEJioursrfjkBP27pdChFGlP2y+Xf6PRbfEKgrwt/tIx6Ol32aSa+RMvd7Ee8U+G1MyN+RIyKfHzS6be+weM1eDPBJYHe3Bxhs7SLOhmSVYIlTY/phRvB1txAjx1mL4OZT9/zOGe3p3rjniO6/Azuk34qQVtvcTA3uorxc/6bPn+zKUlOz/iAerOZYdyndDaNwlDkc0Lf+dkwKaOqgLOWFQGd6TWTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn/VD7SGrYD9isyxJr+qPCOSGyJdWiVJSY29xgLanPk=;
 b=Fk6TPV+WiPV+QvIXMyaPEb/iYNiVB48z5Ut6vPW1Vrr7np0kFM+FMDZnG0NONxE9Vu9YahgUBpHrHYJk5FHgST+SMR5Uq5PYiyKnuK2Ta45NF4qqPDSKrVO8rNmXZxMCN7lQP3xwznAoK0s246yYFPrEZC4Told/upFeMtZy/jQRagFLW9rgx3bDOBOj8EJcTeDoDt76UWzO6MYxCp0zfg3kdlbCTj9oLuSOFBXuTKkx9ZWt7q3lNwQmxZYBId4NtoHMQZC8cuihFX13WttwGE09jRya7b5CNN5yyBj2lTMOAaUxe2K+aOHKu7YtpXA2hIr6mJmIvvQx4JigPbaX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn/VD7SGrYD9isyxJr+qPCOSGyJdWiVJSY29xgLanPk=;
 b=IVrfCsqVBTdTOF9LTfhjtSRHFVyCFA6zXJr2+blDVo+M+vErpw+MAd6KGEEPfR+gwqIYtmK+H5/CqAJHK3U0bWYzAEISq24VLSbJwHBCwwABxu4Jf3LUpqjF9WSl4sBfGqP8Lu7d30U17MoV3CE8b5UYw2+NxiafvFaoRd7HMTM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 9/9] block: drop unallocated_blocks_are_zero
Date: Thu,  7 May 2020 11:48:00 +0300
Message-Id: <20200507084800.20596-10-vsementsov@virtuozzo.com>
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
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:43 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ffff44-3b0b-43eb-f2a5-08d7f2637330
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54958463528EE0DCE6E51CA6C1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIhS0CMUsznp6sgxyExV7gPz/tMhgh1oJlcF/wAP0CTi4c5XBHJkuVAFnpw5wzaYVGFCcag9KVGV3H3NWK4XOnxRt1owEsNbrvavoRSaeFB5PyfB6IP2B5JtwfnSu7JbFkYCliA/3p/lhCYJ3LUjCQ0tDTqyv5ScjoOANiJehzdoxpdPhR84rnORSI4yp6dgoM+xfL/amL2OpHQ8712YVqHVuS/iimTbiz2ApjPEoPTEcGvh5/MzD4WPc9rSmv4CMaeKRDFwdX8Zptrvu1BtTMl7qCyiIu3mODaotRgOOTI6m1yJWQzV/wFL4sgPM4auZZ9lBvMkWPnXHap2hwYC8sLSPARDubT/gn8ffxEGEE5CTe3QGeJ7N96Kuy35257w/42KOhC52wUlYOBFHJqD8o2KS4SmRrLuln5ndwvMyjOYLkPUcD+/GYqK6tZLLBftcJKSC4d+ogA6H855a2GCe7G98NiQOPedIN2cSz9cE7BzBHrqvbyXsqR1GakaeJJR6K43X6vq9SYjK5xkWjHsRd+qw5MvVUAQ1/cJLOiOibQGu7gfPaXCawqq1Su53In0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(107886003)(66476007)(66946007)(66556008)(5660300002)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rXTvLwBxwv677CGecbRAtwyaMABTZD1jFtTr2HTkVZF2jloOXS0OXdVvmfgfUnGuu4aJ4ETKJr+Vd0cYt1v5Y3O4NsO1zh7iFDJtUKQGEdi3pjRhEB1AwYHoa1ACOGZFQmCSyW+OLQpkAtFHVWy23E6jXXRyLVirOuHxccUJo2dEsYwtv+8CZUxiepaz9uv7uECUOxDIR/iu5hVMMNAI28pvUY4SjwyjMkFIbtL2N1Cxsb/4I3eBDzxX7fWAit3G7uzWa0zbU5XIGFChOHdVHhw8mrCI00qXcmnI/TZQMBrqgJoYalQbDRm/4mOARenBpxVg5qRuRX2RBAanj6NULsuQ4+UqXjXOyl4dSrMf2LzcZQqrjtQ46T9irOa+MtOzkZn2XvufQqg+GYbUBzZSFdtoqM88bwhuXD6hpBB/RLqLnIB/zD90BJ6H13rZrM5XsF8ZUiIWiqsSPyz6+T1Ka4jKWsTngoKdo4gkoZDd/s8g4ND0QLqQxrVkclPnT0LmOLs7c+luIzmtiQiK48Hy9KmtWvJZkvf6Y7C1nYDqhIkhkEcrQKZdZk/hDYKC8Yrx1Ygry6la3UKj73NH8++abSHe6QkJLaXR6aZWrDsnalbhgi0SFGH8qXWQmq60IHgOiG7A6oZO/AzUiJv0mnxAb6jjdehElspHIfSrNUcLdtv1FpOiru63siZ/c+nLoxW6spkRM3sEN9UwTDaRWK7nlijypPKbLZSv3DcD6PHyhH4QVuZKJTZjy5H2jkQ2pPkQSFF6GANSrOxDttgAE14j0sMJulje4klRzxkWAfrVYLQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ffff44-3b0b-43eb-f2a5-08d7f2637330
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:44.6905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Mqd1F2d3sEk5tL4I6K/S6Oxdf+tfOPWUrvI878BOcijcL/SWzrp+gA6NDqsqNY1DaPpt59R+JedmIfw4mGP1jy7xhVL3hRGf6G538mg9AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.4.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:35
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

Currently this field only set by qed and qcow2. But in fact, all
backing-supporting formats (parallels, qcow, qcow2, qed, vmdk) share
these semantics: on unallocated blocks, if there is no backing file they
just memset the buffer with zeroes.

So, document this behavior for .supports_backing and drop
.unallocated_blocks_are_zero

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h     |  5 -----
 include/block/block_int.h | 12 +++++++++++-
 block/io.c                |  9 ++-------
 block/qcow2.c             |  1 -
 block/qed.c               |  1 -
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 931003a476..db1cb503ec 100644
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
index 92335f33c7..8fac6c3ce2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -115,7 +115,17 @@ struct BlockDriver {
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
index 00e7371d50..484adec5a1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2385,7 +2385,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
-    } else if (want_zero) {
+    } else if (want_zero && bs->drv->supports_backing) {
         if (bs->backing) {
             BlockDriverState *bs2 = bs->backing->bs;
             int64_t size2 = bdrv_getlength(bs2);
@@ -2394,12 +2394,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
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
index 2ba0b17c39..dc3c0aac2b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4858,7 +4858,6 @@ err:
 static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
-    bdi->unallocated_blocks_are_zero = true;
     bdi->cluster_size = s->cluster_size;
     bdi->vm_state_offset = qcow2_vm_state_offset(s);
     return 0;
diff --git a/block/qed.c b/block/qed.c
index b0fdb8f565..fb7833dc8b 100644
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
2.21.0


