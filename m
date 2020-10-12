Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66581C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110D420575
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPyAQW57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110D420575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzyE-0008EO-2L
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqC-0006f8-AL
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqA-0007Gj-8s
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so19704866wrq.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6I9SMKjr6PmWwGXVMVs+FgMWnXt/xrUHEYtD8jIqzQE=;
 b=tPyAQW57KsDRbOr93Mg6m8QsfI33jkUUv749yVbo4mOsNQZk2Qznr1ltL3peF3Ntl5
 Xhmr/+0qAovF/bCSxj8O3xW4+93hCaIr9EMucxd5Qm5zyqsTPXO0tyq19cR/nZE4d88/
 YL7yxQbg2lh3GDU6RTzu4dTQGgX7Y3kYYi878YTrO0DzRDcUjm6VAsdkyth1nX7hgqzp
 hWooGB4VPq3Mi7/+P4ljKrFxWL4PiNDk2ls11WBXd9s7C69b2XaHnAiAApUXV3kpj4DK
 CYnqfqCwgfrQ50USmaIYB+mAOEf1KpV2xMtHznTlwJ8u7eXGfsEJVUfFAi8x9PyCQo2m
 000A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6I9SMKjr6PmWwGXVMVs+FgMWnXt/xrUHEYtD8jIqzQE=;
 b=TYpsi2K/9uLN8Rg5RQIDbsc2G60k1MuYWmNNs82h9SGAvbdnUTJe7ZehM+kAKUvAMv
 JhjRVDVJVK+lsuLOL2O0PSOjT/FcX0iTzShZveBvPIqdBqSc5XbZMFMcy8bxgriHEl3E
 0cuXW2rZWab3aU0aP9n4RLHvnfhL2F9yRuY32vUVD2WiHJIlSH69ZHTRhGWtpEZ2fhe3
 cAqcNwq5KyZs/JCJ04q1Wlvw5JUH2xDcYqryBJ6qlGrNzVH0YOBYEnf5QTx6KrzV2rWA
 cibh5kfuFFTy/0OLKIDUJrHUj567zN+Ol0lLPyFmcAL8SkU2dktFopm3zZuJpZYEhzSf
 R/aA==
X-Gm-Message-State: AOAM5329Kn9NoZbmoLoBVb4Cn6gPzfw+/b3yZU+9n0Fv/5Xky73JkG1V
 duug/Mi3ucEBvIJbxwrUs14zrA==
X-Google-Smtp-Source: ABdhPJyEuLaQAnvdMH232RUPJGtHHUkRxkgX+mzDC0IqM8610mOM4pBgZEBeAoFXfWZZDzhmrwN5jA==
X-Received: by 2002:adf:f043:: with SMTP id t3mr18402943wro.234.1602516860825; 
 Mon, 12 Oct 2020 08:34:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1] docs/system/arm/virt: Document mte machine option
Date: Mon, 12 Oct 2020 16:33:32 +0100
Message-Id: <20201012153408.9747-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 6a0b7505f1fd6769c which added documentation of the virt board
crossed in the post with commit 6f4e1405b91da0d0 which added a new
'mte' machine option. Update the docs to include the new option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 6621ab7205d..32dc5eb22ee 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -79,6 +79,10 @@ virtualization
   Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
   Arm Virtualization Extensions. The default is ``off``.
 
+mte
+  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
+  Arm Memory Tagging Extensions. The default is ``off``.
+
 highmem
   Set ``on``/``off`` to enable/disable placing devices and RAM in physical
   address space above 32 bits. The default is ``on`` for machine types
-- 
2.20.1


