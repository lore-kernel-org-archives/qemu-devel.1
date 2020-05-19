Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54811207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCHP9nq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54811207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2Kz-00043T-Ul
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Gp-00055e-Dz
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:26:59 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:45003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Go-0008Ln-H1
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:26:59 -0400
Received: by mail-qk1-x743.google.com with SMTP id b6so14916190qkh.11
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=i/dsM3iK/nR8OFunPvIO2V69MTo9ZXVtdKt4AQuIUTU=;
 b=rCHP9nq9qiPKdTyMaSvNWcmapHew2o6oK8CVgTXN/8I68qdnsXWUvyAO7EWBgvBFLq
 yuxlenBEccqB36jBmjzGtLsYpGOMsS6VI0+A1LxRVpSEd1XZMGFIIQ9333FzCnEg43wt
 Gwu3PfjzxGiQcvV/JTFAIjxvShPTJMXxTlHHdtCP61iTB44Xa1hJngBIrEqabTSDJbCt
 Mcd+qsYDAGFaZA2H+fHriuHeUm7qH74B3TinVKwPZ17JGzA/TGLBLMvd+0SpECQ03bWs
 jfK00Eeud3hRbuxYnduDXndOL1q7P4zmANjSVhqe/W7J2T+eQFx18VyTktHc6ksiErv1
 PqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=i/dsM3iK/nR8OFunPvIO2V69MTo9ZXVtdKt4AQuIUTU=;
 b=TTwHIoKWFh131e41DXF+AFJF+eeEeR+KyV2TE1fL0Kct6DrX9YqWIME/9wzWZ0M/Y1
 VEcSYW14OJsqzxefqff5IpkDk5O37EZtbbG3oZiZjB75gOhE2gvKXjCcdBT3qRQBrDXU
 k1/NSDCldq2/227NRBanZUamWKkJBn9zKcF7UdkecDmqtIKrR1d3otcgTIPdOudbVIm/
 1mxtiIFtShIKS27jT+Fg4aMRf4aDElFCvl9kVB1apZQ7p9jZoGPb+YsKLU+7egiLNvOY
 4AkSDVRJldguYFbOd5Ztu2FCdUpxHdL4udDKRV18wgyvM2PxwfJJYdinaJgcHHnRPL5V
 zyyA==
X-Gm-Message-State: AOAM533YmTJc6qXcwBRR/IYipF0SHtxhutM/bnA+rYVvMVyi6iZ0FVzz
 MNpKPPXlf/PWmM3IYtbXLxAJfOepescd2A==
X-Google-Smtp-Source: ABdhPJyX24dASWDEIS3VlgeId6WL/E/kMs1mz8L002T8i8CQ0I+T8WWRQAElqWzFcRgXmGwBVNlfmQ==
X-Received: by 2002:a37:4ed1:: with SMTP id c200mr5989430qkb.385.1589894817175; 
 Tue, 19 May 2020 06:26:57 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:dd6a:8c63:cd9d:ad15])
 by smtp.gmail.com with ESMTPSA id d74sm3482136qke.100.2020.05.19.06.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 06:26:55 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/12] tests/vm: Pass --debug through for vm-boot-ssh.
Date: Tue, 19 May 2020 09:22:53 -0400
Message-Id: <20200519132259.405-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519132259.405-1-robert.foley@linaro.org>
References: <20200519132259.405-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This helps debug issues that occur during the boot sequence.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index d9b34eae63..e22c391a2a 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -97,6 +97,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
 		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
+		$(if $(V)$(DEBUG), --debug) \
 		--image "$<" \
 		--interactive \
 		false, \
-- 
2.17.1


