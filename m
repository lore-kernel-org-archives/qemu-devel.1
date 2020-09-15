Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3940C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67850208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBFG5zie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67850208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF4X-0003yG-HT
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIF2T-0001Zt-J7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:46:46 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIF2Q-0007Ff-5d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:46:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id 67so2337500pgd.12
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zb/g+Fvikq2LApYjpqfoFSuv71lvaud3AwPVH756moE=;
 b=kBFG5ziek6umJHHOGvYzci5tJyE9CPxBb6vyI3flzI+ZOz6WbjSG/Wt04UvpyBvaAR
 fheuhKJCdS3ddA3Iqi7AEyg3ahujPUjSSdolxW5sFeWOjUjDcJPKhAXll19vd8xMs3l+
 nu/cc4lk1gw9w4LyG9uZh4m2Em9aATGCK5N0ne8ICYdYTgy0T5tVXMMJvziUAt8Sz2aU
 5JCm+QrJ6esuUsXdvIkQ2ke5PnbWLTDJljWGmjevW+xzYLcYE1v6OdgjUPL1so8NCca5
 dAvDWrIPKB9NyNreuRIJ9rEdXfFpX9B5O+eoVWRhM4ifRSMi6RTJFQHMqbRKRtBQXZ/F
 3ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zb/g+Fvikq2LApYjpqfoFSuv71lvaud3AwPVH756moE=;
 b=Xep6c+rhBlH2sU/1jjL9HP/2zd1XJXHvBuFJe1R+YbFvpldK5urxp/DavwfoTcbYpA
 gLf/ZKMW1PcDZ/lG11N2bVeMB92FxHMGjFOd8/t2orqDw8wrgX7ZiyPVs5OsvokMvJn3
 vGnYcBcDosWi1sy9YK4WUM8fLeXe4HRcAr7RQvaDqSzwKhd3B3CPVzRMndIoN7DzGMFG
 fiELTgFa1o1ebcdErd2akN8Uf7PmhJlkvoWrSI0XX+cREAjHEuyFVRkoqQOuO8scMruB
 LAWnUL86omvF5nCnlniO/ITAYe0rUJIF9gigvd3jWhNlt/9LEQJFssOMRBFJWlKC96Hc
 ByTg==
X-Gm-Message-State: AOAM532MGpDCMA/0nHa1RwqZr2ie/37waUA7PJDMNUdr9srDw4uQpEjG
 SmZg2lWXRcv2B9NjWJ/VaZCiMClWh8IFTA==
X-Google-Smtp-Source: ABdhPJw3BWkw4aLiFSYzXDuopVcGZbso73fpig8yQTG4xurwAInnErlR3N8xpKuQ0CpSrXRjVjgRNg==
X-Received: by 2002:a63:1016:: with SMTP id f22mr15540135pgl.226.1600192000425; 
 Tue, 15 Sep 2020 10:46:40 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cf7sm147896pjb.52.2020.09.15.10.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:46:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] target/ppc: Set instance_align on PowerPCCPU TypeInfo
Date: Tue, 15 Sep 2020 10:46:33 -0700
Message-Id: <20200915174635.2333553-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200915174635.2333553-1-richard.henderson@linaro.org>
References: <20200915174635.2333553-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix alignment of CPUPPCState.vsr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
---
 target/ppc/translate_init.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
index 230a062d29..accb4f2fae 100644
--- a/target/ppc/translate_init.c.inc
+++ b/target/ppc/translate_init.c.inc
@@ -10960,6 +10960,7 @@ static const TypeInfo ppc_cpu_type_info = {
     .name = TYPE_POWERPC_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(PowerPCCPU),
+    .instance_align = __alignof__(PowerPCCPU),
     .instance_init = ppc_cpu_instance_init,
     .instance_finalize = ppc_cpu_instance_finalize,
     .abstract = true,
-- 
2.25.1


