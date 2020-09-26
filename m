Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D21C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6B12076D
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szTDjndd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6B12076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMAuX-0007g2-Nz
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 10:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMAoX-0000QP-Cp
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:04:37 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMAoV-0005Lt-BZ
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:04:37 -0400
Received: by mail-pl1-x641.google.com with SMTP id j7so870391plk.11
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g28WcNhsCD1pOggCNiGSa3fCFHjJ9SBe6D8ikmZXRPs=;
 b=szTDjnddLVwfHUrFtJYMa+J4P48eTcgLe25aJIO49Zt1YtTy4WOEIBrdX3UfWe954G
 vp1TwkDYuZvwzmFZcMSAEuUT8yH9tXYWUd7tAYgw4jqzvZVarQwwBXjC0Xzt/v+vsAaj
 nMuU6HDv1NgocG7YzUTz4Iy+fsBNy6I98/PPy7UCLx4uByEeH6ErUn5fRbVGNhjWJGIy
 IFSEjdBUFjPUrA9zgODCOTVbvSN6dAghWon+EpVjtHmFdef07uwruSk3cnPezlss3+VV
 0YsZ2X1m+rGXb50FQa+1Zm9mEeyP9p3rhBRbVQTocl0mcmplOUBpmr9D7BJiasMJ8+nm
 dStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g28WcNhsCD1pOggCNiGSa3fCFHjJ9SBe6D8ikmZXRPs=;
 b=FrBtzOMshCnJjReV59bGMiOlOSODYDjeYckzz379UdpXtlfTq8upCB/jNHUorG3n6E
 og+7Y9JrRiQPq5OGHTzh+HRVMAkEz/GperIutX3RTnHbCbz39lelCJp2+C+bIvzzfvFw
 WZHCI3IQXMTjS4/3r6RSC0q1bNNfYqyqO+GG38YelpgcJTmb3wuvWA9lAh2Hby28V7I4
 fCwL8S9LfVXyhJQ06IEG7hHLFrcgH6NJPQVeXAc4boAZzyECmQ5RdVxRaV9XDxNPA1AS
 baFTqBdkNqWNstMcslrdIdTI+WQWBFPK8rR/Ks1wHa1HYwQEIuGkaWXjpw3B5DaF2T0z
 7z2A==
X-Gm-Message-State: AOAM5335ZEsw1RqoOQ+oxeCSrH1ebYVfNntQ03lac+1jZ8AzdKhps9/0
 Niwugftv9JU2mISgUzUHTB3RCai2Cd/wqkqU
X-Google-Smtp-Source: ABdhPJwvcoHnhfM2EhATiYOE8c8HJx5xZiYZIACDdLuP93j1j2koJC/dVVugSKifwVL/klruRRBxnA==
X-Received: by 2002:a17:90b:350b:: with SMTP id
 ls11mr2141667pjb.201.1601129073517; 
 Sat, 26 Sep 2020 07:04:33 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k3sm6091109pfp.41.2020.09.26.07.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 07:04:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] plugins: Fixes a issue when dlsym failed,
 the handle not closed.
Date: Sat, 26 Sep 2020 22:04:12 +0800
Message-Id: <20200926140415.1286-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200926140415.1286-1-luoyonggang@gmail.com>
References: <20200926140415.1286-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x641.google.com
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

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 plugins/loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/loader.c b/plugins/loader.c
index 685d334e1a..8ac5dbc20f 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -235,6 +235,7 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
     return rc;
 
  err_symbol:
+    g_module_close(ctx->handle);
  err_dlopen:
     qemu_vfree(ctx);
     return 1;
-- 
2.28.0.windows.1


