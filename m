Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A18C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BE5207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lu8yuuTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BE5207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxV0-0006MS-D2
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSQ-0001iD-2e
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSO-00086H-Hr
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id u12so3331951wmd.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qfpC1/RfjHmpaXuQbpPq1egtyaXkQ0oE2W1wEaMuX3Y=;
 b=Lu8yuuTmnss4Mx8X1r9hND/0vJqDYx5qjgy7vPH7trGSA2x1ZM/dfT8PaNN/6MzCF9
 F9VgXcGsG+p9p47Ot9pkIkCIR8jq1FZ+6nK5ayJMTMA60JKmbHq6J3P8cHnbphfimz0G
 1A7mBuHM1p3NJWeGUsl3PR4bIPq0xphi8Q+KKJEsykEgGdyqZ61TTujz6REyKsjf0BZB
 8qzxKAx0Y8K04OmXpTJnuCqtLAaf52EUdk5GtwNjDWAhGJGKaNubas2NJNluNQ+E4OZh
 Vfh3tHpw5up9clqNERikSVlzJkyr6SbqUl5CuBYRJcZKpTy4tbVve/xXJECuuWiB1JZt
 KpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qfpC1/RfjHmpaXuQbpPq1egtyaXkQ0oE2W1wEaMuX3Y=;
 b=MWXf9OOf09GwMJSu9zsHFZI5W4czEyCRsZh9cxS8rhdpfHVwugfha+lG5gWUenAItT
 OXuGwGEzAHKT5q35LU3QmVXBDqR/aABat9AcmkQ8mmLwgnSEDXmOtT7NIDyuYENyl3yD
 incXdc3n6rlkDMvCCPJGsnvbzOIpEwhzlxs04hVPxZFulozWvPWDYMNVDbUWa+Cq8Ew/
 DZgpvoX+oMiNU1M6D44WlCZyYtJgydi4kF9Q9oE2jXDoagWFAhKX9/ilmUlSwwnVdg18
 oUfqfNp1jKO2IxkyRa64IqxlQmum0qNv+ymbz42GDrYwzsDCWjf5qYZrqP6tIkhANP14
 Rpqw==
X-Gm-Message-State: AOAM530H9XPQiNZG1ayHiGSIFHko+w18LLloZABA8sEje2kT1FatfQsz
 +JpVnD2fMVNGMHEdDEnwHVAyjA==
X-Google-Smtp-Source: ABdhPJw5YaDUK0+NlMhAvmxYOAH4sFv4tqtQwJYoWIiua3n343QWvkupt8J7Fj0hZqFFRjaRzyxnHw==
X-Received: by 2002:a1c:a901:: with SMTP id s1mr4931395wme.66.1590591298775;
 Wed, 27 May 2020 07:54:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u130sm3143568wmg.32.2020.05.27.07.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:54:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 03BD81FF7E;
 Wed, 27 May 2020 15:54:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/12] testing and plugin fixes
Date: Wed, 27 May 2020 15:54:43 +0100
Message-Id: <20200527145455.2550-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:

  Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' into staging (2020-05-26 14:05:53 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-tcg-plugins-270520-1

for you to fetch changes up to 919bfbf5d6569b63a374332292cf3d2355a6d6c3:

  tests/tcg: add new threadcount test (2020-05-27 14:26:49 +0100)

----------------------------------------------------------------
Testing and one plugin fix:

  - support alternates for genisoimage to test/vm
  - add clang++ to clang tests
  - fix record/replay smoke test
  - enable more softfloat tests
  - better detection of hung gdb
  - upgrade aarch64 tcg test x-compile to gcc-10
  - fix plugin cpu_index clash vs threads

----------------------------------------------------------------
Alex Bennée (11):
      configure: add alternate binary for genisoimage
      tests/vm: pass --genisoimage to basevm script
      tests/tcg: fix invocation of the memory record/replay tests
      tests/fp: enable extf80_le_quite tests
      tests/fp: split and audit the conversion tests
      tests/tcg: better detect confused gdb which can't connect
      tests/docker: add debian11 base image
      tests/docker: use a gcc-10 based image for arm64 tests
      cpus-common: ensure auto-assigned cpu_indexes don't clash
      linux-user: properly "unrealize" vCPU object
      tests/tcg: add new threadcount test

Thomas Huth (1):
      travis.yml: Use clang++ in the Clang tests

 configure                                          |  2 +-
 cpus-common.c                                      | 10 ++--
 linux-user/syscall.c                               | 19 ++++---
 tests/tcg/multiarch/threadcount.c                  | 64 ++++++++++++++++++++++
 .travis.yml                                        |  8 ++-
 tests/Makefile.include                             | 44 +++++++++++----
 tests/docker/Makefile.include                      |  4 +-
 .../dockerfiles/debian-arm64-test-cross.docker     | 13 +++++
 tests/docker/dockerfiles/debian11.docker           | 18 ++++++
 tests/tcg/aarch64/Makefile.softmmu-target          |  2 +-
 tests/tcg/configure.sh                             |  4 +-
 tests/tcg/multiarch/Makefile.target                |  2 +
 tests/tcg/multiarch/gdbstub/sha1.py                |  4 ++
 tests/vm/Makefile.include                          |  1 +
 tests/vm/basevm.py                                 | 16 ++++--
 15 files changed, 172 insertions(+), 39 deletions(-)
 create mode 100644 tests/tcg/multiarch/threadcount.c
 create mode 100644 tests/docker/dockerfiles/debian-arm64-test-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian11.docker

-- 
2.20.1


