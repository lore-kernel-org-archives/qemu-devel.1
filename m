Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381E6C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD24920872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+n7lMB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD24920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2JT-0001GS-Jt
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2HT-0000Az-F2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:22:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2HQ-0003m1-PI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:22:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id k15so6705781wrn.10
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+6y9SStSTnN9ITmv25hC1Xnc3CSF+ES6LDmfkf2yvN0=;
 b=B+n7lMB4E+Kh7A3+lIgqPSfaxJb8wpYZcuRGDJKDZObkWjo0BFYJIB2pTpICCvHHJT
 wxRNm8TuTm2lHbd0r2UiYU80YQ3dlffa1VODm7pSPQY4ptYQ9YTsfqUHmb9Al/VzCgwT
 XnzZS7PzLBx1KkJr0uRxJ9JbU7SFak5ByMoP6DYXCNJtpOunynoYoKJWxbV+DxhIp8ft
 L0axCGyQa77eygR7XW+2vxC3aK2A7uGVfGeMb8LBd/e30NQstNCsWQa9uTPc2PBXocFU
 TuVODKOGQ1ELgvCI8Kl1QHCudrOsUhj5KXLsXv3+7k0TedcjVzrz6AFqRfJ8woB5K2UR
 10bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+6y9SStSTnN9ITmv25hC1Xnc3CSF+ES6LDmfkf2yvN0=;
 b=pGS4zLpBCOXSjJmD/4Fmo/btT7Bco72jLjNonVeQ5t2TAtFpC0efydx6EPoRvzMlKM
 w4Ta+mWMdWDioN25jcYEK18YjuVbXL1+IoEPsI4mT1L1KKilRARQSfyuOk/+pfo+rCJo
 y7bm0i2zNpUFDZv4kvLkfYjFUGW785PU06OdQ3Vm/srUAyvw1aJW0+3zgMH9VDfHM+6X
 pXPEriHIBw6F7AD8Rpa9Z2u2UoVK+ud6997zP19IzBdWXm0XVImwCHaTdfMCRNV8YgcN
 NsRR5+lhW9/aD65BHT1PGGJl8wBBiXfXO5oZvny+dJ4DgTcaRgpbjfyOpABYe7PrhK5Q
 Q1VQ==
X-Gm-Message-State: AOAM531SVoLdoJXbEHl5MiRPOzuf0Tm/hJN8C2BV4D6QnkLqoOqzTHQn
 Ke8vq3xtlLvyGmklb6VjfCcT6ma6oSw=
X-Google-Smtp-Source: ABdhPJz5v+5FS5wJpM3Gu0TPxIodutB3X1LWsbo99w/oDxaJoIEstqP5lEqxAaGCcN5Ew1rOMhuAIA==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr9964746wrm.422.1601572925659; 
 Thu, 01 Oct 2020 10:22:05 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h8sm9719625wrw.68.2020.10.01.10.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:22:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/16] dma: Let dma_memory_set() propagate MemTxResult
Date: Thu,  1 Oct 2020 19:21:47 +0200
Message-Id: <20201001172159.1619456-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001172159.1619456-1-f4bug@amsat.org>
References: <20201001172159.1619456-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

address_space_write() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 15 ++++++++++++++-
 dma-helpers.c        |  7 ++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index c6e12b4c24..37cd9f1121 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -123,7 +123,20 @@ static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
                          DMA_DIRECTION_FROM_DEVICE);
 }
 
-int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len);
+/**
+ * dma_memory_set: Fill memory with a constant byte from DMA controller.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @c: constant byte to fill the memory
+ * @len: the number of bytes to fill with the constant byte
+ */
+MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
+                           uint8_t c, dma_addr_t len);
 
 /**
  * address_space_map: Map a physical memory region into a host virtual address.
diff --git a/dma-helpers.c b/dma-helpers.c
index 41ef24a63b..4a9e37d6d0 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -1,7 +1,7 @@
 /*
  * DMA helper functions
  *
- * Copyright (c) 2009 Red Hat
+ * Copyright (c) 2009,2020 Red Hat
  *
  * This work is licensed under the terms of the GNU General Public License
  * (GNU GPL), version 2 or later.
@@ -18,14 +18,15 @@
 
 /* #define DEBUG_IOMMU */
 
-int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len)
+MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
+                           uint8_t c, dma_addr_t len)
 {
     dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
 
 #define FILLBUF_SIZE 512
     uint8_t fillbuf[FILLBUF_SIZE];
     int l;
-    bool error = false;
+    MemTxResult error = MEMTX_OK;
 
     memset(fillbuf, c, FILLBUF_SIZE);
     while (len > 0) {
-- 
2.26.2


