Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B076C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99DD206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMu5vpeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99DD206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwlj-000657-0R
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLe-0004Vz-2h; Thu, 03 Sep 2020 17:00:46 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:41601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLc-0007kY-39; Thu, 03 Sep 2020 17:00:45 -0400
Received: by mail-oi1-x22e.google.com with SMTP id x69so1542249oia.8;
 Thu, 03 Sep 2020 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YlRR9CLu8pLCxrGm4VFmO7pbcuXORptj+5WioQ7RYAg=;
 b=lMu5vpeOPhsnDJFIOWNy5i66L9lUm78uyEphlubxdhVerVljO+MyKdeqfLbKI+68Q8
 5UUiNjGcYgCDaKpVCLo2DcgErFwFyXrClqZz42O1mfmgbsmbfe2P46xn5XFZAVuQdB/Z
 +t2YcLuFfrdA1UH86TsLhCoflAkADZum7mUCvgF/Va6gNMU6nm3xilUpEs2Q9+TQ/y9T
 qPLHGg9mXWUJEBND4wbAa/+Cr0+LnoTlOgVVIyK4BMNFcgbhxXleRjmNdEg84qPJFaBj
 GF6aeAEIBlB3z3RgTzn+nqOhHruDwl2rKHwtP2q8nlh8tHHl++hPxFQFcL2xyULhSIzZ
 40dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YlRR9CLu8pLCxrGm4VFmO7pbcuXORptj+5WioQ7RYAg=;
 b=rg9D2WyMmFrHRzzXecc1vk6vqtoK4XhjDCXLSohwAe3P1Nt7Rng3FudGeh9A6Ny/8+
 1C4s2SBG7J/DJ+Ri9de5nnlRlFpDatwVmKGFWl4mupfUSTGmH83lGpdpRacqj460fyTk
 neH3UQhVLwze3J93GkGRQievd0ynM1qs6NF/EkoMKH+5FWAteJzl07NQJzGHaNYCJTgA
 Cr5Qixi3r3bMAk1qhFsneELYWoD/9H0/RYFkPIVAq0zgL0ZOYf30prsMKmXk36HhL3dG
 fRAX2YV6VVDOBvAwrjFO0VDdjfGQxbmveqV+e2YEic7yVCLYMDC+svM+oAcvoPzbYs3b
 Q06Q==
X-Gm-Message-State: AOAM533PXYz4bmVluuBbuGZJlrbiTFW0nNBCfQyVf1dz2iUmEUtUVJoi
 6yk0fkzCdgMMoZNYaZi6M2h0BpIDQIQ=
X-Google-Smtp-Source: ABdhPJxPJYagNytP/LA0l4fON6ARdmNJNQPAiYzdc10gqSKN4LkJKr49j0JjAqnfpc/W7Fsv9vcMCw==
X-Received: by 2002:aca:f109:: with SMTP id p9mr3162838oih.84.1599166842222;
 Thu, 03 Sep 2020 14:00:42 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id e9sm814722oog.10.2020.09.03.14.00.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:41 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/77] tests/acceptance/boot_linux: Tag tests using a SD card
 with 'device:sd'
Date: Thu,  3 Sep 2020 15:59:04 -0500
Message-Id: <20200903205935.27832-47-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
(cherry picked from commit b7dcbf1395da960ec3c313300dc0030674de8cd1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/acceptance/boot_linux_console.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index f825cd9ef5..d864d22ca8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -583,6 +583,7 @@ class BootLinuxConsole(Test):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
                    'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
@@ -632,6 +633,7 @@ class BootLinuxConsole(Test):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
         """
 
         # This test download a 196MB compressed image and expand it to 932MB...
@@ -673,6 +675,7 @@ class BootLinuxConsole(Test):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
+        :avocado: tags=device:sd
         """
         # This test download a 304MB compressed image and expand it to 1.3GB...
         deb_url = ('http://snapshot.debian.org/archive/debian/'
-- 
2.17.1


