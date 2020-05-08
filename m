Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586AFC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F51B20CC7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqqDVIQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F51B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5LT-0003oL-5b
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ac-0007eR-TD
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:14 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ac-0005FR-3g
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:14 -0400
Received: by mail-pg1-x544.google.com with SMTP id l12so1021637pgr.10
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zh5AXFaGhtlPqTPsSpsbL94yQNo2CeEhqJ8RoX9VWPE=;
 b=QqqDVIQ7as3k8T06pDkYqE5PAebUoi4fyUoSWU88ykMnnxJpVA1TOvdS8X7Wqcj7cJ
 u7oIEO+vI5ErxrUScuEX9BjbvXRSHY9LSnVJvtyQzN/f9ZiFxhXVEqypB9UYDmPUEain
 Dfgio46iE9JelbfwOdq09mM0fpchaKLrLb5ksb3Z1EzrMn3mOW7dh3iEPtj6VJuTPUrl
 uxpXUlEodgvOcaj3nzY4YNVQvoHpTc4FUf5kLFu4YOue5wQ7f5OF7FIbQ2VoSB1KLO6t
 1hv9ZJvlEDAWToWSVXi4pAw7QP2zGXVdnVR0LiR1Hbjxw7NAJPC/6o/H9FalgTyxOAo7
 5b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zh5AXFaGhtlPqTPsSpsbL94yQNo2CeEhqJ8RoX9VWPE=;
 b=J/TN7PcpdaD1Ap5/hFjfzqSlRBjCEqQVE/vJAJ5W7daH+ZRIYUhZ6+vqTNiFWNIccr
 OMvZGYotSwDwuf1FzkNX+Drd2TLKwjsB1rV3Kz3p/Njk4T8X+s6b9sG0cbHBZx5h8XBf
 EBrjB1I2m3fT16MYAJZTmNidCzYwKVLV3PsizfH1jciVLqWn30ChUkmtPWE11aejaRS/
 O0GR9Po+ZLey8utySd1Jg4L9rjGZM5a3KMbBnejz0dGmxUphMZhLzRHzmNSMZOdSys+e
 0fhOBuAngNTA6FwhMNdzaW+eeWEE+wUdZYu81Me7A/cVDJF4629+Z5Pvmkg1E685ENSt
 Cgxw==
X-Gm-Message-State: AGi0PuZpWGJ1sTcY1bAjTRjGqO67E7Ytlh0KlYiP5R39Jn8ixtAXyrdc
 j3fYnnERQHzd7ZzsRNzHIs19SqvaDp8=
X-Google-Smtp-Source: APiQypISvLplzIagQuWF/TRzATA3SypVlE9Qv3S7bJVuE7sDJ2oUE9wB1z3tvEs8U2J9THeQ1vlb7Q==
X-Received: by 2002:a62:35c3:: with SMTP id c186mr3433671pfa.261.1588952652358; 
 Fri, 08 May 2020 08:44:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o99sm2727662pjo.8.2020.05.08.08.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:44:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 04/19] accel/tcg: Adjust probe_access call to
 page_check_range
Date: Fri,  8 May 2020 08:43:44 -0700
Message-Id: <20200508154359.7494-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
References: <20200508154359.7494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have validated that addr+size does not cross a page boundary.
Therefore we need to validate exactly one page.  We can achieve
that passing any value 1 <= x <= size to page_check_range.

Passing 1 will simplify the next patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 4be78eb9b3..03538e2a38 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -211,7 +211,7 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
         g_assert_not_reached();
     }
 
-    if (!guest_addr_valid(addr) || page_check_range(addr, size, flags) < 0) {
+    if (!guest_addr_valid(addr) || page_check_range(addr, 1, flags) < 0) {
         CPUState *cpu = env_cpu(env);
         CPUClass *cc = CPU_GET_CLASS(cpu);
         cc->tlb_fill(cpu, addr, size, access_type, MMU_USER_IDX, false,
-- 
2.20.1


