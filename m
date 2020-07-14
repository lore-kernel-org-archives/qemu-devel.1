Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A7B224F9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s15XrGau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A7B224F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLT7-0005x4-KG
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRw-00046H-AE; Tue, 14 Jul 2020 09:58:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRu-0003Qz-Md; Tue, 14 Jul 2020 09:58:23 -0400
Received: by mail-wr1-x42b.google.com with SMTP id z2so21787801wrp.2;
 Tue, 14 Jul 2020 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zbGjOBBNZ64R8mcYS6G/b7wiXRpDe2wnK8/pnLl1Lj4=;
 b=s15XrGau8cQoLhTWt3iHLyMzKaxZrTSFy+tB0FqvXRFzVL1eGo3lZEcCO+T19EbROt
 Ak/bUApNPoKLUV2x80+BZWnFXlXOqqnrdS9JQmP07ivzFihbh88OjZOKH5CDeetsJrGs
 QpC9Pvs0knP/iv+jhfrJLqMcoMaIRPR9+E1+S4DcD6XFM6xCkr1wHFGMtZwWnQxHcrQh
 Dlf5QY0juBkCfoJOpnsbv7NBZBD0oGo7iW9tPbW2djGzEiPxAI/zu0LdV1Pl+iO+irIk
 tSNkGP0DNZpSDZVj3EFgnwtA1d4Y7Xb+s+pE91bfUmRx6KHQZyiaYfb3U1AGM6dil/D2
 dsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zbGjOBBNZ64R8mcYS6G/b7wiXRpDe2wnK8/pnLl1Lj4=;
 b=SVikdSRUR9IzpG1oEdtEQj3zlJ7+VMUYIPc4cj0RSl2WtbrEt96HJbU1M5VDbh7L6F
 /W0MWw6QnfFBdGOOWEXVBod/jPyIvg9dlNNtrrNd5kCWCbfdL2puULdnFuJ9nCdilqjX
 rKuQ6HvfXkzbzOJDQ2a2AzEfAeDY2MJInVHBBZSWBLn3XheWSH6s4vhd4j+9hmLP+DIf
 SLOMQPWqKBikiArb9zw1E89amljFk7yv05ZTJOOvCHwsPrPYIjqnsmoQ/ZxkPOSuJ1U/
 yrwvl5SvXS7bhPpOUGxkhedWgDwRZGSE39Pyfnzlu6JbFjWkvmXlpLkjUPA390LFT5zX
 +UtA==
X-Gm-Message-State: AOAM531eVA1RwLvZsvj9jDk6vKjZfK8ZUv4b3Qi58Vbm8W7ncgYj/h/G
 abGb85jaBaIJPt7PKRvyfIh+f48L9S8=
X-Google-Smtp-Source: ABdhPJwaRvv35z3tE6iygWQhuq5DDdwlyfUZAr97uCGq0D+MLv9VfWiOnrwJkHbVTM4gPEe/OY+tEw==
X-Received: by 2002:a05:6000:ca:: with SMTP id
 q10mr5772834wrx.135.1594735100777; 
 Tue, 14 Jul 2020 06:58:20 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm29145343wrn.76.2020.07.14.06.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:58:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] tests/acceptance/boot_linux: Tag tests using a SD card
 with 'device:sd'
Date: Tue, 14 Jul 2020 15:58:08 +0200
Message-Id: <20200714135814.19910-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714135814.19910-1-f4bug@amsat.org>
References: <20200714135814.19910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Prasad J Pandit <ppandit@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Alistair Francis <alistair.francis@wdc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avocado tags are handy to automatically select tests matching
the tags. Since these tests use a SD card, tag them.

We can run all the tests using a SD card at once with:

  $ avocado --show=app run -t u-boot tests/acceptance/
  $ AVOCADO_ALLOW_LARGE_STORAGE=ok \
    avocado --show=app \
      run -t device:sd tests/acceptance/
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_sd
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9
   (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_sd: PASS (19.56 s)
   (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic: PASS (49.97 s)
   (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9: PASS (20.06 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 90.02 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200713183209.26308-4-f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 3d02519660..b7e8858c2d 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -620,6 +620,7 @@ def test_arm_orangepi_sd(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
                    'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
@@ -669,6 +670,7 @@ def test_arm_orangepi_bionic(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
         """
 
         # This test download a 196MB compressed image and expand it to 932MB...
@@ -710,6 +712,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
         """
         # This test download a 304MB compressed image and expand it to 1.3GB...
         deb_url = ('http://snapshot.debian.org/archive/debian/'
-- 
2.21.3


