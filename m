Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C43BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691C1206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyV2KIsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691C1206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssN8-0003Ux-Ma
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssA2-00089R-2U
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:56231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9z-0002u1-1N
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id g75so70423wme.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K8Od5RoTrgZHXT0STiHKBSYH0Kuox0fs2mOyzEFa/Yg=;
 b=nyV2KIsllIk9bJ2/1vkkafWPHrdM0pumAZ3pvSPF5sUWrB6G+3qXZwJ9IwVOMI8kIi
 9q3oy4XEu0j6CXqq0ZbcLl/5EIcdecSSkd7LSUjWLKopihGrJhXaXDTBbzsChTPmsBw0
 oi6evbzeYGMzB9zX8CksDHVPkMVIBU9p/xYMFqD4ltxHUtilUdOb8yy2Knd4G/Eo40kh
 anBq1GCLFAdYwK0LuSxSY+Te47FqJEy4RJGnoZmY+Fd6xeVGibQWASCqKhrufkHHVI6+
 onsYeYiwMc/Rsr77Iw6LnHawK88I9P7uVdGJOlZ0LZ4w9Y6npm7HU2clUhaozIxIB4LB
 sYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K8Od5RoTrgZHXT0STiHKBSYH0Kuox0fs2mOyzEFa/Yg=;
 b=EU8U+IZPv4l4IIZTEF9VMbGbP1wQ7HV7tKardJQCzO6bGZclGFHbNO40m1f6thritt
 gPFEdJgM++vVALXcqNWtFOQSLEafz2LvkxWvDjukCI48vXHMCtUNcSe3X4Zw2Zrs3A29
 R+YwWA49XFoNBBZY5ka3UnB6VjaePXAibxK8Psv5fvZlOEXC/R+uyPTh9BmODq9/1kj3
 3GN30/+GOmdUB652XFzJ7Z6e9xDygpZspp4RTZ1HnPBvd3Pcn82DzC1v19FtUNl/HzdS
 /Kg5VT8lRqcZRNTgtVtIRgWu6KQPlsWIk0yKvL48gcCjXB5QYrq+Fcw1EeC05IgVrrOS
 wS2Q==
X-Gm-Message-State: AOAM530iyTGXqpUeSyGKrffAXSHeas4v+kEhyCuymQjFfCzVioqBsHFB
 rcXHuL1A1ukr/8lS+9NF0WUZSaP3
X-Google-Smtp-Source: ABdhPJyFhPzdbxlpwFdFdNFnmlb4BXAe03iYfjiUozqfHROQon3iGjz8x+6grY/hBhz2XsEPL/rXKg==
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr5377021wmj.63.1594145857464; 
 Tue, 07 Jul 2020 11:17:37 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/32] target/avr: Add instruction translation - MCU Control
 Instructions
Date: Tue,  7 Jul 2020 20:16:53 +0200
Message-Id: <20200707181710.30950-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes:
    - BREAK
    - NOP
    - SLEEP
    - WDR

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-16-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/insn.decode |  8 ++++++
 target/avr/translate.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 7bb6ce7495..482c23ad0c 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -177,3 +177,11 @@ BST             1111 101 rd:5 0 bit:3
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
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 884fbb6081..ee7811995a 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2740,3 +2740,68 @@ static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
 
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
-- 
2.21.3


