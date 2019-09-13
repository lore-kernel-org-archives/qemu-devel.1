Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78076C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDEC20640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKUj1n+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDEC20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nrw-0000sR-Sl
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npd-0007Rv-R3
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npc-0000nr-BF
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:49:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8npc-0000nh-2X
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:49:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id g7so32673819wrx.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=knJlsnqK4CkmdQ5y6JWnWDeSJIq2/fxWy4SXtbG2pn4=;
 b=dKUj1n+6/DszsisbS/c52vUHpDDIyU0gsjOqjrnHB+bi0raZ2Yn94pHIbWQk5peZcm
 pK/nPERNnp5ECnQiph2VrCBqzHQ0RD1+3jy2GcIBVORWqUzjGZsIEZPctcICOVVX4SOy
 Mre6uVH8RB2ONXZPyNlhkASnF7mIyJR01saZh4cHYuSamxVBVt3Ric8/jJMdjJ740Lf2
 MNt3JobSWoUdJJuZHGkMcs9fZ+6ZY7FLx1vMaQ3ThdMJac5Bg8sRLWtCpf20pw1zUKNL
 rXLUxVxweubkcIeKntQ2pA1t0mwnUYqjZN1KK5OMgKi4p3NO0VWCZOE6sM8x8cbevwZv
 zj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=knJlsnqK4CkmdQ5y6JWnWDeSJIq2/fxWy4SXtbG2pn4=;
 b=MeFSUiyteXiV2TgMKdMFEy4VO15CJXBBbDY9xp780LPDz7rZnSrnT5wYIK7koamV29
 fCkBLuhcqnVd12BfwDgLEAhhAJt9Gr3s711Tl5psjl7MERXCbEWWKuNpSGvPSYQF7QFY
 Rqj9oBiOORFaITQUbiLqA+xMD5zJRMw2zNwWn+SNyx327qntAJAU5QCod+ULhYTEQG8A
 7us7oENL0ZzWd/K2XqMfzs4b64AbhRegQB97ZcVVMp2fxhPVxgkfb4ufEihFVui1KTs1
 DgH7sauGttLzctO9+B9QvX6fi42BhFeQBJrryxpP1JqMxrqtVolxRcSBCr9iYraJyUVF
 h6Xg==
X-Gm-Message-State: APjAAAXVPyJF9BdkiinldMYFzWapQd0KRZOTFmcGLAkfI9Uv9g1RhDWO
 4+WMQelnM/UGM48aNbshLfToer4QY62Tpg==
X-Google-Smtp-Source: APXvYqwvc+qKasExbjo0GNuXLNK++O3UqxwHpOaAYn89zhETAxUoDw60LgmEXs4VaOgku/bwkU5QvQ==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr7763201wrr.221.1568389794467; 
 Fri, 13 Sep 2019 08:49:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.49.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:49:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:40 +0100
Message-Id: <20190913154952.27724-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 00/12] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

target-arm queue: mostly aspeed changes from Cédric.

thanks
-- PMM

The following changes since commit 85182c96de61f0b600bbe834d5a23e713162e892:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20190912a' into staging (2019-09-13 14:37:48 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190913

for you to fetch changes up to 27a296fce9821e3608d537756cffa6e43a46df3b:

  qemu-ga: Convert invocation documentation to rST (2019-09-13 16:05:01 +0100)

----------------------------------------------------------------
target-arm queue:
 * aspeed: add a GPIO controller to the SoC
 * aspeed: Various refactorings
 * aspeed: Improve DMA controller modelling
 * atomic_template: fix indentation in GEN_ATOMIC_HELPER
 * qemu-ga: Convert invocation documentation to rST

----------------------------------------------------------------
Christian Svensson (1):
      aspeed/smc: Calculate checksum on normal DMA

Cédric Le Goater (7):
      aspeed: Remove unused SoC definitions
      aspeed: Use consistent typenames
      aspeed/smc: Add support for DMAs
      aspeed/smc: Add DMA calibration settings
      aspeed/smc: Inject errors in DMA checksum
      aspeed/scu: Introduce per-SoC SCU types
      aspeed/scu: Introduce a aspeed_scu_get_apb_freq() routine

Emilio G. Cota (1):
      atomic_template: fix indentation in GEN_ATOMIC_HELPER

Peter Maydell (1):
      qemu-ga: Convert invocation documentation to rST

Rashmica Gupta (2):
      hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
      aspeed: add a GPIO controller to the SoC

 Makefile                      |  24 +-
 hw/gpio/Makefile.objs         |   1 +
 accel/tcg/atomic_template.h   |   2 +-
 include/hw/arm/aspeed_soc.h   |   4 +-
 include/hw/gpio/aspeed_gpio.h | 100 +++++
 include/hw/misc/aspeed_scu.h  |  21 +-
 include/hw/ssi/aspeed_smc.h   |   7 +
 hw/arm/aspeed.c               |   2 +
 hw/arm/aspeed_soc.c           |  63 ++-
 hw/gpio/aspeed_gpio.c         | 884 ++++++++++++++++++++++++++++++++++++++++++
 hw/misc/aspeed_scu.c          | 102 ++---
 hw/ssi/aspeed_smc.c           | 335 +++++++++++++++-
 hw/timer/aspeed_timer.c       |   3 +-
 MAINTAINERS                   |   2 +-
 docs/conf.py                  |  18 +-
 docs/interop/conf.py          |   7 +
 docs/interop/index.rst        |   1 +
 docs/interop/qemu-ga.rst      | 133 +++++++
 qemu-doc.texi                 |   5 -
 qemu-ga.texi                  | 137 -------
 20 files changed, 1585 insertions(+), 266 deletions(-)
 create mode 100644 include/hw/gpio/aspeed_gpio.h
 create mode 100644 hw/gpio/aspeed_gpio.c
 create mode 100644 docs/interop/qemu-ga.rst
 delete mode 100644 qemu-ga.texi

