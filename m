Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8DCC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36BD275F1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cme7cm96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36BD275F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38327 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqZ6-0002MX-6r
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:16:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUJ-0007Dy-Qk
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUG-0004G4-Ph
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqU9-0003tr-51
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so12908590wrm.8
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Vz4mjKg17Zvr1//Qs+PRlUSoBS1/qMyPl690MxJYzec=;
	b=Cme7cm96VN0Z9QoCVSJFvRBtbRUrlIBPu0g97F9zjdrZDstZF/H7C78MUs0de0FV7a
	Sw0N9Gm6ay/c9CSI2Z+vq1bKJeISWwB8Rjx0EMUXJO3EWl9mLVZBkfBUguE5pT8BFAhQ
	W9F93aqo16/KJqP5R2PsrMECsSnc2aWnIkDh0aV5/QkMo1OoXVNCmbOBsDLU4Br2Adzs
	jDod8VEiJgM2EEP34PFcCunVWK5CnyHeAmc6pTnYP/0SF5THqL22spiGCdh4VaZI4lcW
	bYoBRzHrGSssxCWwcsjrp+OM3E7LRwdH9ybnEpKczZQ1bogE2kFEMvQemr2nkszkz/e0
	vLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=Vz4mjKg17Zvr1//Qs+PRlUSoBS1/qMyPl690MxJYzec=;
	b=GCMH7lBFeA7/IFZOiBMosLwV3b5srnnOl33Ra7gHAJdMaTeL1uV8oHiKRLg3ECF1VM
	yToN+wDrO+BPb7wbtqRyljRwrX9o/QKh5yIfeW0NrKkZHVXHZOhnNmVzHbNi2CAYjddc
	2T70xGG4h9dK3qgmXGudc7fBEZOk7pHVObiWeDc7KQklQRvyr92Q2Hx2lMClWvuN97XR
	hLbcryErXkRp5u7TKL9Z7eJRpe1bOKQmLgIrSbhIFekUicz0KQyfeFBEx6bvnBrpZKOe
	lw7h5c4bOciVuCYdeVFgaeiKbn/4oFLqXHAwBBGdYTfTU8wBgXvK2qcBH4TM/Wt7U8aL
	HiMg==
X-Gm-Message-State: APjAAAVbHSJdk3FUIOXAgxJ77LHGqsuUz9DSoGMW1C/Oia5jU3xwPyCe
	4AtLgc9Smo2j2tez77fM0MvnmeBo
X-Google-Smtp-Source: APXvYqx9D7bhwvMIU13tPVRLYtX7RDYa6Ccn+5Wr7oq4ZnFZPajAqIVe1ZWoNWi3N/7iFQnCSzIRZw==
X-Received: by 2002:adf:8367:: with SMTP id 94mr17654360wrd.179.1559581854175; 
	Mon, 03 Jun 2019 10:10:54 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:27 +0200
Message-Id: <1559581843-3968-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 08/24] edu: uses uint64_t in dma operation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

The dma related variable dma.dst/src/cnt is dma_addr_t, it is
uint64_t in x64 platform. Change these usage from uint32_to
uint64_t to avoid trancation in edu_dma_timer.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190510164349.81507-4-liq3ea@163.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/edu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 33de051..19e5545 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -98,23 +98,24 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
     }
 }
 
-static bool within(uint32_t addr, uint32_t start, uint32_t end)
+static bool within(uint64_t addr, uint64_t start, uint64_t end)
 {
     return start <= addr && addr < end;
 }
 
-static void edu_check_range(uint32_t addr, uint32_t size1, uint32_t start,
-                uint32_t size2)
+static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
+                uint64_t size2)
 {
-    uint32_t end1 = addr + size1;
-    uint32_t end2 = start + size2;
+    uint64_t end1 = addr + size1;
+    uint64_t end2 = start + size2;
 
     if (within(addr, start, end2) &&
             end1 > addr && within(end1, start, end2)) {
         return;
     }
 
-    hw_error("EDU: DMA range 0x%.8x-0x%.8x out of bounds (0x%.8x-0x%.8x)!",
+    hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
+             " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
             addr, end1 - 1, start, end2 - 1);
 }
 
@@ -139,13 +140,13 @@ static void edu_dma_timer(void *opaque)
     }
 
     if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
-        uint32_t dst = edu->dma.dst;
+        uint64_t dst = edu->dma.dst;
         edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
         dst -= DMA_START;
         pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
                 edu->dma_buf + dst, edu->dma.cnt);
     } else {
-        uint32_t src = edu->dma.src;
+        uint64_t src = edu->dma.src;
         edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
         src -= DMA_START;
         pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
-- 
1.8.3.1



