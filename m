Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6312FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341822068F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnGkTs62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341822068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdPb-000591-F2
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEl-0002aS-T5
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEd-0005sZ-O4
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so23946823wrc.7
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CRf3v0aaaaR+c9GY3Mn+3wHhPs/9iLnwOOfyb/6spX0=;
 b=MnGkTs62GIjDUDCSW2mDMS1rzy4p/9jBi89tjeATcisAQ1ujXbRPaXrPocKYRXHTVY
 Lw5kl5QjotHF7SY4l4GhNcJNCYahPie+16tGklWcVZZp+qIXM0YQHpjhWOg2uKXtJYMe
 Glq3GBO/1g4JRCFxrucaLYqn5/rzbGvfssFwvBrHyeGPdCTyHbLlXD5bXCFSi0wwBIbF
 MhDojqT8BdQdS9nC6huEZox42yrGyzDOVe+TgiFkFcICMMP+ThzhapXtC3BSCZ1Ry+d3
 ZgljM+3LVEWHKBptLTbX9sx+7Zvbjns5Khgo+gslN54VFWJ+Uw7qhfMm41w9sztRfMgB
 HuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CRf3v0aaaaR+c9GY3Mn+3wHhPs/9iLnwOOfyb/6spX0=;
 b=H91Gi3qiSk4grg3etdK6K2l7gDyf5rHAwY/Q+vaFywJO8BjDcvsQTXpWlB+vYkCQPS
 zueD278sJJ1FE6P360STcZdrlZOUIU33UBQcFaaCwdvlLs72+NcauUbIIEoS0Kj+uRPG
 /gCT8FAVY64ihdATlPUCcWX5BL1N7O+vgIL9RgJTdDSaSf4wGW1yxrfRmeqANDKOLBMx
 O4jEvrxmIJKX7NeqTzT8Ac0U61MntxGthncs5DvXlu3iHHYl8Ks1nc/UwB1Rt8YQnX1o
 hVyPATdKGtu8HZBCP8skF4QqrmkUTmwEQvi4nEX9ZkkEI+5Pa73hmOvbTaHs5eDf9Dbg
 /6BA==
X-Gm-Message-State: AOAM531gs4jgBLcYigLKoRl8/jTB5GaVBZnhBeRd/JvqCamoXsEm6M1r
 7pTk/KazMAQK4mvlSQbIATYFiw==
X-Google-Smtp-Source: ABdhPJxBt3KFGN2tOV18EukzPGM9QJhlDQwC7//Rdgrd3PG7+gzcO9MZiPTc1Vv7EJf6q7CLrx+gIQ==
X-Received: by 2002:adf:f842:: with SMTP id d2mr29114629wrq.55.1593611829478; 
 Wed, 01 Jul 2020 06:57:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f12sm7656081wrj.48.2020.07.01.06.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:57:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 88B051FFB1;
 Wed,  1 Jul 2020 14:56:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 26/40] tests/acceptance: skip s390x_ccw_vrtio_tcg on GitLab
Date: Wed,  1 Jul 2020 14:56:38 +0100
Message-Id: <20200701135652.1366-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
 f4bug@amsat.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the test takes more the 900 seconds on GitLab and then times
out. Running on Travis seems to be OK.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/boot_linux.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index 3aa57e88b0b..0055dc7cee7 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -20,6 +20,7 @@ from avocado.utils import network
 from avocado.utils import vmimage
 from avocado.utils import datadrainer
 from avocado.utils.path import find_command
+from avocado import skipIf
 
 ACCEL_NOT_AVAILABLE_FMT = "%s accelerator does not seem to be available"
 KVM_NOT_AVAILABLE = ACCEL_NOT_AVAILABLE_FMT % "KVM"
@@ -220,6 +221,7 @@ class BootLinuxS390X(BootLinux):
 
     chksum = '4caaab5a434fd4d1079149a072fdc7891e354f834d355069ca982fdcaf5a122d'
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_s390_ccw_virtio_tcg(self):
         """
         :avocado: tags=machine:s390-ccw-virtio
-- 
2.20.1


