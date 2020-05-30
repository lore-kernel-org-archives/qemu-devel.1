Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3D4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EDE206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGO+MTNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EDE206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jexin-0003Ye-9v
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 05:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexhv-0001pn-WC; Sat, 30 May 2020 05:23:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexhv-00072o-54; Sat, 30 May 2020 05:23:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id c71so6082236wmd.5;
 Sat, 30 May 2020 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0BryIsjSR/5V7bP3W0yw7l1w1v5MD2AAAY9d6x1HNm4=;
 b=pGO+MTNgZEYJY0yaXbj9toTPQaha0phuMTaAcBrQYh5TWlcXHoP8siHcI5y71TvLBT
 Wim3AIa7prvUF1Cy/G2p/+w7Yoh7hKqr1ukRevkLqojluw031S6KGTsbZRyToOcbNrfm
 JOl0Vkn2c89ySBKYOMHtQoFrsO0YZkLJLD9HBjeiffGFekXITgOIy4y/FLwjdAJUtRcZ
 auz4ytnFj/tzeMEbfmaEq5vefZyjhG60rolZblYzx1Sskq1McpcGMWt9s0zpLiWAYY7G
 Ztp0ACAWgNdhgLcy6cKcxqMeXHGiEyQCe49s0WD/6NDzYXsWycdkEuS3Ohq5y6ZQKWTu
 ehvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0BryIsjSR/5V7bP3W0yw7l1w1v5MD2AAAY9d6x1HNm4=;
 b=lZV6gjR3HoBFkT58ookZ65JCCo8ursE78gtWtNrtdH8mrRGTETlsLX9yGsjZPkdGTo
 7FExHeN35DJKe3zQMHmXWN+9Nf2ZHy2JXrpvfNdCsIN3HN4qipfZhzLovzW7N/PI9T84
 vMXETZW/XNjPqwyhQ3uLxmSL8xB3Ei8mUuPHi02XbY9oq32vjMZqRK4N7rTxY7T/aA5G
 yDFpiggE1PK9QHQgaH1tuGblhps6o54AkxIjQrcUPUiLmNBcsBSoKtM1OWgnJr+cfWrf
 MJpiLEe3Vf60dOJzy1iOoLibZfbn4VcGhZAMe326jzA+amGkWOWijWsmTc4Wuc6AgeXk
 e62Q==
X-Gm-Message-State: AOAM5337QesUZjkK/4yjM0R+7GgQezCEwzDsQZpWw2La8dLNLpgcpLYk
 B7AlVsjZZrX1J4UdPArP/ExLAwxf
X-Google-Smtp-Source: ABdhPJwctA6t6MzIQprQ8OXJ6q/ql6rq69SV8kBpcEmSEyQ7h/VHiRdTmLe4DIUxWvBvINsh3LtZvw==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr5387647wme.62.1590830588612; 
 Sat, 30 May 2020 02:23:08 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id h1sm3195237wme.42.2020.05.30.02.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 02:23:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/sh4: current patch queue
Date: Sat, 30 May 2020 11:23:01 +0200
Message-Id: <20200530092306.26628-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

As there is no SH4 active maintainer, I gathered various
patches in a single series, in case someone is willing to
apply them.

CI report:
https://travis-ci.org/github/philmd/qemu/builds/692828388

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  hw/sh4: Use MemoryRegion typedef
  hw/sh4: Extract timer definitions to 'hw/timer/tmu012.h'
  hw/timer/sh_timer: Remove unused 'qemu/timer.h' include

Thomas Huth (2):
  tests/acceptance: Add boot tests for sh4 QEMU advent calendar image
  .travis.yml: Test SH4 QEMU advent calendar image

 include/hw/sh4/sh.h                    | 12 +-----------
 include/hw/timer/tmu012.h              | 23 +++++++++++++++++++++++
 hw/sh4/sh7750.c                        |  1 +
 hw/timer/sh_timer.c                    |  3 ++-
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 13 +++++++++++--
 6 files changed, 39 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/timer/tmu012.h

-- 
2.21.3


