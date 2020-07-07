Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F86C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E763A2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAMXv7or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E763A2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshwR-0006ts-5c
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoX-00077m-E9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoT-0004vV-GA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id o11so44021125wrv.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fA+g3LrdgrFUSUvqRSEWu0BkgruGndhEDIAbeRZnv3g=;
 b=yAMXv7orRZmRvCHJtjRNT9bVYsLmUCu9NfC+utNdbJxOTsryrfGKznJ+LrenMzk3IZ
 +RW1ZOglfVhTmA9T1rYkmZNI9pKDUj43jJrfu0Ad7uYI8BN35ziaza2D5Z9sSkAJZk5q
 GduDzZ1mBmfJqsDYDEHI4Wx0AHYNKjEwXmwKAy+jdNofaGCR6dGf8B0jWR4wvObw7qA0
 uhJAe5Ew6Ry6/Ji9wSA5A1Am4bxcNoJwo2zCzj0wms7+1oleULKshQrxGcxlcb7A3sXC
 bGiyGW3lYjv13pgZzOfl4aEVJWIkyQXjDTIPBG83NgYE/b289trglZYX97kDlG2fud9O
 qQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fA+g3LrdgrFUSUvqRSEWu0BkgruGndhEDIAbeRZnv3g=;
 b=PJz/20QdHEXBGd+zZo4eZrbxzHuDjhKoaDajUublhb11HFbDtyYxyC7vh2a0B5VEnt
 cZTDzJP17kKrSW4la0PyGPfrDF7VOdgER9pbxvjcdayE1Rlz+RCZz5lqu5a3rk75bxoH
 3Don9sXbCxSSJJsW91ofLeaU69we9OpLTGBDX4nO2BhCbm+HAzopxblQt/9xXdAbZSs6
 JVDIn4UoPbKhw+ma4mwGiYSeNNVTojTcEM/ZmEOuWyLZ1w6JJeryAU8TrlEabJ5+vUPx
 LyDKG/L0pdSLOYvBX+vEqoF8nzeKe01aomqDqglCsdLK++LtQP7OaD+EIW4ssGIL58z0
 oxkw==
X-Gm-Message-State: AOAM530o5UWGVkhlmVbvBoKFGz3IftZ5NRvCatfZri8hCdMGn3OuT/Y8
 cdBusRBvZwUqUf9pPO2hYF54uamTnFw=
X-Google-Smtp-Source: ABdhPJxgzLuxgG01ZGSiTDLilQsx+RKWftz7yrBmUzzjGwhHJfeRFcE/WIUA/7vuKyZsDAqkgnbk9w==
X-Received: by 2002:adf:b608:: with SMTP id f8mr56804021wre.363.1594106084003; 
 Tue, 07 Jul 2020 00:14:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d81sm2677820wmc.0.2020.07.07.00.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 276471FFB1;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 26/41] tests/acceptance: skip multicore mips_malta tests on
 GitLab
Date: Tue,  7 Jul 2020 08:08:43 +0100
Message-Id: <20200707070858.6622-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For some reason these tests fail all the time on GitLab. I can
re-create the hang around 3% of the time locally but it doesn't seem
to be MTTCG related. For now skipIf on GITLAB_CI.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200701135652.1366-29-alex.bennee@linaro.org>

diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
index 92b4f28a1123..7c9a4ee4d2d6 100644
--- a/tests/acceptance/machine_mips_malta.py
+++ b/tests/acceptance/machine_mips_malta.py
@@ -15,6 +15,7 @@ from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import archive
+from avocado import skipIf
 
 
 NUMPY_AVAILABLE = True
@@ -99,6 +100,7 @@ class MaltaMachineFramebuffer(Test):
         """
         self.do_test_i6400_framebuffer_logo(1)
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         :avocado: tags=arch:mips64el
@@ -108,6 +110,7 @@ class MaltaMachineFramebuffer(Test):
         """
         self.do_test_i6400_framebuffer_logo(7)
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         """
         :avocado: tags=arch:mips64el
-- 
2.20.1


