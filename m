Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3478C04E53
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 00:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E59220843
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 00:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A101xwxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E59220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR4je-0008K3-OK
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 20:59:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hR4io-0007zS-Bx
	for qemu-devel@nongnu.org; Wed, 15 May 2019 20:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hR4in-0007QD-3T
	for qemu-devel@nongnu.org; Wed, 15 May 2019 20:58:10 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hR4ik-0007Lz-1a; Wed, 15 May 2019 20:58:06 -0400
Received: by mail-pg1-x542.google.com with SMTP id e6so653148pgc.4;
	Wed, 15 May 2019 17:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=jq+HPCSh37a6/Sz62UudWaSSUGZY4jB0ooluTp6kgQw=;
	b=A101xwxBcOPzBcgdoSRwxUQDmFLurluUKTCdu8fDm+xZGBnO606CNpz/fVMiifdXqg
	ssTdWoBf/LEiKWM6DOLKr5ddFMlGDGZkniv5mqtGV4wnxz7a2y3jQzvxHb3GwQw07B7j
	vJgwjGxHvG981F4+lk7E/9Z4eL/ljWcUBweyi8qVKRixwvvmKXMDp3FbjNrBtvxYbFJF
	qDeXv4MiDaAQXW4kmHeoacRUU+qEMCW2BAucGiPUC5lIxQ1pjkdTXRKBx/UsGquk4jcm
	mskmX/eDh/bKeOJIPt9GvbxiRCQVK92mauABOhpbBFcGGcP9OzW8yfGbOxPLyfn1PcLt
	0lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=jq+HPCSh37a6/Sz62UudWaSSUGZY4jB0ooluTp6kgQw=;
	b=DRdnTgytiFXIRjkJe5G7MiC4MGJx0SYz/V0Jjrn67k/kQb5GBo8aqL/7cpG+pKy6TO
	x5gNqKJYpUgL/FaXxStWFqPBSx7RiCwpMi0qczIDR5doJvqJu95MNo0XMy/1kJdZkXvE
	hItBV10hnwxpVqqlozN5XQgMi43uCSGfbGxfsiCG1oHJBlEdbn0nVBYWONcNrgRNK+Bc
	CRs9UV8YNaqSVH3wbBFLKyRCb4KduaOdOdlR4u1xcNA3rmeCUNQmvDMdw45MOHHtGQf5
	nkHKzs4nGmGYF+WLBLjwG3gRCuYr9uc/v/+i2205eOsWMkOM8N9oXOemtDEHMtdXtvG8
	iMdA==
X-Gm-Message-State: APjAAAUexT0/22VtpWuY0ppAZ/mu9PBqN9Rznf+Fgu0E1Ykg2te0F9RP
	4DwxU5RNWV25aV95Ek9mJKa/XDfi
X-Google-Smtp-Source: APXvYqwylJyB1w2isr0mLwwmnrY7UzDZZrIzzoxmxNA4sRBuy8G77BXgKSKZcHWnd5Jf6bvMICOZkw==
X-Received: by 2002:a65:608a:: with SMTP id t10mr46751210pgu.155.1557968283367;
	Wed, 15 May 2019 17:58:03 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
	by smtp.gmail.com with ESMTPSA id
	e14sm4106322pff.60.2019.05.15.17.58.00
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 17:58:02 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-ppc@nongnu.org
Date: Thu, 16 May 2019 10:57:44 +1000
Message-Id: <20190516005744.24366-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH] target/ppc: Set PSSCR_EC on cpu halt to
 prevent spurious wakeup
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
Cc: clg@kaod.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The processor stop status and control register (PSSCR) is used to
control the power saving facilities of the thread. The exit criterion
bit (EC) is used to specify whether the thread should be woken by any
interrupt (EC == 0) or only an interrupt enabled in the LPCR to wake the
thread (EC == 1).

The rtas facilities start-cpu and self-stop are used to transition a
vcpu between the stopped and running states. When a vcpu is stopped it
may only be started again by the start-cpu rtas call.

Currently a vcpu in the stopped state will start again whenever an
interrupt comes along due to PSSCR_EC being cleared, and while this is
architecturally correct for a hardware thread, a vcpu is expected to
only be woken by calling start-cpu. This means when performing a reboot
on a tcg machine that the secondary threads will restart while the
primary is still in slof, this is unsupported and causes call traces
like:

