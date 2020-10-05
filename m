Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE42C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E9420756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olHMZPCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E9420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTQe-0003NV-Ab
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLk-0007dd-9f
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:32 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLi-0006qJ-No
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:31 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a1so81077pjd.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ChWuKq12YEBlrVQq4Iva9E7cg0lDlX98+uvW3A3EDFU=;
 b=olHMZPCdk03UW6KpuQANhCdTk8Ae51Mwtppw6qCET96hJnHN9HYlfHggD1bDVjW4SZ
 yaJBdyLRBAhBPsL0kBIwF+/kc+VKrVjrmEZYbXBmel7X90t6pKxyLjF5pZewt1j0lwyX
 2X33QZPJyamZtS/iCtUsyGDd6d80TxRYnyExa2Nda49Z9H2GY+fv+5cr/5CJmPrun9ob
 9TrvR29WIbE3hc9ATWMj5gTYyjLli23Hw9AdA9ni2DddQYBxDCr97w4YWzcNJJXgVixi
 1X+qs4JrmCxkcuunpIGoyCzRf3/2AWCxgwns8tzqO1QoV1dNrLx9OPIrRn3/+4DEB1W2
 2kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ChWuKq12YEBlrVQq4Iva9E7cg0lDlX98+uvW3A3EDFU=;
 b=MvnnvTzAsXJO6YBQKDyf+PoZVwaMEFR5RHvSydDP1MQTMQpsKFvKxSIjI5C9eG8Fe1
 pQU/ceIx27edcTHobAIwfz9Ha3UcvojKVvTvTIkEyIvTwKEqMomGBbT1GRZZMrrryl8U
 hPIvS78xo2gjRARd/wQpjvExi3b5aqxF4vvcQffp8r7eC2iumlGqtmdgigssZ4CdyA0B
 G/wrEL4KkjsgDIAP9mhsV9s2vh3Y+RNxGRg0Htu77QKVLgO11Z+xaI9P6O5vRjzyNa7J
 9GbR/MzGgMPyt8RYQOi+9o3Zq3unbN+TVQJI3nCWNVUMpng6HB8UGjg4MQvJhAeAUr+x
 WLsw==
X-Gm-Message-State: AOAM531N0D+W1ws9MjsPQ3Fk5XakDxxxB0hws9mGXtUitFDH7BYqFuxo
 I1x56RgfNM/oE15P55SV1xOQ0eYYqfB5AQ==
X-Google-Smtp-Source: ABdhPJyVxw4UAclm3mHzlhUqRBHzcolb/ltH2afNage4BVDNMoebf4pPOo4YE3pmnaAcKHVlmFfcSg==
X-Received: by 2002:a17:90a:b285:: with SMTP id c5mr229019pjr.44.1601915308904; 
 Mon, 05 Oct 2020 09:28:28 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x13sm374725pfj.199.2020.10.05.09.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 09:28:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/6] plugin: getting qemu_plugin_get_hwaddr only expose one
 function prototype
Date: Tue,  6 Oct 2020 00:28:03 +0800
Message-Id: <20201005162806.1350-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201005162806.1350-1-luoyonggang@gmail.com>
References: <20201005162806.1350-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1042.google.com
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


