Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F583C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F766206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtEOIcjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F766206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUxH-0003ZE-IV
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUuP-0008U6-1i
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:16:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:38896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUuM-0003HK-Un
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:16:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id m16so5792005pls.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=soz5/dc63AWvfYnTeEOXYkPjarLppwOrJCQsvAF2Sbw=;
 b=gtEOIcjcSir6uFvFnTXVDiyfze6bhdwMBkKx2ZxGa1H7E9PSk6uAFCNXuVNEVUm1lU
 a91XLoqcSnUN6/wK8SPhT1VpCiguqm8uRiEqNXpwRC1XOB2xAwy76DXUnFFBLkcGaZtK
 89jzGTEsufPI4cwSp7DqtDFrAnQ3oef738QHIEaV5exRLdti1Hbp3c96WpsxJpFQdWj4
 k6LvLDlDxOH2WlhWGEsQ9O+ex11Uk/xzEhXk4Hgnu8uThqvN3Ppgd3Ech4x/ax8B/pRd
 ER/9n9ub4asA14dCSAdIMEG+JsRlxeITYDzOyX7XdrmxM6kXR/LN2SMRIbO/0dWdd2mb
 fjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=soz5/dc63AWvfYnTeEOXYkPjarLppwOrJCQsvAF2Sbw=;
 b=dBw3Tjkn7ckfkEyTs/F5fPyFuLW8obPo225nmx2VH/Mdb66LDxJTGuQxEVgXGsStNQ
 Xjox4tPm69C1HgcxcYKkStWcsa5a7csSdnTSMNw8wN382V23dJ2L29gQahhUTzHuyB9r
 RKBZALdd53n4wPSTL7Zmr1p0jzosiJ4SYOnJYiu7sdGw5PjzdPivSfH4a31/gzspmod7
 wPeExavkPI1rSYBlvWvslhl7f68oh5SPadQIOwk0CWbVFeA5EPnBYPwvqbmzVDHqq+/O
 Z5ddqY9xrptt5KuY0xl01cGym5o3hSJN1ZWDO3efHq3EST+kbhH7EfZYsAqxRJLm15Dq
 Pxfg==
X-Gm-Message-State: AOAM533N7Ab6B/at1TgqPFFKigpRt5NARvABw+bVQVxyR1xZd3/4qUMi
 uBjzl/t/K/zLSIC/M5xxOIfH6kUYAks=
X-Google-Smtp-Source: ABdhPJznO3+/rrrct3Yz4qitOk06c5qtaRzAHaWoHY7SiBfsLzGUdWlNzxZN2kCNKswXoK+peMSdAw==
X-Received: by 2002:a17:902:be06:: with SMTP id
 r6mr8129071pls.143.1595009788686; 
 Fri, 17 Jul 2020 11:16:28 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id r7sm8698578pgu.51.2020.07.17.11.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 11:16:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.1 3/3] tcg/cpu-exec: precise single-stepping after an
 interrupt
Date: Fri, 17 Jul 2020 11:16:23 -0700
Message-Id: <20200717181623.2742758-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717181623.2742758-1-richard.henderson@linaro.org>
References: <20200717181623.2742758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
Cc: peter.maydell@linaro.org, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When single-stepping with a debugger attached to QEMU, and when an
interrupt is raised, the debugger misses the first instruction after
the interrupt.

Tested-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/757702
Message-Id: <20200717163029.2737546-1-richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6a3d3a3cfc..66d38f9d85 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -588,7 +588,13 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         else {
             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
                 replay_interrupt();
-                cpu->exception_index = -1;
+                /*
+                 * After processing the interrupt, ensure an EXCP_DEBUG is
+                 * raised when single-stepping so that GDB doesn't miss the
+                 * next instruction.
+                 */
+                cpu->exception_index =
+                    (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
                 *last_tb = NULL;
             }
             /* The target hook may have updated the 'cpu->interrupt_request';
-- 
2.25.1