SLOF **********************************************************************
QEMU Starting
 Build Date = Jan 14 2019 18:00:39
 FW Version = git-a5b428e1c1eae703
 Press "s" to enter Open Firmware.

qemu: fatal: Trying to deliver HV exception (MSR) 70 with no HV support

NIP 6d61676963313230   LR 000000003dbe0308 CTR 6d61676963313233 XER 0000000000000000 CPU#1
MSR 0000000000000000 HID0 0000000000000000  HF 0000000000000000 iidx 3 didx 3
TB 00000026 115746031956 DECR 18446744073326238463
GPR00 000000003dbe0308 000000003e669fe0 000000003dc10700 0000000000000003
GPR04 000000003dc62198 000000003dc62178 000000003dc0ea48 0000000000000030
GPR08 000000003dc621a8 0000000000000018 000000003e466008 000000003dc50700
GPR12 c00000000093a4e0 c00000003ffff300 c00000003e533f90 0000000000000000
GPR16 0000000000000000 0000000000000000 000000003e466010 000000003dc0b040
GPR20 0000000000008000 000000000000f003 0000000000000006 000000003e66a050
GPR24 000000003dc06400 000000003dc0ae70 0000000000000003 000000000000f001
GPR28 000000003e66a060 ffffffffffffffff 6d61676963313233 0000000000000028
CR 28000222  [ E  L  -  -  -  E  E  E  ]             RES ffffffffffffffff
FPR00 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR08 0000000000000000 0000000000000000 0000000000000000 00000000311825e0
FPR12 00000000311825e0 0000000000000000 0000000000000000 0000000000000000
FPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR24 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPR28 0000000000000000 0000000000000000 0000000000000000 0000000000000000
FPSCR 0000000000000000
 SRR0 000000003dbe06b0  SRR1 0000000000080000    PVR 00000000004e1200 VRSAVE 0000000000000000
SPRG0 000000003dbe0308 SPRG1 000000003e669fe0  SPRG2 00000000000000d8  SPRG3 000000003dbe0308
SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SPRG7 0000000000000000
HSRR0 6d61676963313230 HSRR1 0000000000000000
 CFAR 000000003dbe3e64
 LPCR 0000000004020008
 PTCR 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000
Aborted (core dumped)

To fix this, set the PSSCR_EC bit when a vcpu is stopped to disable it
from coming back online until the start-cpu rtas call is made.

Fixes: 21c0d66a9c99 ("target/ppc: Fix support for "STOP light" states on POWER9")

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_cpu_core.c | 2 ++
 hw/ppc/spapr_rtas.c     | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index f04e06cdf6..5621fb9a3d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -58,9 +58,11 @@ static void spapr_cpu_reset(void *opaque)
      *
      * Disable Power-saving mode Exit Cause exceptions for the CPU, so
      * we don't get spurious wakups before an RTAS start-cpu call.
+     * For the same reason, set PSSCR_EC.
      */
     lpcr &= ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_pm);
     lpcr |= LPCR_LPES0 | LPCR_LPES1;
+    env->spr[SPR_PSSCR] |= PSSCR_EC;
 
     /* Set RMLS to the max (ie, 16G) */
     lpcr &= ~LPCR_RMLS;
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index ee24212765..5bc1a93271 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -177,6 +177,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, SpaprMachineState *spapr,
         } else {
             lpcr &= ~(LPCR_UPRT | LPCR_GTSE | LPCR_HR);
         }
+        env->spr[SPR_PSSCR] &= ~PSSCR_EC;
     }
     ppc_store_lpcr(newcpu, lpcr);
 
@@ -205,8 +206,11 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     /* Disable Power-saving mode Exit Cause exceptions for the CPU.
      * This could deliver an interrupt on a dying CPU and crash the
-     * guest */
+     * guest.
+     * For the same reason, set PSSCR_EC.
+     */
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
+    env->spr[SPR_PSSCR] |= PSSCR_EC;
     cs->halted = 1;
     kvmppc_set_reg_ppc_online(cpu, 0);
     qemu_cpu_kick(cs);
-- 
2.13.6


