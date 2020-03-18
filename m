Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B78C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A59D20768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL/ehmz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A59D20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEQYi-0001hC-DR
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 00:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jEQXx-0000i7-22
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jEQXu-0004rM-BF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:43:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jEQXq-0004VO-Hj; Wed, 18 Mar 2020 00:43:07 -0400
Received: by mail-pf1-x444.google.com with SMTP id x2so12836968pfn.9;
 Tue, 17 Mar 2020 21:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UO3pThTw0bLlMLOdAGNpaCK+RKzxZlZsMKGSRRLJe+0=;
 b=mL/ehmz0/k97cKyGf73ui1QEzIHW46wMjXGgKyhFtTGmdzNZY5mKsksaF9fmoBvP48
 B4YQTiFmCLzy3RAtGAiwQ9O2IDqKoPL4ejtoo1r9ZpRJiIxrRCuGuwZXpYSODRvWD0Tu
 6xJMg8rwGX9fjgvEh5IgPcW+A7Z3Mgtzr9ga3LDUC/lNZvGNbolkW22DlyRkDenSbI30
 WNgslTLONJGNWhkylkc2hcJLskpWyWFU87E+RpoNuOFr85X3zptLX3OGVuxNcYe/X0MO
 FqmI8P3GwhQhdhowjecvDpurQrqOxxOm9Haja0/Z6Wx1mcdwX54i9GcLAYVYG4RRfUQa
 9qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UO3pThTw0bLlMLOdAGNpaCK+RKzxZlZsMKGSRRLJe+0=;
 b=V5iwAPWYauUS62tVeXtDGtvbfPXi1jV8T4kQ4nCUWb7uiq5+MslqchlizfrCEZno9L
 IzKmSL3EZCcmUV7uzfPkDvdgamA1cVP6s+xlFuCzUIWr7iN9zmLLY2wzGCyuQygHIZaD
 J6px6gQk9YNNVwL0piqcInOsxSBgOt8V2epswGViBUw4ULyytMtQ6ISQlVxeAvKhKoIV
 QtkukUcv+2hRtCzUOrHNArGangOugcBREiojrbH3HRi6d13xI36iC52gM/Po8F7yKiNb
 gxaefFTJLqHmOA+UqcX2areKEJf9p+0AwmdRdgXj1SVNHnMwCRiO3/1tE6kBDkBYaE5E
 XfYQ==
X-Gm-Message-State: ANhLgQ0wniWaTjnsqucaS5n+RY8gA67vxeve9FzLka+vgkko9yi/4Dns
 sdQ7HTV4Rmks1oHuNhWPq6vXuKXj
X-Google-Smtp-Source: ADFU+vtaVkYjALOZj0tdybEwR5k152vTpBXoH2FalmJtD1hHMEfIzL6r9rBL5ONbSWnkAM9omd2+BA==
X-Received: by 2002:a63:f752:: with SMTP id f18mr2699438pgk.196.1584506584865; 
 Tue, 17 Mar 2020 21:43:04 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id e28sm4192629pgn.21.2020.03.17.21.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 21:43:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 1/2] target/ppc: Fix slbia TLB invalidation gap
Date: Wed, 18 Mar 2020 14:41:34 +1000
Message-Id: <20200318044135.851716-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

slbia must invalidate TLBs even if it does not remove a valid SLB
entry, because slbmte can overwrite valid entries without removing
their TLBs.

As the architecture says, slbia invalidates all lookaside information,
not conditionally based on if it removed valid entries.

It does not seem possible for POWER8 or earlier Linux kernels to hit
this bug because it never changes its kernel SLB translations, and it
should always have valid entries if any accesses are made to usespace
regions. However other operating systems which may modify SLB entry 0
or do more fancy things with segments might be affected.

When POWER9 slbia support is added in the next patch, this becomes a
real problem because some new slbia variants don't invalidate all
non-zero entries.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash64.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 34f6009b1e..373d44de74 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -100,20 +100,29 @@ void helper_slbia(CPUPPCState *env)
     PowerPCCPU *cpu = env_archcpu(env);
     int n;
 
+    /*
+     * slbia must always flush all TLB (which is equivalent to ERAT in ppc
+     * architecture). Matching on SLB_ESID_V is not good enough, because slbmte
+     * can overwrite a valid SLB without flushing its lookaside information.
+     *
+     * It would be possible to keep the TLB in synch with the SLB by flushing
+     * when a valid entry is overwritten by slbmte, and therefore slbia would
+     * not have to flush unless it evicts a valid SLB entry. However it is
+     * expected that slbmte is more common than slbia, and slbia is usually
+     * going to evict valid SLB entries, so that tradeoff is unlikely to be a
+     * good one.
+     */
+
     /* XXX: Warning: slbia never invalidates the first segment */
     for (n = 1; n < cpu->hash64_opts->slb_size; n++) {
         ppc_slb_t *slb = &env->slb[n];
 
         if (slb->esid & SLB_ESID_V) {
             slb->esid &= ~SLB_ESID_V;
-            /*
-             * XXX: given the fact that segment size is 256 MB or 1TB,
-             *      and we still don't have a tlb_flush_mask(env, n, mask)
-             *      in QEMU, we just invalidate all TLBs
-             */
-            env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
         }
     }
+
+    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
 }
 
 static void __helper_slbie(CPUPPCState *env, target_ulong addr,
-- 
2.23.0


