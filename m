Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D3EC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3634A2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3634A2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvCT-0005po-GE
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgul3-00007F-7j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgul0-0000kk-Bv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hguky-0000dW-2K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so3321154pff.9
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=MsITP9g02yPdJ/4apRI29XJbL0BqwsUIcjd2jJ0cnTY=;
 b=VgIo0ngkD8NbvbLbnPfbI3zinKZzB0ZoERLRWtXqFXN5YFcStQhVV5pHfAvTOdW9VM
 XgYXMfhnFQpzZm7Rc5JqZx5LUo2kbsWzUvwiHz++/7Hb+nuVTkK32joSIvJhWTYVmZJJ
 Khfrx+tjlLKuRecGwRfn9LNX50o1a0Ouhy3LCi8nQWMoQoQdNeRM4qkA9MOpP43Za1qs
 uiZh/c0ocqVJ8aEwpo53cEjXdVTYobIycoWYjrmws12Qwq4KE2nICYu6j27OvbPbrQ0Q
 AkfyfxpGt/dJ2V+m97gMs3dOhT4HMWjv3EsNJvzLNwNhTZhG8IHQ+S4Nua7Hb2WdW/bJ
 PVTQ==
X-Gm-Message-State: APjAAAUG1DWBeKRP8JBZL8dWY3YGnSd198bYX7sv4x3k1lgbuuxPJYC3
 Q7HZuQjEev3eM0lUv1RkaDzYXRMyEne0tisp
X-Google-Smtp-Source: APXvYqzbjn9bLPbmNthwzW4TBr8YUWwQWZMeVeIhofrOb8Fu5eE13WjVK3PFkmuEeGwKnCXucK2M9A==
X-Received: by 2002:a63:52:: with SMTP id 79mr10213248pga.381.1561743227478;
 Fri, 28 Jun 2019 10:33:47 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id y22sm6318573pfo.39.2019.06.28.10.33.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:46 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:17 -0700
Message-Id: <20190628173227.31925-25-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
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


