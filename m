Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85746C3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F132077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJj/rovf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F132077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Awi-0008FH-RA
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArK-0002h8-Jn
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArJ-0005sB-8f
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArJ-0005ra-2M
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id q19so9923449wmc.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bIBiqHwLNlw6akaBX7exBs2n/dBWc3wYnn3LUfBBjxw=;
 b=bJj/rovfgKg8U81FEH4qt3vzVDA/yiq2X0ciAAwJsr0WM1L697GLHT1lvL/+It5ndd
 CfoG4ejG3laP3spJI9yywP8PV4wTHXEq/8Rh4Bqul7PAVJAPCW65nTDoL1UTlCZaXSW8
 A4TpQDaF/j/BUWH/JBBG5Orx2Eel7cQUVTNOJWfyNSVBi6kCMgcrNGthcqLZbCXE1PJt
 601FSERVzMYasqGCS3P8Aix1f+oQC1FX1uEcj8K0aF6Axt5Xl2PN210Z1OFSmoVbXVBr
 yK4cw6AwUnvHCP8qbdskAW3O3/DXY9C7yUDJa8nHkmdfU28oHBnx/LxLfV02bo3Eq5fV
 6+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bIBiqHwLNlw6akaBX7exBs2n/dBWc3wYnn3LUfBBjxw=;
 b=k5XS7UF7uAf7XV+UhP5in61d5l8CTcia9RVxmv3+iBhWR30mHMkV9Spmd33c+VTGGF
 8mG3ahLo2dgWb92zziVge6c44O0o7zhtLz9po5Yie17ZLUlgaUxybcew+RHGjmlT6Hfd
 3QDZ5umiI8nP4v2TcPMuhWAH8mz0znpyikMyGbpeyLuVFPPsw0Q/fCCOQn63999F10UG
 okt4+o/o6rsQVlQoxeUYegx218dRYDE4KklDGAMqJUUXx80atd35OnA+0O8PX4kMbk97
 I1Dv4JwpCMjxxCYlaYllFS6wIK0MevwWm9Q0236HMj6Mt7vvrbAAxSJP+YEwyQQOGkIW
 CUWQ==
X-Gm-Message-State: APjAAAVW9EJfsxNg/cORue9eo9DU1xWoBiMdZaI5o+qKf85HSRZiTgFN
 q0vLxks7VH5FUCGm93ba+lzHt3iabee8Ew==
X-Google-Smtp-Source: APXvYqwgEbh/y8Q2TLB5tRj2LQL1Igw6Rz+iAkN43LOFNFzZwmRIGBiNG4ons3R72Hd8YaHlzKwDQA==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr796752wme.41.1567524999788;
 Tue, 03 Sep 2019 08:36:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:15 +0100
Message-Id: <20190903153633.6651-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 03/21] target/arm: Allow ARMCPRegInfo read/write
 functions to throw exceptions
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

Currently the only part of an ARMCPRegInfo which is allowed to cause
a CPU exception is the access function, which returns a value indicating
that some flavour of UNDEF should be generated.

For the ATS system instructions, we would like to conditionally
generate exceptions as part of the writefn, because some faults
during the page table walk (like external aborts) should cause
an exception to be raised rather than returning a value.

There are several ways we could do this:
 * plumb the GETPC() value from the top level set_cp_reg/get_cp_reg
   helper functions through into the readfn and writefn hooks
 * add extra readfn_with_ra/writefn_with_ra hooks that take the GETPC()
   value
 * require the ATS instructions to provide a dummy accessfn,
   which serves no purpose except to cause the code generation
   to emit TCG ops to sync the CPU state
 * add an ARM_CP_ flag to mark the ARMCPRegInfo as possibly
   throwing an exception in its read/write hooks, and make the
   codegen sync the CPU state before calling the hooks if the
   flag is set

This patch opts for the last of these, as it is fairly simple
to implement and doesn't require invasive changes like updating
the readfn/writefn hook function prototype signature.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20190816125802.25877-2-peter.maydell@linaro.org
---
 target/arm/cpu.h           | 6 +++++-
 target/arm/translate-a64.c | 6 ++++++
 target/arm/translate.c     | 7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0981303170a..297ad5e47ad 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2212,6 +2212,9 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
  * IO indicates that this register does I/O and therefore its accesses
  * need to be surrounded by gen_io_start()/gen_io_end(). In particular,
  * registers which implement clocks or timers require this.
+ * RAISES_EXC is for when the read or write hook might raise an exception;
+ * the generated code will synchronize the CPU state before calling the hook
+ * so that it is safe for the hook to call raise_exception().
  */
 #define ARM_CP_SPECIAL           0x0001
 #define ARM_CP_CONST             0x0002
@@ -2230,10 +2233,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_FPU               0x1000
 #define ARM_CP_SVE               0x2000
 #define ARM_CP_NO_GDB            0x4000
+#define ARM_CP_RAISES_EXC        0x8000
 /* Used only as a terminator for ARMCPRegInfo lists */
 #define ARM_CP_SENTINEL          0xffff
 /* Mask of only the flag bits in a type field */
-#define ARM_CP_FLAG_MASK         0x70ff
+#define ARM_CP_FLAG_MASK         0xf0ff
 
 /* Valid values for ARMCPRegInfo state field, indicating which of
  * the AArch32 and AArch64 execution states this register is visible in.
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9183f89ba39..4d09ae6f424 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1714,6 +1714,12 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         tcg_temp_free_ptr(tmpptr);
         tcg_temp_free_i32(tcg_syn);
         tcg_temp_free_i32(tcg_isread);
+    } else if (ri->type & ARM_CP_RAISES_EXC) {
+        /*
+         * The readfn or writefn might raise an exception;
+         * synchronize the CPU state in case it does.
+         */
+        gen_a64_set_pc_im(s->pc_curr);
     }
 
     /* Handle special cases first */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 66311580c05..78d93f63cab 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7191,6 +7191,13 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             tcg_temp_free_ptr(tmpptr);
             tcg_temp_free_i32(tcg_syn);
             tcg_temp_free_i32(tcg_isread);
+        } else if (ri->type & ARM_CP_RAISES_EXC) {
+            /*
+             * The readfn or writefn might raise an exception;
+             * synchronize the CPU state in case it does.
+             */
+            gen_set_condexec(s);
+            gen_set_pc_im(s, s->pc_curr);
         }
 
         /* Handle special cases first */
-- 
2.20.1


