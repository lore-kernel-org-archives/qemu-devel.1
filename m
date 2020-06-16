Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5568E20882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRar0dNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5568E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCko-0006J5-G4
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPp-0002BH-3I; Tue, 16 Jun 2020 10:18:17 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPn-0006fk-Ai; Tue, 16 Jun 2020 10:18:16 -0400
Received: by mail-ot1-x342.google.com with SMTP id n70so16044260ota.5;
 Tue, 16 Jun 2020 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wJrYjqEEa3ZXREtHH6UNEd/DSW1JqxV2SjbmLwmSWHM=;
 b=GRar0dNLDEOV6q5B8UlO4NwB3uVEo5W8/HYWua50zwAO/EQdA+hvZZz3l21XgThdQD
 d6eSXCRrRlMWq+O7vD0nUoBKQM0gxdCajI1ZURAbEP0J+YWzVc31b+bJ0KMryYARBJoA
 WS3hggoUqkjDuWedNCX9J4GGbiED5vmxfWbzaaANn2KrARXLAiZmKB2/HJFDkYpCZ0dQ
 zjsD5eCyAHdDXoP4eLHjVaY9ZBLgcWywrw1c3UqjIoy1ShyJA3KzJZZH0yYGQNvaBgeD
 3vV9pkJOarzeWbSVW4u8K5VYR75he8BVeR8pyo5PsRnJ5wfQtIo3JHLguW0JNxc2iAn0
 b+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wJrYjqEEa3ZXREtHH6UNEd/DSW1JqxV2SjbmLwmSWHM=;
 b=H+x5sf3yMM/bLkhPrTXKNIT7L9rA8tNjog1cJxS+uZ56NX3Nei+bF1zIBNCDNUC8XM
 mPYdME6v0ej7QlYbT/rQrSqWYHi8YJ70T7wNC6KoFCmvaNtkIRIJxJCk8/cdjUbaI7gw
 4Q2TvGWKfvs34rKeQcI5Ow7siF/b1mlr9c3fLY8ghmcs0jP0qC/pikNe8gfkmwmZVF5Q
 5BVSMdzSAALtzURtsKtvlU1XNzfPVwEjU0P/vrCIr6B58foSvTRs9KBzzV+/Ky7fiDRq
 TtbFwpwDxCN2V4bhXwrorwpvpbQbjrX8rHzm/QoFAD0cU6HdxVXvcLUWX240VoCJR3Vw
 2ywQ==
X-Gm-Message-State: AOAM532S75UX6aJlSrC5tTXBV2xdMM9rMrAYanwj2aiCXBGmdoqRl6Y2
 FrvIbGTzkITkO/fTYnu+PGxgv9n7
X-Google-Smtp-Source: ABdhPJyUx2T6lAvHCczqd5gUjLQ7mxx5XK3473upZ15KI5BS2KBzQQCAmlgX35YVjgOgqQFCGqFTEw==
X-Received: by 2002:a9d:204f:: with SMTP id n73mr2514196ota.342.1592317090711; 
 Tue, 16 Jun 2020 07:18:10 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c23sm4072625otd.7.2020.06.16.07.18.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:09 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/78] dp8393x: Update LLFA and CRDA registers from rx
 descriptor
Date: Tue, 16 Jun 2020 09:15:00 -0500
Message-Id: <20200616141547.24664-32-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

Follow the algorithm given in the National Semiconductor DP83932C
datasheet in section 3.4.7:

    At the next reception, the SONIC re-reads the last RXpkt.link field,
    and updates its CRDA register to point to the next descriptor.

The chip is designed to allow the host to provide a new list of
descriptors in this way.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 5b0c98fcb7ac006bd8efe0e0fecba52c43a9d028)
*drop context dep on 19f70347731
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a696485a55..8dd6bf032c 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -784,12 +784,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)s->data, size, 0);
-        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
+        s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
+        if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
             /* Still EOL ; stop reception */
             return -1;
-        } else {
-            s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         }
+        /* Link has been updated by host */
+        s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
     }
 
     /* Save current position */
@@ -837,7 +838,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     address_space_rw(&s->as, dp8393x_crda(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
 
-    /* Move to next descriptor */
+    /* Check link field */
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
@@ -852,6 +853,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         dp8393x_put(s, width, 0, 0);
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)s->data, size, true);
+
+        /* Move to next descriptor */
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.17.1


