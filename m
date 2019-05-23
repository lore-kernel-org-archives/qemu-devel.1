Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A98C282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321A120863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MklDAxKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321A120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37346 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToaj-00085q-AV
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:21:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHf-0006Jy-Gt
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHa-0004XJ-LE
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:27 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:43641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToHa-0004Wr-GB
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:22 -0400
Received: by mail-vs1-xe43.google.com with SMTP id d128so3624723vsc.10
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Zp/XppcdDbx7mB8QWYDppSxf4juiYNTe8E7a8rf4oVA=;
	b=MklDAxKv9JKngGPfJmB5DzbxL+4KSprzwb5aIGaklxAMOgptWu0oA51mDPu8V+PXdv
	17SV3UJQIQ3hzThVzxnERiuzCg2j33tXNCuDFbpnezK1yXRB4A2OsEyXba7QpbOPaR1y
	d0a8XVhxR5Q0RrD9CYihP8KiWUVB2VyYQAVxg19GjHQUE/8B+aGSp8A2WiAmTYBuaK44
	bGPKAZ/YRYxKRP5o0xcqYYPxADztxyoSVQD8WovoAVz45VqffRikgbW0E4zKGLi3H/9G
	Rs4xRqG/iYd9qFLkUETbAGtZwwadE4oFXJppmC1hINh2p7SKqn1dQ1NEFuqTA6gpqdAs
	+PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Zp/XppcdDbx7mB8QWYDppSxf4juiYNTe8E7a8rf4oVA=;
	b=RAkc+q8GGkfdGnhlH10I8/WT+857wz1HXZpMPsOqSa4i/geChxtVjHfCcDDlJN8Gfq
	J58VfDzfcJOUUyMCXysaUBsBFkG60VYmUAwMdQAjjKodTdP5hVtT70V8VeehieJl2cBh
	wrpHbi1RfEsA8f9KgNRvfn4YiEGDOGywRVvzlq7sGJ5NJoH88IW+8wLQF9C88ylpij0i
	yfkvWZch+zIAm7nXcvdyDmky1EBx9eGjAytEXwGFN9eD8ZDMwxORKoUEp3ZEw5jToTGQ
	4RE2xzLziHB4RuSnSaO1B6UpiaxsK14zPUyHRuNGI2bpsBf2AJMjh/eonXmjsh4qT+fM
	bi2A==
X-Gm-Message-State: APjAAAUj5n8Bpo428YyemtWlvyX8wQMSkksdMVZCPipqRlHbXpnqo9pK
	uIdhwGfZKZDCF5twxiPOe88BG+wmDHEvag==
X-Google-Smtp-Source: APXvYqxh6B7OiCZIg8ERnRNfNyQGl/jJbQK3gM2sc5wmMle4lyxOvK4zM8roE+Hv2Atr8iasgcTVdA==
X-Received: by 2002:a67:b348:: with SMTP id b8mr39678030vsm.144.1558620081333; 
	Thu, 23 May 2019 07:01:21 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	v133sm1984166vkv.5.2019.05.23.07.01.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:01:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:00:58 -0400
Message-Id: <20190523140059.18548-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523140059.18548-1-richard.henderson@linaro.org>
References: <20190523140059.18548-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e43
Subject: [Qemu-devel] [PULL 12/13] Add rx-softmmu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190516055244.95559-10-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/arch_init.h     | 1 +
 arch_init.c                    | 2 ++
 configure                      | 8 ++++++++
 default-configs/rx-softmmu.mak | 3 +++
 hw/Kconfig                     | 1 +
 5 files changed, 15 insertions(+)
 create mode 100644 default-configs/rx-softmmu.mak

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 10cbafe970..3f4f844f7b 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -25,6 +25,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_RX = (1 << 20),
 };
 
 extern const uint32_t arch_type;
diff --git a/arch_init.c b/arch_init.c
index f4f3f610c8..cc25ddd7ca 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -74,6 +74,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_PPC
 #elif defined(TARGET_RISCV)
 #define QEMU_ARCH QEMU_ARCH_RISCV
+#elif defined(TARGET_RX)
+#define QEMU_ARCH QEMU_ARCH_RX
 #elif defined(TARGET_S390X)
 #define QEMU_ARCH QEMU_ARCH_S390X
 #elif defined(TARGET_SH4)
diff --git a/configure b/configure
index 528b9ff705..dc04d6d13f 100755
--- a/configure
+++ b/configure
@@ -7578,6 +7578,11 @@ case "$target_name" in
     gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
     target_compiler=$cross_cc_riscv64
   ;;
+  rx)
+    TARGET_ARCH=rx
+    bflt="yes"
+    target_compiler=$cross_cc_rx
+  ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
@@ -7798,6 +7803,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   riscv*)
     disas_config "RISCV"
   ;;
+  rx)
+    disas_config "RX"
+  ;;
   s390*)
     disas_config "S390"
   ;;
diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
new file mode 100644
index 0000000000..a3eecefb11
--- /dev/null
+++ b/default-configs/rx-softmmu.mak
@@ -0,0 +1,3 @@
+# Default configuration for rx-softmmu
+
+CONFIG_RX_VIRT=y
diff --git a/hw/Kconfig b/hw/Kconfig
index 88b9f15007..63a071092e 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -53,6 +53,7 @@ source nios2/Kconfig
 source openrisc/Kconfig
 source ppc/Kconfig
 source riscv/Kconfig
+source rx/Kconfig
 source s390x/Kconfig
 source sh4/Kconfig
 source sparc/Kconfig
-- 
2.17.1


