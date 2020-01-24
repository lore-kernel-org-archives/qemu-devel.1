Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCF9C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E8B2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="punFJQzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E8B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunFA-0007Q2-SA
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCW-0001e8-Pl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCV-000599-FY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:51:56 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCV-00058k-91; Thu, 23 Jan 2020 19:51:55 -0500
Received: by mail-wm1-x342.google.com with SMTP id g1so72404wmh.4;
 Thu, 23 Jan 2020 16:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7nhPtElT5dcpIVZ2NrsJhCxZsHHTxQARtHEdVtHVrDE=;
 b=punFJQzpW+NSwK7sFbfigOitnCkkuBdV8EJkkdLkMXCSyGCCWBXqk6MvCzZ/wBQ03h
 D7Fpz9Nr1awAZ1zby73hbq5nCE+reK2YHw9VIlGkET65ki2KAQ77kS2wdmO4n63hX/BQ
 TejpmXq6IP0N2eUw37C7KL9kwStCIGs8pXl6jb/9DSIKEY+6FkHAdvCFYJzJEiEN+NBB
 nf0mx+/RFroN9cm2deU+lWkr7EF86yMLRgSNH7ZEWSKlkmImbxi9ACiIgTvWnu6rZWJd
 9mj8a/xU66tNqSUkP20aIpFh8nBr8eoKwKsEgOXopxZD3B3ea0xp6NHcR6zXgF+ZzpV4
 4uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7nhPtElT5dcpIVZ2NrsJhCxZsHHTxQARtHEdVtHVrDE=;
 b=TqxudghcXy+5DyfQtqhAJ4mKKGSUq5yos+2Aju4/Bje5h8kpBbn2mwLTFAC/EoxoWg
 83CyKyBbyp/K+V3H20p+8b2wCDW8VEpHM6+xNVrifjle5YjVnGfxZ31GrzuTTqpVdPD+
 Kf7oxb52dJjx4HwLDatASYEwQkSjR/4HIoijTfM1XaD9U/mT0V3GtjacZBFElvxh8cW6
 aX/ZinEgcYUIYsilyeiGddRjOUgXKv/oq09OAjrzJ1YwgdmmjVM0Z0DAgJz3yIrWwwRK
 dWOSqRvn/bx3a6qco2aU2eDRuD23rXAAeUtFuq55wKn1poBulB0LP0xTFbKzCS2ncPDd
 Nt4A==
X-Gm-Message-State: APjAAAXH9lpDpWR21nygDnvQjvse2UP/sihKxYL/UeL34H736MojpWlw
 hf2m/1/uPa06oar18VsVxZNM9VW1
X-Google-Smtp-Source: APXvYqy3q5r+EEN6tirfxVhF6hlyAZAzfzZAfLwDhe4TxfSs84eIRR4r0fsaqr9q2tidCaXEDrFjNA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr564016wmk.172.1579827113772; 
 Thu, 23 Jan 2020 16:51:53 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:51:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 08/25] target/avr: Add instruction translation - MCU
 Control Instructions
Date: Fri, 24 Jan 2020 01:51:14 +0100
Message-Id: <20200124005131.16276-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
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
Message-Id: <20200118191416.19934-9-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 target/avr/insn.decode |  8 +++++
 2 files changed, 76 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 58775af17c..4c680070e2 100644
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
index 4ee55862b2..f8d32f2258 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -172,3 +172,11 @@ BST             1111 101 rd:5 0 bit:3
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
-- 
2.21.1


