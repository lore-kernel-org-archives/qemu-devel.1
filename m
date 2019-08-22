Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3692AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CD220856
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dE0DA4SP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CD220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0rDy-0000z2-8b
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0rD1-0008PA-0T
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0rCz-00085c-1H
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:49:14 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0rCw-00083m-WB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:49:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id f17so4433915pfn.6
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=umjbQvyNhOeOnMJlj/UuLiaomopZxKybKESiEh98ACs=;
 b=dE0DA4SPGerbn4y2RCGP0X8kvObOOlORj5VZGKoZeNOjE589UWR/8l4koJUuH2AYqU
 XJkWOsEidEgOSXeC3+A2Vp41yGZikzoG8VBkoZLVV4Rc7UjiBvA47ES0OIwRHQBFRWxz
 EJiAgN24vjNT3kRKUmORi58/HYrklStKxqR0CCpfY0mokobAR+oGh8pduBk3E/y99InL
 NRhEXtLpF7e1M7gJAoaYZHbjYbqm82ASFXt7yc6dLhFYl884vXlV2TkgERzJ0RllJNW1
 YURg8q/bA4mOgulmXDsG+SnSTQX4XkySBSLfvQ+pnvk1mQMIBVdqFjLQAaIpiQ2R6+xE
 xH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=umjbQvyNhOeOnMJlj/UuLiaomopZxKybKESiEh98ACs=;
 b=TupOdPWgT5oBIwCn9HA7MD9yYoKIviFssEncjTzR3riK74My2k7q7qWzP62ZeOgrl6
 sAXxlaG10ZEnZyHE9ULzFRjH8yE2f/kVLm40JlWVYIa+7NLABF7n8aEn74FM+VApEydF
 FUXjXrlXYIV9H9E01IdoCTxuHZUX32eGGjwoCb+LWchOVVFCDGnKJaj8+Ym83oPOb9VJ
 ZGMHi7FsVb0BMtfuFX0+6od3LRifN6Ft917YN72dVrJBhMdP/YIry6wxEvz4GYb5ERd2
 e+D7N/6PYlY+N908A/sQSrEEZei0DWB/E7XQDdkYSSJaHNZnOV3WLnOl2O7Od6FaFluc
 zoVQ==
X-Gm-Message-State: APjAAAXlIa3aTvUopRHqis+WrkHbd0Vi5mO3bqVI7uNjy7By4U35RAZ+
 j4WHG391PJeaPkcsIDfzEUVcpscbGBU=
X-Google-Smtp-Source: APXvYqzP6X6BaB2oTnXvNz9jlsATcjiMd1/QQ3GTvbgucImEie+nhRAkWg/Ke9ckajMw+8Gif8RTDw==
X-Received: by 2002:a17:90a:d343:: with SMTP id i3mr920810pjx.15.1566496146793; 
 Thu, 22 Aug 2019 10:49:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k64sm40469177pgk.74.2019.08.22.10.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 10:49:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 10:49:04 -0700
Message-Id: <20190822174904.11339-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2] target/alpha: fix tlb_fill trap_arg2 value
 for instruction fetch
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aurelien Jarno <aurelien@aurel32.net>

Commit e41c94529740cc26 ("target/alpha: Convert to CPUClass::tlb_fill")
slightly changed the way the trap_arg2 value is computed in case of TLB
fill. The type of the variable used in the ternary operator has been
changed from an int to an enum. This causes the -1 value to not be
sign-extended to 64-bit in case of an instruction fetch. The trap_arg2
ends up with 0xffffffff instead of 0xffffffffffffffff. Fix that by
changing the -1 into -1LL.

This fixes the execution of user space processes in qemu-system-alpha.

Fixes: e41c94529740cc26
Cc: qemu-stable@nongnu.org
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
[rth: Test MMU_DATA_LOAD and MMU_DATA_STORE instead of implying them.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index c6998348df..19cda0a2db 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -283,7 +283,9 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         cs->exception_index = EXCP_MMFAULT;
         env->trap_arg0 = addr;
         env->trap_arg1 = fail;
-        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1 : access_type);
+        env->trap_arg2 = (access_type == MMU_DATA_LOAD ? 0ull :
+                          access_type == MMU_DATA_STORE ? 1ull :
+                          /* access_type == MMU_INST_FETCH */ -1ull);
         cpu_loop_exit_restore(cs, retaddr);
     }
 
-- 
2.17.1


