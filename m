Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55780C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C644208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPrqy5cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C644208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCWF-0004PG-84
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPK-0001OE-H6; Tue, 16 Jun 2020 10:17:46 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPJ-0006Yf-04; Tue, 16 Jun 2020 10:17:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id t6so16019270otk.9;
 Tue, 16 Jun 2020 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dMAfRKU6ZrmfHJJ6NFU2O1ZIHPVnAPeYIVisRHhIKSo=;
 b=dPrqy5cmgqkFGiQG0KkGp8VfQFtMmmSou/XG7IiWa4JQbqi3uTD8uDdCE+rCNSfZkW
 My6FhS3rAKb95Xv/R+6lp1ZVNc3hHF3EHLGtB8eHOQ+Nx5YQ29ETDcNdX73B8iVhSm99
 vkoxrmEfKXpYE6MZLP4XjtC7ni96aq8xzUNtz62e9LU5g+AgIhUDv98b9Q9h5PK2tGVg
 0s2A78Y/MCXdh2oHdZFRmK5+GfRBenT6UQ9D5eZ3jsip+vYJlqKfnToJqTrv9BpHczhW
 +dsLf+c573RiNKKVydqb1iHYxvz4qYvVXincLdRUatQLqXAW+9g3plM2L7b82B3ryyKQ
 YIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=dMAfRKU6ZrmfHJJ6NFU2O1ZIHPVnAPeYIVisRHhIKSo=;
 b=lEOzOfZt0abx18cAZWl6GbXpwpeRJyNUIa5glmSJ0rT6v38wZMu1tmHq9TnCBQofxN
 IHAZjb84UpE97OvPp3eJmjnVItdbGW2zTXraWC4dyLHDzMum4VxvrhdwjVdm1zC7CLGd
 yKTHcqt2XvSjWScOzS8mg3UhDK7twGyMGKTdjYgh4rHkY71gVGFp0KSsAfY4/HnFuPJp
 T6sK71dpQ0vPg5nn9RmylP9RgGnwy67T4TgstjSjBbY+ToHwFagVbN5C7CwRHqhZaa1s
 +/XMO3+tKYCPfNURXu/ywHmMzIFcgqPPbsJPG8ixwhZjnhJs9rIzkTY4w/TFbKcFZeOD
 QWew==
X-Gm-Message-State: AOAM533PrKigZqSZz+wzI6BrdOuSTDgL1hLpPygiiAKEYLOKaCm7ok2o
 Sctniw/p2zkyxHfihuC/xCiEb1si
X-Google-Smtp-Source: ABdhPJw2DgVkrr9fUCpm1xZeHfL7DxNaacR+wGpHeBreNnujfPlxmexowp4agB1Erij1vp5A+lUGsw==
X-Received: by 2002:a05:6830:1001:: with SMTP id
 a1mr2665125otp.94.1592317063048; 
 Tue, 16 Jun 2020 07:17:43 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id r10sm3649071ooh.20.2020.06.16.07.17.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:41 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/78] ide: Fix incorrect handling of some PRDTs in
 ide_dma_cb()
Date: Tue, 16 Jun 2020 09:14:44 -0500
Message-Id: <20200616141547.24664-16-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org,
 Alexander Popov <alex.popov@linux.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Popov <alex.popov@linux.com>

The commit a718978ed58a from July 2015 introduced the assertion which
implies that the size of successful DMA transfers handled in ide_dma_cb()
should be multiple of 512 (the size of a sector). But guest systems can
initiate DMA transfers that don't fit this requirement.

For fixing that let's check the number of bytes prepared for the transfer
by the prepare_buf() handler. The code in ide_dma_cb() must behave
according to the Programming Interface for Bus Master IDE Controller
(Revision 1.0 5/16/94):
1. If PRDs specified a smaller size than the IDE transfer
   size, then the Interrupt and Active bits in the Controller
   status register are not set (Error Condition).
2. If the size of the physical memory regions was equal to
   the IDE device transfer size, the Interrupt bit in the
   Controller status register is set to 1, Active bit is set to 0.
3. If PRDs specified a larger size than the IDE transfer size,
   the Interrupt and Active bits in the Controller status register
   are both set to 1.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20191223175117.508990-2-alex.popov@linux.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit ed78352a59ea7acf7520d4d47a96b9911bae7fc3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ide/core.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 754ff4dc34..80000eb766 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -849,6 +849,7 @@ static void ide_dma_cb(void *opaque, int ret)
     int64_t sector_num;
     uint64_t offset;
     bool stay_active = false;
+    int32_t prep_size = 0;
 
     if (ret == -EINVAL) {
         ide_dma_error(s);
@@ -863,13 +864,15 @@ static void ide_dma_cb(void *opaque, int ret)
         }
     }
 
-    n = s->io_buffer_size >> 9;
-    if (n > s->nsector) {
-        /* The PRDs were longer than needed for this request. Shorten them so
-         * we don't get a negative remainder. The Active bit must remain set
-         * after the request completes. */
+    if (s->io_buffer_size > s->nsector * 512) {
+        /*
+         * The PRDs were longer than needed for this request.
+         * The Active bit must remain set after the request completes.
+         */
         n = s->nsector;
         stay_active = true;
+    } else {
+        n = s->io_buffer_size >> 9;
     }
 
     sector_num = ide_get_sector(s);
@@ -892,9 +895,20 @@ static void ide_dma_cb(void *opaque, int ret)
     n = s->nsector;
     s->io_buffer_index = 0;
     s->io_buffer_size = n * 512;
-    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < 512) {
-        /* The PRDs were too short. Reset the Active bit, but don't raise an
-         * interrupt. */
+    prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
+    /* prepare_buf() must succeed and respect the limit */
+    assert(prep_size >= 0 && prep_size <= n * 512);
+
+    /*
+     * Now prep_size stores the number of bytes in the sglist, and
+     * s->io_buffer_size stores the number of bytes described by the PRDs.
+     */
+
+    if (prep_size < n * 512) {
+        /*
+         * The PRDs are too short for this request. Error condition!
+         * Reset the Active bit and don't raise the interrupt.
+         */
         s->status = READY_STAT | SEEK_STAT;
         dma_buf_commit(s, 0);
         goto eot;
-- 
2.17.1


