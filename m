Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A71C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D7520727
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fPualdzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D7520727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSEp-0006ha-B3
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXSC0-0003NR-BU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:51:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:43264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXSBv-0004Ro-Je
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:51:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id o9so1054465plx.10
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SJ7E8JqgOLx2ZEpYUNi3ic5vKG5NWEQV9qbwhc56KHQ=;
 b=fPualdzQSWBq+Cbb+/WPwqu/ApZ1ZDK3IVAnh8cfGam3aUKZ592jzZtZvdXO3eH39J
 eU61iCSp6ptAYZmuYHTs6TnU/rRNh/0a5nKtuSHWlNPqRJTyaceiB0GZCg2A74VnKhSY
 e9xyNDrfPSFKdhYJ0Rl+H7Vn9l1tCAp3AJfvhscLpC3NTHW1sRn4u8l1SMZPHuk3tF7q
 RwFwZiYTrZTJByUJl1URPrscDwdRbChqOaAfMaBH7aKjki1lox0/wke/1bAqvoVn75IZ
 9iDe06s9ctSNvXJaAHQFEN3O5ghfLmBbB8oyMcyr5Z1wINnXLiTliopdWr2Wo0xwNTqD
 I2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SJ7E8JqgOLx2ZEpYUNi3ic5vKG5NWEQV9qbwhc56KHQ=;
 b=KVzFuCKAAdmd9qmHu2DdDwHugrSBpKZsfclWv4KInlAtCEsKWEScFKgTcU3BI8DDOP
 IuVHpmWk1Db/UKIi0XgDpffYGLzmb9fvpRvx/Bf6I1EnMzaTPvwXRcWM20dBFAqnIMlG
 h4aNUyr8cM6lPGJPNSAQ49M0I+VTNV/D9w8bHJ1YuaTqYUEaDVm7x/+wT+0of5JZpUE5
 SCswNzo9XTdiCA3Jb7xhh6ea4nATMZ+BemNiMO19c6h+XEmuI1IR2MvtcF7mcSAvMA4O
 jNGNlgJRacS/s71Z/mV/kbT5ty47j+jKifKgmruSJN9SHyruU2zpxti/LWDo7OIxjKbe
 dTcA==
X-Gm-Message-State: AOAM5310KFO+In8uwdhXvoGGN6F9rGTHJ0oPKBB9KfwL8NcCvwStaBET
 fXzD+ABjqm+Oildovw6OkdpSOi7m9TQZQQ==
X-Google-Smtp-Source: ABdhPJzjgihkqa6PvHlMUcYfxsWLQbAqqZmnnceeTOMpErPIBKZkavL6ob0UsKxOhvtT20OUhC3Rsw==
X-Received: by 2002:a17:90a:a898:: with SMTP id
 h24mr2843421pjq.179.1603817481803; 
 Tue, 27 Oct 2020 09:51:21 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q16sm2955283pfj.117.2020.10.27.09.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 09:51:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] accel/tcg: Add CPU_LOG_EXEC tracing for cpu_io_recompile()
Date: Tue, 27 Oct 2020 09:51:14 -0700
Message-Id: <20201027165114.71508-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027165114.71508-1-richard.henderson@linaro.org>
References: <20201027165114.71508-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

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
Message-Id: <20201013122658.4620-1-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d76097296d..4572b4901f 100644
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
2.25.1


