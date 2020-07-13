Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEFF2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pa87KSmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEFF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzHB-00088Q-Sz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAm-0004rk-Jb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAj-0006bZ-G1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id 22so13464788wmg.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HdNJ20eMAOaPbQ6G50C4oWU8DxNiUlxGWU4qkJAbt7M=;
 b=Pa87KSmqoZ8CIvJHzE4x9k/grgosYSd89sd7flN5vAo4/A/Dczidg7HDI3vA3E0fmc
 EIDHFG5V8geP8VehXPbu5442XVpnQUL/OBv8A3s7AXR8B86viLtKM6dd2U2se1zwRebe
 zpiJw/wf7xvqGtl6d7rWfgyDXiPEL9PPjZoJT5oIz+HnIKbM2xCd7lLGMaACANN1qjoG
 i+Hl4I1Bet9Y1rbZzpHyaCnhbXWHdx0XhjTMB1wn5LElq0bLskgN2ucdP54ZXdWgDTGX
 9T8BLh2uyusPiM4yd7vEjNGv+DSrDYezaTEaE9P0s3fqh/KiyqE3Hkq9Vz0jteoqYMTA
 2Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HdNJ20eMAOaPbQ6G50C4oWU8DxNiUlxGWU4qkJAbt7M=;
 b=dfSMR/uM/6Fhx00R7QuE0iaqtD5MZbGdPteNwDQ2gR+hbo6u2kDLoL8tv7RUYITygU
 0Xyr+mXcQQSpAJ+ucfFTMp8nQl+lD4jVigAU2UgtDzfbHZs6pRBAb/G43h/YsrtLkr8k
 Wj/KS+OLYb43FLYMNIH58SuF1RBhMJZSQ2dpF+PKazASPv/UGm/6VC+gGwira0cIxcj9
 IVEmckAevaydpJdtEZqz/aL9Sp4PdAPD4MH5HUC3aC5suw4Kog8qfo/3+ONoA9W/EWcd
 4h5/LpjlSmJJEkjFQ5pSbzmrZv2+bY2WkIL03RoSrVjy/WpUiKjHJ6B/sW+TtQYtVqNX
 tMFg==
X-Gm-Message-State: AOAM532P1zfcY5xQHmE6RWdKSSzE0x9ICezmqlJtwI7bP4NdyFBLJ0AN
 Fts8uQtaOklbHXV6v0+rEUR/zUTQ7VSvJQ==
X-Google-Smtp-Source: ABdhPJzZwJFP5I85T7S9uLj6BSfpNT7hWHa6lFnf/7z0Sk4BT36cNMYt6Tt83CjPzvcN2MOp/bGkFg==
X-Received: by 2002:a1c:6246:: with SMTP id w67mr177258wmb.42.1594649467242;
 Mon, 13 Jul 2020 07:11:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/25] target-arm queue
Date: Mon, 13 Jul 2020 15:10:39 +0100
Message-Id: <20200713141104.5139-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Last lot of target-arm changes to squeeze in before rc1:
 * various minor Arm bug fixes
 * David Carlier's Haiku build portability fixes
 * Wentong Wu's fixes for icount handling in the nios2 target

The following changes since commit 00ce6c36b35e0eb8cc5d68a28f288a6335848813:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-13' into staging (2020-07-13 13:01:30 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200713

for you to fetch changes up to 756f739b1682bf131994ec96dad7fbdf8b54493a:

  hw/arm/aspeed: Do not create and attach empty SD cards by default (2020-07-13 14:36:12 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/bcm2836: Remove unused 'cpu_type' field
 * target/arm: Fix mtedesc for do_mem_zpz
 * Add the ability to change the FEC PHY MDIO device number on i.MX25/i.MX6/i.MX7
 * target/arm: Don't do raw writes for PMINTENCLR
 * virtio-iommu: Fix coverity issue in virtio_iommu_handle_command()
 * build: Fix various issues with building on Haiku
 * target/nios2: fix wrctl behaviour when using icount
 * hw/arm/tosa: Encapsulate misc GPIO handling in a device
 * hw/arm/palm.c: Encapsulate misc GPIO handling in a device
 * hw/arm/aspeed: Do not create and attach empty SD cards by default

----------------------------------------------------------------
Aaron Lindsay (1):
      target/arm: Don't do raw writes for PMINTENCLR

David CARLIER (8):
      build: Enable BSD symbols for Haiku
      util/qemu-openpty.c: Don't assume pty.h is glibc-only
      build: Check that mlockall() exists
      osdep.h: Always include <sys/signal.h> if it exists
      osdep.h: For Haiku, define SIGIO as equivalent to SIGPOLL
      bswap.h: Include <endian.h> on Haiku for bswap operations
      util/compatfd.c: Only include <sys/syscall.h> if CONFIG_SIGNALFD
      util/oslib-posix.c: Implement qemu_init_exec_dir() for Haiku

Eric Auger (1):
      virtio-iommu: Fix coverity issue in virtio_iommu_handle_command()

Gerd Hoffmann (1):
      util/drm: make portable by avoiding struct dirent d_type

Jean-Christophe Dubois (3):
      Add the ability to change the FEC PHY MDIO device number on i.MX25 processor
      Add the ability to change the FEC PHY MDIO device number on i.MX6 processor
      Add the ability to change the FEC PHY MDIO devices numbers on i.MX7 processor

Peter Maydell (4):
      hw/arm/tosa.c: Detabify
      hw/arm/tosa: Encapsulate misc GPIO handling in a device
      hw/arm/palm.c: Detabify
      hw/arm/palm.c: Encapsulate misc GPIO handling in a device

Philippe Mathieu-Daudé (2):
      hw/arm/bcm2836: Remove unused 'cpu_type' field
      hw/arm/aspeed: Do not create and attach empty SD cards by default

Richard Henderson (1):
      target/arm: Fix mtedesc for do_mem_zpz

Wentong Wu (4):
      target/nios2: add DISAS_NORETURN case for nothing more to generate
      target/nios2: in line the semantics of DISAS_UPDATE with other targets
      target/nios2: Use gen_io_start around wrctl instruction
      hw/nios2: exit to main CPU loop only when unmasking interrupts

 configure                   |  38 ++++++++++++-
 include/hw/arm/bcm2836.h    |   1 -
 include/hw/arm/fsl-imx25.h  |   1 +
 include/hw/arm/fsl-imx6.h   |   1 +
 include/hw/arm/fsl-imx7.h   |   1 +
 include/qemu/bswap.h        |   2 +
 include/qemu/osdep.h        |   6 +-
 hw/arm/aspeed.c             |   9 +--
 hw/arm/fsl-imx25.c          |   7 +++
 hw/arm/fsl-imx6.c           |   7 +++
 hw/arm/fsl-imx7.c           |   9 +++
 hw/arm/palm.c               | 111 +++++++++++++++++++++++++------------
 hw/arm/tosa.c               | 132 +++++++++++++++++++++++++++++---------------
 hw/nios2/cpu_pic.c          |   3 +-
 hw/virtio/virtio-iommu.c    |   1 +
 hw/xen/xen-legacy-backend.c |   1 -
 os-posix.c                  |   4 ++
 target/arm/helper.c         |   4 +-
 target/arm/translate-sve.c  |   2 +-
 target/nios2/translate.c    |  12 +++-
 util/compatfd.c             |   2 +
 util/drm.c                  |  19 +++++--
 util/oslib-posix.c          |  20 ++++++-
 util/qemu-openpty.c         |   2 +-
 24 files changed, 292 insertions(+), 103 deletions(-)

