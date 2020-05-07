Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B68C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6172073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEl0+1Qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6172073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWgym-0002lL-6H
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWgsd-0002si-HG
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:48:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWgsZ-0002QK-AO
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:48:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id h9so6498922wrt.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=omD69ttFpxcDTaYekNBFVUzGkRuZKIclc+69h9JbEvA=;
 b=IEl0+1Qh8WlMukYuKO3rZbTOC+RE6IQVl4gHr8vXgUgCjDXYIm3uIEU7grgG06pBGN
 j2rohfKXSesZ9uVtfxxG5wA4YML1chSKWFXlaIe0dFKNgfiXWVyHF3UJyPYCnuEc26zh
 t8p4igrhcHJHzaFrnQxk+6BK6Zl9xY0BtC9Us/zt1LzSmL9yJAM3us7wQzy2f2mM1a9Z
 NgzM+2N5fANampKxM/P/OfN02KmDhm/IC3ExDczryKJXYfjQpQYSnrnYdT1txh9oN9NZ
 eJcAhtd9AjKGW9Sv2xrOcJaQ8v+j2sEVU/nWFGGJN+/m0VRpj3927akvbtiFX+klas+j
 Sguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=omD69ttFpxcDTaYekNBFVUzGkRuZKIclc+69h9JbEvA=;
 b=Hz82gEuNPxCmIpymSmyw5wMwNC5FJ9vSBx3tv/PaUjz24L+Z51smTKlle5RiG2gwsH
 uKCUgc8aS/rEVkc/8F5MV5HPe5tfDJKPgVB8YfunqBzX8b8VovoeGdYep98z1fb7+FPX
 XAsUh3l8HB7WYLws7GQqTETWuIUlo2hAi+WmR923xSV2qmPL5jYup4GDCZdYEyO/u4Gs
 qK3X8WO8znh7ohBZnglpz+RJcUZvlFthzvbdIsY7O5LXB526V/NDWMBLL+oXPYZT2OV+
 iRcG+54hRiabieM1Mwd1bLhNLxq4fe1JmVgRgimlTkHRDLYfm3+hYYxVST0AemyXQCnA
 AZNQ==
X-Gm-Message-State: AGi0Pua6iL6XtCLNFE9vZ6G6X4lrrSax+pykCt05jYY2Ueadn3INDOKP
 wgEfTk0njtc+qa+Q8o48/7XoKQ==
X-Google-Smtp-Source: APiQypLnO7e9CdfS83/GTPKjicsihUykbO0KKDNY69D/i432klDgPncsXorVQkMlGcyPaX6CKDyg8g==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr15299876wru.405.1588859277480; 
 Thu, 07 May 2020 06:47:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s14sm8443128wme.33.2020.05.07.06.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 06:47:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Use correct GDB XML for M-profile cores
Date: Thu,  7 May 2020 14:47:55 +0100
Message-Id: <20200507134755.13997-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GDB's remote protocol requires M-profile cores to use the feature
name 'org.gnu.gdb.arm.m-profile' instead of the 'org.gnu.gdb.arm.core'
feature used for A- and R-profile cores. We weren't doing this, which
meant GDB treated our M-profile cores like A-profile ones. This mostly
doesn't matter, but for instance means that it doesn't correctly
handle backtraces where an M-profile exception frame is involved.

Ship a copy of GDB's arm-m-profile.xml and use it on the M-profile
cores.  The integer registers have the same offsets as the
arm-core.xml, but register 25 is the M-profile XPSR rather than the
A-profile CPSR, so we need to update arm_cpu_gdb_read_register() and
arm_cpu_gdb_write_register() to handle XSPR reads and writes.

Fixes: https://bugs.launchpad.net/qemu/+bug/1877136
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure                 |  4 ++--
 target/arm/cpu.c          |  1 +
 target/arm/gdbstub.c      | 22 ++++++++++++++++++----
 gdb-xml/arm-m-profile.xml | 27 +++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 6 deletions(-)
 create mode 100644 gdb-xml/arm-m-profile.xml

diff --git a/configure b/configure
index 0d69c360c0e..360e7e6a0a4 100755
--- a/configure
+++ b/configure
@@ -7806,14 +7806,14 @@ case "$target_name" in
     TARGET_SYSTBL_ABI=common,oabi
     bflt="yes"
     mttcg="yes"
-    gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
+    gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"
   ;;
   aarch64|aarch64_be)
     TARGET_ARCH=aarch64
     TARGET_BASE_ARCH=arm
     bflt="yes"
     mttcg="yes"
-    gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
+    gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"
   ;;
   cris)
   ;;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5d64adfe76e..b386bbbfd12 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2179,6 +2179,7 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
 #endif
 
     cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
+    cc->gdb_core_xml_file = "arm-m-profile.xml";
 }
 
 static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 063551df234..ecfa88f8e60 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -57,8 +57,12 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         }
         return gdb_get_reg32(mem_buf, 0);
     case 25:
-        /* CPSR */
-        return gdb_get_reg32(mem_buf, cpsr_read(env));
+        /* CPSR, or XPSR for M-profile */
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            return gdb_get_reg32(mem_buf, xpsr_read(env));
+        } else {
+            return gdb_get_reg32(mem_buf, cpsr_read(env));
+        }
     }
     /* Unknown register.  */
     return 0;
@@ -98,8 +102,18 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         return 4;
     case 25:
-        /* CPSR */
-        cpsr_write(env, tmp, 0xffffffff, CPSRWriteByGDBStub);
+        /* CPSR, or XPSR for M-profile */
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            /*
+             * Don't allow writing to XPSR.Exception as it can cause
+             * a transition into or out of handler mode (it's not
+             * writeable via the MSR insn so this is a reasonable
+             * restriction). Other fields are safe to update.
+             */
+            xpsr_write(env, tmp, ~XPSR_EXCP);
+        } else {
+            cpsr_write(env, tmp, 0xffffffff, CPSRWriteByGDBStub);
+        }
         return 4;
     }
     /* Unknown register.  */
diff --git a/gdb-xml/arm-m-profile.xml b/gdb-xml/arm-m-profile.xml
new file mode 100644
index 00000000000..5319d764eeb
--- /dev/null
+++ b/gdb-xml/arm-m-profile.xml
@@ -0,0 +1,27 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2020 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.arm.m-profile">
+  <reg name="r0" bitsize="32"/>
+  <reg name="r1" bitsize="32"/>
+  <reg name="r2" bitsize="32"/>
+  <reg name="r3" bitsize="32"/>
+  <reg name="r4" bitsize="32"/>
+  <reg name="r5" bitsize="32"/>
+  <reg name="r6" bitsize="32"/>
+  <reg name="r7" bitsize="32"/>
+  <reg name="r8" bitsize="32"/>
+  <reg name="r9" bitsize="32"/>
+  <reg name="r10" bitsize="32"/>
+  <reg name="r11" bitsize="32"/>
+  <reg name="r12" bitsize="32"/>
+  <reg name="sp" bitsize="32" type="data_ptr"/>
+  <reg name="lr" bitsize="32"/>
+  <reg name="pc" bitsize="32" type="code_ptr"/>
+  <reg name="xpsr" bitsize="32" regnum="25"/>
+</feature>
-- 
2.20.1


