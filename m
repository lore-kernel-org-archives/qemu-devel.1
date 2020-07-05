Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A155C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DEC20739
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBNPBoSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DEC20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBvT-0000rS-D2
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 17:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBu2-0007Bk-Jz
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:10:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBu0-0004ot-Uo
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 17:10:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id z2so16512997wrp.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nNzM5/93dUYll+2DdWYX0zojdbNWRAz6yoQKex94XlY=;
 b=mBNPBoStoEYwHsybcQAC7801f54RH3gT39zO6q8g16E6gDOh6ZtLzwFTref/aoLd2z
 JMpUNnp1pflYiHGWkA+aZ1khMjj88L7rExbNJD69cRQbX4qj2OvdFFuoJ1lPUSbNNIua
 4CSJPGhapAxhn6LESAycA2eZHjMb6OGB2kA+bG0vxc+SqE5Ay9BdarMhL8ADwi/fjz3r
 5eT4NGFgSmDl5Rv4wa4U0yWuIDldmOZAe1GI5ystJjzfl+NKGicbZUqBn6ydE2+l+cgt
 RCGLznN9vTT52HX6M43Ka7j3y92HpFLMZo03FSlOLlE8rNeLDQlVaKivpQSseHytfTcL
 4dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=nNzM5/93dUYll+2DdWYX0zojdbNWRAz6yoQKex94XlY=;
 b=MIiN2pkpSCuVV6jGTt24rzHWygYLlHATwV+POgD+0E4BvzaP/TXOFXHkbr8TvDZS6t
 /odP6ccgdbwMXtlz1HGPQFKREEEPeJFsDn3lbkqNIF3cV0u3d8gW1FD1PGyPlQy8lKN3
 B6/wmYmFNIpZ5Y9ubaqIos3e48Dz4xFgFCpnIG0jJzxmtTb/6VF+sC6eAstnfqwfv+Ct
 QjlLw7VcbcuMEN+KrtW3xg/1gPyjXLZDwOLxvchzjm8wMvAh1a4eRkZ3GHdo3/Y4EuVD
 WiAkbeF7CogoClhwqarMV3xBhUdbdLfoMfVzAfZPwXT4Dy7qnpM2X2rsqmBMK4cAm0TR
 jm7g==
X-Gm-Message-State: AOAM530nn485khewKS4/39eAZ0OqZSCkau79vP9WewTTptVRwhMSr81h
 qKcXfGlSaZ9AYFG5ImJjyxuUE4HL/ok=
X-Google-Smtp-Source: ABdhPJz2zec1peohHykuLQkc45XnnPU8+pv3yxsdcxxO9plwIbk8BL/ffh7CDNYAckQJ2w/RmdMVSQ==
X-Received: by 2002:adf:82b8:: with SMTP id 53mr49526845wrc.172.1593983418975; 
 Sun, 05 Jul 2020 14:10:18 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r8sm21102004wrp.40.2020.07.05.14.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 14:10:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/sd/milkymist: Do not create SD card within the SDHCI
 controller
Date: Sun,  5 Jul 2020 23:10:12 +0200
Message-Id: <20200705211016.15241-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SDHCI controllers provide a SD Bus to plug SD cards, but don't
come with SD card plugged in :)

This series move the SD card creation to the machine/board code.

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  hw/lm32/milkymist: Un-inline milkymist_memcard_create()
  hw/lm32/milkymist: Comment to remember some IRQs lines are left
    unwired
  hw/sd/milkymist: Create the SDBus at init()
  hw/sd/milkymist: Do not create SD card within the SDHCI controller

 hw/lm32/milkymist-hw.h    | 11 --------
 hw/lm32/milkymist.c       | 25 +++++++++++++++++
 hw/sd/milkymist-memcard.c | 57 ++++++++++++++++++++++-----------------
 3 files changed, 58 insertions(+), 35 deletions(-)

-- 
2.21.3


