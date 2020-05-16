Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F53AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E3520671
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/nDkRHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E3520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja0uV-0004zA-HD
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tQ-0002uQ-12
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:36 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tP-0008Mi-BJ
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:35 -0400
Received: by mail-lj1-x241.google.com with SMTP id o14so5581438ljp.4
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u+u2GTLpTwv9NrMPHkakKvWn/ABYNzXl/Rjh49VH7qg=;
 b=T/nDkRHkrCcINh2+rgRSsyzK0O1ure9Vey9bXzz+v/ERixEDw8P79ImQ/pDorm/TJC
 GQL3A55B0Q4eawBspFPhwEDs5WYmENbMqImkh/W4GJ7lDmmmou6j3Ar9QaR1pINlyzIC
 m7BQaGOi2wIyCuNk4wbugeVUNy3nxwBCyvWhAqFTkRO3itH69kKNXOTTCr1ktq5/EY63
 B1gBMwKI9GaV4myQkIAKQKRu/h+jVTVXmEZmrR5QBxDcBmQtaR1w2zHjvxkqVxOTCt4u
 wJqXnfffggOPi/cB1gGxueJ7rHnglK7I8CprAMOtMe9LIG64TUVW283bYYmfmOTlbeTa
 G5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u+u2GTLpTwv9NrMPHkakKvWn/ABYNzXl/Rjh49VH7qg=;
 b=nTZu21MwSb1Up/wFE4SlYroyCQP8+ana9MuJs/TnON6REu6QxAWZTSdKpIp2BIWtOh
 GJdAXPhUVy5Dcr04o1XezoQ0DUVw8njP9pg4CUopuFCqqgGSSCu8G4Lvzyfu/OhYd56q
 eIxSUyY3zSkoPPvVhsudoc51hEJ0Qe/o8kBk2pT1wsldG4NwU0yYXkTZBnSVCcoW+Xfy
 CHEbD9Hcdb1/VX68USNfVd8QZ5wBAxHqEBxRxaQ4a5ouAtbhMElXaMyA9RLDdpZWrQcR
 NIetcF9lwSUQRXA38yR6adXZFFPnt4Sd0pONjr9J1awajfbzKTI1H8wMfbByiRhYaxPF
 ojvA==
X-Gm-Message-State: AOAM5310YO78UokplInFaaXVhuQp2yw9U/kLn0HFHNA86uaUGH8ILR4A
 q3jBY2VwLAZC75AmYqN2dl3Ss8wBNqA=
X-Google-Smtp-Source: ABdhPJynOQ8bf/2J7jnISVmuppOR0PEPMKrNRBuiAuulCQcCAfHf5548jyG6cgzDfrVz6URV37i5Qg==
X-Received: by 2002:a2e:b177:: with SMTP id a23mr5690353ljm.140.1589651193635; 
 Sat, 16 May 2020 10:46:33 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:33 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/18] target/mips: fpu: Demacro DIV.<D|S|PS>
Date: Sat, 16 May 2020 19:45:34 +0200
Message-Id: <20200516174548.7631-5-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 449e945166..2759c9989d 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,7 +1208,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
 uint64_t helper_float_add_d(CPUMIPSState *env,
@@ -1319,6 +1318,42 @@ uint64_t helper_float_mul_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
+uint64_t helper_float_div_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_div(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_div_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_div(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_div_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_div(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_div(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
 
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-- 
2.20.1


