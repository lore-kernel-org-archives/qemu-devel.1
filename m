Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB35C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A939320760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMdPaoOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A939320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigoV-0003io-Tq
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighi-0003MV-Fj
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighd-0003QA-9T
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id r9so3357722wmh.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Po3TGUgc62Sm+OROEr5qzIKDQbHx7K4FmJnkx1dhO0=;
 b=TMdPaoOVc06Hcuvb444JBkpYSOXZoYIIgGmcsB6k8J70qDFAdYz4I+YnsfdBeQQcWu
 7kWoGGbjxbeJKuWdHXfYU4h5sMgkCjSePRUDQ8MgSdRbWkeI5nFZQ7yI6degLsH/FTSo
 2qpRYYWS5ifcx9t4R2fUrTvEkepWOO4M4jyS72ie6uN/8i8HtH+wU25XtXHpVn5TGu5p
 dVJjChSxteORd+VkuVaDNIZGSWcvFnoqI3kRW+YWxhApP7vlqbLzxu69EC1ZdB1hEguA
 /bmuJTaZkOh09zXF09vrgov/e53ucycEM4zi8/VfiphMXnvvSpxFP3YL534PV47VZY6Z
 pePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6Po3TGUgc62Sm+OROEr5qzIKDQbHx7K4FmJnkx1dhO0=;
 b=h8Y+crN8qGVFpj9WdQvXbT6l4QJ9EDZRKdL6LOMPsIpiOYtpZ8ebuW2dczidoviCmS
 dHZeOnHKgCeqiokwKqOq2ncT2S9+poo6R32eJNEhnAuCiQVFjs/tokhjw/4waL6yTp9s
 2VGUDFL6hiEhGXIYUWVgtoSVm9qvEqYqLTrifUtRI31uJUvEFccG/7Qkm7E0i6WeW/mf
 r30t77rabUEfI3llMfjAXzkKlLyMZRRkPvpcZvaY7/mW6SLGJjkaMzqBtaVMiVarMuGK
 PChAHXmcYQqKDsURIAiV4IC/nm6FLQ8+JnH2+VXsHB2VXLxIJyHFOQ6vgNnsFKZ9Xb4p
 tuWw==
X-Gm-Message-State: AOAM5302gwdv5lN4/61LdOgPQ/hUU+5th9VKTqsiLxnNJ+LzMLqph6wR
 pYC5atS2zFLh4LjdSB5jNJi9DQ==
X-Google-Smtp-Source: ABdhPJxuSZcpHq/4Qg5JzeeIiuX7XIuehQlX36A0ed2JArfbRVJ2mimu5wCWd7CrAB2ZGrHNgGSuXg==
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr4887468wma.33.1591718533812; 
 Tue, 09 Jun 2020 09:02:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b81sm3699867wmc.5.2020.06.09.09.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:02:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/7] target/arm: Fix missing temp frees in do_vshll_2sh
Date: Tue,  9 Jun 2020 17:02:03 +0100
Message-Id: <20200609160209.29960-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609160209.29960-1-peter.maydell@linaro.org>
References: <20200609160209.29960-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The widenfn() in do_vshll_2sh() does not free the input 32-bit
TCGv, so we need to do this in the calling code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 664d3612607..299a61f067b 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1624,6 +1624,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
     tmp = tcg_temp_new_i64();
 
     widenfn(tmp, rm0);
+    tcg_temp_free_i32(rm0);
     if (a->shift != 0) {
         tcg_gen_shli_i64(tmp, tmp, a->shift);
         tcg_gen_andi_i64(tmp, tmp, ~widen_mask);
@@ -1631,6 +1632,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
     neon_store_reg64(tmp, a->vd);
 
     widenfn(tmp, rm1);
+    tcg_temp_free_i32(rm1);
     if (a->shift != 0) {
         tcg_gen_shli_i64(tmp, tmp, a->shift);
         tcg_gen_andi_i64(tmp, tmp, ~widen_mask);
-- 
2.20.1


