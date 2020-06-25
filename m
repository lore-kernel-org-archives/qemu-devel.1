Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0430EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C3C2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5zLbafZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C3C2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joN0p-0006Tm-2E
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 04:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1joMzC-0004NX-HO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:11:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:38070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1joMzB-0004ve-2n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:11:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id d10so2483027pls.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/lmFz+/5EWhAeuE8pWX/NhEtF7RqvrziGaP6CzN97uQ=;
 b=o5zLbafZEXnc9ZrtZd7IRy/BUE/C3bZQLbyJ46kwvdgeWO/FwGttD0+FdV46lZmjK1
 Rlv6WwKBScpclY0xbvMmHqjtZr4MwPLKDXJ+Reu78gvFsqFiuVqvfW0B8kgMRaeMRTuS
 4B/MovkbkV+yCqhJ0znezWHq2JGm1oZBNVvIefY8TiKz08mJqiri8tRyV1P8rR8P8Cfg
 TuBYJ6bPk2NIvFfjmsgelZOvLOdf+A83hHhHkBT+YlhIN3vJqSLO9g3auqBwBWTj+wtr
 6G6pZ+egg0TJmzBnCNJWznhIIS3Ty5V2CbfQKJbofacuOutJxHs87wYs+xge0HAVq+6Z
 8o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/lmFz+/5EWhAeuE8pWX/NhEtF7RqvrziGaP6CzN97uQ=;
 b=jQ9lr6CagCI8uWPv3vJFxaXuT/TqAOpj28oSlBmdC43u+v4sfigOmU9vOzLv4CAtMJ
 HRH4A8q26qkkbkOYe6ax7Rup9B/jwFJx62FR59h9Kh2mpCAYcOZUgc1YPJKcmlv1CJfg
 m7jKLM/3RFNZbe5nK/Sduua3QvCSsqJdSNQF6ZE/iW5+qLnllBdCs+ALRQoUq7Z2PE2G
 DP/CDtXD12nAxxvUZ0yJTllp6GIH05jjbkGc4EkAiDRGJltcV2+ZMI9u70gtTpMsbyXN
 HOZYsSMQuyrFYuecAVZcIWzk9p9O0O75ggLBynqkUpbfjMgDPxfLtitWRSDSG2BbCgD4
 mcxw==
X-Gm-Message-State: AOAM532CVH/uToG1eQ//jpdKCbS/KD9KDT8KvqAZxD7d8qNvW2mSkNHm
 NzW+UF1cPTcequNVmIkc+WQN6ZGe
X-Google-Smtp-Source: ABdhPJynunLT/ITNZgqOnCJTcK214zTKF5A4gX+Xrh8spW7oUmimTNRtd90ShvCkGxDv3mQFPYX6ig==
X-Received: by 2002:a17:902:7208:: with SMTP id
 ba8mr32550397plb.217.1593072711148; 
 Thu, 25 Jun 2020 01:11:51 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:dc59:7b7e:f4cf:4ab8])
 by smtp.gmail.com with ESMTPSA id k92sm7184001pje.30.2020.06.25.01.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 01:11:50 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] target/xtensa fixes
Date: Thu, 25 Jun 2020 01:11:33 -0700
Message-Id: <20200625081133.446-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x62e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

please pull the following batch of fixes for the target/xtensa.

The following changes since commit 648db19685b7030aa558a4ddbd3a8e53d8c9a062:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2020-04-29' into staging (2020-04-29 15:07:33 +0100)

are available in the Git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20200625-xtensa

for you to fetch changes up to 8a3a81478dcc592518069125a6ad271fe5511b95:

  target/xtensa: drop gen_io_end call (2020-06-22 03:38:30 -0700)

----------------------------------------------------------------
target/xtensa fixes for 5.1:

- fix access to special registers missing in the core configuration;
- fix simcall opcode behavior for new hardware;
- drop gen_io_end call from xtensa translator.

----------------------------------------------------------------
Max Filippov (4):
      target/xtensa: work around missing SR definitions
      target/xtensa: fetch HW version from configuration overlay
      target/xtensa: fix simcall for newer hardware
      target/xtensa: drop gen_io_end call

 target/xtensa/cpu.h          |  1 +
 target/xtensa/overlay_tool.h |  8 +++---
 target/xtensa/translate.c    | 60 +++++++++++++++++++++++++++++---------------
 3 files changed, 46 insertions(+), 23 deletions(-)

-- 
Thanks.
-- Max

