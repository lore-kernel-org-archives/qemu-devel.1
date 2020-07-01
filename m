Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4256C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B240E20702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6SmoSSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B240E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdRx-00019z-U1
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKx-00052k-Hc
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:43 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKv-0006qY-NR
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id k6so24004882wrn.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WZkO+vj6G284wXUPR2Uuf7/6SV8a7gabQd5K0j8iabU=;
 b=f6SmoSSP/+Plb8g+qJIpf64xBm0FZd6601GR8Lo9mxD+8bM0k0MoP6f0jAovJOvlVQ
 ek6oqvmA9iLqJkLQkHJHe9ec6LQGC0rxEWG5IneDkMTCjPjqcbEjdT1u42DXe3V6c8iS
 F9DS4UnlDZLaL/HTedFiOUVvaZin48B4xuoFf0mZmqsqgEVH7Q2mEBsls1KqlGOD/dQC
 +5+3sQHj+9vxyayGEJMTIZhQVYdRd2bQycldZqqK+MOB+HP1AKcBKIQkYTPZkaNF2VPu
 Th4N0s+U8cCUxAqW7kpUuxGZBHtzQJFU21b+pAa20wjY2/aKnM0vhBCHwhsUx558X3AO
 Mcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WZkO+vj6G284wXUPR2Uuf7/6SV8a7gabQd5K0j8iabU=;
 b=iJbf0navUfixputkkME4D+h7guGvDga9jQNJxcKrPr8HXhDZfVVF1bhOPWnRNpNxhc
 eGF8kjwMr3YjrmCJ0D5uA71HVe3feRpJEUjWO/176Rv5TKdxSCPfrAGoOfIqeQ0PcAXO
 FXI5mn1sHgR6dMNUdKKXELOLNSu92gaU6xjs+jR0VkVELGpjQbl4hlSLuw8lsMK7fLtN
 BP9ty/QEgiNCaEuX2/f3xz8+iIUiu6TgS9g6Zzd15FXFyxPgNzzuarWWDwUNhkrBcRi8
 qLqooy5Em+Hrs6AJzwd1LZqj6jz+CfB+6U2DdDXV3vZ+eJkY6aIBBLZswnToAPM8fLcH
 5bCg==
X-Gm-Message-State: AOAM533MirQveqmg8LjwkKZhrQ2cxBj11zibcUElFvHmkXUZq3g0+e5L
 AWOcLrXCmMYK4QQufd4eaJAywA==
X-Google-Smtp-Source: ABdhPJzk8xYLq2c1Yg2m7ygfxcJ7bMtzsmtA86xRgargc9yOtoPle0sMI39otzBP6SPx8cAfl9QvaQ==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr27846749wrq.189.1593612220396; 
 Wed, 01 Jul 2020 07:03:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l8sm7567341wrq.15.2020.07.01.07.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D00E31FFB5;
 Wed,  1 Jul 2020 14:56:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 29/40] tests/acceptance: skip LinuxInitrd 2gib with v4.16
 on GitLab
Date: Wed,  1 Jul 2020 14:56:41 +0100
Message-Id: <20200701135652.1366-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fails on GitLab but not when run locally on the same container
image. It's very confusing.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/linux_initrd.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
index a3e54d3fc91..a249e2f14a2 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -8,10 +8,12 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import os
 import logging
 import tempfile
 
 from avocado_qemu import Test
+from avocado import skipIf
 
 
 class LinuxInitrd(Test):
@@ -51,6 +53,7 @@ class LinuxInitrd(Test):
                 max_size + 1)
             self.assertRegex(self.vm.get_log(), expected_msg)
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_with_2gib_file_should_work_with_linux_v4_16(self):
         """
         QEMU has supported up to 4 GiB initrd for recent kernel
-- 
2.20.1


