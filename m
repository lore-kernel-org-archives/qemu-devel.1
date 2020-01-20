Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D8EC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D17C206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n77fPCT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D17C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgwW-0001Uh-3F
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq7-0000yC-3a
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq5-0007a2-QX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:14 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq5-0007Zl-Kc; Mon, 20 Jan 2020 18:52:13 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so1277424wro.9;
 Mon, 20 Jan 2020 15:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5pr6W5RFhMmV9VGbpJaWwEgOlR2uCM7o5V9+FQdTDQg=;
 b=n77fPCT76au2bt4wgItA9oPwh8goAaRwjz/XWNjzSHPgFgiqeCUbZs/Gwk75ICiiWU
 CkB1YJc3piup8Lo5nMa4JSqP4drqOhyH4aVmpncPwOdZhyBko2myFSYQSzAfomWbNr0M
 GY9zwk1oww8+1qQxsZD3kr8rkDIKKlun3D4rwT5TAvTxQFHiJO73+KvSeYbakPdRetuC
 BViRVTA3I6Dj3A/3M/UAKFKJ6GnuryuFmmX0vC+E5C1nWNf6skl7S8ieTYwy/IUHFsig
 LiwVQBuZdFDzQy11W3OsZfmKpV5wlVGTDYI5Aq3J2oeOsC+ZOeOS8LdaLng20u29rJFw
 wiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5pr6W5RFhMmV9VGbpJaWwEgOlR2uCM7o5V9+FQdTDQg=;
 b=tFkiadY+oTUDRmGxJ8lqdkIOz7gSUY5HvEAJXV+MyxUUcxZaH6kyqwJf/ZVpAE1Ifu
 +BhR2JBla7ZaVXmixu1sSkHYpoZhwc7ef5ELwwp/AiX9mYLlvbLBPJH3zpq6KkRUnwsa
 R5LSnoCAKcSYtlrAAZWwCbtP/FvfJw/t6kPIbu/p0iSPFBqLoxBNjTWvTe9O547OCZYv
 /9bjci90kiUo8tGwzlz9MKtfSxkOol2ApIEzEeKglasbuKJ6OClBiBmQ+I737HoWBvi/
 jpzAL54+d4eukSNNpaTMaUAFI18/7sEHq/OsVT8S1dwVNXnrJy3/6q+qvALssYzHrSna
 aV6Q==
X-Gm-Message-State: APjAAAXU2/CrU9r4W3SQWO01OaJAqWuEQbUTyRzL3GOwcZjwmDMDl1nU
 qVwWWjFtKbMRsSeb2mlDzwpQr1cY
X-Google-Smtp-Source: APXvYqzRCs2EPTAbghMVhHr+LbAI2QMePPm+oDeRbPaYPGkBzeEuaEa1KgBWPMmLy6tTnoDCRasX3A==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr1848778wrs.237.1579564332549; 
 Mon, 20 Jan 2020 15:52:12 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm48655269wrx.71.2020.01.20.15.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 15:52:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/7] tests/boot_linux_console: Tag Emcraft Smartfusion2 as
 running 'u-boot'
Date: Tue, 21 Jan 2020 00:51:59 +0100
Message-Id: <20200120235159.18510-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120235159.18510-1-f4bug@amsat.org>
References: <20200120235159.18510-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avocado tags are handy to automatically select tests matching
the tags. Since this test also runs U-Boot, tag it.

We can run all the tests using U-Boot as once with:

  $ avocado --show=app run -t u-boot tests/acceptance/
  JOB LOG    : avocado/job-results/job-2020-01-21T00.16-ee9344e/job.log
   (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_emcraft_sf2: PASS (16.59 s)
   (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2_uboot: PASS (0.47 s)
   (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_raspi3_uboot: PASS (2.43 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 19.78 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 22b360118d..4a4cf9d0ea 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -305,6 +305,7 @@ class BootLinuxConsole(Test):
         :avocado: tags=arch:arm
         :avocado: tags=machine:emcraft-sf2
         :avocado: tags=endian:little
+        :avocado: tags=u-boot
         """
         uboot_url = ('https://raw.githubusercontent.com/'
                      'Subbaraya-Sundeep/qemu-test-binaries/'
-- 
2.21.1


