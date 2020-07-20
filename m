Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2676AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68A722B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3oEPBcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68A722B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVMG-0003sP-2F
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLI-0002HB-Cc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:28 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLG-0007Hn-Iw
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id o11so17740001wrv.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mp29SHojRqpKy9V+YXlQO41fiUtg5Fxt1q4evYrhW18=;
 b=v3oEPBcGecUbrSaLDiLHNgRo7mQLOgrVQAGkNq0o1g5gmzyQPSDEICBLE/AoBTdotq
 LUjRj3xjjTw3bWH474z9Npemz/CPWt6Gmcq/DagkmL/A+3LuWPBNOfgZptVnWgKSItTa
 fV+UAkrMryU86ljGwYY4rBfDGR0MFrG75YTt2RLjhR8EeqMHqIMHRTM342guTWFFiz6/
 KuHuSNU5ifWdTTEY7PFzYAYU0T/nGzqkSuMRJLzOjRPi6yXdolGt0XPS/8pTVFFKoozQ
 RQ5kl/H9RkiglWPCoiPM23SnxE/DlDl+uF9UmUUwiAmO6D4fuLqZl6Qz5t85Dfd49/QT
 el/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mp29SHojRqpKy9V+YXlQO41fiUtg5Fxt1q4evYrhW18=;
 b=CgdzM/jhG8iVLZaaIPNIR6BM3mZDJoI1X73LAKhlMVAt8mcnF0xcNYTpIf/D0sguJB
 djkWjc1b5/q+AXGW9nGMhUKMDtAjrN1Nr26mDsRaORhRt/Swi2owOVWQP/1wpZ0CgLTZ
 pezKPJNkJ9/e78lZE15/DGyd0nORVoj/cyPeeE/d83R6yBCElsEkkH9KKcqmYRmPX8Vu
 F1hW/aVSXGxeoBgbt2zv5Z2bIMQ6WDroXjVvholJTNGGHUmB5nbrRS3EkJ4HF5WiSQsB
 7gPBfCnyolAqIWOrQNztBprmBsoEj8cfe+r32NxjU6A8JDYUpw67K7OHCUvguyI6WW8x
 xEBw==
X-Gm-Message-State: AOAM531BBOLr+AhP6mdGu/D/05pkXKKgYi0uQKVdOwZp6mNCNSDan6k4
 XRVahwG/+oFrQDTas3eQDSJhPEKWdB8YAw==
X-Google-Smtp-Source: ABdhPJxOJaUA2uDfP1Gn6+CYYbUwoq9XaVVZvpb1bCw3OTOWbzInnVGLZKWCd/LuuxKyszVoC/UGyw==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr1596058wrh.381.1595249784139; 
 Mon, 20 Jul 2020 05:56:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] target-arm queue
Date: Mon, 20 Jul 2020 13:56:09 +0100
Message-Id: <20200720125621.13460-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Not much here, mostly documentation, but a few bug fixes.

thanks
-- PMM

The following changes since commit 873ec69aeb12e24eec7fb317fd0cd8494e8489dd:

  Merge remote-tracking branch 'remotes/cminyard/tags/for-qemu-i2c-5' into staging (2020-07-20 11:03:09 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200720

for you to fetch changes up to 6a0b7505f1fd6769c3f1558fda76464d51e4118a:

  docs/system: Document the arm virt board (2020-07-20 11:35:17 +0100)

----------------------------------------------------------------
target-arm queue:
 * virt: Don't enable MTE emulation by default
 * virt: Diagnose attempts to use MTE with memory-hotplug or KVM
   (rather than silently not working correctly)
 * util: Implement qemu_get_thread_id() for OpenBSD
 * qdev: Add doc comments for qdev_unrealize and GPIO functions,
   and standardize on doc-comments-in-header-file
 * hw/arm/armsse: Assert info->num_cpus is in-bounds in armsse_realize()
 * docs/system: Document canon-a1100, collie, gumstix, virt boards

----------------------------------------------------------------
David CARLIER (1):
      util: Implement qemu_get_thread_id() for OpenBSD

Peter Maydell (8):
      qdev: Move doc comments from qdev.c to qdev-core.h
      qdev: Document qdev_unrealize()
      qdev: Document GPIO related functions
      hw/arm/armsse: Assert info->num_cpus is in-bounds in armsse_realize()
      docs/system: Briefly document canon-a1100 board
      docs/system: Briefly document collie board
      docs/system: Briefly document gumstix boards
      docs/system: Document the arm virt board

Richard Henderson (3):
      hw/arm/virt: Enable MTE via a machine property
      hw/arm/virt: Error for MTE enabled with KVM
      hw/arm/virt: Disable memory hotplug when MTE is enabled

 docs/system/arm/collie.rst   |  16 +++
 docs/system/arm/digic.rst    |  11 ++
 docs/system/arm/gumstix.rst  |  21 ++++
 docs/system/arm/virt.rst     | 161 ++++++++++++++++++++++++++
 docs/system/target-arm.rst   |   4 +
 include/hw/arm/virt.h        |   1 +
 include/hw/qdev-core.h       | 267 ++++++++++++++++++++++++++++++++++++++++++-
 include/hw/qdev-properties.h |  13 +++
 hw/arm/armsse.c              |   2 +
 hw/arm/virt.c                |  50 +++++++-
 hw/core/qdev.c               |  33 ------
 target/arm/cpu.c             |  19 +--
 target/arm/cpu64.c           |   5 +-
 util/oslib-posix.c           |   2 +
 MAINTAINERS                  |   4 +
 15 files changed, 559 insertions(+), 50 deletions(-)
 create mode 100644 docs/system/arm/collie.rst
 create mode 100644 docs/system/arm/digic.rst
 create mode 100644 docs/system/arm/gumstix.rst
 create mode 100644 docs/system/arm/virt.rst

