Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09904C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4665D21D81
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXyA/fmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4665D21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagfP-0006LI-MC
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kageo-0005vf-0l
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:54:34 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kagel-0005Gk-Qm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:54:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id x7so2113264wrl.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=4+u4YMgDgUVFIAFu1azoEzrYkuhRgW3jWIiyqbzplY0=;
 b=WXyA/fmOQ1g7C7fvoV1MtfWC05/7e21QACPEg9Ta+JyaU5iRsjboHUojZph2QvCZbK
 jq0JjHtTIdNHI3VV1osP0yKWO6XIpU5fSaBSu8k6riFk/7tmamYMXdYx6Mzzhx0ChpNS
 7SA23srhNPKXFbykoj2yRZZHkm5KfmmY3s5e3FuCo9hxfm7Ol4OqewCJH8klkqr7KNAi
 yyktf4yDQLSE3IhrFRIaObvFl8hs+ea7JhioJmhZC5czR5oMERRZ/6Zcj9s0JccrGsoI
 0bsUu4RUhQNCsg6G92Z+id276OoRRA3ZtTArfNhaJD3wBxjLdSN0nvsHB5X6EjEWgHKU
 ZO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=4+u4YMgDgUVFIAFu1azoEzrYkuhRgW3jWIiyqbzplY0=;
 b=hl4FSWvspHpsGJrHQKLypKR3g6+R52THsO0w1ACz9rITunUHTEM7bq/AxolyKvSkOC
 0y+AOkkUuhJrhoGcjdeXU4BnAANe+Y8HtXXJEQifK7w63Q4OA+zy8+xp2JTkhrN7poRn
 H5htlZPsctiWEpF8WORB4e1Bol6HT+H9Qr5JclWMEzZXIrUmy74p8LfrZ9jiG1sqXt1C
 wUF21Y5JmjG1/uuUPAeNIpaVCoNdfx7SouwRgv7+qKZsRQCbUPSw5Y0EwzLRMy9XH8Km
 ++QzFRcUBWgqkjAnvE5d7alY9q1jNWouglYUzhvQnFD8VydxPmtPBAVMm+0lyPVIWNuC
 Fkvw==
X-Gm-Message-State: AOAM5310BXRpUI6SdjbWMRLQYAzc6cJBKP+HkYIhRu0nlVawrkTl1UCX
 yRXmZ97OAbzt1OOVUFWM+injR58ctRg=
X-Google-Smtp-Source: ABdhPJxYJ9/kUUdpCUZ+Y3KU5gvmqvW4qnkkTVmuYIQl9x/Lj18IZzXqel8nqKqPqQ93qrakTJT6uA==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr2897325wrr.364.1604588069639; 
 Thu, 05 Nov 2020 06:54:29 -0800 (PST)
Received: from [192.168.1.103] ([151.33.227.77])
 by smtp.gmail.com with ESMTPSA id z5sm2852186wrw.87.2020.11.05.06.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 06:54:29 -0800 (PST)
To: Laurent Vivier <laurent@vivier.eu>
From: LemonBoy <thatlemon@gmail.com>
Subject: [PATCH] linux-user: Correct definition of stack_t
Message-ID: <bf2b4da4-385d-a0f7-7915-4f31fa797898@gmail.com>
Date: Thu, 5 Nov 2020 15:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=thatlemon@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 914c30863b45d6fcd3e2fc83929bcac546be1555 Mon Sep 17 00:00:00 2001
From: LemonBoy <thatlemon@gmail.com>
Date: Thu, 5 Nov 2020 15:48:24 +0100
Subject: [PATCH] linux-user: Correct definition of stack_t

Some platforms used the wrong definition of stack_t where the flags and
size fields were swapped or where the flags field had type ulong instead
of int.

Due to the presence of padding space in the structure and the prevalence
of little-endian machines this problem went unnoticed for a long time.

The type definitions have been cross-checked with the ones defined in
the Linux kernel v5.9, plus some older versions for a few architecture
that have been removed and Xilinx's kernel fork for NiosII [1].

The microblaze header and the bsd-user ones remain unchanged as I don't
know if they are wrong or not.

[1] https://github.com/Xilinx/linux-xlnx/blob/master/arch/nios2/include/uapi/asm/signal.h

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
---
 linux-user/alpha/target_signal.h  | 3 +--
 linux-user/arm/target_signal.h    | 6 +++---
 linux-user/cris/target_signal.h   | 6 +++---
 linux-user/hppa/target_signal.h   | 2 +-
 linux-user/i386/target_signal.h   | 6 +++---
 linux-user/m68k/target_signal.h   | 6 +++---
 linux-user/mips/target_signal.h   | 6 +++---
 linux-user/mips64/target_signal.h | 7 +++----
 linux-user/nios2/target_signal.h  | 5 +++--
 linux-user/ppc/target_signal.h    | 6 +++---
 linux-user/s390x/target_signal.h  | 2 +-
 linux-user/sh4/target_signal.h    | 6 +++---
 linux-user/sparc/target_signal.h  | 6 +++---
 linux-user/x86_64/target_signal.h | 6 +++---
 14 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/linux-user/alpha/target_signal.h b/linux-user/alpha/target_signal.h
index cd63d59fde..b83797281c 100644
--- a/linux-user/alpha/target_signal.h
+++ b/linux-user/alpha/target_signal.h
@@ -42,8 +42,7 @@
 
 typedef struct target_sigaltstack {
     abi_ulong ss_sp;
-    int32_t ss_flags;
-    int32_t dummy;
+    abi_int ss_flags;
     abi_ulong ss_size;
 } target_stack_t;
 
