Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3581EC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E3620672
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpTNYJl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E3620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Db-0003aQ-8Z
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02An-0006qi-2e
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Ak-0006Pm-U3
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id y3so14671710wrl.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YtPMokqpNUHAcEyVMeHPzcW1sXNfgMsM9HjJyWOt79M=;
 b=gpTNYJl/2hPGKLyupstu5Kgrdv2hu4wqDtsm95xx6JS+Iv589tEl3XU1oQmzAxzpIW
 k1X2D9mnD7aF6q7a9uDpsrdOWnS0berCjacwIbAfP1SfuYMU+Qn1YUOQqriAmr4Lx3X0
 +24qOfR4lzfogEkzOkYbcl5NqXpLFSedAibIomOQA8TAupF21hc7jTWvYmldhRqCpXiP
 XcQBbuOQ+8yE91+l3OTFEXGVq67tZ2VUD9AifQQjJAn8fXzZRy7JztfYTZjCRPeWbbNH
 u9B7RO1WXPWtq67+HvncnP8ZY9ViDaBdXWTYijyWxate3x37BahmDN51lDwSAIECDCkr
 6T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YtPMokqpNUHAcEyVMeHPzcW1sXNfgMsM9HjJyWOt79M=;
 b=jw0MaivaCKotdWCdHQX5p510Gi+XFN5idvtRbkAUUeUzj7N8GSrO/8WiRhvToxpwmH
 1QloZ854rcvyTgTlGO/wW9Mpytzvp6j5Q/3LnPGG8EcXT1FfKQi8dpDS+b0tpgRqaBhV
 2BQMwqiiKCg7pWW1Z7Sq51Chakwdkou+5sv6yh3nET4bbW1SMsMYTl/UxW91gwI4s6pb
 5/VlO7jaOpISN1rzbCZ1mgKeiszq7fwYeyWgaHmNaYN4oIG58htsXRink08Ay+/N6+gl
 702TsdSCv+TVSlWhIuPoeBEP4DhI4aRHeGpHKAVgzSY9EG+DoAgjHNluukgv+njAnD40
 dcdQ==
X-Gm-Message-State: AOAM532AM7kXXa39Dj93dsYDNDeqQNnQ3WmVbda4X/LwCGyPKgaXdUXU
 C8PA+6Ojmnwmo1tAmUDN3eT8FA==
X-Google-Smtp-Source: ABdhPJzPre27vfJSokQPpkErOLLcSFad6ACUn3viWQVaCCAUq/1+CJCojG9YGKNjaZdE5nV2Tncc3A==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr20218228wrn.225.1595852641204; 
 Mon, 27 Jul 2020 05:24:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j8sm12779117wrd.85.2020.07.27.05.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:23:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8F2781FF8C;
 Mon, 27 Jul 2020 13:23:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/16] semihosting: defer connect_chardevs a little more to use
 serialx
Date: Mon, 27 Jul 2020 13:23:43 +0100
Message-Id: <20200727122357.31263-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

With that we can just use -semihosting-config chardev=serial0.

[AJB: tweak commit message]

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
Message-Id: <20200724064509.331-3-alex.bennee@linaro.org>

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 660537a7098..4eb9d1f7fd5 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4127,8 +4127,6 @@ void qemu_init(int argc, char **argv, char **envp)
 
     qemu_opts_foreach(qemu_find_opts("chardev"),
                       chardev_init_func, NULL, &error_fatal);
-    /* now chardevs have been created we may have semihosting to connect */
-    qemu_semihosting_connect_chardevs();
 
 #ifdef CONFIG_VIRTFS
     qemu_opts_foreach(qemu_find_opts("fsdev"),
@@ -4279,6 +4277,9 @@ void qemu_init(int argc, char **argv, char **envp)
     if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
         exit(1);
 
+    /* now chardevs have been created we may have semihosting to connect */
+    qemu_semihosting_connect_chardevs();
+
     /* If no default VGA is requested, the default is "none".  */
     if (default_vga) {
         vga_model = get_default_vga_model(machine_class);
-- 
2.20.1


