Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D9C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B985206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcyPq1zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B985206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilsxF-00079u-38
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvt-0005SC-Sn
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvs-00036J-PZ
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:09:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvs-00035q-JP; Mon, 30 Dec 2019 06:09:56 -0500
Received: by mail-wm1-x32f.google.com with SMTP id b19so13627535wmj.4;
 Mon, 30 Dec 2019 03:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jFReq7E825k+36Vj4KnB4Ttzw5P5x4uoxxDy/kudsL8=;
 b=QcyPq1zcjS0NG3GzjIvcKo0woTeiWd3MDk/avS3IP7Zqqp9UqM9b8V2qPA0MrlGps9
 VMcV2ToEoRC6RD0hGlx0yju5JQkxNJYzgsV1n7uD2IJssxZN2a4xCFuCdl9KJNswopdI
 osaF3zzSdKi9kyzUweJkiu6gjEP4yWlGh2y/HqpXpASyikN8CdmJq9T6S4vmaQ7SL2zf
 RaSejGuWaG46K9KzYz6eSChBljQnA/lHZDzh+Ms3iPFphROM5SG03LkEc7aFxeqevRD+
 6KZ1L8fGVTKdq0NzH3fx0WpApgSjuh8uYSfdP06Gk+52w6aVjyq7PTVcCZEEK1Vp+QUb
 aZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jFReq7E825k+36Vj4KnB4Ttzw5P5x4uoxxDy/kudsL8=;
 b=M8BJ1JB+JIIex8oOJ6tOpKuApFyriE4DANxj7+K+xk9jHzBE54DkXqsq+M1wX+yOTZ
 dT1xhLbbq7v8g9x1nCyeimWVZ8YgxtlzbfMtUAISCU2EqiIOTCHJvUFIdhtnjHLoKGcy
 P8y6Aa0DulGKSaFON6vGVdQt5PdTQCJEmd/OFWy5an0Fi5ca4j7whDhGWe4F9LVYImwA
 zJAoxj4ImABxdE7ZEtSZrtyjFVA8s0NYg1It/Osh3dOktUKHtVNifq2Xcd7IigVayrLq
 tychNOtQw8GUaoLI3MtmZFcVL5dLnnDJcPpvn4ytlCCIiItBTNvniwKfwcpMhgIqP8yC
 yXww==
X-Gm-Message-State: APjAAAVcgOVZYa4PePiaxzaEfZwne8GK1eENXWVkw9Aq/dy9foh5LiwJ
 WJJ1nHUEtXynQJL5h3ee02/ON+sK11w=
X-Google-Smtp-Source: APXvYqyoIg7m3paOrdLpc0D+CvDPqx8OfdgI6oFyqe2vAmERKkmCKub+HqFQ5Sh7ytkUuJ5xZCwElw==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr35056743wma.159.1577704195299; 
 Mon, 30 Dec 2019 03:09:55 -0800 (PST)
Received: from x1w.redhat.com ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id p15sm20442738wma.40.2019.12.30.03.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2019 03:09:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] hw/arm/cubieboard: Few cleanups, add acceptance tests
Date: Mon, 30 Dec 2019 12:09:47 +0100
Message-Id: <20191230110953.25496-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After looking at Niek Linnenbank implementation of the
Allwinner H3 [1], I looked what is common in the A10 [2].

Add some tests before modifying the code further.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg665532.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg666809.html

Philippe Mathieu-Daudé (6):
  tests/boot_linux_console: Add initrd test for the CubieBoard
  tests/boot_linux_console: Add a SD card test for the CubieBoard
  hw/arm/allwinner-a10: Move SoC definitions out of header
  hw/arm/allwinner-a10: Simplify by passing IRQs with qdev_pass_gpios()
  hw/arm/allwinner-a10: Remove local qemu_irq variables
  hw/arm/cubieboard: Disable unsupported M-USB in device tree blob [RFC]

 include/hw/arm/allwinner-a10.h         |  7 ---
 hw/arm/allwinner-a10.c                 | 39 ++++++------
 hw/arm/cubieboard.c                    | 24 ++++++++
 tests/acceptance/boot_linux_console.py | 85 ++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 25 deletions(-)

-- 
2.21.0


