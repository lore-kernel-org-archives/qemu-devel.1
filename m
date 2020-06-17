Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7952CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412212184D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbqe93r9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412212184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfqQ-0001iH-Fw
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEk-0004Oo-8w
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:46 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEd-0000Mu-F9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:45 -0400
Received: by mail-qt1-x842.google.com with SMTP id q14so2744727qtr.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NQ/BbjaNmbkm5KQOy7Vv4O17R/NYOg7qZF+hAsl6NgU=;
 b=nbqe93r9K4U8lYPXg4i1bJG9LdCn/l8r2IMJNiRx8Jo2MrIeaa7KCf6eUKyjziJAUy
 iM4JsruncRAxUF0U9DVKp0vwdwlty8EHiiMWthQVW85QP9/AtlvCe5n+SKgQlbwCLGHm
 Ge5UPlXyvV9K6vIDCsPXRZZD//DzigbXygtmg/o2F7gKNkCvty/aInxu3r046SANPoG+
 Jj4Cy7BEB9XK+j5E+1jd8vFEEwHc9T27+lNyhOUGkGigbrnQxM3bZiNgbmNnzAiemW4z
 JC1nePJWOxnXi/AOZHXdZRY0cJs7BcZZzP/d/rDzhP+9HFqkAcfqR0E3g3Bo1kPxinGI
 kvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NQ/BbjaNmbkm5KQOy7Vv4O17R/NYOg7qZF+hAsl6NgU=;
 b=EEzbYXvWn2mpcPl6l5z39TjiXQv+kPfRJ+aOLiWRTyvDBygr8OKW5MaDgry9F4ujjD
 cOBwUnsXMJGaYqrdHKnWYQaXAk+bbVcAXctWUSBTT36zgO4HiA8VW14m0kQbUVKjeevj
 3u83BtxWaOOmEcrkfSoHY+9BW+bPNal+31RxrlbLq3tWMCnOo+XFW24Dy1zW637TblJg
 snRhGYibwlucull8Y6d7nicSltT0VvZUvFDGZWxRfIDMu1qRD4eM1iGZwq2FRyguxOdy
 GAid5MYd3K/H6eOsNoIeONCO7yBVegxqfrHa7zGgsYpMaoIXTQR4HfsSqboZKQUMypKH
 mA4g==
X-Gm-Message-State: AOAM533LPy01p2tqibWjDe/mllC6Zkl0LQ2Y6VfuUFk5gBjPNODmDRNt
 D7uQpydQTM6bEWaBB8jlde2O3w9qn7C1fA==
X-Google-Smtp-Source: ABdhPJwx3BgYdlywnyjqWo0ZkR2Ounnd6fxtCLVwk8+Po16TZ3taU3TarQuhJEW97IazglhYl87rGQ==
X-Received: by 2002:ac8:7a90:: with SMTP id x16mr1084555qtr.233.1592427878391; 
 Wed, 17 Jun 2020 14:04:38 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:37 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 57/73] unicore32: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:15 -0400
Message-Id: <20200617210231.4393-58-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, peter.puhov@linaro.org, cota@braap.org,
 alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/unicore32/cpu.c     | 2 +-
 target/unicore32/softmmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index b27fb9689f..06bf4b4b63 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -27,7 +27,7 @@ static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool uc32_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request &
+    return cpu_interrupt_request(cs) &
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_EXITTB);
 }
 
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index cbdaa500b7..9660bd2a27 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -117,7 +117,7 @@ void uc32_cpu_do_interrupt(CPUState *cs)
     /* The PC already points to the proper instruction.  */
     env->regs[30] = env->regs[31];
     env->regs[31] = addr;
-    cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+    cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
 }
 
 static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
-- 
2.17.1


