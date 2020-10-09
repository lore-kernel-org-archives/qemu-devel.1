Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20201C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8079622251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rw5+s/Y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8079622251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvir-0002ge-Az
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJB-0008NE-Qo
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:31:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:34628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJ9-00058M-6K
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:31:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id l15so9325028wmh.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z/3FJnBAJGBqxaPVww8H3rWV4h9ZpETTH3GSqWuzYus=;
 b=rw5+s/Y6vcTut6CHUf/1KSnxFtLMclfvu3wStQqa9PnciiAjJN7rHwTU0qBIoCWWzk
 wsUVSR9IdEUa5hTEgB3jMQaXG2o2wcsTAERbnrbHuzjIwTWrb5oXHFvLIsGDF0wMYNex
 NbzBzmJQwxHp1aeewCQ2UvjCJtJEbzFk8L3GPIQGaIYNP8N7XhOlP4No6IxZPNXIqIM9
 FBW4VXa2Yf4zTTdrRHbxORMRSftFVCfYpXdOa/ETF2w1i95DST2jnF1GfsbruNuX0yon
 nEXOQUdmzjEQruy+OzSry+wOBDDwhUwSv4KX2FxJuf6hpJNvZ9plnPLsYxfD2hhUuCAn
 cu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z/3FJnBAJGBqxaPVww8H3rWV4h9ZpETTH3GSqWuzYus=;
 b=h0npknCpMGhNY63xSIjUhzfliNLboq7vOddgK40zpHL97wkWufUmpyYJCJD3cDFUUU
 FUwaZaiVlcUpvXbYJ5gbzCn/vqvxKMOseb92zBlGHlGEri2gTlHU4JI6ZBGJzhGN+VsW
 862kLcHFbpnoJfDuiDy7REHaDLA2Chq7j/upboIMMv6AylF3DbA/Lt5h2ZGks1PXQdM7
 +OqOjw2ncaeRtm12Gh8RUJBhhRYSZOnHgaSLy6clOi+7/tH7EEvK5aAwJTObPkImqdxu
 I2koKdUTsis99FdeJ6UooS2cfWAl2X1rfDlmrnQ8wnl02jqbSERZ7Fzu1b6VC66uIuIL
 LrKg==
X-Gm-Message-State: AOAM5328yVNftNNokTnJ1ymP2QHnq6aMwHPXczi3WRDCDJ2iCbrO/wRq
 XpCFcS2UXoPfZg+nPejhrPsw0w==
X-Google-Smtp-Source: ABdhPJwf9zqpqowyjNtrx4w7XUCpmK2iVd9gdeVAw7P1A2WwtvfW2riyf6zwaowak5fwvlhKsHdvqg==
X-Received: by 2002:a1c:b78a:: with SMTP id
 h132mr15211997wmf.172.1602261109235; 
 Fri, 09 Oct 2020 09:31:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q9sm12806167wrd.57.2020.10.09.09.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 16A341FF7E;
 Fri,  9 Oct 2020 17:31:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/22] acceptance regressions, testing, gitdm, plugins
Date: Fri,  9 Oct 2020 17:31:25 +0100
Message-Id: <20201009163147.28512-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit 4a7c0bd9dcb08798c6f82e55b5a3423f7ee669f1:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20201009' into staging (2020-10-09 15:48:04 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-various-091020-1

for you to fetch changes up to e5d402b28f1a325d46b7b0f08d04257f618e6d03:

  tests/acceptance: disable machine_rx_gdbsim on GitLab (2020-10-09 17:27:55 +0100)

----------------------------------------------------------------
Testing, gitdm and plugin fixes:

  - fix acceptance regressions in MIPS and IDE
  - speed up cirrus msys2/mingw builds
  - add genisoimage to more docker images
  - slew of gitdb updates
  - fix some windows compile issues for plugins
  - add V=1 to cirrus output
  - disable rxsim in gitlab CI

----------------------------------------------------------------
Alex Bennée (2):
      hw/ide: restore replay support of IDE
      tests/acceptance: disable machine_rx_gdbsim on GitLab

Paolo Bonzini (2):
      configure: fix performance regression due to PIC objects
      cirrus: use V=1 when running tests on FreeBSD and macOS

Philippe Mathieu-Daudé (13):
      hw/misc/mips_cpc: Start vCPU when powered on
      contrib/gitdm: Add more academic domains
      contrib/gitdm: Add more individual contributors
      contrib/gitdm: Add Baidu to the domain map
      contrib/gitdm: Add ByteDance to the domain map
      contrib/gitdm: Add Google to the domain map
      contrib/gitdm: Add Nuvia to the domain map
      contrib/gitdm: Add Qualcomm to the domain map
      contrib/gitdm: Add Nir Soffer to Red Hat domain
      contrib/gitdm: Add SUSE to the domain map
      contrib/gitdm: Add Yadro to the domain map
      contrib/gitdm: Add Yandex to the domain map
      .mailmap: Fix more contributor entries

Thomas Huth (1):
      tests/docker: Add genisoimage to the docker file

Yonggang Luo (4):
      cirrus: Fixing and speedup the msys2/mingw CI
      cirrus: msys2/mingw speed is up, add excluded target back
      plugins: Fixes a issue when dlsym failed, the handle not closed
      plugin: Fixes compiling errors on msys2/mingw

 configure                                    |   1 +
 contrib/plugins/hotblocks.c                  |   2 +-
 hw/ide/core.c                                |   4 +-
 hw/misc/mips_cpc.c                           |   1 +
 plugins/loader.c                             |   1 +
 tests/plugin/bb.c                            |   4 +-
 .cirrus.yml                                  | 121 ++++++++++++++++-----------
 .mailmap                                     |   2 +
 contrib/gitdm/domain-map                     |  10 ++-
 contrib/gitdm/group-map-academics            |   4 +
 contrib/gitdm/group-map-individuals          |   7 ++
 contrib/gitdm/group-map-redhat               |   1 +
 tests/acceptance/machine_rx_gdbsim.py        |   1 +
 tests/docker/dockerfiles/centos8.docker      |   1 +
 tests/docker/dockerfiles/debian-amd64.docker |   1 +
 tests/docker/dockerfiles/fedora.docker       |   1 +
 tests/docker/dockerfiles/ubuntu2004.docker   |   1 +
 17 files changed, 107 insertions(+), 56 deletions(-)

-- 
2.20.1


