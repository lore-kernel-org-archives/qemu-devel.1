Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943DCC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F357E20872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GotOFXkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F357E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1h4-00015R-PV
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xh-0005CZ-MI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:53 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xf-0004X0-Sn
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:53 -0400
Received: by mail-pf1-x444.google.com with SMTP id d9so5046642pfd.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ftwAsBeI7Tx5KHajpgLxYQyV0gF6bUfHmuSitMUFQwc=;
 b=GotOFXktQIjUWL1k2r5N1ARvqP+ispCqYqw2LhSYqvQHjOTOUYhSXVacojKajMcP76
 /hGo6TB83Jl1+LAS/g7/YrqsO+z8l9fpz7gJIbBxAtlwven5vFpJa9J/rpn6zUf14aKe
 a3O7Ut7JwPoEzlsG67Xt+hNsXsxyyIeRUq6wirGj0AJjWTETnZ5tMXRWT8y9zlepx0aW
 Zonr+Lj6i9YOfNYT4+SoZU0gKfCN4Xc3KGfuS6Cl72vXdwvJ2hGQ86JVhgUrP3Wt85lW
 wV/7t47aJGB0sanZX4iQ//kS7+BgEXIBZ9QVOgPZCi9mLR0zhfuIKJLRSl/mwWRjGEzM
 AVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ftwAsBeI7Tx5KHajpgLxYQyV0gF6bUfHmuSitMUFQwc=;
 b=o2qKPvKNpKQURX0MLaAOW3mmxWNos1SV2AZr3gUEWVzQGTk9AZsQ38YwnsNItYUJkg
 b8Va727ietpCsNW7wvSDrz/SLIGEECcpfc8Y2fHrkNV4sQQuQb1P9L7RRFckd6DaxQoa
 QDZfOwhOnxdRqPlo5DjSvydZWhrpnT4V+XVP31fn4wsphpTPK0mBNLzzeH3LVnJTiPB0
 LGxlpvzOsibuw6bl/TgWl746QydYswtpdt6J7QdeE63zqHihQ36pJoz8a9RKImGExvPJ
 3/NClV9bF+CQcWaNLFBTcPay6+BdHMXWfTM0zGiEa5XghHIVYb/vktZ4VpYnSRP+fhbT
 fWIA==
X-Gm-Message-State: AOAM532kPZp5nOdzTf0O7omNDrFUDlKeJ+0ma6ZrHTzPDk+gcOV3V/BX
 szYGI5qrKfb35S6TerfdMhH9elM5O3PIUQ==
X-Google-Smtp-Source: ABdhPJwim4F4NTOiNbUUZosAV07I5UFdiua8F/S1Ycdlqql2JU5jwotaUc3DWvn6KRq/PMq1KC0Cow==
X-Received: by 2002:a63:1c4e:: with SMTP id c14mr6614918pgm.98.1601570089985; 
 Thu, 01 Oct 2020 09:34:49 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t12sm6946028pfh.73.2020.10.01.09.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:34:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/6] plugin: Fixes compiling errors on msys2/mingw
Date: Fri,  2 Oct 2020 00:34:25 +0800
Message-Id: <20201001163429.1348-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201001163429.1348-1-luoyonggang@gmail.com>
References: <20201001163429.1348-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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


