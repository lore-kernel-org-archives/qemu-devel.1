Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAFCC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C312474A
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3bMEs68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C312474A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmbI-0008Ng-S1
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmma5-0006x7-BW; Sat, 20 Jun 2020 19:07:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmma3-0002Ly-NM; Sat, 20 Jun 2020 19:07:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id p19so1787390wmg.1;
 Sat, 20 Jun 2020 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VGwkKeB6tl+dGrbm6jHQLUZ5L3WbmR4JBPloevQDRIU=;
 b=i3bMEs68t7hIxPLU8I8EPOyTAYoj+PPKepJA2J7T6EhchaG6BEVyjbhCZDUP9iwh7u
 tr2GXFH48tr4Xol2F5J4lNhL5NiBOM9ra9PWybEgXKzFCYbnNzVkk2QxfwyBG4tKOR8W
 SbxMkzP+sgbY1NyWCQtCx5dGniCtxRK8hBruqsuZWuRPo3/qea6W8XaoKkqqmTjdYEsA
 9UFXnGw8ah3V5q0Ec4FpDr041NioxAelPTRKqvD7hhNJT4Kr2uTW2R9Dshqb+pyHMkmn
 HcaWqxhYia518QQzCb9rjKLrXC4C3UVvlrNdz0J2TN/usuGSP8lxYOFoua5nzM/snRlU
 mqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=VGwkKeB6tl+dGrbm6jHQLUZ5L3WbmR4JBPloevQDRIU=;
 b=Hc2bj7/Km5BprXASbV7CXg/bIa7SiRVRhztuUiL0cGdkAenzm0eFuULJJuC6sP1els
 S665W4E5f2zp4Lgx2NzRutAIOtN6/2Z/Sot7VeUQomLdZ9nc2hSvaeggnK6lpQ+5unZU
 lu3cUS6U08LjzjH9wauwPYCionk5QASaseCL3eVGJYvKFCKv8m2x4Y1vrQyTSyy93jTB
 D1LnKv0HBiPSVwBbpl59YZZdZbv6yUNOZwxOConcie4OlwvGh93ti7MRFLUCEGXjvxqY
 k1aisUTxH/phy+9FXFHO9yyF6Jl84C66B5lMPe1AsLkl/XMgEyk6m9OAcPqOXsyY91Q9
 pUQg==
X-Gm-Message-State: AOAM5330K7fMlf/jZk04gLFOcxSNOde/8R8HOlowgMgO/7SuUDh+zQd7
 1S9qOlzuvC6PyB5lFNogXX3GAYlv
X-Google-Smtp-Source: ABdhPJz15+tZmMj/B9tnNwTp8Hf8tErWYJ6Oh1cw7orujMqvT69W9mhGKUardplFE/n5UASERo56Fw==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr10041426wmi.7.1592694441819;
 Sat, 20 Jun 2020 16:07:21 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o82sm11455037wmo.40.2020.06.20.16.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 16:07:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] hw/misc: Add LED device
Date: Sun, 21 Jun 2020 01:07:12 +0200
Message-Id: <20200620230719.32139-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

These patches are part of the GSoC unselected 'QEMU visualizer'
project.  As the AVR port is not merged, I switched to microbit
to keep working on it.

This series presents a proof of concept of LED device that can
be easily connected to a GPIO.

Since v2:
- Rebased on PCA9552
- Model intensity to be ready for PWM use (Dave)
- Remove QMP events until we get a UI visualizer (Peter)
- Remove microbit patch (Peter)

Since v1: addressed Eric Blake review comments
- Added QMP rate limit

Next steps planned:

- PoC visualizer...
- look at using a dbus backend (elmarco)
- look at LED array/matrix such 7segments.

Regards,

Phil.

Based-on: <20200620225854.31160-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (7):
  hw/misc: Add a LED device
  hw/misc/led: Add helper to connect LED to GPIO output
  hw/misc/led: Emit a trace event when LED intensity has changed
  hw/arm/aspeed: Add the 3 front LEDs drived by the PCA9552 #1
  hw/misc/mps2-fpgaio: Use the LED device
  hw/misc/mps2-scc: Use the LED device
  hw/arm/tosa: Replace fprintf() calls by LED devices

 include/hw/misc/led.h         | 100 ++++++++++++++++++++++
 include/hw/misc/mps2-fpgaio.h |   1 +
 include/hw/misc/mps2-scc.h    |   1 +
 hw/arm/aspeed.c               |  17 ++++
 hw/arm/tosa.c                 |  40 +++------
 hw/misc/led.c                 | 151 ++++++++++++++++++++++++++++++++++
 hw/misc/mps2-fpgaio.c         |  13 +--
 hw/misc/mps2-scc.c            |  23 +++---
 MAINTAINERS                   |   6 ++
 hw/arm/Kconfig                |   2 +
 hw/misc/Kconfig               |   5 ++
 hw/misc/Makefile.objs         |   1 +
 hw/misc/trace-events          |   6 +-
 13 files changed, 321 insertions(+), 45 deletions(-)
 create mode 100644 include/hw/misc/led.h
 create mode 100644 hw/misc/led.c

-- 
2.21.3


