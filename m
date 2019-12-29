Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B441DC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BA02071E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld0faP6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BA02071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilgdZ-0001O4-Gv
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilgUh-0007OF-A2
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilgUg-0003LM-3r
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:03 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilgUf-0003J9-U0
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:02 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so31132138wro.9
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xpfZgnT26wh6XP4aMAQe8AQUYeKm0us2smWVQbWZbdE=;
 b=ld0faP6Gp8uEps0TBsuZ1Ln53yQ2Efbcl8NOVGYMRaXmv2f5Je1Y0/AW2UO0ZEOLBI
 mLE1lE5O+93CuUaX6NaxxEJu+wqvvXc5snjjV83plkZKX/vSl0LeanreQFoAwoheQCh8
 21110+xujhjPR+lPV6+YYqIf2IDPKACtGbk6sFkvYMkzvc5TP/BYl7EgRRkFjzrWEg2r
 dXWdgV8ym5g057USVCv8fNTQP+nJ06LuHqU8Q+rECerLfK4HC0qp8k0OzsbuZw6ZuaCe
 fhgn+tXof+PDjL9AggiPUGn759O/U47qB5YosinOwQ12EThIh8LjQeqwumHM7PVTuirm
 wWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xpfZgnT26wh6XP4aMAQe8AQUYeKm0us2smWVQbWZbdE=;
 b=gBdR8eE1N83OgO99VjfVQOMmMCsnwZ5iXlHZuYLc8GHCHFDma+WQGAkTjGFiIlW6Pj
 LfHB+v+LHdNt9UGu/1cuqFw0J0gBSF8v0gNIW7X+2JXW8bYK8fYlCq2KHcsQLXKmvFHO
 Zh5DL0eEghluKgVAdXAVKd7a2Df+eZiSleHocwQFzUvp+/SPeEIdx9jsJRUucqYmmzyV
 lcyoyP9t2weCuYDupFBItgQIMKPYaI4ZUoaxV5hDPmCQKp7RlMfkVTAJzIp9/nRH+ZtX
 nPziUXBYIotY7xHJqz9szOxHbhq1EyTrjuBEwct+67+eCB60rUQsFVjOwZ4iufGQSGk3
 IAbg==
X-Gm-Message-State: APjAAAWeAM9yAcdeBx3iT2F/7Lzxz2XmD1Xq9XaBOh6eaqZ3DJ3co/4V
 UmyypD6HRmfmXd7fCnwT2SLJgzrKNHlkew==
X-Google-Smtp-Source: APXvYqzSy9147ZUIAvJa/t6KXRIrOimxkjQlUIdylexapI9HHnxsUDRje2nTnZbPtrsg+R0LS1zSUQ==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr66286554wrr.340.1577656380760; 
 Sun, 29 Dec 2019 13:53:00 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-183-93-3.red.bezeqint.net. [79.183.93.3])
 by smtp.gmail.com with ESMTPSA id 25sm18182850wmi.32.2019.12.29.13.52.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 29 Dec 2019 13:53:00 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v40 08/21] target/avr: Add instruction translation - MCU
 Control Instructions
Date: Sun, 29 Dec 2019 23:51:45 +0200
Message-Id: <20191229215158.5788-9-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191229215158.5788-1-mrolnik@gmail.com>
References: <20191229215158.5788-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes:
    - BREAK
    - NOP
    - SLEEP
    - WDR

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 target/avr/insn.decode |  9 ++++++
 2 files changed, 77 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 55706c6b29..246f9e7e47 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2681,3 +2681,71 @@ static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
 
     return true;
 }
+
+/*
+ * MCU Control Instructions
+ */
+
+/*
+ *  The BREAK instruction is used by the On-chip Debug system, and is
+ *  normally not used in the application software. When the BREAK instruction is
+ *  executed, the AVR CPU is set in the Stopped Mode. This gives the On-chip
+ *  Debugger access to internal resources.  If any Lock bits are set, or either
+ *  the JTAGEN or OCDEN Fuses are unprogrammed, the CPU will treat the BREAK
+ *  instruction as a NOP and will not enter the Stopped mode.  This instruction
+ *  is not available in all devices. Refer to the device specific instruction
+ *  set summary.
+ */
+static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_BREAK)) {
+        return true;
+    }
+
+#ifdef BREAKPOINT_ON_BREAK
+    tcg_gen_movi_tl(cpu_pc, ctx->npc - 1);
+    gen_helper_debug(cpu_env);
+    ctx->bstate = DISAS_EXIT;
+#else
+    /* NOP */
+#endif
+
+    return true;
+}
+
+
+/*
+ *  This instruction performs a single cycle No Operation.
+ */
+static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
+{
+
+    /* NOP */
+
+    return true;
+}
+
+
+/*
+ *  This instruction sets the circuit in sleep mode defined by the MCU
+ *  Control Register.
+ */
+static bool trans_SLEEP(DisasContext *ctx, arg_SLEEP *a)
+{
+    gen_helper_sleep(cpu_env);
+    ctx->bstate = DISAS_NORETURN;
+    return true;
+}
+
+
+/*
+ *  This instruction resets the Watchdog Timer. This instruction must be
+ *  executed within a limited time given by the WD prescaler. See the Watchdog
+ *  Timer hardware specification.
+ */
+static bool trans_WDR(DisasContext *ctx, arg_WDR *a)
+{
+    gen_helper_wdr(cpu_env);
+
+    return true;
+}
diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 4ee55862b2..0e4ec9ddf0 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -172,3 +172,12 @@ BST             1111 101 rd:5 0 bit:3
 BLD             1111 100 rd:5 0 bit:3
 BSET            1001 0100 0 bit:3 1000
 BCLR            1001 0100 1 bit:3 1000
+
+#
+# MCU Control Instructions
+#
+BREAK           1001 0101 1001 1000
+NOP             0000 0000 0000 0000
+SLEEP           1001 0101 1000 1000
+WDR             1001 0101 1010 1000
+
-- 
2.17.2 (Apple Git-113)


