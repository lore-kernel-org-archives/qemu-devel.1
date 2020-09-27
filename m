Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7948BC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A7123976
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKCC9rBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A7123976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMRzQ-00013V-TI
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 04:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMRu0-0004Pa-Ld
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:19:24 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMRtz-0005Kz-41
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:19:24 -0400
Received: by mail-pf1-x442.google.com with SMTP id z19so6646965pfn.8
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ftwAsBeI7Tx5KHajpgLxYQyV0gF6bUfHmuSitMUFQwc=;
 b=UKCC9rBNBi4KadBMXsX5KAXif+NhzbpJN3SU4kxg4ObJ0yRgv034oOpXaLv/Lbt5JQ
 5ZHnpAgl28KDS1pUKdQVNxH7P++BVINAnym5Oc9SWQIMl+cn/XkSQFXjB8K8fx8RQwKR
 GPhquhi6HBwy2bVXcXSHBykkg7oGok/Ky8eqWwk8QtNAVaJK1awbs5y9XMDoz11660Ii
 UJpK1VR6Vt2xjSEywZJQsOJ7C4DoLfS7mhT2YBrHqFnuMeOKvHNNWMORBbi7HJT2Kd1N
 Fe1uISTEBlDTVgfhT2UpkFlUpNI+gAAdlGlBUny4LFdYlXMH3P8W5S0iEwLor8bK8WW/
 FDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ftwAsBeI7Tx5KHajpgLxYQyV0gF6bUfHmuSitMUFQwc=;
 b=Xw83splTBLFiIA2w28Y/f6Tm5n23rSmRVy8cDdHO13v7t9jgzJ8QpXRYZdAaYB8R4/
 yJMNMAXCtN9LLs2tLRxPw3l4JeiA/o5TWy6rlENR5eyG0XH26zPr5ZYIPB7V3fHOLMrJ
 tURG8QN8rbSpNCXyJk7a+uRhh+BIyeCVM586wzFvgz+WkE5C0gbPSaGzxPr/P69KR2XX
 uRZVhT2tpA5fwLiGI1WO6ugS0LcX0iI64aH0ZAnMFRh4S4hNrjCzyPwIKtuTSM8j3rhF
 0iwiu+AjTphx4T7dfzH3K4XQDEHJMlsKAwI3IkbDoAHgS0YHkPwJGcbqxdDwVJugSymz
 rPOA==
X-Gm-Message-State: AOAM530wVpFY4dVH0toDTWglGswmsFfZ5QSW2unlE3OeE78ABeaLL9AX
 B7i6sghaOd0ljI30Pb5DjbUGKX3wlpzysaj/
X-Google-Smtp-Source: ABdhPJxPu1ohMkg6E8ZLWy+be8gV2/wh2yjoIkdEndHxaAPcF/C629bA/NtpKPVWk0QWFBZ4kfQNRw==
X-Received: by 2002:aa7:8512:0:b029:13c:1611:653e with SMTP id
 v18-20020aa785120000b029013c1611653emr6322059pfn.16.1601194761270; 
 Sun, 27 Sep 2020 01:19:21 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id z22sm3317693pjq.2.2020.09.27.01.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 01:19:20 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] plugin: Fixes compiling errors on msys2/mingw
Date: Sun, 27 Sep 2020 16:18:59 +0800
Message-Id: <20200927081901.771-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200927081901.771-1-luoyonggang@gmail.com>
References: <20200927081901.771-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=E8=8C=85e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index e4cc7fdd6e..de09bdde4e 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -72,7 +72,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     CPUCount *count = max_cpus ?
         g_ptr_array_index(counts, cpu_index) : &inline_count;
 
-    unsigned long n_insns = (unsigned long)udata;
+    uintptr_t n_insns = (uintptr_t)udata;
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


