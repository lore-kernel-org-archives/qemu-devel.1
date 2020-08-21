Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D44C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DCE20656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOpsBlDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DCE20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9AsB-0002yV-8z
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Aqx-0000wt-QL; Fri, 21 Aug 2020 13:29:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Aqw-00018o-6j; Fri, 21 Aug 2020 13:29:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id 88so2660855wrh.3;
 Fri, 21 Aug 2020 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8UmPEBqHrjvPs/KBLPT0a1bzj7Klv5TNoMNfuKZPiIs=;
 b=sOpsBlDqQGsQ/wTlUDCIX9W2uara5u8JoHg+Rxjn0lmOZyHLuWoy/k/053E/ZkD4OP
 EtrcK6qqNfPwy+8L2mkL5X7vNVef7q1bDe2aCk2EfmH1XaXDcLSaS6g0NxQ95plIDTE3
 YbO4YpzKDo3hw1sFYyyfOk5QGm+QF0Xvinbv6Ul+8EBKxls1YjbKV1NO5Zu2anlZgJ+5
 0xkfUAm1iCO9S+zylZjvx0MVmwVg9vykLbiPP8e0k7NbaVJTd7Ig7D9GuOytK17rsfn/
 GpMWFsUDsX9wTUJLjNmoNSP3gvcgttl3boxA0XpgMINvDfSNI9cs++L6yWC5PUNjC9p4
 v0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=8UmPEBqHrjvPs/KBLPT0a1bzj7Klv5TNoMNfuKZPiIs=;
 b=ob/GpG8L/OtNmifhpWuYbTVAp8zHDktZ+RdkiTFtw0Y+fKT8Tci5Olq+gydOzsCBqD
 e0jCCwqrqz/vnvLUirFZQb9kG3y8HNZBVtVRWe+horEjYQFSSuwt4opJv3hNWCo/iga0
 inHUCnZJRAs79mabu3hA94ebgwK56scrhoDyAAJo1Y+5xb638HxS01I75SSUoIhhZ4Aw
 E9ljN1isXBxLmCP6uAr5i7xCnaoV6h6EDr+YAcVeKTcMRUOHOmvJ7IXHMFlm/pyHz/HN
 skqnMkuHAW7RDEQwtHFtuuKnZ8tkLzuZJzjxI5qCKrlMucBqpnnQuJev1l3QZPtybiSp
 ZY6g==
X-Gm-Message-State: AOAM533jATec+bIMzM8lMOYgTHUqFsPh/kuiWRSxlebnR0Q6DKK/YGc/
 U9MhNR3QNZG2LO57jG+LOxxVm/nFWcA=
X-Google-Smtp-Source: ABdhPJzqFQ9YPW/Y7FVBBTk5ircWr0yiYufQbjKADT8jKmDYQGAJdz/u8CFTqQtHHSsdRaK/OZ1OTQ==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr3412280wrh.381.1598030959115; 
 Fri, 21 Aug 2020 10:29:19 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] SD/MMC patches for 2020-08-21
Date: Fri, 21 Aug 2020 19:28:53 +0200
Message-Id: <20200821172916.1260954-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d6f83a72a7db94a3ede9f5cc4fb39f9c8e89f954:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-testing=
-20200812' into staging (2020-08-21 14:51:43 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/sd-next-20200821

for you to fetch changes up to 6d2d4069c47e23b9e3913f9c8204fd0edcb99fb3:

  hw/sd: Correct the maximum size of a Standard Capacity SD Memory Card (2020=
-08-21 16:49:22 +0200)

----------------------------------------------------------------
SD/MMC patches

- Convert legacy SD host controller to the SDBus API
- Move legacy API to a separate "sdcard_legacy.h" header
- Introduce methods to access multiple bytes on SDBus data lines
- Fix 'switch function' group location
- Fix SDSC maximum card size (2GB)

CI jobs result:
  https://gitlab.com/philmd/qemu/-/pipelines/180605963
----------------------------------------------------------------

Alistair Francis (1):
  hw/sd/pl181: Replace fprintf(stderr, "*\n") with error_report()

Bin Meng (2):
  hw/sd: Fix incorrect populated function switch status data structure
  hw/sd: Correct the maximum size of a Standard Capacity SD Memory Card

Philippe Mathieu-Daud=C3=A9 (20):
  hw/sd/pxa2xx_mmci: Do not create SD card within the SD host controller
  hw/sd/pxa2xx_mmci: Trivial simplification
  hw/lm32/milkymist: Un-inline milkymist_memcard_create()
  hw/sd/milkymist: Create the SDBus at init()
  hw/sd/milkymist: Do not create SD card within the SD host controller
  hw/sd/pl181: Rename pl181_send_command() as pl181_do_command()
  hw/sd/pl181: Add TODO to use Fifo32 API
  hw/sd/pl181: Use named GPIOs
  hw/sd/pl181: Expose a SDBus and connect the SDCard to it
  hw/sd/pl181: Do not create SD card within the SD host controller
  hw/sd/pl181: Replace disabled fprintf()s by trace events
  hw/sd/sdcard: Make sd_data_ready() static
  hw/sd: Move sdcard legacy API to 'hw/sd/sdcard_legacy.h'
  hw/sd: Rename read/write_data() as read/write_byte()
  hw/sd: Rename sdbus_write_data() as sdbus_write_byte()
  hw/sd: Rename sdbus_read_data() as sdbus_read_byte()
  hw/sd: Add sdbus_write_data() to write multiples bytes on the data
    line
  hw/sd: Use sdbus_write_data() instead of sdbus_write_byte when
    possible
  hw/sd: Add sdbus_read_data() to read multiples bytes on the data line
  hw/sd: Use sdbus_read_data() instead of sdbus_read_byte() when
    possible

 hw/lm32/milkymist-hw.h        |  11 ----
 include/hw/arm/pxa.h          |   3 +-
 include/hw/sd/sd.h            |  73 +++++++++++++++-------
 include/hw/sd/sdcard_legacy.h |  50 +++++++++++++++
 hw/arm/integratorcp.c         |  17 +++++-
 hw/arm/pxa2xx.c               |  39 +++++++++---
 hw/arm/realview.c             |  16 ++++-
 hw/arm/versatilepb.c          |  26 +++++++-
 hw/arm/vexpress.c             |  15 ++++-
 hw/lm32/milkymist.c           |  24 ++++++++
 hw/sd/allwinner-sdhost.c      |  24 +++-----
 hw/sd/bcm2835_sdhost.c        |   4 +-
 hw/sd/core.c                  |  38 ++++++++++--
 hw/sd/milkymist-memcard.c     |  71 ++++++++++++----------
 hw/sd/omap_mmc.c              |  10 +--
 hw/sd/pl181.c                 | 111 +++++++++++++++++++---------------
 hw/sd/pxa2xx_mmci.c           |  19 ++----
 hw/sd/sd.c                    |  28 +++++----
 hw/sd/sdhci.c                 |  46 ++++----------
 hw/sd/ssi-sd.c                |   2 +-
 hw/sd/trace-events            |  10 +++
 21 files changed, 415 insertions(+), 222 deletions(-)
 create mode 100644 include/hw/sd/sdcard_legacy.h

--=20
2.26.2


