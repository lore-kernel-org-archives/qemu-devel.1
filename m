Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D22FC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8503A20708
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh9Fr/Z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8503A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOGE9-0004pl-DX
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kOGD8-0004Nn-NO
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:14:38 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kOGD6-0000cr-V5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:14:38 -0400
Received: by mail-pj1-x1043.google.com with SMTP id s14so504018pju.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=k0zl0VV/IBgA9lzxOPJnTAzID61FVzz32rreJl2dQ/Q=;
 b=Wh9Fr/Z+9RE/6lrYa2uJcRHZntpg+5K08oq25Jp+qGHiy+gMcoUoYrPWD2H0T5lhH1
 yg+21uYqXQVy7aBF2eC9CimRGTBHlfbEJq9xYIjFFaYXLEbP1hIiIUQZvUactgejFkUy
 e91bO9p6D0rUhG4lSmDc4z1ddw5HmS7Hrh29Gzbq6VGVCFu7vzvjFVh+egaMMnXQzneL
 tTJMnIBHsyoTJuaU1JjjHyFpLRY1ZIuX3Sc8KL6l1EPmsPxDiTunBQegO7TtLCTZSrnY
 xgacQGI4QVIgULBMrtSZ5oEaoESqL3vDG7PBqiOMAob3qkjuyut2NRfR5nul1NcjuwH4
 mf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=k0zl0VV/IBgA9lzxOPJnTAzID61FVzz32rreJl2dQ/Q=;
 b=DZiSICsrkqi3Jtn4oHu/p4EVsxVcFNSkunemZbg3riD6M6pSxh/snP/4ZRgHsxmHsL
 FxW+2DijUkXkQnUrIoEHNYaeQr1vVgNoYGxUXguI3QKOLR32NVHp1Fu8u19TVASu5t9w
 ev0WInj0vpwekjnxHyOzY0snvhHTTubqgxZ6Pqa62B66TAfjt74Q5FkwF+m7XL0NVSIE
 POWQEESB+87/uTaPHUBdWts25TkP6BMCpnjVRPbPUjPoeQ90NpdcgjUMiJBLpcu7BZQP
 KH0vQKNLE2SGnxrzRaqrxA4xx1333CWYKadZXT3oUB9aYsQnahW+6P0JTsTCa3CPCbm+
 M5Iw==
X-Gm-Message-State: AOAM531E/Xz/URWxcUugBzA2bZHKGgBKBTki7zELWdn+VYHzKos88b/U
 CsIHSZehq6yJ6ygB/OtBsHk3LYT/5tRwpw==
X-Google-Smtp-Source: ABdhPJy37TGAlhJhf/g8X4bg7zfeKF5trrhmZXOXXFD8wgoTqeVrjcOYYfm8n/Na9BnLTN/ia/pxfw==
X-Received: by 2002:a17:90a:7bcf:: with SMTP id
 d15mr1532872pjl.230.1601626474676; 
 Fri, 02 Oct 2020 01:14:34 -0700 (PDT)
Received: from carbon.loongson.cn ([47.91.219.17])
 by smtp.gmail.com with ESMTPSA id f4sm887863pfj.147.2020.10.02.01.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 01:14:33 -0700 (PDT)
From: Kele Huang <kele.hwang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/1] accel/tcg: Fix computing of is_write for MIPS
Date: Fri,  2 Oct 2020 16:14:20 +0800
Message-Id: <20201002081420.10814-1-kele.hwang@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=kele.hwang@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Xu Zou <iwatchnima@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kele Huang <kele.hwang@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Detect all MIPS store instructions in cpu_signal_handler for all available
MIPS versions, and set is_write if encountering such store instructions.

This fixed the error while dealing with self-modified code for MIPS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Kele Huang <kele.hwang@gmail.com>
Signed-off-by: Xu Zou <iwatchnima@gmail.com>
---
 accel/tcg/user-exec.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 5c96819ded..88eccf7900 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 
 #elif defined(__mips__)
 
+#if defined(__misp16) || defined(__mips_micromips)
+#error "Unsupported encoding"
+#endif
+
 int cpu_signal_handler(int host_signum, void *pinfo,
                        void *puc)
 {
@@ -709,9 +713,42 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     ucontext_t *uc = puc;
     greg_t pc = uc->uc_mcontext.pc;
     int is_write;
+    uint32_t insn;
 
-    /* XXX: compute is_write */
+    /* Detect all store instructions at program counter. */
     is_write = 0;
+    insn = *(uint32_t *)pc;
+    switch((insn >> 26) & 077) {
+    case 050: /* SB */
+    case 051: /* SH */
+    case 052: /* SWL */
+    case 053: /* SW */
+    case 054: /* SDL */
+    case 055: /* SDR */
+    case 056: /* SWR */
+    case 070: /* SC */
+    case 071: /* SWC1 */
+    case 074: /* SCD */
+    case 075: /* SDC1 */
+    case 077: /* SD */
+#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
+    case 072: /* SWC2 */
+    case 076: /* SDC2 */
+#endif
+        is_write = 1;
+        break;
+    case 023: /* COP1X */
+        /* Required in all versions of MIPS64 since
+           MIPS64r1 and subsequent versions of MIPS32r2. */
+        switch (insn & 077) {
+        case 010: /* SWXC1 */
+        case 011: /* SDXC1 */
+        case 015: /* SUXC1 */
+            is_write = 1;
+        }
+        break;
+    }
+
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
-- 
2.17.1


