Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF6C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EB7218A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EB7218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibBW-0001iW-VR
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq9-0006Sc-D5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0008I1-PN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0007gb-CV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so1499992ljh.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=MsITP9g02yPdJ/4apRI29XJbL0BqwsUIcjd2jJ0cnTY=;
 b=Q+ZIUeZdZ6WQJHIuDpj58k9mfhdaHyY9fXYOrFiH6Q57+2Ak8TeujnxWLNO0YzYjpJ
 sOJaUm6okqJnwdBaPL1dOEWJRzMoO+eGRT3PiisxYkL6D8HCy0FsFqVEe86wMnBtbpPC
 SdI0yT7bPwLk89VHGwSfJq8sf15QNiADJqnbaIWKg6/dyToCP5+T+BzmUuSpDNfqnmX7
 M0fyyrcMRHfDnVc+subrGBOAMDnms8IZHUoUSIDfPyXfDUDkA2Py4Z4RIajfpad6x1cS
 ydG7aIee2Jy7xwQu1/6e2m7RTI16fmIqry5qpsBbmnsTmL8KYxGRnL2I7wJ/DoAvUbhP
 XiXA==
X-Gm-Message-State: APjAAAWwkDbmSuzLeXxigEKX77INRVlrrij8+oosoZ1Y6u2zi95GEY7O
 nBEcxAIbd1V8hHKWCWOVXvMVvTefgI5uPQ==
X-Google-Smtp-Source: APXvYqysXN4JqoAYFHcdKMzeakQpqVOLUR1If3mT9DOpJFXxm9Rx0lT8cqSdY1C7kFN0IwQPzMxxcQ==
X-Received: by 2002:a2e:981:: with SMTP id 123mr20701388ljj.66.1562143312127; 
 Wed, 03 Jul 2019 01:41:52 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id r17sm343514ljb.77.2019.07.03.01.41.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:51 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:40 -0700
Message-Id: <20190703084048.6980-25-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.194
Subject: [Qemu-devel] [PULL 24/32] RISC-V: Update syscall list for 32-bit
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


