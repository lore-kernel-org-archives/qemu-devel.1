Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967AFC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620C92064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cK6JxAMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620C92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybsz-0002XF-GR
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hybo0-0005yK-Oj
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hybnz-0000LW-FH
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hybnz-0000Km-8J
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id p17so1453201wrf.11
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kiHYxixAH+hnIg9DQ+VKLaTdfWcHEjePhgVIqnM4T2g=;
 b=cK6JxAMPmhtLCGGXFI5/HleR0DoMx/pe8kfq3ZVwcrXmxKpJjFW7FnoRoqDIgbCd7D
 0R3o/IkUbIrhdxmE4qzXHdgnYKxPyp6hueC23cAVx+dr+lDUbUbxEsF8wc6Cd+tiaH+5
 tsWTqGkRjk4Go9rG3NH6RhDnrG1AKGSDADHZAm31NYAMQLcov/Qviof6jZdwrUF6ZKYv
 YWQQE8mhyoZDKCkXNs/IuqN3+D4AS/rw1QXupeBbESymC9zLbi8NkY1EvhYzwJZa04EO
 WpXHAenQv60qr2GsHEbnM6Mw3feR71C1AEjnbMfYSucao5YxBfFAmVsmX9WqujOBj1yf
 670g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kiHYxixAH+hnIg9DQ+VKLaTdfWcHEjePhgVIqnM4T2g=;
 b=hFatmNmsIO3XCqn4RvCzTLRxrqEk96Wsy9+nvrpAc8DTbhwcuPBbubugaiHn5IMBkg
 /ATAWtcDw7vfCplKxHC46js1ezLVYNTQHfl39wYR1BTnnnyGS1Rj7h5WLNykzeY0JSeo
 cGBA800CVglGx5obGDrUoUDXVQy3tT6K6ABAJh/q6puf3M7NmvOGZLhk1JP65qWXepze
 McP66GQRVUQ1sLzpaknNOTFeOMhn8nNS1eC4CQ1Hr5j4jbnGSJvfmPidLcgzFrlY/Wa0
 Rpc90eK/HlUm2Sam1Rjdal/y9ktMe/z0nzmqWETTk3suQLAO1RtAvY43e7rrcik/ylgr
 ZIxA==
X-Gm-Message-State: APjAAAVvnOwraF4eoUYaOWL4/NqAI0dil37dEgT+3BGgIj5r2KIFOeB9
 Gdv5tgVBgkLoHa/Z0LIqiSXYww==
X-Google-Smtp-Source: APXvYqxRILS4aPmLazZtvajfaheRIqUBExgLxEYBqQDGF1meVIPfh4OD9y1MC8n9BxJYs92XjGWKOw==
X-Received: by 2002:adf:e708:: with SMTP id c8mr11046060wrm.25.1565960286137; 
 Fri, 16 Aug 2019 05:58:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a19sm17594348wra.2.2019.08.16.05.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 05:58:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 13:58:01 +0100
Message-Id: <20190816125802.25877-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816125802.25877-1-peter.maydell@linaro.org>
References: <20190816125802.25877-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 1/2] target/arm: Allow ARMCPRegInfo read/write
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
---
 target/arm/cpu.h           | 6 +++++-
 target/arm/translate-a64.c | 6 ++++++
 target/arm/translate.c     | 7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94c990cddbd..021b552334b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2206,6 +2206,9 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
  * IO indicates that this register does I/O and therefore its accesses
  * need to be surrounded by gen_io_start()/gen_io_end(). In particular,
  * registers which implement clocks or timers require this.
+ * RAISES_EXC is for when the read or write hook might raise an exception;
+ * the generated code will synchronize the CPU state before calling the hook
+ * so that it is safe for the hook to call raise_exception().
  */
 #define ARM_CP_SPECIAL           0x0001
 #define ARM_CP_CONST             0x0002
@@ -2224,10 +2227,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
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
index d3231477a27..908a186bfec 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1729,6 +1729,12 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         tcg_temp_free_ptr(tmpptr);
         tcg_temp_free_i32(tcg_syn);
         tcg_temp_free_i32(tcg_isread);
+    } else if (ri->type & ARM_CP_RAISES_EXC) {
+        /*
+         * The readfn or writefn might raise an exception;
+         * synchronize the CPU state in case it does.
+         */
+        gen_a64_set_pc_im(s->pc - 4);
     }
 
     /* Handle special cases first */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462b21b..da38e15be8d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7228,6 +7228,13 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             tcg_temp_free_ptr(tmpptr);
             tcg_temp_free_i32(tcg_syn);
             tcg_temp_free_i32(tcg_isread);
+        } else if (ri->type & ARM_CP_RAISES_EXC) {
+            /*
+             * The readfn or writefn might raise an exception;
+             * synchronize the CPU state in case it does.
+             */
+            gen_set_condexec(s);
+            gen_set_pc_im(s, s->pc - 4);
         }
 
         /* Handle special cases first */
-- 
2.20.1


