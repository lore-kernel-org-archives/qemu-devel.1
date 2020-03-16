Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301EFC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF192051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQhphno+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF192051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsGQ-0003M0-CP
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDqhy-0007Th-Rw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDqhx-0002QJ-Lf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDqhu-0001ke-Ev; Mon, 16 Mar 2020 10:27:06 -0400
Received: by mail-pf1-x442.google.com with SMTP id u68so10036676pfb.2;
 Mon, 16 Mar 2020 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bDbE0pWdx402i6b4b97coyniPhlyf+H/P2krEymTHzo=;
 b=bQhphno+Hlq4pjljuaxdLywBWXs/8rlmt2MBj1CLSi90+BOJHhDwHF18Y/rxXAYxej
 w6QxaW2z0Ps3rDss0oWYkrRkzC1QHCuJ9DcWFB3CyCegef/BSG6KNtV8wZvAYfnUHZHi
 qVkSwyqA44nILFceOPm9LHG91o2dqDCJ2Dx0KLGo57LRi+x6kj9/5jQAk6RBWD1j5iBk
 Q01ylOTonjGbwYpZj4KtjFa1Lsbkk7XokSk65P25yAPUJz37ezhvyZ0Iq4GrTROl8jNm
 kDGy62kwUDotsRHncOkUvLcv29AZTws5kJuaW+7xCPC21wPX2PWJLTE2LaJs3ZdUt3el
 ou3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bDbE0pWdx402i6b4b97coyniPhlyf+H/P2krEymTHzo=;
 b=QlPJEWglG/653rhZQKmajp5AFJPP3vl/Adn4n1KgLGhzZryCBSmF5VVa446exfR4/U
 rh9U4lL8H1gJQjL3citcim3zuIP59D18PzQC23BOqIXqh9XRO0mqvztgwdAdUK8NMo29
 A+iV5+zLxQcP1g32qdY9GIW2f6axey+iVTeY2iBnVG9jkjHJk/pEHDmpS40E3j4nD+tR
 Z4B/g4t8X26SlMNKNPtbZRVSInxy9BwSkCBemmbjY+Y4I+JlJCLcPKEW1DPcT3eeUDTn
 c8PvmoXrkAW0IHdrDiPqJDgF8+5gMe4vG/thlWAPdVmdq32EjGN6aUTmNN/NWTIN29xv
 dsXg==
X-Gm-Message-State: ANhLgQ02T86Sv4U2YXdH8NfzCi36lFDjMFcPZnwTAPp8TO1zT4Oh8s7x
 iPl+VTWm1P/Pu3UZpgYF6FNm8Ty99zY=
X-Google-Smtp-Source: ADFU+vt6Q3FCOIX+XkBV1/Lz8CiZKg5IzFJYn3PXeKhkU+1PwPCAjKbQcx3E5cWK/SwLZ2zRmO1aHg==
X-Received: by 2002:a62:b604:: with SMTP id j4mr28928311pff.93.1584368825345; 
 Mon, 16 Mar 2020 07:27:05 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.63.160.49])
 by smtp.gmail.com with ESMTPSA id v1sm45564pjy.35.2020.03.16.07.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:27:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 3/8] ppc/spapr: Add FWNMI System Reset state
Date: Tue, 17 Mar 2020 00:26:08 +1000
Message-Id: <20200316142613.121089-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200316142613.121089-1-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FWNMI option must deliver system reset interrupts to their
registered address, and there are a few constraints on the handler
addresses specified in PAPR. Add the system reset address state and
checks.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_rtas.c    | 14 +++++++++++++-
 include/hw/ppc/spapr.h |  3 ++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b03b26370d..5f93c49706 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1704,6 +1704,7 @@ static void spapr_machine_reset(MachineState *machine)
 
     spapr->cas_reboot = false;
 
+    spapr->fwnmi_system_reset_addr = -1;
     spapr->fwnmi_machine_check_addr = -1;
     spapr->fwnmi_machine_check_interlock = -1;
 
@@ -2023,6 +2024,7 @@ static const VMStateDescription vmstate_spapr_fwnmi = {
     .needed = spapr_fwnmi_needed,
     .pre_save = spapr_fwnmi_pre_save,
     .fields = (VMStateField[]) {
+        VMSTATE_UINT64(fwnmi_system_reset_addr, SpaprMachineState),
         VMSTATE_UINT64(fwnmi_machine_check_addr, SpaprMachineState),
         VMSTATE_INT32(fwnmi_machine_check_interlock, SpaprMachineState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0b8c481593..521e6b0b72 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -414,6 +414,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
                                   uint32_t nret, target_ulong rets)
 {
     hwaddr rtas_addr;
+    target_ulong sreset_addr, mce_addr;
 
     if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
         rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
@@ -426,7 +427,18 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
         return;
     }
 
-    spapr->fwnmi_machine_check_addr = rtas_ld(args, 1);
+    sreset_addr = rtas_ld(args, 0);
+    mce_addr = rtas_ld(args, 1);
+
+    /* PAPR requires these are in the first 32M of memory and within RMA */
+    if (sreset_addr >= 32 * MiB || sreset_addr >= spapr->rma_size ||
+           mce_addr >= 32 * MiB ||    mce_addr >= spapr->rma_size) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    spapr->fwnmi_system_reset_addr = sreset_addr;
+    spapr->fwnmi_machine_check_addr = mce_addr;
 
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 64b83402cb..42d64a0368 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -194,9 +194,10 @@ struct SpaprMachineState {
 
     /* State related to FWNMI option */
 
-    /* Machine Check Notification Routine address
+    /* System Reset and Machine Check Notification Routine addresses
      * registered by "ibm,nmi-register" RTAS call.
      */
+    target_ulong fwnmi_system_reset_addr;
     target_ulong fwnmi_machine_check_addr;
 
     /* Machine Check FWNMI synchronization, fwnmi_machine_check_interlock is
-- 
2.23.0


