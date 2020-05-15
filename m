Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C20C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C282075F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHfGjZZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C282075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbaf-0003xe-KW
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZK-00027U-UA
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:10 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZJ-0000vx-V1
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id j5so3888904wrq.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0DyY3fTt6DB6fwNBq75tYY3fTi8zzs9Jme6cGVMg2A0=;
 b=pHfGjZZ8nevwyvvPvQLxMioQSN20v/t4C65OmcbopoouH39Wg9l9o8cbb9ZL9WOn7G
 KDj8Upjz7CfJtGoUSsPGh7C4a2+LUC4kuvecx4b/LqdY/stBwoT1CBcs8Iyvh5aVve2Y
 keayCGZAWIpvG66BlHVTZtLUPasvml8gaOPA3IfbaLWWrTF9hoLaD26bW1U2WS4cfw4S
 Dxa7PTyzX2uxL3Q60vGVXY4O2O4GJvgAdMGQ6ok2ooL1tD7TicimywbobXJoM6p3EZ8c
 YV/KTcB+3FnIBmVtsGUPqmD/PUa46YH4TPQnbZLMPmWyrWxsXYEIj6+YUIFrByuHtF62
 bhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0DyY3fTt6DB6fwNBq75tYY3fTi8zzs9Jme6cGVMg2A0=;
 b=OmkfAYwtXh3TkJ8ceAAZnpDxmrMNjHR8Mhu5fslNLUlEiXSYO5wcv7pGOpQKiNldro
 O6fI8fFB1wjLzXhKoPA8DrVC1xzrWe890KlefIeISEXHcKoR/5LFH9NtIrJa97MplnjW
 zgZyHOATCi17sR6bTotdkUsZyZ6H6KaVuvbFEv3lBIZZ9iuBlCio9gpvRE3WL0YJfEP2
 A1TtVm6LOl6vt4uSoQiNjR743CfHEw7LNNdEo0sNzSTk6gp6TuxDAT1RhdCX8zWITn9J
 umPcc7LQ9AP5aVNCg0SNYYSX68AGVsDvmfhZzI8DgLztE52nlN/uI8RGVksAQNe2jMnh
 rCZw==
X-Gm-Message-State: AOAM532DLIgw+IQTQBoabRiqeR6fAkvar/ppYWl6VHwml35q01LN+a6Q
 KjueBY7q7L31ECM5J0BmCIp70A==
X-Google-Smtp-Source: ABdhPJzFAGGpPN8koIM+uWN0G2RmEiTesd0vm3NhntjYSvtfKXWcHBfAChFzTd1OZt2P8PDLRJyPlQ==
X-Received: by 2002:adf:a1d7:: with SMTP id v23mr4636733wrv.155.1589553848550; 
 Fri, 15 May 2020 07:44:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q18sm3789313wmk.28.2020.05.15.07.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:44:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 244041FF7E;
 Fri, 15 May 2020 15:44:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 00/13] testing, tcg and plugin updates
Date: Fri, 15 May 2020 15:43:52 +0100
Message-Id: <20200515144405.20580-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2478b8ecd45f81a21b9aa319ce7147a790a2144f:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200515-pull-request' into staging (2020-05-15 11:18:13 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-tcg-plugins-150520-2

for you to fetch changes up to adf1cfbdc29e6e3342ca07701be4d2cbfd7d3907:

  MAINTAINERS: update the orphaned cpus-common.c file (2020-05-15 15:25:16 +0100)

----------------------------------------------------------------
Various testing, tcg and plugin updates

  - fix bug in gdbstub tests that leave hanging QEMUs
  - tweak s390x travis test
  - re-factor guest_base handling
  - support "notes" in disassembler output
  - include guest address notes in out_asm
  - cleanup plugin headers and and constify hwaddr
  - updates MAINTAINERS for cpu-common.c

----------------------------------------------------------------
Alex Bennée (7):
      tests/guest-debug: catch hanging guests
      linux-user: completely re-write init_guest_space
      accel/tcg: don't disable exec_tb trace events
      disas: include an optional note for the start of disassembly
      disas: add optional note support to cap_disas
      translate-all: include guest address in out_asm output
      MAINTAINERS: update the orphaned cpus-common.c file

Philippe Mathieu-Daudé (3):
      qemu/plugin: Trivial code movement
      qemu/plugin: Move !CONFIG_PLUGIN stubs altogether
      qemu/qemu-plugin: Make qemu_plugin_hwaddr_is_io() hwaddr argument const

Richard Henderson (2):
      exec/cpu-all: Use bool for have_guest_base
      accel/tcg: Relax va restrictions on 64-bit guests

Thomas Huth (1):
      travis.yml: Improve the --disable-tcg test on s390x

 include/disas/disas.h         |   2 +-
 include/exec/cpu-all.h        |  25 ++-
 include/exec/log.h            |   4 +-
 include/qemu/plugin.h         |  65 +++---
 include/qemu/qemu-plugin.h    |   2 +-
 linux-user/qemu.h             |  31 ++-
 target/alpha/cpu-param.h      |  15 +-
 accel/tcg/translate-all.c     |  54 ++++-
 bsd-user/main.c               |   4 +-
 disas.c                       |  37 +++-
 linux-user/elfload.c          | 503 +++++++++++++++++++++---------------------
 linux-user/flatload.c         |   6 +
 linux-user/main.c             |  27 +--
 plugins/api.c                 |   4 +-
 tcg/tcg.c                     |   4 +-
 .travis.yml                   |  18 +-
 MAINTAINERS                   |   1 +
 accel/tcg/trace-events        |   8 +-
 tests/guest-debug/run-test.py |   6 +
 19 files changed, 424 insertions(+), 392 deletions(-)

-- 
2.20.1


