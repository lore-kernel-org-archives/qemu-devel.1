Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594BC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C5D2070A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4t0qHPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C5D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH745-0003QA-DY
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jH72w-0002US-EZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jH72v-0002yZ-Be
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:30:18 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jH72s-0002vK-Vz; Wed, 25 Mar 2020 10:30:15 -0400
Received: by mail-pf1-x443.google.com with SMTP id l184so1114076pfl.7;
 Wed, 25 Mar 2020 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4d62g15iywxB4Q10tLYc59koLC5xXVOvRd2UYcqqCI0=;
 b=s4t0qHPEhvjG76DaMtNZYU/TaznAP16MtG5IvwKbDVkmljUTc0zAhZ+PfP5nNBziet
 OuM1O5n5RDBpJQbQimrDmSLuaL1njYiF2QzCzD5PcOgMBV3uvqS6xPYH0N9MoDQj8AzG
 gpHKoSpRFC1G6vTJfJgms5LQkSYOYtjTqtKF7goWb6JgowywEERw8tDrIOVfz3dqKfzQ
 OImGjSRz/oEBGyTZ+lcC1Krma7psYoc23btFer+Xu0WTkaO8hDvjHG8rLoTbm+cz4N/S
 lv+ddJzLTi//RLtA9pJDAyUbULgtCl6P1LN+0pgEqrbjjcq4ywVdFvtrB0oI6Q5AjxoP
 lrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4d62g15iywxB4Q10tLYc59koLC5xXVOvRd2UYcqqCI0=;
 b=ZzacVFKvJAS56FgeUM2t+5mlwuYRg079EqKkq4nEvaS7785gxfqHJlZcprDNJ3srCz
 IuOVU0VduzFbMKXUABgJ+EcEBOaJWI2V4zDbwVZ2qmXnm+P1cW6aT9BjKH4PZ/RCHq5N
 NzLnGVYwSCdx+fUV9MqTudRo8gFpM21Uv5DqE2r3NMo4+lTkwgKXHC46915Cvwqr5lk3
 e808fy5dcHaqTM3ijKdltSel28gDCxoM9ws5cGnqO82tCVXEw13sXV8G0imQ+oUpHZpx
 syyAnLViVc7jjooaOVRhojyVYZOSrdJITQ+5J+ergqGKcD0vp0j1DG52gQ28FAwcoW9n
 rp/Q==
X-Gm-Message-State: ANhLgQ1eD32jc7NHPgCJQaPQCNB5ml1OQCKG8lBJIU7XtZGC8MWW6b7F
 +SnuThloXtP6LFxcdMU2NqT0Zvrb
X-Google-Smtp-Source: ADFU+vvIMh2NXitzpMM2PNqBukzI7e/A9Nb+uF60hlRa7RF4IENEV11GSxdtCLO5CHO4k02C91JG/Q==
X-Received: by 2002:a62:6503:: with SMTP id z3mr3810532pfb.232.1585146613812; 
 Wed, 25 Mar 2020 07:30:13 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id i20sm10609622pfd.89.2020.03.25.07.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:30:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 4/4] ppc/spapr: Don't kill the guest if a recovered FWNMI
 machine check delivery fails
Date: Thu, 26 Mar 2020 00:29:06 +1000
Message-Id: <20200325142906.221248-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325142906.221248-1-npiggin@gmail.com>
References: <20200325142906.221248-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Try to be tolerant of FWNMI delivery errors if the machine check had been
recovered by the host.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_events.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index c8964eb25d..b90ecb8afe 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -833,13 +833,25 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
     /* get rtas addr from fdt */
     rtas_addr = spapr_get_rtas_addr();
     if (!rtas_addr) {
-        error_report(
+        if (!recovered) {
+            error_report(
 "FWNMI: Unable to deliver machine check to guest: rtas_addr not found.");
-        qemu_system_guest_panicked(NULL);
+            qemu_system_guest_panicked(NULL);
+        } else {
+            warn_report(
+"FWNMI: Unable to deliver machine check to guest: rtas_addr not found. "
+"Machine check recovered.");
+        }
         g_free(ext_elog);
         return;
     }
 
+    /*
+     * Must not set interlock if the MCE does not get delivered to the guest
+     * in the error case above.
+     */
+    spapr->fwnmi_machine_check_interlock = cpu->vcpu_id;
+
     stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFSET,
                 env->gpr[3]);
     cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
@@ -876,9 +888,15 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
          * that CPU called "ibm,nmi-interlock")
          */
         if (spapr->fwnmi_machine_check_interlock == cpu->vcpu_id) {
-            error_report(
+            if (!recovered) {
+                error_report(
 "FWNMI: Unable to deliver machine check to guest: nested machine check.");
-            qemu_system_guest_panicked(NULL);
+                qemu_system_guest_panicked(NULL);
+            } else {
+                warn_report(
+"FWNMI: Unable to deliver machine check to guest: nested machine check. "
+"Machine check recovered.");
+            }
             return;
         }
         qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_cond);
@@ -906,7 +924,6 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
         warn_report("Received a fwnmi while migration was in progress");
     }
 
-    spapr->fwnmi_machine_check_interlock = cpu->vcpu_id;
     spapr_mce_dispatch_elog(cpu, recovered);
 }
 
-- 
2.23.0


