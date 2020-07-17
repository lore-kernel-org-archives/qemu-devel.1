Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD60C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C0D206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ch9byqhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C0D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUw2-0001MN-50
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUuO-0008TG-M0
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:16:32 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUuL-0003H6-H2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:16:32 -0400
Received: by mail-pl1-x644.google.com with SMTP id w17so5779460ply.11
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WF3WUUJ3102Nb47JAT2FiwU+zNqijVjebyKLsz6cFP8=;
 b=ch9byqhMvr04Ympul6i2g749xIj1liOt1rbWppVh8yvfjRdjRMB5cbEDD5wMsoEZvf
 0tQ+48CPQPQArSyfGeO0DevA4WesHKcdpZTP93Iul5n/ruEQxUyDTQNN5I1jTVh6feAY
 5eQBUVPETM2a+0XsKL1KGAr2jhxAk7nTpWnn1+jUytwC0vgFdccvRRp8AIe52RFBdjgW
 e2UrJ3674khcXfjiQixF0fXxx4CjOP1BqlOFVwjDcwL3FHXitBRi7gyZlGEgBH+uglEu
 I0CdygBaVNkWbCnH9ASZZP9vce+34xzRDxXEkq8uR9sI+1r0he3Gdf9mjHo6A0Dmh45S
 z9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WF3WUUJ3102Nb47JAT2FiwU+zNqijVjebyKLsz6cFP8=;
 b=bzNVHd1AXit4w07J4YM+qgB29MkVGPhvnjDFiH6XzXstpM/Ir0Fjab8kDnNENacsNB
 ZS0vwk+QRtuFEHugSNPaYb78RGiqmtsI0LM957dRs5Rb17LEy1YVqtWmxw3nVGzK4RmK
 +fKmkVgMRztTfM737CyLw4fzxWiVzRjYPNkCYuab7kauwakmVFzHL4rZryiD+eGIcXlc
 EkkN8eKvDGp89BqnJXqeD8Np32TPW1uePxs9Qpc3kCupkC66ZWAqEH1MLXztLlj+TfL1
 hzsPVLa5k0H6bX//jszLcmO15vnBx9t3ROufT2Rcls58MlB7GTB5mWl6lxf6dcrkgpFP
 oRVA==
X-Gm-Message-State: AOAM533PU9Fd0UZDzWRvpSX/d25AMO++T+qWprP8TQi4L16fbHYp0OM7
 Mywv9ucja/xHAK8foaO4VuPfmR4QJR0=
X-Google-Smtp-Source: ABdhPJw3T1bPoY0ytHRdhX5g2QSBZHEQlA9eF6X2tM5OrxGOzE2S8ks8YlkI+ZWGi2iRHaLNgA834Q==
X-Received: by 2002:a17:90a:5d15:: with SMTP id
 s21mr11678190pji.154.1595009787587; 
 Fri, 17 Jul 2020 11:16:27 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id r7sm8698578pgu.51.2020.07.17.11.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 11:16:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.1 2/3] tcg/cpu-exec: precise single-stepping after an
 exception
Date: Fri, 17 Jul 2020 11:16:22 -0700
Message-Id: <20200717181623.2742758-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717181623.2742758-1-richard.henderson@linaro.org>
References: <20200717181623.2742758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

From: Luc Michel <luc.michel@greensocs.com>

When single-stepping with a debugger attached to QEMU, and when an
exception is raised, the debugger misses the first instruction after the
exception:

$ qemu-system-aarch64 -M virt -display none -cpu cortex-a53 -s -S

$ aarch64-linux-gnu-gdb
GNU gdb (GDB) 9.2
[...]
(gdb) tar rem :1234
Remote debugging using :1234
warning: No executable has been specified and target does not support
determining executable automatically.  Try using the "file" command.
0x0000000000000000 in ?? ()
(gdb) # writing nop insns to 0x200 and 0x204
(gdb) set *0x200 = 0xd503201f
(gdb) set *0x204 = 0xd503201f
(gdb) # 0x0 address contains 0 which is an invalid opcode.
(gdb) # The CPU should raise an exception and jump to 0x200
(gdb) si
0x0000000000000204 in ?? ()

With this commit, the same run steps correctly on the first instruction
of the exception vector:

(gdb) si
0x0000000000000200 in ?? ()

Buglink: https://bugs.launchpad.net/qemu/+bug/757702
Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Message-Id: <20200716193947.3058389-1-luc.michel@greensocs.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d95c4848a4..6a3d3a3cfc 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -504,6 +504,17 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
             cc->do_interrupt(cpu);
             qemu_mutex_unlock_iothread();
             cpu->exception_index = -1;
+
+            if (unlikely(cpu->singlestep_enabled)) {
+                /*
+                 * After processing the exception, ensure an EXCP_DEBUG is
+                 * raised when single-stepping so that GDB doesn't miss the
+                 * next instruction.
+                 */
+                *ret = EXCP_DEBUG;
+                cpu_handle_debug_exception(cpu);
+                return true;
+            }
         } else if (!replay_has_interrupt()) {
             /* give a chance to iothread in replay mode */
             *ret = EXCP_INTERRUPT;
-- 
2.25.1


