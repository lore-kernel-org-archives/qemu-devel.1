Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5562AC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D54206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG9D6EGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D54206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwrc-0000xt-7X
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMD-00058S-Um; Thu, 03 Sep 2020 17:01:21 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c]:34353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMC-0007ub-6O; Thu, 03 Sep 2020 17:01:21 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id k63so1135379oob.1;
 Thu, 03 Sep 2020 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5RZT5c65N2inveAD4NSJ6yvBuDinvqkRBIn47Uw8RQo=;
 b=ZG9D6EGedpXkdaf31lj8tC4UHFbfFpmjul3uBFpfcF8LrbxsUPFymoFEmbjnfUsQ2+
 Yx72FovkqHoaAZpPcqfAsC9TaLlB/ERke+kEbmB7sKpMnoHMINBiZd+BHGkC2fD1Zy9K
 ZKVMIWGhXB+QjH28SlA9FwHGmUMav5iDpib5YgXR7f8qftzw/sIsSgxoSXrHmX1Wt5u/
 NKt3P9y13p7BQzEcGEKfi56CEE/kswPzr8lmg3k4m0r7x1XsH4rEsw2VmdHkjlnqSCNx
 g18y1mOSAXIJwCGgS6hCwozdcaWGItxFdw+QHrUzrzFWOgQ7wn7ZeubZQYjMxBLmfYNF
 qVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=5RZT5c65N2inveAD4NSJ6yvBuDinvqkRBIn47Uw8RQo=;
 b=W1s/sgY/7p/lFxUbI8XxkuHShVxyfw8mf/qU0v6uf1nV+LXwMyv+gTgggryrqbSrmw
 4ogynOltb9sfxvIeveHYlFsbomDmml/ffskXZTx/J/g4+Zr0QrrRy/W/Kge5OHJ29Fh6
 Mpzp2juPqfkYAiGDcA+I/T52011z7VuqGJvpBZjB0y+LYqlwQX0SVutPUPh94YGnD1Ba
 zyZVEAdY29qwi2oOa3WF4fgkN07Dw9fueyoLbG+vHu/rSwwGCHUT0rCVZCCBx2AWfmJH
 syf/vkin9Urv2NwgkLloLwTt15BOfH7DzT6sFMSOFb/gAtHE+pnn8nBws6/3eRDnS6rT
 Tqgg==
X-Gm-Message-State: AOAM532+CPSHVadVRuSkXi5DNkBCzdb3JFtVj99eVlqHqG/h08OrNsfh
 7/ecbtATq2vY4Qw3R4SLgDUptBcYimmZdQ==
X-Google-Smtp-Source: ABdhPJzQQpluC1Y8YtuCuohjg3rsagUO4s8i7H/fF1RNw5sgUKz4eFbQrCdNaFwjJlsmmZ5mK0Z77w==
X-Received: by 2002:a4a:5a06:: with SMTP id v6mr3367008ooa.22.1599166878534;
 Thu, 03 Sep 2020 14:01:18 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id v35sm763916otb.32.2020.09.03.14.01.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:17 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 71/77] migration/block-dirty-bitmap: fix
 dirty_bitmap_mig_before_vm_start
Date: Thu,  3 Sep 2020 15:59:29 -0500
Message-Id: <20200903205935.27832-72-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc2c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Using the _locked version of bdrv_enable_dirty_bitmap to bypass locking
is wrong as we do not already own the mutex.  Moreover, the adjacent
call to bdrv_dirty_bitmap_enable_successor grabs the mutex.

Fixes: 58f72b965e9e1q
Cc: qemu-stable@nongnu.org # v3.0
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727194236.19551-8-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit e6ce5e92248be5547daaee3eb6cd226e9820cf7b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 migration/block-dirty-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7eafface61..16f1793ee3 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -498,7 +498,7 @@ void dirty_bitmap_mig_before_vm_start(void)
         DirtyBitmapLoadBitmapState *b = item->data;
 
         if (b->migrated) {
-            bdrv_enable_dirty_bitmap_locked(b->bitmap);
+            bdrv_enable_dirty_bitmap(b->bitmap);
         } else {
             bdrv_dirty_bitmap_enable_successor(b->bitmap);
         }
-- 
2.17.1


