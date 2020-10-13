Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6581EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8D321655
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePKiuh2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8D321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8DB-00017l-Rs
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8B2-0007t2-QQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:28 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8B1-0004mc-Bp
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id h2so9663135pll.11
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 17:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ChWuKq12YEBlrVQq4Iva9E7cg0lDlX98+uvW3A3EDFU=;
 b=ePKiuh2D+XewheeHdwXV9LmhBtd20Y3xPfwOWGM2LISqb2jg45l67QdbTVF3uidRCz
 owTcpdQ4J7x2iI9H7vChqU25E9WJri2oS205Y1ibUJ/Z0/7D6O9bbEBeP5CGfULAJhXD
 wEla8/UQrHKNPHUzlJXCjCHvaLUUAdD8DPaildb66YvRPes++mvk4KCR1+oDujY0HteH
 yNsl8Bmjiei8AT6KCxY7TH4p4LOBqOJw0/Kd0qK6D8yCL3uQjyIjjUWECPAGWVZ5tNa+
 pG7oCBDKuD8DKSA71PJxNVmcA2zmXTLOrapaVGzhEBe0FtCNUp10Cc8uaUGFkH2s1b+8
 swxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ChWuKq12YEBlrVQq4Iva9E7cg0lDlX98+uvW3A3EDFU=;
 b=Dugcq9z0m+QqzbEJZ4tSoqonG2+jekgjkxqECniPmzhYl3w3fRFbrOQZnxpB1DZwQh
 uaX4PsyKedHvaVXtk1pYZkV6QDIyix9Tcv8GDSRPEsidGyG2/JgjBvHf7z7tHbazlHal
 zDzeCQSd0r55x6jG9ZfQk0LIZvOw0xgIo+k8REhsiNT/zLeBUKxeuRgXyda1go/jCMMl
 5MSjXu5jMC7InxRs5288J+74rNp5EAb64B3WKkK5DLwGsElSPMWnRzjvLQpLDdPdz7Lk
 2rB0mQzL54TARExDrcYdKw/4YblFdjs3FSsffgHvkgdfp5Fk7z5+zbsbMDzAZDov7BaR
 ufuw==
X-Gm-Message-State: AOAM533JeD1J93bSEzxlZg0bHSCosk3CeSoaj/aLq5v2v3+fOqZ+w7Ge
 nIs80kQvVbnqIbz9fO2o7YhCtKgbbiVLsw==
X-Google-Smtp-Source: ABdhPJy1t0/ivvgk17yuXbu22t5/1KW7JJJR2ABog2xXo2sw6uydJgGHyDyIqC6kJE9gxv7O8Y13DQ==
X-Received: by 2002:a17:902:8482:b029:d2:6356:82f8 with SMTP id
 c2-20020a1709028482b02900d2635682f8mr24498904plo.75.1602548904639; 
 Mon, 12 Oct 2020 17:28:24 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id y5sm22565925pge.62.2020.10.12.17.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 17:28:23 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/5] plugins: getting qemu_plugin_get_hwaddr only expose
 one function prototype
Date: Tue, 13 Oct 2020 08:28:02 +0800
Message-Id: <20201013002806.1447-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201013002806.1447-1-luoyonggang@gmail.com>
References: <20201013002806.1447-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x644.google.com
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

This is used for counting how much function are export to qemu plugin.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/api.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index bbdc5a4eb4..13177d3578 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -251,10 +251,12 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
 
 #ifdef CONFIG_SOFTMMU
 static __thread struct qemu_plugin_hwaddr hwaddr_info;
+#endif
 
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr)
 {
+#ifdef CONFIG_SOFTMMU
     CPUState *cpu = current_cpu;
     unsigned int mmu_idx = info >> TRACE_MEM_MMU_SHIFT;
     hwaddr_info.is_store = info & TRACE_MEM_ST;
@@ -266,14 +268,10 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
     }
 
     return &hwaddr_info;
-}
 #else
-struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
-                                                  uint64_t vaddr)
-{
     return NULL;
-}
 #endif
+}
 
 bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 {
-- 
2.28.0.windows.1


