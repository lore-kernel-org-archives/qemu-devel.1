Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341BAC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA94A2227F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slhjeBkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA94A2227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvWC-00020s-IR
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRC-00034q-Qw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRB-0006HR-3A
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id m6so10980644wrn.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7hehInkKQivK5jFvcBnQIy+vpL6uJMeHgLNPrr9WBHA=;
 b=slhjeBkpyRRdsfiOmXlKp7mLTtMtXI4tPE6qF16agAiTRQnL/Kr8TVxF/wDf5Dg0W9
 w3H6iwViDtXCOzCS78QVm7I5w9kQPo9Viti9tpEOXfaj3j2VRGvJSK3TYFClUJbPfZ1B
 WTeOHrx9zrWFwMcqnhgBhiw73Gj2dbFcMoaDRNgtu07jhvBU4tW+8TAo35UuksigWK6v
 r5MdDo0is6dz8n9W8GdU859KMqPQnrrHM7OSqbTQGsrOQmSXd0ZpR90krx2ajB8zwJbw
 46Z+C8BRNyptTN8Ia3J5N9Bj1ni/W2ZA4yKUE3DLuR4VKdCXK7drpUJtKGwD/lLDu8Sd
 M5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7hehInkKQivK5jFvcBnQIy+vpL6uJMeHgLNPrr9WBHA=;
 b=Q6mzbhccCVXRPOkUA4a1vmvWSuhHrH2P5I5/JYRVr//LLOq44ceg6rzluokmQn44w2
 hD+tqy9y9faEa9p5DPY3wpkzgGqahIRq9QaMFtsU7iiOHNc9EH8WzM7B6pgJw1J3cye5
 B+w6Ti8PFyEzNRmMZ1P+49ygTvj/yYba3v/MojL5bI28BJwCIgMup5keqR4TuDL6wPdH
 yeML+ab0gyG/780hLvzyHBcjj0XTIohFs6DnIiT1aX0HrSAVLTR8lBeCwUW3qe4lqdDm
 qExl85VJI2yuFHevXjyBS22JnMbPJ+f6prve36r91O6/EeY/psDErbT+qZWgxf5V1g4o
 eltA==
X-Gm-Message-State: AOAM530Hqvgu9Asqkk6F9wYNZJkpEm1iucGKBmWjtN9lJ2cpppYsKKxA
 umUx3FfFN58lt13uNbtEDIyJN0xfliWmpQ==
X-Google-Smtp-Source: ABdhPJxlQHuyxXhkFJdUVzHLPsJ3UIpFUPjj5o/V+ZE8K1MtBq9sxRCkbRU8ijIzxRasyre/AvaYfQ==
X-Received: by 2002:a05:6000:8e:: with SMTP id
 m14mr15877518wrx.400.1602261607674; 
 Fri, 09 Oct 2020 09:40:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p21sm12676556wmc.28.2020.10.09.09.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:40:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD07C1FFAA;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 20/22] plugin: Fixes compiling errors on msys2/mingw
Date: Fri,  9 Oct 2020 17:31:45 +0100
Message-Id: <20201009163147.28512-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201001163429.1348-3-luoyonggang@gmail.com>
Message-Id: <20201007160038.26953-21-alex.bennee@linaro.org>

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


