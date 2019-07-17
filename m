Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A471C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0812173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW6w6fON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0812173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hncgP-0004Ad-Dh
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 01:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50221)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hncfy-0002dn-CT
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hncfw-0005Ps-Vy
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:40:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hncfq-0005Gr-0H; Wed, 17 Jul 2019 01:40:19 -0400
Received: by mail-pl1-x644.google.com with SMTP id k8so11351807plt.3;
 Tue, 16 Jul 2019 22:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4ymRbbQ1EIHFO3Mw1nCIQEG1l7W4bUNAte9gP14Oo18=;
 b=YW6w6fONBsPOOw922YFEe1rvDVqhZF0Zjs0BQ/x9yNLJZXWkgN7CtzAqt0xnb9QLpJ
 t1TMNjvKbAx8nKiNzfMDeC1LFQcMkT2brPab+mJVZs1NDvaxx03+X4TSXP5r9YGYCsbI
 AEYXCboaNsdjESRQmZiNFzL/TDWNo/k4WsG9y7U6vX96YmYcrUO+TxTO9tVJ09TCiMN1
 wjpFljiTjevTkImj27eZ3zzHGuJpd0Lbu7Y485+T/Fq7s4KRA0d1P6VU6I7N8+SXIEFY
 9JGtHvSmf5DWYD006DTcgLt1+O7vmH3oLq7QLPKs66nPyLhVU1QImm4DPXkEXp93tysv
 AQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4ymRbbQ1EIHFO3Mw1nCIQEG1l7W4bUNAte9gP14Oo18=;
 b=k23yV5vNe2vnRTVUgVBBIFGfu8qzIRH95bRry8y4FEdejG5nrmjRFFPl3bnQ7i2wnG
 lYSvwa0RoesGAlZZtc+fZpCTyQerO5hl1TlXEJyaE+Rwf4mNnCUSdoRqPEseNqtU58nC
 OKk1N5h734sthEFUUcj5NiRjaivSkNAQLf3wPbOcAU5HNRtPppNyCIhqi1fBuivSych1
 k18kVxGASOBq3GJpu3UYQSEzes3lainsU0bZEwomJzrbYW4kx8lWWxZB/zVEshHxDX4k
 bmtGgdOv4hRkDkijgl5Gfs8FstHSDU4ncoZFDgdD6/E8KOKk7hcYMo3TyxFZ8MKRvylC
 uGYg==
X-Gm-Message-State: APjAAAUuqkUaOG/wp7C/mdUT8GK+/WJ5WBvOIJxYPODw9DmdReN1Wt7c
 GYnShaD8fw6+KTbxh84qV9k2AnOR
X-Google-Smtp-Source: APXvYqxskJ6fxN864Ec3dZPi4jRkAUj84m4cmIYyBMsGVww3hSPXm0D5zHrsvRqWgvClzXjxcUSoWQ==
X-Received: by 2002:a17:902:28e9:: with SMTP id
 f96mr39314755plb.114.1563342017145; 
 Tue, 16 Jul 2019 22:40:17 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id g18sm39322656pgm.9.2019.07.16.22.40.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 22:40:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jul 2019 15:39:51 +1000
Message-Id: <20190717053952.13729-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717053952.13729-1-npiggin@gmail.com>
References: <20190717053952.13729-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v5 3/4] spapr: Implement H_CONFER
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
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does not do directed yielding and is not quite as strict as PAPR
specifies in terms of precise dispatch behaviour. This generally will
mean suboptimal performance, rather than guest misbehaviour. Linux
does not rely on exact dispatch behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v4:
- Style, added justification comments, spelling.
- Fixed trying to dereference spapr_cpu for a -1 target.

 hw/ppc/spapr_hcall.c | 68 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8b208ab259..5e655172b2 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1069,6 +1069,73 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target = args[0];
+    uint32_t dispatch = args[1];
+    CPUState *cs = CPU(cpu);
+    SpaprCpuState *spapr_cpu;
+
+    /*
+     * -1 means confer to all other CPUs without dispatch counter check,
+     *  otherwise it's a targeted confer.
+     */
+    if (target != -1) {
+        PowerPCCPU *target_cpu = spapr_find_cpu(target);
+        CPUState *target_cs = CPU(target_cpu);
+        unsigned int target_dispatch;
+
+        if (!target_cs) {
+            return H_PARAMETER;
+        }
+
+        spapr_cpu = spapr_cpu_state(target_cpu);
+
+        /*
+         * target == self is a special case, we wait until prodded, without
+         * dispatch counter check.
+         */
+        if (cpu == target_cpu) {
+            if (spapr_cpu->prod) {
+                spapr_cpu->prod = false;
+
+                return H_SUCCESS;
+            }
+
+            cs->halted = 1;
+            cs->exception_index = EXCP_HALTED;
+            cs->exit_request = 1;
+
+            return H_SUCCESS;
+        }
+
+        if (!spapr_cpu->vpa_addr || ((dispatch & 1) == 0)) {
+            return H_SUCCESS;
+        }
+
+        target_dispatch = ldl_be_phys(cs->as,
+                                  spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
+        if (target_dispatch != dispatch) {
+            return H_SUCCESS;
+        }
+
+        /*
+         * The targeted confer does not do anything special beyond yielding
+         * the current vCPU, but even this should be better than nothing.
+         * At least for single-threaded tcg, it gives the target a chance to
+         * run before we run again. Multi-threaded tcg does not really do
+         * anything with EXCP_YIELD yet.
+         */
+    }
+
+    cs->exception_index = EXCP_YIELD;
+    cs->exit_request = 1;
+    cpu_loop_exit(cs);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1909,6 +1976,7 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_PROD, h_prod);
 
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
-- 
2.20.1


