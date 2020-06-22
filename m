Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFAEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D472073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8jyAKDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D472073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNZY-00057F-HZ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUc-0006sa-1e
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUX-0005eA-Pe
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id j18so1550025wmi.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2TP59sqRa7ULiuhCAr8UN3lNhG3MyXFocIyac3d81uM=;
 b=B8jyAKDXjne3qOU/amyQVFR19dSgKlZUYG73ypDwzXxGE9m2LBUKo5ZU4TCGgOzBl+
 VsEm92bD1Vx4b3TEl1P4GBnfu0kA1yjP7u7ow0HP7cQyv9t4B5YX0022q5z/3RZkm6Ye
 pnDgp7XbdsfvcSDUA+hsH7/kJULZVhL73+YMc6nZCit4zfmP5bKfoGpiKIepqKkk90tk
 eK/2NSIMIWeFxqKgxix6gMBG1wCmguFodiD+y0RILWbFpaJMZbDXcdb+rya+mnwioAFO
 Z/0V/apq1AvnKn47ZWZsdJdl4heUzsvVo8RmthEqt5KtvbDJCC6V3TeQ9Ewzq+DkfK9q
 ywcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2TP59sqRa7ULiuhCAr8UN3lNhG3MyXFocIyac3d81uM=;
 b=OYdnAKQztiU8MQ57TElUta6lBQJcQV73yRFjb1xI70hXDS8xsoEu0lu2xyhhnHF/Qn
 uhduJxQl4CN3kLx6Av9JufIt1QInbYkjLyS5Qdoa5H8CRoAhnF/XypT7MdUTPQcBAEjP
 BWOdP/5YfmZ+IdfTa8ZTWeGuTsR2ynuWkyuceXggC5zW5fJwi5D5hKGXacCStrC94ptW
 KjPtJYoFEb2QjaSAZuPAIymDlmiV2ttIWZffzSegeotoMfcgEgpCGKXU8V4RNoCKxrId
 +GM4qaSZna92x85KDdCNBqDaeY3k0LaD2urtrRxHMC6XdHlfOKi5Z77uYySgt/ylp3L7
 0/yg==
X-Gm-Message-State: AOAM530CQiJ4H/ABWu8I4SFIuGGQQuGzgI2HaI4RkjJwV8G8RUBqGJJK
 5Aa+NRa3t0rdmtl5dqIHUhXFvA==
X-Google-Smtp-Source: ABdhPJy2djkyIgOyrSHMTj8QFeknCEKEUaHpnWn3OxsDwfxt97iNDdc3QvZk9FKkFMSGGQBe04YShg==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr18015641wmh.98.1592836327955; 
 Mon, 22 Jun 2020 07:32:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u4sm18570781wmb.48.2020.06.22.07.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:32:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B70AE1FF7E;
 Mon, 22 Jun 2020 15:32:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/18] testing/next (vm, gitlab)
Date: Mon, 22 Jun 2020 15:31:46 +0100
Message-Id: <20200622143204.12921-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current state of my testing/next queue. In brief:

  - tests/vm updates for aarch64 VMs
  - moving check-acceptance to gitlab
  - some minor fixes going in via other trees

Most of tests/vm are well reviewed but I added a few clean-ups that
need review alongside the gitlab stuff:

 - .gitlab: add avocado asset caching
 - .gitlab: tag remaining jobs as builds
 - .gitlab: split fedora-misc-disabled
 - .gitlab: add acceptance testing to system builds
 - .gitignore: un-ignore .gitlab-ci.d
 - tests/docker: check for an parameters not empty string
 - tests/vm: allow us to take advantage of MTTCG
 - tests/vm: switch from optsparse to  argparse

Alex Bennée (8):
  tests/vm: switch from optsparse to  argparse
  tests/vm: allow us to take advantage of MTTCG
  tests/docker: check for an parameters not empty string
  .gitignore: un-ignore .gitlab-ci.d
  .gitlab: add acceptance testing to system builds
  .gitlab: split fedora-misc-disabled
  .gitlab: tag remaining jobs as builds
  .gitlab: add avocado asset caching

Philippe Mathieu-Daudé (1):
  iotests: Fix 051 output after qdev_init_nofail() removal

Robert Foley (9):
  tests/vm: pass args through to BaseVM's __init__
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: Add common Ubuntu python module
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config
  python/qemu: Add ConsoleSocket for optional use in QEMUMachine
  tests/vm: Add workaround to consume console

 configure                         |  29 +++
 .gitignore                        |   2 +-
 .gitlab-ci.yml                    | 149 +++++++++++++-
 .travis.yml                       |  23 ---
 python/qemu/console_socket.py     | 110 ++++++++++
 python/qemu/machine.py            |  23 ++-
 tests/docker/common.rc            |   2 +-
 tests/qemu-iotests/051.pc.out     |   4 +-
 tests/vm/Makefile.include         |  22 ++
 tests/vm/aarch64vm.py             | 106 ++++++++++
 tests/vm/basevm.py                | 332 ++++++++++++++++++++++--------
 tests/vm/centos-8-aarch64.ks      |  51 +++++
 tests/vm/centos.aarch64           | 227 ++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 +++++
 tests/vm/conf_example_x86.yml     |  50 +++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +-
 tests/vm/openbsd                  |  17 +-
 tests/vm/ubuntu.aarch64           |  68 ++++++
 tests/vm/ubuntu.i386              |  46 ++---
 tests/vm/ubuntuvm.py              |  60 ++++++
 22 files changed, 1230 insertions(+), 194 deletions(-)
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64
 create mode 100644 tests/vm/ubuntuvm.py

-- 
2.20.1


