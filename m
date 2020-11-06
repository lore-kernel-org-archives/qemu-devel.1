Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC95C2072E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVd9OiTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC95C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kashO-00051o-HM
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRn-0005Cs-7D
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:55 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRl-00070n-DU
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:54 -0500
Received: by mail-pg1-x542.google.com with SMTP id i7so2881104pgh.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GhRqALWf9y48BIzmwb6ec/JDv3hDJBRmMXBLeIk5tow=;
 b=PVd9OiTz07UJ7Oyr+RHrlqG5g3BMhQUcj8txKh9hKP/lhuAiJkF8qcAMB/8P1zqK13
 isXy9qaRe98nsADZM9e57elE0vVur6EiO/DT6h/6VdE/wfMbQ9rPnyfOMVmS8C0Dekf/
 l6275MPJ1+o5zKwHXJmxt3KH511z3Qy0p9P8m1QIqHxXIijmvqtfb6qxI7UfQolv1063
 lZKewG+bIUVFWkgWD1ft/wfyuA5rE6jpxZsMKsqaO4vpJYxe1r0w3uL0HluDv3vpku9Z
 UULZ4rtBBwjHLJA7rsuDvx/j0LPo1z1oaSocGP2NqXrNkVJcbRX4vol07nRwEcSs1swt
 CPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GhRqALWf9y48BIzmwb6ec/JDv3hDJBRmMXBLeIk5tow=;
 b=Lw3uyjCuufBaWOy6oZEfRUgqMUu6YeC3R2UuAST72OBHok4AphU46eC2lB67fJtzRy
 DMlmXmza6VGcrZrBYcEnpgGaIfJ3yiC1JNP8W/Iea4iFaHxuUc923hYsHYSu+7cF/Cch
 XqPli92lSNuQ6eEZXZwl8XU40SJLbzBUK064ok9A7ipnAiccZRJ3yAxNHA5NmoAeX5T0
 KLoyBt0U4Twf/6IDDb/YXSJcYHzbbiQw0NfG/ArCeR0xS/lucFWRLPhIsgqslDa/tTfr
 NO/XX1eT+zoumZHrPDaGYclC4Jjz+ytrfIC1ncn6w/Ihf8vQyDYPGx9qsUYj0uBDwtq9
 ZBfw==
X-Gm-Message-State: AOAM533g3u9n7yuxFXV4UUX45L/Qnqy19RfwEO6DYptAukZm6kQNnUx1
 D2Gi0XymV7NDe3EFW40lTWqVDc5TqnLwPw==
X-Google-Smtp-Source: ABdhPJwNOjkKvb0hxulvS+ui0ckDkTszzhXCU6hepRXUNY/zXghGL2EAZKZbmEfv23leouAqTRAzTg==
X-Received: by 2002:a62:2e47:0:b029:155:853a:80d5 with SMTP id
 u68-20020a622e470000b0290155853a80d5mr102567pfu.29.1604633391633; 
 Thu, 05 Nov 2020 19:29:51 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/41] disas: Push const down through host disasassembly
Date: Thu,  5 Nov 2020 19:29:02 -0800
Message-Id: <20201106032921.600200-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/dis-asm.h | 4 ++--
 disas.c                 | 4 +---
 disas/capstone.c        | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 2164762b46..d1133a4e04 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -358,7 +358,7 @@ typedef struct disassemble_info {
     (bfd_vma addr, struct disassemble_info * info);
 
   /* These are for buffer_read_memory.  */
-  bfd_byte *buffer;
+  const bfd_byte *buffer;
   bfd_vma buffer_vma;
   int buffer_length;
 
@@ -462,7 +462,7 @@ int print_insn_rx(bfd_vma, disassemble_info *);
 
 #ifdef CONFIG_CAPSTONE
 bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size);
-bool cap_disas_host(disassemble_info *info, void *code, size_t size);
+bool cap_disas_host(disassemble_info *info, const void *code, size_t size);
 bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count);
 bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size);
 #else
diff --git a/disas.c b/disas.c
index de1de7be94..a61f95b580 100644
--- a/disas.c
+++ b/disas.c
@@ -299,10 +299,8 @@ char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
 }
 
 /* Disassemble this for me please... (debugging). */
-void disas(FILE *out, const void *ccode, unsigned long size)
+void disas(FILE *out, const void *code, unsigned long size)
 {
-    /* TODO: Push constness through the disas backends. */
-    void *code = (void *)ccode;
     uintptr_t pc;
     int count;
     CPUDebug s;
diff --git a/disas/capstone.c b/disas/capstone.c
index 7462c0e305..20bc8f9669 100644
--- a/disas/capstone.c
+++ b/disas/capstone.c
@@ -229,7 +229,7 @@ bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
 }
 
 /* Disassemble SIZE bytes at CODE for the host.  */
-bool cap_disas_host(disassemble_info *info, void *code, size_t size)
+bool cap_disas_host(disassemble_info *info, const void *code, size_t size)
 {
     csh handle;
     const uint8_t *cbuf;
-- 
2.25.1


