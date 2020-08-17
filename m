Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E786C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298DA2065D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plw/NNh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298DA2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7c18-0003fV-88
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7bzw-000242-3t; Mon, 17 Aug 2020 06:04:12 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7bzt-0005jX-He; Mon, 17 Aug 2020 06:04:11 -0400
Received: by mail-pf1-x442.google.com with SMTP id y206so7962816pfb.10;
 Mon, 17 Aug 2020 03:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wKDshQFa0k7HfBQMbO63VpUhXSNzxnkzaLE53/spjZQ=;
 b=Plw/NNh9tGHHe8Gy486PLdhRDvFqF6qzwFfV0EvRXEHA7UiTM2MjgU87EXuCJzOmqn
 N2zWW+SEZB7ykrmnWINtE4CL4SKnQCUGtiLYnHp+jv9MByrbD8GGQe2RuoFlvVUkcyYf
 Q6PG7pYxifDVx+ZdkkME03WUgf3VuB7NpOcuDSZelsZXitTZnPP51hjVRRh1LNm/WY5F
 ktrdfY7gGLbBB5kRHHIao/GiLeO8h9o/xCvIwIRbLQ03bNL9OkeYgf9iA+R10Nxz9ds/
 G0hX6yN3/xfaxkRx0SLBs+KbJZUoCulJP/G/+e+3Qpx8A/kQXZ8qDYcsKt0RHpWPqMI7
 pWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wKDshQFa0k7HfBQMbO63VpUhXSNzxnkzaLE53/spjZQ=;
 b=QCnF6QQOkmgcy9IZeVgk16wZ7uODQIiTGRMGyk7pvGTtkVnA9CB3QlQQ0r7UqeeOzB
 2HXUMG0UtehTl2F4yc7EQEvG3tCftRV1DDoAaKsZ+RzuMXfagn8//VUzljc2CoKjFvSt
 BFZ8QSaTrPigONjxnX8mT+YXgC4kzEGKE6tSsoRRhO+Cd2bNrVj1sVm5xdlAszj6r/BZ
 oiV3CoznXcIMP6wa8l9Gxq0B4jDrY0wBZQhq6/m2CEj29YurTRJ5QqNc2H9E4eqll18Y
 mr798zKIwaLVvOmH/QMHQCY5V6LPzPg7x298obkv3a3rPioZiaGoR3e6fo/xf6EzY4o8
 vROw==
X-Gm-Message-State: AOAM533FWwlEbwWrN57M224WqRbOL04z/4JtwYOtmVn2YT7osKBAAWu1
 O903g5b2msZupnq0IRiAdfg=
X-Google-Smtp-Source: ABdhPJxQmvQLEv6GeERWzdvgizz9ZnsqQsxOjmiGAgjBVCJhOOaadlnXapOipVU/K5VuC/TgyL80+g==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr9573228pga.142.1597658646819; 
 Mon, 17 Aug 2020 03:04:06 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id i1sm19417576pfo.212.2020.08.17.03.04.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Aug 2020 03:04:06 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
X-Google-Original-From: Bin Meng <bin.meng@windriver.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH v2 0/3] hw/sd: Add Cadence SDHCI emulation
Date: Mon, 17 Aug 2020 18:03:51 +0800
Message-Id: <1597658633-12802-1-git-send-email-bin.meng@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

This series is spun off from the following series as it is hw/sd
centric, so that it can be picked up separately by Philippe.

http://patchwork.ozlabs.org/project/qemu-devel/list/?series=195648

This series fixed 2 SD card issues, and added a new model for
Cadence SDHCI controller.

Patch "[09/18] hw/sd: sdhci: Make sdhci_poweron_reset() internal visible"
in this series per the review comments.

Changes in v2:
- remove the pointless zero initialization
- fix SDSC size check in sd_set_csd() too
- use 's' for the model state
- call device_cold_reset() in cadence_sdhci_reset()
- add .impl in cadence_sdhci_ops
- move Cadence specific register defines to cadence_sdhci.c
- use 'sdhci' instead of 'slot' to represent SDHCIState
- use sysbus_mmio_get_region() to access SDHCI model's memory region
- initialize TYPE_SYSBUS_SDHCI in the instance_init() so that users
  of Cadence SDHCI do not have to do that themselves
- propergate irq and 'sd-bus' from generic-sdhci

Bin Meng (3):
  hw/sd: sd: Fix incorrect populated function switch status data
    structure
  hw/sd: sd: Correct the maximum size of a Standard Capacity SD Memory
    Card
  hw/sd: Add Cadence SDHCI emulation

 hw/sd/Kconfig                 |   4 +
 hw/sd/Makefile.objs           |   1 +
 hw/sd/cadence_sdhci.c         | 200 ++++++++++++++++++++++++++++++++++++++++++
 hw/sd/sd.c                    |   9 +-
 include/hw/sd/cadence_sdhci.h |  46 ++++++++++
 5 files changed, 257 insertions(+), 3 deletions(-)
 create mode 100644 hw/sd/cadence_sdhci.c
 create mode 100644 include/hw/sd/cadence_sdhci.h

-- 
2.7.4


