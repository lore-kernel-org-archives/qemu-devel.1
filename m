Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD8C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330E82168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrJ8FCvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330E82168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLUt-00037T-WF
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thatlemon@gmail.com>) id 1iFLBv-0004g6-Jq
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thatlemon@gmail.com>) id 1iFLBt-0008NI-TG
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:39:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <thatlemon@gmail.com>) id 1iFLBs-0008Dx-8E
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:39:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id b24so3962095wmj.5
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=GAJjguWUwmP/WsVKo8gF3+A3WszXHwQvwqITmyrIgjQ=;
 b=WrJ8FCvvEjBuHbQZbe7yqlacPi6BOY0SAeZfbxZGerta7gZJfS471ayvzyAft0xrkS
 uuGWZ4xRNb57slpf/peylD0qL7cMxOug5YUmLxQcmhrBBgOnMArD03omFRygU2zvAvxy
 roT6uTSIx1xF3ZbF8SUvJPmAOU13ZoqrSwRVHRxMpb1QQ/t690i+YaeC6A+UnmlSlVGg
 luxGqVaZ58VTRBm6xiTrqufqTOd2TeRzdUg9Dk9QVqM/86Zur29y441ytq1PxU5Ce3JV
 PvUb6wzufDV4MXfKUNcB1mgUw656KSyi1rMQ1PoqQrbtctigFt8QIwVO0CM6ojMZKl9w
 rhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=GAJjguWUwmP/WsVKo8gF3+A3WszXHwQvwqITmyrIgjQ=;
 b=QPjWS4bxouCASFx67DjM7dXN6q5KboGkGqr4in1yu/6XM0M8V2FzLmDK8WNasrW/rn
 tK/oqHcZX6jyGHCCRxygBh77C049YSaBoGZ7sMXxTzwYr748HfMq3G/KBfWDiom3nO78
 JGA0fYTqMB8MJcegbBpPrkTmsXFa5yiHoRhKqWKZZUhr9ktgEhDJUUV9/h3mdiM5MnFs
 VcLOhKm9phWE4aOPr7NsPHLJ06elHynKcqb+HvWLH8M8hQ69apA30wOKHv5OKJe10+Fh
 Rsh+/X4Z0Hs7p8oqNqorJP4m+tmqGl6HjpEth6YYGcI7EHkWsiiKD/CjIQKL8/gTE4gt
 EgeA==
X-Gm-Message-State: APjAAAUkA93vZr5h9gSb+s5iFx70OZUt1FZATEMqa1FodJIFdGxzEA2a
 vnuiMFXMW3mlLGT6cTulMa0ZsIjS
X-Google-Smtp-Source: APXvYqy9LB6x8l4ZKER29GS4mYgzqAPCmqBotwLnAbyfPSDPH8SVmGCQXlY5au/VcAHFmiSCoi2PAg==
X-Received: by 2002:a1c:6609:: with SMTP id a9mr4806218wmc.127.1569947993975; 
 Tue, 01 Oct 2019 09:39:53 -0700 (PDT)
Received: from [192.168.1.103] ([151.33.120.151])
 by smtp.gmail.com with ESMTPSA id o9sm41071957wrh.46.2019.10.01.09.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 09:39:53 -0700 (PDT)
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
From: LemonBoy <thatlemon@gmail.com>
Subject: [PATCH] linux-user/riscv: Propagate fault address
Message-ID: <5059f7eb-07c4-62c7-542b-e71315a4f675@gmail.com>
Date: Tue, 1 Oct 2019 18:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

The CPU loop tagged all the queued signals as QEMU_SI_KILL while it was
filling the `_sigfault` part of `siginfo`: this caused QEMU to copy the
wrong fields over to the userspace program.

Make sure the fault address recorded by the MMU is is stored in the CPU
environment structure.

In case of memory faults store the exception address into `siginfo`.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
---
 linux-user/riscv/cpu_loop.c | 3 ++-
 target/riscv/cpu_helper.c   | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 12aa3c0f16..aa9e437875 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -89,6 +89,7 @@ void cpu_loop(CPURISCVState *env)
         case RISCV_EXCP_STORE_PAGE_FAULT:
             signum = TARGET_SIGSEGV;
             sigcode = TARGET_SEGV_MAPERR;
+            sigaddr = env->badaddr;
             break;
         case EXCP_DEBUG:
         gdbstep:
@@ -108,7 +109,7 @@ void cpu_loop(CPURISCVState *env)
                 .si_code = sigcode,
                 ._sifields._sigfault._addr = sigaddr
             };
-            queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
         }
 
         process_pending_signals(env);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 87dd6a6ece..58e40e9824 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -446,9 +446,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
-#ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+#ifndef CONFIG_USER_ONLY
     hwaddr pa = 0;
     int prot;
     bool pmp_violation = false;
@@ -499,7 +499,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     case MMU_DATA_STORE:
         cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
         break;
+    default:
+        g_assert_not_reached();
     }
+    env->badaddr = address;
     cpu_loop_exit_restore(cs, retaddr);
 #endif
 }
-- 
2.20.1


