Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAAB20679
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+3wTBEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAAB20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCyd-0001e9-Fg
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCR5-0004S6-Vv; Tue, 16 Jun 2020 10:19:36 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCR4-00072K-7f; Tue, 16 Jun 2020 10:19:35 -0400
Received: by mail-oi1-x243.google.com with SMTP id s21so19372297oic.9;
 Tue, 16 Jun 2020 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JE04LHO3R8Lv6V+Ze+GWJq1aq7ZP3I/hJjdZ+OxJue8=;
 b=F+3wTBEvoXTt/wdDR76fgrPOZScw0efLIMjPtyUnJelkf4EPiMipI86riVFa0GFrZ5
 2uQ+PI+/oz4GgJMBloBMzXuH61sGOOd5E9uxfBS8BfFQ5Ml44y4JJ47cPybitqGyU95T
 VRa2pKn3TgS28YErJo39LAcfw2XTAuudV5GZB6E/mgh3Lh691SaOfnYSUzk4RF7ZgNLt
 T3t3DVEs4nWQFj0o15WHShJgof/z8xzyUOKXfLXwJlIYAmRT3iRHKLVhPfa2rTBWNbk1
 vyAGsg34ZzzP0bAE9VhSuTUX9opfxkuGe+pRWDymIvi0IWD2Sj46AvO8Orw87dGa9SLI
 XsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=JE04LHO3R8Lv6V+Ze+GWJq1aq7ZP3I/hJjdZ+OxJue8=;
 b=dliDscswLghbrcRjZmaR4/bW1Zddkk1mkdLuC/n9WpxoiyuFF0JzVCN5kJLwFXTBBU
 RIDVLkqvEJ9Sm7eMc11a737/BBadSUBZxQpHTNqetJh7kLUsPvwurPOD2ydJla1lK7Zu
 kVbZgOW3gJnCaAY4NZWsHTAWxHDhfW8cu/g/2n1ICf3UPBSNeTun/zIeN3E6CDNYpu0z
 9DpWxqM7nQUnEu576BooDmX0XDlvHXOIAWAOYGIRuAE7Ye/XJgiU/KYCZnnVBx8AAdfK
 YbNWzqZhMTqdr8elNyKbfDHDWVcifzXZE9IeqnnIAZ+j9+PVeJq/CchmkLKvoGV5LQeO
 vGlQ==
X-Gm-Message-State: AOAM5331OtMfPztpYvHr0EVVdIVew9iEu9ZZsij1gK3uTp0thxPvvq62
 jFoMpoZ1AN6DXbNuHrWStmnlTyr/oOQ=
X-Google-Smtp-Source: ABdhPJwEAHpHpImMWMBqmsF7fRgZqunbZfEmp+7TWHNpFDjxcC8HP9dnYADlwbf9QBoXH7sRMRXqxw==
X-Received: by 2002:a05:6808:8e2:: with SMTP id
 d2mr3350787oic.131.1592317172226; 
 Tue, 16 Jun 2020 07:19:32 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id j2sm4207324oiw.24.2020.06.16.07.19.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:31 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/78] block: Activate recursively even for already active
 nodes
Date: Tue, 16 Jun 2020 09:14:35 -0500
Message-Id: <20200616141547.24664-7-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

bdrv_invalidate_cache_all() assumes that all nodes in a given subtree
are either active or inactive when it starts. Therefore, as soon as it
arrives at an already active node, it stops.

However, this assumption is wrong. For example, it's possible to take a
snapshot of an inactive node, which results in an active overlay over an
inactive backing file. The active overlay is probably also the root node
of an inactive BlockBackend (blk->disable_perm == true).

In this case, bdrv_invalidate_cache_all() does not need to do anything
to activate the overlay node, but it still needs to recurse into the
children and the parents to make sure that after returning success,
really everything is activated.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 7bb4941ace471fc7dd6ded4749b95b9622baa6ed)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/block.c b/block.c
index 473eb6eeaa..2e5e8b639a 100644
--- a/block.c
+++ b/block.c
@@ -5335,10 +5335,6 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         return;
     }
 
-    if (!(bs->open_flags & BDRV_O_INACTIVE)) {
-        return;
-    }
-
     QLIST_FOREACH(child, &bs->children, next) {
         bdrv_co_invalidate_cache(child->bs, &local_err);
         if (local_err) {
@@ -5360,34 +5356,36 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
      * just keep the extended permissions for the next time that an activation
      * of the image is tried.
      */
-    bs->open_flags &= ~BDRV_O_INACTIVE;
-    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &local_err);
-    if (ret < 0) {
-        bs->open_flags |= BDRV_O_INACTIVE;
-        error_propagate(errp, local_err);
-        return;
-    }
-    bdrv_set_perm(bs, perm, shared_perm);
-
-    if (bs->drv->bdrv_co_invalidate_cache) {
-        bs->drv->bdrv_co_invalidate_cache(bs, &local_err);
-        if (local_err) {
+    if (bs->open_flags & BDRV_O_INACTIVE) {
+        bs->open_flags &= ~BDRV_O_INACTIVE;
+        bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
+        ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &local_err);
+        if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
             error_propagate(errp, local_err);
             return;
         }
-    }
+        bdrv_set_perm(bs, perm, shared_perm);
 
-    FOR_EACH_DIRTY_BITMAP(bs, bm) {
-        bdrv_dirty_bitmap_skip_store(bm, false);
-    }
+        if (bs->drv->bdrv_co_invalidate_cache) {
+            bs->drv->bdrv_co_invalidate_cache(bs, &local_err);
+            if (local_err) {
+                bs->open_flags |= BDRV_O_INACTIVE;
+                error_propagate(errp, local_err);
+                return;
+            }
+        }
 
-    ret = refresh_total_sectors(bs, bs->total_sectors);
-    if (ret < 0) {
-        bs->open_flags |= BDRV_O_INACTIVE;
-        error_setg_errno(errp, -ret, "Could not refresh total sector count");
-        return;
+        FOR_EACH_DIRTY_BITMAP(bs, bm) {
+            bdrv_dirty_bitmap_skip_store(bm, false);
+        }
+
+        ret = refresh_total_sectors(bs, bs->total_sectors);
+        if (ret < 0) {
+            bs->open_flags |= BDRV_O_INACTIVE;
+            error_setg_errno(errp, -ret, "Could not refresh total sector count");
+            return;
+        }
     }
 
     QLIST_FOREACH(parent, &bs->parents, next_parent) {
-- 
2.17.1


