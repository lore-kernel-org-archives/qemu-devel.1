Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A3C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAC120789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqX/iNZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAC120789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCAZ-0007FW-NU
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0k-0004CM-HH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:50 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0h-0003Bq-9p
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id g12so2839098wrp.10
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DxeLu6aGWBvskvNncWpQH0bTFZxrTYaBhzESwlwiROA=;
 b=rqX/iNZrYPFCy9PCxJww3ksToJvgCYc1MMJ9shADetfmnm0V37am99D7tWNwD7kuB7
 10Hq+zvSUI6d1cqNygU3oHDa9ZnNeXDXijfXHFeB+0MJF8dFf3B+r9q7+ZOpPBFhwT/Z
 IseXru3ynXMMoR+2841Yz2Jn8dOb+jQBTUzsrsuDb0mqN4ILgLUnTtmYwPtzMoPs6Erk
 Makki6xC4EF3Iv33PTRJmufGxsA2ERhbVt1e8hoZkioLBgueRH7YodlYaJXxc/Qpep5x
 KH3ejxoLlCsjj2nLGJ4n4HS98+wsvKtK6qUAkyYHv/C65f7D2kGTgxKzBGDDRcKHFLbz
 ElAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DxeLu6aGWBvskvNncWpQH0bTFZxrTYaBhzESwlwiROA=;
 b=EpzBuPxqYZBdyfA6m53HObbE6+p8JoPc/1a7PArZadj8+xe9B0dzWb0K6iKP48O/od
 hO2XqNc6QtgpOKSdoocCYWuc7wV7KBGhn2pgvmaGjRCau+XHaNnsb8sdQjhz7BXHr1rv
 VCXuuZ+pfE3lZP+yrn7xpq2Qf2KD2IN+HoOYVgTze9xKuyUWonV2eOho4mFO5Hgu48kx
 O5zTDmOSMERtgcaNKtbVZhdugzsEIsHM1HX1P+iRiXrGtQKszlp+sXtED6Di4fD6Cqhz
 gWubdz0wyxS/d9CI7pAzUPlg3q1IEBBPm1rQw2SKAeB8Leosd+oxc1gHUwUdUznmL0M1
 IuCA==
X-Gm-Message-State: AOAM531qirNpEKl3ErJ4ZILSKlux6Z1HabTia4DqIutMcra2rhHUr2nU
 LgNZS7mk1SfIM6qizWgxvdUUkA==
X-Google-Smtp-Source: ABdhPJzhmef4nh6Xi4jrGbygq8X5doI4h8zPJmlJoQa7uibnslZ7WSHD3oyX6bIXXmneeYBli6DnPg==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr4660400wrp.179.1602086985477; 
 Wed, 07 Oct 2020 09:09:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p21sm3331561wmc.28.2020.10.07.09.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:09:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F12F41FFAA;
 Wed,  7 Oct 2020 17:00:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 20/22] plugin: Fixes compiling errors on msys2/mingw
Date: Wed,  7 Oct 2020 17:00:36 +0100
Message-Id: <20201007160038.26953-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20201001163429.1348-3-luoyonggang@gmail.com>
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
2.20.1


