Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA38AC35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD90A2082E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGiJiXab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD90A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43313 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0TQz-0007GB-Rl
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 11:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPj-0005Vt-6J
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPh-0001d6-SM
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:02 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPh-0001cH-KW; Sat, 08 Feb 2020 11:57:01 -0500
Received: by mail-wm1-x336.google.com with SMTP id b17so6067992wmb.0;
 Sat, 08 Feb 2020 08:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M6znWrwvkqZIc+O5AYJ19ilD9hYxp5DQIdt31ia8C3Q=;
 b=HGiJiXabjwc8ocLFlTVpqQYHMva4qCcYfBGrpA9BjBUd21rLsUtRzbmnCH6nSIoUpZ
 5/6Cd61EUUN0N4JsjQU/wgwCiq5s0rIvIZbK4+YJZ5ZVg+57tyaGtlk4ObXXCoko0CVR
 kt84iHq2vaes7z+Z8WqQkqwZgKVayzuh+XGzLOcyrmjNYIDU1UU6qYHaXL1e/GhFd5PI
 AgjoLpez4XtJpz7JCL0N+cyg/ZWLHgYr2Ks0MY3NuDRj1QLuwCpGWiljzpRBoe3X0AJX
 D93zD3YZCYvTgAZqB4FHcF8pDpiLTePUnUF9VsZGxq+RgpvlfIP8jrg+ZkE/Y5x1u6fG
 0Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=M6znWrwvkqZIc+O5AYJ19ilD9hYxp5DQIdt31ia8C3Q=;
 b=L0WhE04uOufkQ43g1BU1SrPh1rvhPIPyrst9Dzi3tWHUFHjxwuvnfZqczeZafqoSDb
 EYHrA51rTLhj5A8SsFEgByCo/DCXE4962RL3wR9mTsu9M+/bopWsjNDHkY/UCK1Ui4bB
 ZoWcP5yHt79E2uzrB4c+jPhXmcp3VobvDOqRI4uIjU19jhbb2nGlyyBuaAKGB/gN98dn
 a7fAuXnVFC0xnIwnN2tYIMmBonTEaZj5rf8xQnX+Lv7GGAjeAysqYERFMYD9aaj9S/lq
 LLugb/oyjWQz0YlNpH1EZ9H7FTESKAvoAc/s3DDacCyNmBCYWrPVx4zwsmkesMEvp8vf
 Mhag==
X-Gm-Message-State: APjAAAUsd60fpm6LXVE4xdzR/AMAula2+XFzHmnW12SPDQfcUYtTB6VH
 PvMYuR8NeWEOMm7psPifunWmXJGc
X-Google-Smtp-Source: APXvYqw3GlFo8WLo33ofdWmxu9mfiXwMtFWRUCHPFrJhkZszB8fcOhBb8EdlRkDWfs3xb5UZJKt7oA==
X-Received: by 2002:a05:600c:20c6:: with SMTP id
 y6mr5106294wmm.95.1581181019299; 
 Sat, 08 Feb 2020 08:56:59 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:56:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/13] hw/arm/raspi: Dynamically create machines based on
 the board revision
Date: Sat,  8 Feb 2020 17:56:32 +0100
Message-Id: <20200208165645.15657-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is a preparatory to easily add the raspi0/raspi1/raspi4
boards (see [1]).

Igor has been working in his "refactor main RAM allocation to use
hostmem backend" series, and now v4 [2] is almost reviewed.

His raspi patch [3] clashes with my work, Since it is easier for
him to apply his on top of mine, I am sending these patches first.

Since v2:
- Split of bigger series (30 patches was scary)
- addressed Zoltan review comments

Phil.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg677145.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675738.html
[3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675752.html
Supersedes: <20200206011756.2413-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (13):
  hw/arm/raspi: Use BCM2708 machine type with pre Device Tree kernels
  hw/arm/raspi: Correct the board descriptions
  hw/arm/raspi: Extract the version from the board revision
  hw/arm/raspi: Extract the RAM size from the board revision
  hw/arm/raspi: Extract the processor type from the board revision
  hw/arm/raspi: Trivial code movement
  hw/arm/raspi: Make machines children of abstract RaspiMachineClass
  hw/arm/raspi: Make board_rev a field of RaspiMachineClass
  hw/arm/raspi: Let class_init() directly call raspi_machine_init()
  hw/arm/raspi: Set default RAM size to size encoded in board revision
  hw/arm/raspi: Extract the board model from the board revision
  hw/arm/raspi: Use a unique raspi_machine_class_init() method
  hw/arm/raspi: Extract the cores count from the board revision

 hw/arm/raspi.c | 190 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 143 insertions(+), 47 deletions(-)

-- 
2.21.1


