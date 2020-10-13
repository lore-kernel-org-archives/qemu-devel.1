Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF0DC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935D2223BD
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvxmzsGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935D2223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSJPd-00089H-Nx
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSJOW-0007IL-6X
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 08:27:09 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSJOQ-0001f3-Q4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 08:27:07 -0400
Received: by mail-wr1-x429.google.com with SMTP id b8so10587820wrn.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 05:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h5VN4Q20awkDDa5DusJocR61578qcAgu0ciOdFIb8TI=;
 b=RvxmzsGHeLjXHIiTudA27WRqWOs07OQMe/uNt4aiIB+SJvoXWepG2bZ7oko4UPsKBM
 abZnLGBwfoBNMPxSqRW34UFHJpZKvdA+wmoHzUbpGeFfX10pvTR7Aafrq351B2yty7mZ
 uRVYNQoCN0NqMplC9fYbn0QO8xVv0NH6cVR/Hd7bJpITbPAKH2DW6mx9WYPMWWatDQrv
 DYYlRLMHPHJhHvtJ9jhLbKoQx0STzvT3DTLmuugNivnnmFH375PeLl03ZNj9xgR4qP/G
 JxbToE2oE4bX+3WQw6IwhGfXbeElSsFvDhtgkyMfBnkGT8/fK1ALake1yhuPLDrnA1+v
 9PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h5VN4Q20awkDDa5DusJocR61578qcAgu0ciOdFIb8TI=;
 b=mYlph3dnj/nKCfyB1qJx7lVQ8wT/zhZGardHB0WRnl3GDYcQcGZHMLzlwm+QqfzmgT
 IBB+g7egOuqJhdwXnPIfGk8z/fgx0s478ohErbIPnXGnpM7W4Xp+R5W0/Si/vlJxPzB8
 s9tj98DSPUSMeeqfDaTSuoSO195ME8SC7uITdUiMQXcHctI1uzu6DJ5jm2gPMJJvnzsL
 3Ct6GQd0WKlNP+vOoGubisDa0ykCywOo2ukN8/SOaoJPuLyB/BkqCoA68uAfGNXvr8T2
 0Zwz5C8R8FBDtSu/X+B/DsRcX+MOIUqZf3gY/PQo5xezFSB4kuVPuICNhRZiP9UHxLm+
 DjAA==
X-Gm-Message-State: AOAM530gtnbzou5JN+zWNh0cZ2oEKZY6V25r7aAqFDsqffd+zYtFtiFL
 Ez621uNfsMoS40tpZ8QbKXAqQ11eeVEnqwpR
X-Google-Smtp-Source: ABdhPJzHIcwg8pNyeApvLJUjCAELdSbsSeZRr9zyAZJYZrJKUfhgqiAaYQIPpvtGOIgXc/dlsVSZTQ==
X-Received: by 2002:a5d:6345:: with SMTP id b5mr37073014wrw.288.1602592020817; 
 Tue, 13 Oct 2020 05:27:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i126sm28583582wmi.0.2020.10.13.05.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 05:27:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel/tcg: Add CPU_LOG_EXEC tracing for cpu_io_recompile()
Date: Tue, 13 Oct 2020 13:26:58 +0100
Message-Id: <20201013122658.4620-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using -icount, it's useful for the CPU_LOG_EXEC logging
to include information about when cpu_io_recompile() was
called, because it alerts the reader of the log that the
tracing of a previous TB execution may not actually
correspond to an actually executed instruction. For instance
if you're using -icount and also -singlestep then a guest
instruction that makes an IO access appears in two
"Trace" lines, once in a TB that triggers the cpu_io_recompile()
and then again in the TB that actually executes.

(This is a similar reason to why the "Stopped execution of
TB chain before..." logging in cpu_tb_exec() is helpful
when trying to track execution flow in the logs.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/translate-all.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d76097296df..4572b4901fb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2267,6 +2267,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         tb_destroy(tb);
     }
 
+    qemu_log_mask_and_addr(CPU_LOG_EXEC, tb->pc,
+                           "cpu_io_recompile: rewound execution of TB to "
+                           TARGET_FMT_lx "\n", tb->pc);
+
     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
      * the first in the TB) then we end up generating a whole new TB and
      *  repeating the fault, which is horribly inefficient.
-- 
2.20.1


