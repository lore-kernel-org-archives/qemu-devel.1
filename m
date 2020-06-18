Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A77A2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="GeISHAq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A77A2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0M5-00054I-KO
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jm0Kl-0003Zn-HA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:36:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1jm0Kj-0003vJ-Vm
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:36:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id r15so6912650wmh.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jrtc27.com; s=gmail.jrtc27.user;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ecAMYIQiG0bgTF7m4VC12CqC+k295YsygfVj48I72I=;
 b=GeISHAq6lwBYMsS92m6LXp8c/zgbPmccKMyRxQ7vedcUtQSq8UvBZiCN8eXFpmm60h
 M1b3r/1ufLIzoLIMhZkfjd0bsNxx7B5zWMZBOu34j68VcGVQodyVfQ7XLP/0oeyqoZAi
 cLGrrOGjHFghvmVjM38KYziAK+Rm8KPgXEhuSyme/Uo3WdtnjQLG8UbMGZnflR/Bjbkz
 3Bj/jGK2kQWZJDepl5HwxR1qTMkueZlDY0sC4pYLjzOkzik0j02FBu5Ez5jo75jmKXaK
 IuNNpFScC5monmH4GfbeLLxt+WZAHy/TrkbrJ4eyfzItB48nYdpmTUB1BGkSlJQacTc8
 4tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ecAMYIQiG0bgTF7m4VC12CqC+k295YsygfVj48I72I=;
 b=b0QJvgWq3slK8HTbioRz8MSD0UHHUqBvaMV/9kOiHinKgnEqO1v2iZ2FEbXmMV4IER
 /4PzDp5SJazWIhSkaunBzwZQLNP74ec8bj+GMp5kadwVwUAyGK/mif5S/PHSlMyGW5OP
 yv+nf0KZazboVaIWhQMwiDXNdd8la4ZaSH5L6Janbacl7qtmKccemJUb/LcUkHedlUD2
 xM3ZuwFFNs0ZXwUQZA49pbYpZ+YE3hKMwSh3qMnmznsgB27DF1/DQ8BGPfeoh3lxbk9p
 xb604YSRR8j+SUBBFAALlqs9niRXwFsvy6SWcxau4SS7ZPiPbRTYOH/x+Fe7VAxwJv65
 3zKw==
X-Gm-Message-State: AOAM532wifmwRun0aKl6k7vWPlQ5sknMLSYUd5cKR3xmVKtsoNEe39zt
 jfGlEpP+28QWiArlyywYIolang==
X-Google-Smtp-Source: ABdhPJxpgTcK0piK4TRkyh+WtKdHHXW/l1bNwYAzpbCI7E1SthbKVoI/H2OTaWUVC0tqf17FPFol4g==
X-Received: by 2002:a1c:154:: with SMTP id 81mr5496071wmb.23.1592508979909;
 Thu, 18 Jun 2020 12:36:19 -0700 (PDT)
Received: from Jessicas-MacBook.local (trinity-students-nat.trin.cam.ac.uk.
 [131.111.193.104])
 by smtp.gmail.com with ESMTPSA id h15sm4406720wrt.73.2020.06.18.12.36.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Jun 2020 12:36:19 -0700 (PDT)
Received: by Jessicas-MacBook.local (Postfix, from userid 501)
 id B98F0207585400; Thu, 18 Jun 2020 20:36:18 +0100 (BST)
From: Jessica Clarke <jrtc27@jrtc27.com>
To: qemu-riscv@nongnu.org
Subject: [PATCH] riscv: plic: Honour source priorities
Date: Thu, 18 Jun 2020 20:35:56 +0100
Message-Id: <20200618193556.19459-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=jrtc27@jrtc27.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The source priorities can be used to order sources with respect to other
sources, not just as a way to enable/disable them based off a threshold.
We must therefore always claim the highest-priority source, rather than
the first source we find.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 hw/riscv/sifive_plic.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 4f216c5585..911e006095 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -166,6 +166,9 @@ static void sifive_plic_update(SiFivePLICState *plic)
 static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
 {
     int i, j;
+    uint32_t max_irq = 0;
+    uint32_t max_prio = 0;
+
     for (i = 0; i < plic->bitfield_words; i++) {
         uint32_t pending_enabled_not_claimed =
             (plic->pending[i] & ~plic->claimed[i]) &
@@ -177,14 +180,20 @@ static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
             int irq = (i << 5) + j;
             uint32_t prio = plic->source_priority[irq];
             int enabled = pending_enabled_not_claimed & (1 << j);
-            if (enabled && prio > plic->target_priority[addrid]) {
-                sifive_plic_set_pending(plic, irq, false);
-                sifive_plic_set_claimed(plic, irq, true);
-                return irq;
+            if (enabled && prio > plic->target_priority[addrid] &&
+                prio > max_prio)
+            {
+                max_irq = irq;
+                max_prio = prio;
             }
         }
     }
-    return 0;
+
+    if (max_irq) {
+        sifive_plic_set_pending(plic, max_irq, false);
+        sifive_plic_set_claimed(plic, max_irq, true);
+    }
+    return max_irq;
 }
 
 static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
-- 
2.20.1


