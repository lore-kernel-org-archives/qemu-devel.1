Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B8CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B812074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBdON3YY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B812074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGMd-0004Au-V2
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHt-0003np-7e
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:49 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHs-0003vn-DR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:48 -0400
Received: by mail-pl1-x643.google.com with SMTP id x11so3970325plv.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v6Twul2TWinr3wq/OK/PDzXQA1fcuJlgD8ranJI4BbA=;
 b=EBdON3YYo2xKvrGSBkHyEwTIAXa61zRQoHX8yCulu7uFXilzRYrcVWM9Dj1XeJV2OH
 dZ2faymKP5rnvE1O1bvGQUH8Qq/QqL89/F/HqqqMNeQ/dO4pJAlUkUG4ovAE90P+R0TF
 QogqOTUVIcCacRqHeMi5U3VPZ9ym2TkIODq1pCP/CeX9OE8DMY5qc9TIlsovpH6mL4+E
 JjoLdTMG0ijXuMtbUPf/7ifWt47C4IA2OkPYoNgnBQHxzDLLz89qtYl40dIRxyqFz+hl
 4MArs8YLqh89qlM7ouspumwDrNtiqYp6t9QWGprph2ArY/KEqGuMbqDRms579/CpnLFh
 gw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v6Twul2TWinr3wq/OK/PDzXQA1fcuJlgD8ranJI4BbA=;
 b=fZHtlg/sZlxRe+SItfo2jV3SzOVdn3k33vIX/ShWYNc9VgZe3SdfW7KHbRlaEThBvC
 gpuZoEK0GGrgKcA9qlp+PZWrRph6gX+9EO0CmlzQaManr6bkHcgKf9E0MzW6WEdXVTo3
 Zex1d2134nwhxQHNzuRVmfJzY/KNuttBsQ6XZ1uiYryBV90Vny9sEU1Q6qdA5/1A9LG3
 CGBTQ/VJfARHvWu6sKBl1fYF2QTiL0gYnkBBshy/OScXVfrbRGqsVOVMo+BTqx9qGAjV
 xt/zpeIU9Tg2m6osc14LgqvySnP/10RwhCBdyH2yPdOLMKpLp6pdXL7BPklC6BQI7656
 43iA==
X-Gm-Message-State: AOAM5326tW9mrFXAewq2PWfMCqjKBK7Bv09PclQdfcsFdoxyTL8Wvnup
 SYm24c2B5SKN/29kSj8oc8RaPwDYPWbLAA==
X-Google-Smtp-Source: ABdhPJzbrXcrZ3ylaYvR3CPB5ANin7X8436DGAOKCvo/u8bOMvKRRmvy+yxoiWavh4EU7k7LKFVU9w==
X-Received: by 2002:a17:902:c3cb:: with SMTP id
 j11mr2968816plj.171.1591378666868; 
 Fri, 05 Jun 2020 10:37:46 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:46 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/13] translate-all: call qemu_spin_destroy for PageDesc
Date: Fri,  5 Jun 2020 13:34:16 -0400
Message-Id: <20200605173422.1490-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
References: <20200605173422.1490-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

The radix tree is append-only, but we can fail to insert
a PageDesc if the insertion races with another thread.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/translate-all.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3708aab36b..3fb71a1503 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -547,6 +547,15 @@ static PageDesc *page_find_alloc(tb_page_addr_t index, int alloc)
 #endif
         existing = atomic_cmpxchg(lp, NULL, pd);
         if (unlikely(existing)) {
+#ifndef CONFIG_USER_ONLY
+            {
+                int i;
+
+                for (i = 0; i < V_L2_SIZE; i++) {
+                    qemu_spin_destroy(&pd[i].lock);
+                }
+            }
+#endif
             g_free(pd);
             pd = existing;
         }
-- 
2.17.1


