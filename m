Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65198C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24E62168B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrjaSurQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24E62168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMAvm-0000fk-Uq
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 10:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMAoZ-0000VN-SC
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:04:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:40675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMAoY-0005MG-1c
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:04:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id bd2so878963plb.7
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EOZ1D2QEBZkHNlw7AF2wWJzGV7XJ3mBIlC+/pAIy1UI=;
 b=rrjaSurQ7c1hZSrwZX5ift//w0vHEt6TzhxHRC9Tfg/XpcXok+qgltwT9d9+ziepXS
 qj5YdhnJi0yIkKzQChJ6Yu0T1Gff7xBNcXCkk5Pm1y2rgtLaQ+IdgODHixu5M75fBAyv
 RjISEwx598EckQnXPAFGotR8ISEx10Rev+lG9BYLn63MGtUs55enMqtBnsnsD0A4nzWI
 Ye2qGLX1tnsA8fOjy8sSg08yizEgn+YGrsYN97iL3goAEtTQIegOJEQSfqmp3MrBBf7N
 o6BIolBLuZh3OXwbkrTeEvI/YBCINAuyrCBRbbpMH54+k9CWYrctmR2HRdcbaqoP/8qO
 5ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EOZ1D2QEBZkHNlw7AF2wWJzGV7XJ3mBIlC+/pAIy1UI=;
 b=e0ssnNxwUz758MwyTHP8KxF2rKjx9BrihDastPZ+0K5snEPjdwYHs4LFBch5KrX25N
 hbScGVPNuaZ0PNGFMGxzrFmOSHXamXzkRQQJyd/nLI9UXHsMfpMbewGpN1PiSZk7w/Xf
 AH945SB5YbLrFaDlgl4rawcEojPC79tfQ6fJuAgKW4qfd9XTqS5Por1mvynarscqzXAe
 GsXQ7VLXGY2W67YV97pqmpNb/0KKuNWHqhoqb0XYGyf2F53JSSj/a62TV9ZwCT9/wCWH
 U6Faz8Pn3Gq4e+7G/XPeytjzZRrYfRIH6hH3yrcfNCKzG7nTevEFzk2MRXLAcT/N01eg
 WTNQ==
X-Gm-Message-State: AOAM530YDp011mYD5TFDcxaEmcSgsOSCaAdPQotAC/wDYjMixjYo4T1B
 MeQk9BLhVQtkH9U6bhDvEN3ZE+xfrFBvWSN+
X-Google-Smtp-Source: ABdhPJwtZIj/WwLnJO8m/y3qHvXALXQ0m0EFB8lQPLQZOtNlxC2MBHfDoS/i0sGIr02TrZFnD/X2jg==
X-Received: by 2002:a17:902:fe88:b029:d2:2a16:254 with SMTP id
 x8-20020a170902fe88b02900d22a160254mr4152247plm.23.1601129076004; 
 Sat, 26 Sep 2020 07:04:36 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k3sm6091109pfp.41.2020.09.26.07.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 07:04:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] plugin: Fixes compiling errors on msys2/mingw
Date: Sat, 26 Sep 2020 22:04:13 +0800
Message-Id: <20200926140415.1286-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200926140415.1286-1-luoyonggang@gmail.com>
References: <20200926140415.1286-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x635.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 contrib/plugins/hotblocks.c | 2 +-
 tests/plugin/bb.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 3942a2ca54..37435a3fc7 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -102,7 +102,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     ExecCount *cnt;
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
-    unsigned long insns = qemu_plugin_tb_n_insns(tb);
+    size_t insns = qemu_plugin_tb_n_insns(tb);
     uint64_t hash = pc ^ insns;
 
     g_mutex_lock(&lock);
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index e4cc7fdd6e..ef784be78f 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -72,7 +72,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     CPUCount *count = max_cpus ?
         g_ptr_array_index(counts, cpu_index) : &inline_count;
 
-    unsigned long n_insns = (unsigned long)udata;
+    uint64_t n_insns = (uint64_t)udata;
     g_mutex_lock(&count->lock);
     count->insn_count += n_insns;
     count->bb_count++;
@@ -81,7 +81,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
-    unsigned long n_insns = qemu_plugin_tb_n_insns(tb);
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
     if (do_inline) {
         qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-- 
2.28.0.windows.1


