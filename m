Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8015C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E20215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vo9TftZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E20215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLsU-0008ON-IH
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlC-0001Xo-NA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlB-0005VH-PS
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:26 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlB-0005Uu-KF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:25 -0400
Received: by mail-pl1-x642.google.com with SMTP id t10so5787081plr.8
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=H3DBi0mNjNbESSisGeli3T+KiEWE4J/mD2CVZfFgXJw=;
 b=vo9TftZgn+6YC9bzDZvlRmhXUtXLeyTsstPkVVjuIFBK+vEHkzChXz5afcuPT9oCKz
 IkCScm8pR0g8bH+bC/5SBB3W6bGyzcgnYB44CZHmZDqHH8caqBTrUq24ZgjIyBUGWiUa
 v7xos6Hf6uCXvvkrBO//azefw3fVVlcDnjXVsaQAViRyt6vC5BzIuzD0RbuJ1WD+IXVl
 tEjqU9u7E8Encvs8JVMsgIU2Ab7RUU2aCLcPJFtpT6ZUeNXct76GJbl+IYV6sVXqO0Kz
 Mb7eHf6RJQ/OwDn5XNUd1zUtvRzSAojkMDTxrW2RzGBm9VMHyGpudhQZM4PMxbdV1yiq
 LOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=H3DBi0mNjNbESSisGeli3T+KiEWE4J/mD2CVZfFgXJw=;
 b=hDLgACVzt5SrewYlz6BRxwZgMUIw48eFHYgVtfbX0KzLb3kYyLrZrPU8u9el3dWnjr
 Rrww+2ORxo7t2BTh93PhVLosd/6iAf5v1Q3zT2VYEmm0PpL8j+sVNGix6Z3JqHmsw3cP
 XGZAfgHA3aWde3j3kG7GVmT/47O/e7D9RyzXWwA9FS5tRGfZt6JFxJEslEt7pnWo04sk
 0AJT20iGnR91MFn2OaPAVkUd8Fsl2MvLSIqJrNcxH42psrIMIFa3/ggJmkWvTaDNwpzD
 9qj3rxQFEFbPp5hdRrK7UBuEo1DFokT/WVlqJQzP9sRXFFQYP/r69aICupq7UaLElvwW
 WXcA==
X-Gm-Message-State: APjAAAVcYxW7KFX9tPLFCCO4pRqHjk3STYuv82kwdfHdpJBXr3K4Jzv5
 5KUmVWvvdR5hAsWhuHsn12xT5dyW5dk=
X-Google-Smtp-Source: APXvYqy2XOTW6oxzO8cUs4u1luNDhJ6DqNpexpddCMdwC4DPbE2RZq9CJl1dq+K0Z672gViSErYAPg==
X-Received: by 2002:a17:902:467:: with SMTP id
 94mr26441246ple.208.1569950184360; 
 Tue, 01 Oct 2019 10:16:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/18] target/s390x: Handle tec in s390_cpu_tlb_fill
Date: Tue,  1 Oct 2019 10:16:02 -0700
Message-Id: <20191001171614.8405-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a step toward moving all excption handling out of mmu_translate,
copy handling of the LowCore tec value from trigger_access_exception
into s390_cpu_tlb_fill.  So far this new plumbing isn't used.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/excp_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 552098be5f..ab2ed47fef 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -126,7 +126,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
     target_ulong vaddr, raddr;
-    uint64_t asc;
+    uint64_t asc, tec;
     int prot, fail, excp;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
@@ -162,6 +162,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
                       __func__, (uint64_t)raddr, (uint64_t)ram_size);
         excp = PGM_ADDRESSING;
+        tec = 0; /* unused */
         fail = 1;
     }
 
@@ -178,6 +179,10 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     if (excp) {
+        if (excp != PGM_ADDRESSING) {
+            stq_phys(env_cpu(env)->as,
+                     env->psa + offsetof(LowCore, trans_exc_code), tec);
+        }
         trigger_pgm_exception(env, excp, ILEN_AUTO);
     }
     cpu_restore_state(cs, retaddr, true);
-- 
2.17.1


