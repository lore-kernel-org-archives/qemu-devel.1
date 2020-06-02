Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39028C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0683C206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjHXT5b+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0683C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1a4-0005Jn-5z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <morecache@gmail.com>)
 id 1jg1ZB-0003lZ-9j
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:42:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <morecache@gmail.com>)
 id 1jg1ZA-0000Ym-LY
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:42:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so2269927wrr.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bFt0WsKi9YCNdM7hkyu3tuuPZYw4VooHNM+xovmMUSU=;
 b=UjHXT5b+mAHucrJN+ZcFcwlt4a7/rA+EDtXusPHC+3wo7dFu0POHseQ/H2tSunibjN
 eg6As0H9nuVDoyV6r2L0lx69QjH/mC87krqnX4yMN2YU/688/F8hVL17UJdH8C8zO5NO
 DTvZTClUy1Lw+Af0bI++6Zpxelkm8Z+YXQQgAEkWV/Ij7lKU16ls6/Yh10ge+qU9IjhF
 g5x+3fbZq25ChZNqGN8C1JV456pfzIaDpFaQExtMFASuw7yUCrNJIB2h6d0OA9Nps+VZ
 0ma2bmy9F55JEE78QnIQq2thqOGOnlBqUjNUDZJlWZ7/YyuTd12cAbwgWRvbM12P/mx0
 /5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bFt0WsKi9YCNdM7hkyu3tuuPZYw4VooHNM+xovmMUSU=;
 b=Irjf4pJFYbrDcQKYigU5rHWo9gi3Rlv2Afg2F3pcRE7uIFFIujWN7hxo0+3+ppPKL2
 eC1xbsSJfRpucJz21ouSC5x/tRAIV8RoVmt3PdKSq3oiCIuNM4/71rf2BNQzh0SntO41
 VmhLphLHBqQ+A4T1IbYTHLwbdGWUun0uaebX7bXkSjX9H6YtIQJNQmSl5hOVHHG3j5GQ
 c6iCW4NA+Emd4+Qol+6hLmgKWBsPBDzYMIegOK+UUwV6UGCXHpc3N0ppRcO2dTWsArHJ
 3TSryPCCe2HzDqg48Nu7kf795kBulAVNfXHrvZG7fGiDgC8bi69WB7be5cgSJzBSvo3S
 MbrQ==
X-Gm-Message-State: AOAM5324mg2R1b6RTRRYrGZbpeb6+yFTTRWxYCcH++X7mBIfklaeM4U3
 SPEjz5D+xSEypFzx2K8Pj5OOLz+jZwE=
X-Google-Smtp-Source: ABdhPJxicM6rpPP9PklDqcsi02NSQb1Yq9AysFhDVJeVZg4YJVUxyEu056EqBOTCBgwNAIRJ/vZOdw==
X-Received: by 2002:adf:f389:: with SMTP id m9mr23676786wro.195.1591083751265; 
 Tue, 02 Jun 2020 00:42:31 -0700 (PDT)
Received: from t440p.suse.asia (60-251-47-115.HINET-IP.hinet.net.
 [60.251.47.115])
 by smtp.gmail.com with ESMTPSA id w3sm2294518wmg.44.2020.06.02.00.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 00:42:30 -0700 (PDT)
From: Lin Ma <lma@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] block: Add bdrv_co_get_lba_status
Date: Tue,  2 Jun 2020 15:41:58 +0800
Message-Id: <20200602074201.10879-2-lma@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200602074201.10879-1-lma@suse.com>
References: <20200602074201.10879-1-lma@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=morecache@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: pbonzini@redhat.com, stefanha@redhat.com, Lin Ma <lma@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The get lba status wrapper based on the bdrv_block_status. The following
patches will add GET LBA STATUS 16 support for scsi emulation layer.

Signed-off-by: Lin Ma <lma@suse.com>
---
 block/io.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/block/io.c b/block/io.c
index 121ce17a49..dacc3c2471 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2186,6 +2186,49 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
                            BDRV_REQ_ZERO_WRITE | flags);
 }
 
+int coroutine_fn
+bdrv_co_get_lba_status(BdrvChild *child, int64_t offset, int64_t bytes,
+                       uint32_t *num_blocks, uint32_t *is_deallocated)
+{
+    BlockDriverState *bs = child->bs;
+    int ret;
+    int64_t target_size, count = 0;
+    bool first = true;
+    uint8_t wanted_bit1 = 0;
+
+    target_size = bdrv_getlength(bs);
+    if (target_size < 0) {
+        return -EIO;
+    }
+
+    if (offset < 0 || bytes < 0) {
+        return -EIO;
+    }
+
+    for ( ; offset <= target_size - bytes; offset += count) {
+        ret = bdrv_block_status(bs, offset, bytes, &count, NULL, NULL);
+        if (ret < 0) {
+            goto out;
+        }
+        if (first) {
+            if (ret & BDRV_BLOCK_ZERO) {
+                wanted_bit1 = BDRV_BLOCK_ZERO >> 1;;
+                *is_deallocated = 1;
+            } else {
+                wanted_bit1 = 0;
+            }
+            first = false;
+        }
+        if ((ret & BDRV_BLOCK_ZERO) >> 1 == wanted_bit1) {
+            (*num_blocks)++;
+        } else {
+            break;
+        }
+    }
+out:
+    return ret;
+}
+
 /*
  * Flush ALL BDSes regardless of if they are reachable via a BlkBackend or not.
  */
-- 
2.24.0


