Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A37C41514
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318AF2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wz3vRxuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318AF2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2P3S-0001In-Nh
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1g-00080c-B8
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1e-00074j-UR
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:56 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2P1e-00074S-NT
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:54 -0400
Received: by mail-pf1-x442.google.com with SMTP id w16so12864405pfn.7
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 17:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1Zuq0tlzGGwhy0svpkvA02+v0ve2QXCamXjAcXS3hRU=;
 b=wz3vRxuBD6UPQTIhRv7cdTw+9ujVORoAZhJmq+jpyxfZughOoKdbZzLP/R1nAUATun
 a6VZv2ybBw+lnFk4wMLsImrQpCJo2rIa8dmYEDSkzpAhcDMZBnXmWyfHUQk7+y0GmIHC
 uxxPgmJmVozTYbm5qO7bAEequ2ztCVouBaxipivrIh0FPUSACpJiScKgwtMFOYpc14kq
 jUJFsnbcHMXExYKQ1v429ptQdhiwcLqmt+TxzVDT1vCDtQ1UZVUdPC+A3xfIFyY7HshD
 kiGJadOBVEKSsc7HPrYKxve6Sx0a9BOZt2HSo8XR8o+sabdsyhJUpzMOjP2Hd14KUA8h
 QyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1Zuq0tlzGGwhy0svpkvA02+v0ve2QXCamXjAcXS3hRU=;
 b=LYRllQee8VyEAGTxIFq+0zguIcZcwAJsK/CT06gHGVbhNdOgQtq0AjkbfBCPrflUNL
 af6cpObsv2hL/CGEqce8baPh32P/WaQfsCl5N+LhKFy/k9aiG61jJQIXNtFSGQabILfT
 tgupubMKXo11EeVymtBiw/pRktJ6oY6bS4VJ5ov/2+HK8AD0qj/erSlNveAx9cgt5/Dt
 zHNzKCv/yeJm6lHYnid0bJXRaYv/6T4TfTMO6tJ0q9+2+tpZpvBfKViM0wN5CQmjXf/k
 76/eagkg1eRczwSSaeEhA2w+HG8lv+QrkyKbHEUu84/S5/GSFDQB9J3EPI05bMKXXyW5
 /Sgg==
X-Gm-Message-State: APjAAAWzbi2NbNTXhEF79gdJl/cPtvcbLlbjn0BbVPVIv3DXAnSWIOcL
 mJ5pSDHx3ImmtGYnWXYtiRU/hlZRWIM=
X-Google-Smtp-Source: APXvYqyqWnwTnLZux5wbhmEpedsLP3KWy0c9pXzKdxR2xU7DKli48jpXYV4Y46NR1mEZAONkpWWr/A==
X-Received: by 2002:a63:553:: with SMTP id 80mr18211538pgf.280.1566864473428; 
 Mon, 26 Aug 2019 17:07:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e189sm11691067pgc.15.2019.08.26.17.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 17:07:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 17:07:37 -0700
Message-Id: <20190827000745.19645-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827000745.19645-1-richard.henderson@linaro.org>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 05/13] target/openrisc: Move VR, UPR, DMMCFGR,
 IMMCFGR to cpu init
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
Cc: shorne@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These registers are read-only and implementation specific.
Initiailize VR for the first time; take the OR1200 values
from the verilog source.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h        |  8 ++++----
 target/openrisc/cpu.c        | 23 ++++++++++++++++-------
 target/openrisc/sys_helper.c |  4 ++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 755282f95d..18d7445e74 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -260,10 +260,6 @@ typedef struct CPUOpenRISCState {
     target_ulong sr_cy;       /* the SR_CY bit, values 0, 1.  */
     target_long  sr_ov;       /* the SR_OV bit (in the sign bit only) */
     uint32_t sr;              /* Supervisor register, without SR_{F,CY,OV} */
-    uint32_t vr;              /* Version register */
-    uint32_t upr;             /* Unit presence register */
-    uint32_t dmmucfgr;        /* DMMU configure register */
-    uint32_t immucfgr;        /* IMMU configure register */
     uint32_t esr;             /* Exception supervisor register */
     uint32_t evbar;           /* Exception vector base address register */
     uint32_t pmr;             /* Power Management Register */
@@ -283,7 +279,11 @@ typedef struct CPUOpenRISCState {
     struct {} end_reset_fields;
 
     /* Fields from here on are preserved across CPU reset. */
+    uint32_t vr;              /* Version register */
+    uint32_t upr;             /* Unit presence register */
     uint32_t cpucfgr;         /* CPU configure register */
+    uint32_t dmmucfgr;        /* DMMU configure register */
+    uint32_t immucfgr;        /* IMMU configure register */
 
 #ifndef CONFIG_USER_ONLY
     QEMUTimer *timer;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index f19e482a55..d9f447e90c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -56,13 +56,6 @@ static void openrisc_cpu_reset(CPUState *s)
     cpu->env.lock_addr = -1;
     s->exception_index = -1;
 
-    cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP |
-                   UPR_PMP;
-    cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2))
-                      | (DMMUCFGR_NTS & (ctz32(TLB_SIZE) << 2));
-    cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2))
-                      | (IMMUCFGR_NTS & (ctz32(TLB_SIZE) << 2));
-
 #ifndef CONFIG_USER_ONLY
     cpu->env.picmr = 0x00000000;
     cpu->env.picsr = 0x00000000;
@@ -117,15 +110,31 @@ static void or1200_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
+    cpu->env.vr = 0x13000008;
+    cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP | UPR_PMP;
     cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_OF32S |
                        CPUCFGR_EVBARP;
+
+    /* 1Way, TLB_SIZE entries.  */
+    cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2))
+                      | (DMMUCFGR_NTS & (ctz32(TLB_SIZE) << 2));
+    cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2))
+                      | (IMMUCFGR_NTS & (ctz32(TLB_SIZE) << 2));
 }
 
 static void openrisc_any_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
+    cpu->env.vr = 0x13000000;
+    cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP | UPR_PMP;
     cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_EVBARP;
+
+    /* 1Way, TLB_SIZE entries.  */
+    cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2))
+                      | (DMMUCFGR_NTS & (ctz32(TLB_SIZE) << 2));
+    cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2))
+                      | (IMMUCFGR_NTS & (ctz32(TLB_SIZE) << 2));
 }
 
 static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index d20f48b659..a2b1f52294 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -199,13 +199,13 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
         return env->vr;
 
     case TO_SPR(0, 1): /* UPR */
-        return env->upr;    /* TT, DM, IM, UP present */
+        return env->upr;
 
     case TO_SPR(0, 2): /* CPUCFGR */
         return env->cpucfgr;
 
     case TO_SPR(0, 3): /* DMMUCFGR */
-        return env->dmmucfgr;    /* 1Way, 64 entries */
+        return env->dmmucfgr;
 
     case TO_SPR(0, 4): /* IMMUCFGR */
         return env->immucfgr;
-- 
2.17.1


