Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECFDC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2402083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUGFmCnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2402083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j334g-00019z-Ts
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331B-00040A-Mk
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331A-0000t4-Pd
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:21 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331A-0000r7-J6
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:20 -0500
Received: by mail-ed1-x543.google.com with SMTP id j17so15463245edp.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bLa+ADTgEFCmHmyq/daR6zg2jND3Ce2pdEx2x+QpKNg=;
 b=uUGFmCnCZyj2TUv2pRlmVFPGmqESQ6+XllK8LqAmVOFFZ2esG+is4tX/Vuq2LHItUG
 Om+HHUJ97Zk8Vven262Qo8qY4pAiT71zzILZLIajIjch4qnpSa65qfcfZ6/NTi7RSoQi
 pLHjttNBBpGAlZ+ipOEIIM6jwgU96yvTA6i7/lL4E/Y9YhdwcOVfrtYxpEH2r8Qw2ZmM
 qI5cAWnHMOTmqWsa1EfAZ6e0S3Hg0G/rzORKZ4MMQR4LDJrQ+KMZYI8pqZWjdxrxcF+b
 xVS7YxXVMxpxPpstgu4ncf7HgsyKSmDpwD37+iDkzVwPq5tfes6ACMSAkY1JIMIxZ0ni
 JKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=bLa+ADTgEFCmHmyq/daR6zg2jND3Ce2pdEx2x+QpKNg=;
 b=bC9KJouqk1gVoyrYC4YQme9jf4He98qRaglP9qZ4CnM8nVP5rpUPn/kh4IHkbhEAe9
 BUwp+DWLRoo2LXZw+xnfaln5yZb9rpHno8tehpsdxPWcuvB6StWF63irmryVdnDuCk9+
 LwLZ5Lru3ga7bardb7OY84q2Ag5G4RHQWt8fjqYgxtvefEVHNHB+Crno+D6y9cr1DGAV
 svzJvWKUBHqbQt59tLotHVl9zh9kkOsEAYhzSfUGWmDWnxuxl/Dyj0n3FU1pDVGxV5qJ
 DuG1eOi09+MtvLNgPfOQuwOzjNKiFLBrd3tU93Rv6asYEgi8D66pYLr1kZWnlOQNmHS5
 LJ2g==
X-Gm-Message-State: APjAAAXCmjpv0nCks8PKVzXmixxzdzDPpyT9EQKJHl95yt1qVpiEhY7F
 m9dPt6Bxw/wCdLXuFtn+y7PCDxkboG8=
X-Google-Smtp-Source: APXvYqzrBR5p67ZUrjVHgBHMfshfUCuPUNlZzOydiYan7W6pwkAP0QarGF+To6RQYuiFDyqIfcAEiw==
X-Received: by 2002:a50:f391:: with SMTP id g17mr8388092edm.52.1581794539227; 
 Sat, 15 Feb 2020 11:22:19 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a24sm657128ejt.40.2020.02.15.11.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:22:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] hw/arm: Add raspi[0123] acceptance tests
Date: Sat, 15 Feb 2020 20:22:08 +0100
Message-Id: <20200215192216.4899-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Add raspi0/raspi1 Linux boot tests
- Add raspi2/raspi3 U-Boot tests
- Add bcm2835 framebuffer test

I'll send another series moving these tests from boot_linux_console.py
to machine_arm_raspi.py, but this doesn't affect the review.

raspi0/raspi1 are based on "hw/arm: Add raspi0 and raspi1 machines".
Based-on: <20200215191543.3235-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (8):
  tests/acceptance/boot_linux_console: Use raspi console model as key
  tests/acceptance/boot_linux_console: Add raspi version=2 parameter
  tests/acceptance/boot_linux_console: Test the raspi1 console
  tests/acceptance/boot_linux_console: Test the raspi0 console
  tests/acceptance/boot_linux_console: Test the raspi1 AUX console
  tests/boot_linux_console: Test booting U-Boot on the Raspberry Pi 2
  tests/boot_linux_console: Test booting U-Boot on the Raspberry Pi 3
  tests/acceptance: Count Raspberry Pi logos displayed on framebuffer

 tests/acceptance/boot_linux_console.py | 207 +++++++++++++++++++++++--
 1 file changed, 195 insertions(+), 12 deletions(-)

-- 
2.21.1


