Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B86C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E5D2224A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t641ZX9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E5D2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWcR-0001b6-Ae
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWU-0002Hn-G7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWS-00058v-LM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id j2so6701935wrx.7
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jZ6O2w/Kfi3k/oWIW8f2nmLwv8cNGZxfrT3LHYdaJYc=;
 b=t641ZX9VXlASXLcZFA340Zase/E3gqxmJ14ShHIwOBjeq8wioLtANn4cMcgq7rrSMy
 Mo3MJPgrAW8BXR8w6/MhLelk/LlBFsSBKsym5KYd+2oiSyFALKm1mji5Upiw9nVmuBNQ
 WZOLClNG+saPZOYSPbgMAD6rzw4D/pKSx41q6ZicQVPBsNUr1Ze3YfI+bmypGPi252Ki
 4ci/roBsMn7DFyIZhgDHMiybmqW/EP+3XiaK1PGv4wLukdxgTg3AtjoSG06+Z5Sqd+S4
 p7Tv85W4yGTs2aXsKbUReqpgZpSZVyi+tIOnXpnCrZ4MGxzzkFalp3RCcZt2jvis4NXk
 W2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jZ6O2w/Kfi3k/oWIW8f2nmLwv8cNGZxfrT3LHYdaJYc=;
 b=QvqdqcuTVU7y89oSSYI74adEC0K+4f6nGXUx2mLObnVh1ZiwtTeVHzETvTpEan9E7T
 PRjis30xDVhxJCohS/DDBP8FKLZx2Icgefs7FbJTvddx1LIXThRnZwXmo4hhz64L3kEG
 CpwvS03zUsFc5pPraO6JOQu9dQR+BHL1/MygAHwAGVX+l+jfqUzwLLAbHb65pdkIABwV
 C4VUPY7uQiGkoEmAhHcd9xTIa961XC4AjqxQ3kZcvJMlVRtArED6AqzrLJzBNfjSPq3G
 eFlmBNrYqLX51jLoZ8yw9LUhviG6+qgw2rGlaT/qIQZtMpcCH10vnMTET/7aHwcpaNb7
 f/rg==
X-Gm-Message-State: AOAM533bavbzi9ELWZi8saZAD57JU8bD65/AJ7KtVXNuy/DzhSsxag0u
 pSL+zP9rPcf5ADo5eQ9UardmLw==
X-Google-Smtp-Source: ABdhPJw/2XdJCUhnBDjWPz4ZRcgeBlz4qTD0HJYd3RmqANUQO2kmhJbPC7+dCat3Cgws+NQb42HjOQ==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr27114459wre.275.1600259210472; 
 Wed, 16 Sep 2020 05:26:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 11sm5127743wmi.14.2020.09.16.05.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:26:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 797D01FF7E;
 Wed, 16 Sep 2020 13:26:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 0/8] configure deprecation, linux-user and test fix
Date: Wed, 16 Sep 2020 13:26:40 +0100
Message-Id: <20200916122648.17468-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0bac:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-request' into staging (2020-09-15 14:25:05 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-configure-fixes-160920-1

for you to fetch changes up to 3ffc7f013763bf4fc50c3b403cbacca2bee68cfa:

  configure: add [lm32|unicore32]-softmmu to deprecation logic (2020-09-16 10:07:01 +0100)

----------------------------------------------------------------
configure tweaks for deprecation

  - iotest fix for readlink -f
  - linux-user, report rather than assert on mmap failure
  - clean-up and re-factor the logic
  - add tilegx-linux-user to deprecated_targets_list
  - add [lm32|unicore32]-softmmu deprecated_targets_list
  - add a gitlab deprecated builds test

----------------------------------------------------------------
Alex Bennée (7):
      linux-user: test, don't assert addr != test in pgb_reserved_va
      configure: move deprecated feature processing to supported_target
      configure: also skip deprecated targets with target-list-exclude
      configure: clean-up the target-list-exclude logic
      configure: include tilegx-linux-user in the deprecation logic
      gitlab: create a build-deprecated target
      configure: add [lm32|unicore32]-softmmu to deprecation logic

Max Reitz (1):
      iotests: Drop readlink -f

 configure                | 33 ++++++++++++++++++---------------
 linux-user/elfload.c     |  9 ++++-----
 .gitlab-ci.yml           | 15 +++++++++++++--
 .shippable.yml           |  2 +-
 .travis.yml              |  3 +--
 tests/qemu-iotests/check |  2 +-
 6 files changed, 38 insertions(+), 26 deletions(-)

-- 
2.20.1


