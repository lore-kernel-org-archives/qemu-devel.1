Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F1C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9A222277
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efismLLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9A222277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFRD-0006rg-Hb
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNa-0001db-La; Sun, 18 Oct 2020 16:34:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNY-0000xM-KS; Sun, 18 Oct 2020 16:34:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id q5so10707622wmq.0;
 Sun, 18 Oct 2020 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h0GvI7MkM0GKC7AKZJq4LYQMFHsqsuNUcEBNqubAW/A=;
 b=efismLLo1CCl/ijp76H4KE2vmUP8gCmzLfegC61xi8F24T6JgnIcYNXbY6EiBgDQs+
 mVnwPgTGrdPp7K1NhHHFEL43u4nJvDDkAI50+akjWDSfbY7tzg/rAgXwRvGffC9FJUy/
 JtcMgvQot6hia5snV/eAgYlOQNQFmPpTIIicTgONRrn/s8Jw4SKK+fwfRR+AVyODc+fD
 lIPB9Am2vNHMpRva/sdgnECx57Sdhjw7SfeMKZd4MUxkZgY7ciMP90aokBKUyvK24sFR
 SnuCUs+A+6STfOZmRSAKU9NMXwScYO1KtXbtliCYPMxwrk7M+2gaz7uz2zB0y7w0Zyt3
 CD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=h0GvI7MkM0GKC7AKZJq4LYQMFHsqsuNUcEBNqubAW/A=;
 b=uHqlzatwNiERk5BP2jBbzSt/lXS/ElPf/Aop+cnx3++kCc6fU3RjaHR5oeMq1IUPho
 PuQ51mVPp89NaGFm18XB88uuuEr2LB8JNiJS3PZypr3o+Blw+2Mp8Dqsc+v9RdHjzoAB
 rXk2VST6+TfTfuQSPBpHqEoAhAlY50j8xCVq59kVq1oaoMM+urJRtd4IQYqi9LyZKPbE
 7UkUIq14ltQyLKeSntVczCg/UIVT8IbolN2c6f13t3vIrcL3FbN4Mgkr5mtsJaarjkc1
 qwBJ5fqMukHpWoZxIKRrS9l6642iUT/t22tBo+SR4XfF25adoB+eQi+DQgvUBvzuTK++
 zL/g==
X-Gm-Message-State: AOAM530xV/bG0II4OgkCYkHD4A8GWtVTOru+wtPIO9Y/Wu+IhxZPXrtw
 dHpGQCISurM3vVxIL13CvhZsiTgs0Cw=
X-Google-Smtp-Source: ABdhPJxbNTTGg/Kyu3wSpDYXWMIWSPd4ZIc+bLwK1MrPsVGuToU4VDWmxtf2K0nTpWTjif1fsrDkxA==
X-Received: by 2002:a1c:68d5:: with SMTP id
 d204mr14298744wmc.100.1603053241543; 
 Sun, 18 Oct 2020 13:34:01 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id h4sm15716440wrv.11.2020.10.18.13.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 13:34:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] hw/arm: Add raspi Zero, 1A+ and 3A+ machines
Date: Sun, 18 Oct 2020 22:33:49 +0200
Message-Id: <20201018203358.1530378-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the raspi0/1/3A+ machines.=0D
=0D
Missing review: #7 and #9=0D
=0D
Since v2:=0D
- Rebased=0D
- Addressed Igor comment=0D
- Added Luc R-b=0D
- Added model 3A+=0D
=0D
Since v1:=0D
- Use more specific machine names=0D
=0D
Based-on: <20201010135759.437903-1-luc@lmichel.fr>=0D
Supersedes: <20200217114533.17779-1-f4bug@amsat.org>=0D
=0D
Philippe Mathieu-Daud=C3=A9 (9):=0D
  hw/arm/bcm2836: Restrict BCM283XInfo declaration to C source=0D
  hw/arm/bcm2836: QOM'ify more by adding class_init() to each SoC type=0D
  hw/arm/bcm2836: Introduce BCM283XClass::core_count=0D
  hw/arm/bcm2836: Only provide "enabled-cpus" property to multicore SoCs=0D
  hw/arm/bcm2836: Split out common realize() code=0D
  hw/arm/bcm2836: Introduce the BCM2835 SoC=0D
  hw/arm/raspi: Add the Raspberry Pi A+ machine=0D
  hw/arm/raspi: Add the Raspberry Pi Zero machine=0D
  hw/arm/raspi: Add the Raspberry Pi 3 model A+=0D
=0D
 include/hw/arm/bcm2836.h |   9 +-=0D
 hw/arm/bcm2836.c         | 182 ++++++++++++++++++++++++++-------------=0D
 hw/arm/raspi.c           |  41 +++++++++=0D
 3 files changed, 162 insertions(+), 70 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