diff --git a/linux-user/arm/target_signal.h b/linux-user/arm/target_signal.h
index ea123c40f3..0998dd6dfa 100644
--- a/linux-user/arm/target_signal.h
+++ b/linux-user/arm/target_signal.h
@@ -4,9 +4,9 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_ulong ss_sp;
-	abi_long ss_flags;
-	abi_ulong ss_size;
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
 } target_stack_t;
 
 
diff --git a/linux-user/cris/target_signal.h b/linux-user/cris/target_signal.h
index 1cb5548f85..495a142896 100644
--- a/linux-user/cris/target_signal.h
+++ b/linux-user/cris/target_signal.h
@@ -4,9 +4,9 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_ulong ss_sp;
-	abi_ulong ss_size;
-	abi_long ss_flags;
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
 } target_stack_t;
 
 
diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index c2a0102ed7..c52a3ea579 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -44,7 +44,7 @@
 
 typedef struct target_sigaltstack {
     abi_ulong ss_sp;
-    int32_t ss_flags;
+    abi_int ss_flags;
     abi_ulong ss_size;
 } target_stack_t;
 
diff --git a/linux-user/i386/target_signal.h b/linux-user/i386/target_signal.h
index f55e78fd33..50361af874 100644
--- a/linux-user/i386/target_signal.h
+++ b/linux-user/i386/target_signal.h
@@ -4,9 +4,9 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_ulong ss_sp;
-	abi_long ss_flags;
-	abi_ulong ss_size;
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
 } target_stack_t;
 
 
diff --git a/linux-user/m68k/target_signal.h b/linux-user/m68k/target_signal.h
index 314e808844..d096544ef8 100644
--- a/linux-user/m68k/target_signal.h
+++ b/linux-user/m68k/target_signal.h
@@ -4,9 +4,9 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_ulong ss_sp;
-	abi_long ss_flags;
-	abi_ulong ss_size;
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
 } target_stack_t;
 
 
diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index 66e1ad44a6..fa4084a99d 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -45,9 +45,9 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_long ss_sp;
-	abi_ulong ss_size;
-	abi_long ss_flags;
+    abi_ulong ss_sp;
+    abi_ulong ss_size;
+    abi_int ss_flags;
 } target_stack_t;
 
 
diff --git a/linux-user/mips64/target_signal.h b/linux-user/mips64/target_signal.h
index 753e91fbd6..799f7a668c 100644
--- a/linux-user/mips64/target_signal.h
+++ b/linux-user/mips64/target_signal.h
@@ -45,12 +45,11 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_long ss_sp;
-	abi_ulong ss_size;
-	abi_int ss_flags;
+    abi_ulong ss_sp;
+    abi_ulong ss_size;
+    abi_int ss_flags;
 } target_stack_t;
 
-
 /*
  * sigaltstack controls
  */
diff --git a/linux-user/nios2/target_signal.h b/linux-user/nios2/target_signal.h
index fe48721b3d..aebf749f12 100644
--- a/linux-user/nios2/target_signal.h
+++ b/linux-user/nios2/target_signal.h
@@ -4,11 +4,12 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-    abi_long ss_sp;
+    abi_ulong ss_sp;
+    abi_int ss_flags;
     abi_ulong ss_size;
-    abi_long ss_flags;
 } target_stack_t;
 
+
 /* sigaltstack controls  */
 #define TARGET_SS_ONSTACK     1
 #define TARGET_SS_DISABLE     2
diff --git a/linux-user/ppc/target_signal.h b/linux-user/ppc/target_signal.h
index 4453e2e7ef..72fcdd9bfa 100644
--- a/linux-user/ppc/target_signal.h
+++ b/linux-user/ppc/target_signal.h
@@ -4,9 +4,9 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_ulong ss_sp;
-	int ss_flags;
-	abi_ulong ss_size;
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
 } target_stack_t;
 
 
diff --git a/linux-user/s390x/target_signal.h b/linux-user/s390x/target_signal.h
index b58bc7c20f..bbfc464d44 100644
--- a/linux-user/s390x/target_signal.h
+++ b/linux-user/s390x/target_signal.h
@@ -3,7 +3,7 @@
 
 typedef struct target_sigaltstack {
     abi_ulong ss_sp;
-    int ss_flags;
+    abi_int ss_flags;
     abi_ulong ss_size;
 } target_stack_t;
 
diff --git a/linux-user/sh4/target_signal.h b/linux-user/sh4/target_signal.h
index 434970a990..d7309b7136 100644
--- a/linux-user/sh4/target_signal.h
+++ b/linux-user/sh4/target_signal.h
@@ -4,9 +4,9 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_ulong ss_sp;
-	abi_long ss_flags;
-	abi_ulong ss_size;
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
 } target_stack_t;
 
 
diff --git a/linux-user/sparc/target_signal.h b/linux-user/sparc/target_signal.h
index 5cc40327d2..1b10d1490f 100644
--- a/linux-user/sparc/target_signal.h
+++ b/linux-user/sparc/target_signal.h
@@ -42,9 +42,9 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_ulong ss_sp;
-	abi_long ss_flags;
-	abi_ulong ss_size;
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
 } target_stack_t;
 
 
diff --git a/linux-user/x86_64/target_signal.h b/linux-user/x86_64/target_signal.h
index 4c4380f7b9..4ea74f20dd 100644
--- a/linux-user/x86_64/target_signal.h
+++ b/linux-user/x86_64/target_signal.h
@@ -4,9 +4,9 @@
 /* this struct defines a stack used during syscall handling */
 
 typedef struct target_sigaltstack {
-	abi_ulong ss_sp;
-	abi_long ss_flags;
-	abi_ulong ss_size;
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
 } target_stack_t;
 
 
-- 
2.27.0


