Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A4CC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFC7206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6MWrrGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFC7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35099 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRJB-0005yp-BN
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:04:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9e-0005tB-Jh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9d-0003UC-IB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:42 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR9d-0003Tu-Cd; Fri, 03 May 2019 01:54:41 -0400
Received: by mail-pf1-x443.google.com with SMTP id z28so2361384pfk.0;
	Thu, 02 May 2019 22:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=iRgrjuJWAeNPPmfwJhAiW5ZkTsvnUdrbfqd5lYY/Gao=;
	b=J6MWrrGNtXMEAyyLNtz2wxWmsJYN/EMNmQKK1zxdLiWWWgRhchYdhypyJtZ/enyrGf
	uYcpvK058DCyLnICTItewfkVEqMQRVRuquA130/1MX2JRWtfpDGVXTEArm8MZcj/5nyV
	iHwWhafVbP92A195FnIK0H+286k5n5oB4Pi6KQodPR649zElWuG0EZEH2ZAvJcQgA4F3
	C804Yjr3WruWdO25WyY8wDPhYY1JyBFqSXLrHYdvvvp+u7v7LZmD4xaBkt2ZmmkY67uZ
	GaSwc4jqDV+HX7cLb+OOHluaIhz52yyQP0m5hO41pD+tLm00jtyacWOE5Q56CuH/FSPK
	OcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=iRgrjuJWAeNPPmfwJhAiW5ZkTsvnUdrbfqd5lYY/Gao=;
	b=hXAnRPMoWL2MVLKNsqPf7boComPXSJUyj4IspBMEypjpcMhE1Gaad2JaRQ8JEVYB+Y
	6as9k6uMpZEnKsfuFPh4luRw1+hvB+YFuhIgBxk8rAGRiEmMaFo0LFFw/aqj8WXlBagU
	zn1EbtVshZuqT5qCv7TAuOIX7NMKoC2efMsqcsteBW/+ZHlZ/6if5dHw2BykAvyTu1kc
	Xd6r1eLIqgIh7B3RSV1wRWRaKL3NUzp83gsktOrJtko5UtZyEpkAgz02ZVYqw0djZPrZ
	sATIPbnLbB6M1C6tJ2joRHo4GI/NZndt6HaPmP5lPfL5hnFIbeCguTFSOW1+tXKrYeoD
	dgUg==
X-Gm-Message-State: APjAAAWtrQPKkUpjCgQDo9VyYPMR4jsRbrfwsp4cc/uiL/6uhWu/hdjG
	QX5B1Ba7vv9/Q4zM2WW7KwZkybsxMjI=
X-Google-Smtp-Source: APXvYqxFzLNfjlVGTT7FMlUfUDWgfYOsYKnCqqiXjmNRzcwjZTwOyRF298YUrILqk/ft8qsmqCWGIg==
X-Received: by 2002:a63:1d4f:: with SMTP id d15mr7840690pgm.347.1556862880285; 
	Thu, 02 May 2019 22:54:40 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.54.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:54:39 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:16 +1000
Message-Id: <20190503055316.6441-14-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 13/13] target/ppc: Enable
 SPAPR_CAP_NESTED_KVM_HV under tcg
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503055316.xWpwPLVFeuonEeeuvIEkp1O7NrWpVHdi90lvLlYWlyw@z>

It is now possible to use nested kvm-hv under tcg, thus allow for it to
be enabled.

Note that nested kvm-hv requires that rc updates to ptes be done by
software, otherwise the page tables get out of sync. So disable hardware
rc updates when nested kvm-hv is enabled.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_caps.c      | 22 ++++++++++++++++++----
 target/ppc/cpu.h         |  1 +
 target/ppc/mmu-radix64.c |  4 ++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 3278c09b0f..7fe07d83dd 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -389,10 +389,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
         return;
     }
 
-    if (tcg_enabled()) {
-        error_setg(errp,
-                   "No Nested KVM-HV support in tcg, try cap-nested-hv=off");
-    } else if (kvm_enabled()) {
+    if (kvm_enabled()) {
         if (!kvmppc_has_cap_nested_kvm_hv()) {
             error_setg(errp,
 "KVM implementation does not support Nested KVM-HV, try cap-nested-hv=off");
@@ -400,6 +397,22 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
                 error_setg(errp,
 "Error enabling cap-nested-hv with KVM, try cap-nested-hv=off");
         }
+    } /* else { nothing required for tcg } */
+}
+
+static void cap_nested_kvm_hv_cpu_apply(SpaprMachineState *spapr,
+                                        PowerPCCPU *cpu,
+                                        uint8_t val, Error **errp)
+{
+    CPUPPCState *env = &cpu->env;
+
+    if (tcg_enabled() && val) {
+        if (env->spr[SPR_PVR] != 0x004E1202) {
+            error_setg(errp, "Nested KVM-HV only supported on POWER9 DD2.2, "
+                             "try cap-nested-hv=off or -cpu power9_v2.2");
+            return;
+        }
+        env->disable_hw_rc_updates = true;
     }
 }
 
@@ -544,6 +557,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .set = spapr_cap_set_bool,
         .type = "bool",
         .apply = cap_nested_kvm_hv_apply,
+        .cpu_apply = cap_nested_kvm_hv_cpu_apply,
     },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
         .name = "large-decr",
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 426015c9cd..6502e0de82 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1237,6 +1237,7 @@ struct CPUPPCState {
     target_ulong hv_ptr, regs_ptr;
     struct hv_guest_state l2_hv, l1_saved_hv;
     struct pt_regs l2_regs, l1_saved_regs;
+    bool disable_hw_rc_updates;
 };
 
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 2a8147fc38..cc06967dbe 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -31,9 +31,9 @@
 static inline bool ppc_radix64_hw_rc_updates(CPUPPCState *env)
 {
 #ifdef CONFIG_ATOMIC64
-    return true;
+    return !env->disable_hw_rc_updates;
 #else
-    return !qemu_tcg_mttcg_enabled();
+    return !qemu_tcg_mttcg_enabled() && !env->disable_hw_rc_updates;
 #endif
 }
 
-- 
2.13.6


