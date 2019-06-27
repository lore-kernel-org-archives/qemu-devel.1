Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B50C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F21820659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F21820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWz8-0004KW-6i
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHh-0003JB-RM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHe-0000JV-EN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHd-0007A1-U1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so1410584pfd.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=MsITP9g02yPdJ/4apRI29XJbL0BqwsUIcjd2jJ0cnTY=;
 b=TVcCpaHstW0vyrdVcXrPpPPdbehby1k1xLaQDjuJvy3Wjp+/wS9pPFVGJR1ZuDVC7h
 /1o0uxgWyafiYrLfBtl/I0gAjZEpKJlZ5iLm7LIf2NEhjSFPlsmXarlBghMFpBdjdEar
 HMXHajA5xDwKTAWVVBLQ1uybujRs3n3IMBKQxjmu7Ng3CTREPPBpg3EpIPVD+rAMo99R
 IFNOlrFLt0YTKdVEpshhkodRkn1BX+tVnGEHSdMDTe6GOcJp5yLU9chGimq1DBIcAfj1
 eK884niMrI8clWtpLpTMd9pFSl+7fHFBvC9jdZkTwqMJT3MYPJleqD38gC2ZANSkikkX
 TwBQ==
X-Gm-Message-State: APjAAAW16721WTptRRO4c9TKsije+eacsMI5kC8p4bmuL5GBA7jgNUym
 D1+6dCu8TNRIpv3mjHJs2BfilUd1U/kbWA==
X-Google-Smtp-Source: APXvYqwP3X0J8lWjIMxxmjd7unuQEoMoZbWww3FjeBzFoPZmdGngKnGlZcGK9un87W8Y8mo+4XkOCQ==
X-Received: by 2002:a17:90a:b011:: with SMTP id
 x17mr6764327pjq.113.1561649060874; 
 Thu, 27 Jun 2019 08:24:20 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id q10sm2309063pgg.35.2019.06.27.08.24.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:20 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:20:01 -0700
Message-Id: <20190627152011.18686-25-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PULL 24/34] RISC-V: Update syscall list for 32-bit
 support.
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
Cc: Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jim Wilson <jimw@sifive.com>

32-bit RISC-V uses _llseek instead of lseek as syscall number 62.
Update syscall list from open-embedded build, primarily because
32-bit RISC-V requires statx support.

Tested with cross gcc testsuite runs for rv32 and rv64, with the
pending statx patch also applied.

Signed-off-by: Jim Wilson <jimw@sifive.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 linux-user/riscv/syscall_nr.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/linux-user/riscv/syscall_nr.h b/linux-user/riscv/syscall_nr.h
index dab6509e3ade..5c8728220994 100644
--- a/linux-user/riscv/syscall_nr.h
+++ b/linux-user/riscv/syscall_nr.h
@@ -72,7 +72,11 @@
 #define TARGET_NR_pipe2 59
 #define TARGET_NR_quotactl 60
 #define TARGET_NR_getdents64 61
+#ifdef TARGET_RISCV32
+#define TARGET_NR__llseek 62
+#else
 #define TARGET_NR_lseek 62
+#endif
 #define TARGET_NR_read 63
 #define TARGET_NR_write 64
 #define TARGET_NR_readv 65
@@ -286,7 +290,16 @@
 #define TARGET_NR_membarrier 283
 #define TARGET_NR_mlock2 284
 #define TARGET_NR_copy_file_range 285
+#define TARGET_NR_preadv2 286
+#define TARGET_NR_pwritev2 287
+#define TARGET_NR_pkey_mprotect 288
+#define TARGET_NR_pkey_alloc 289
+#define TARGET_NR_pkey_free 290
+#define TARGET_NR_statx 291
+#define TARGET_NR_io_pgetevents 292
+#define TARGET_NR_rseq 293
+#define TARGET_NR_kexec_file_load 294
 
-#define TARGET_NR_syscalls (TARGET_NR_copy_file_range + 1)
+#define TARGET_NR_syscalls (TARGET_NR_kexec_file_load + 1)
 
 #endif
-- 
2.21.0


