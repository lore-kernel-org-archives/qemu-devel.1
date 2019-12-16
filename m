Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA2EC2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE85206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3Px4neg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE85206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoFP-0006oQ-2i
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoDy-00059m-IP
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoDx-0003Sr-CR
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:38 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoDx-0003OW-64
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:37 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so6219078wma.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z/yAMxTAOXzQdowAYSyEQz+KmYwG/8lzp4QerstC74U=;
 b=R3Px4neg8Jrs5sEqgsAe0/f2l7Occ3yWPU/OG3ZPJXqXeBP8MCj5Q2QZKckmS0VNJd
 MW3ltrypS++k539omMsMz8Z9qIAwCIak4dY9x9409b0DEVmqNvrglyL5owsuKYuDLQyF
 6NwjjqLnITnT1LxeUz3c0ZMXzypasflY3rheOJg2lzYft07RKuGrEN7a5QKJMScBL+T7
 3jyzCa4/38hKWChQ2zMNL4TDD7AMgNrGlKOcm3dulO3ZwWLw6TsKSUqRcrt8jc4sVOMm
 LBYs30Y2dT5L8+JCPkrd8xrQ8MhmyLJi5hIrmd/d9DmG8zb9gKFsz5GohJTsGDox6b8b
 VL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z/yAMxTAOXzQdowAYSyEQz+KmYwG/8lzp4QerstC74U=;
 b=ne1D2FX2CoxIHl9W/fZxhjjnTMdG2Gth8yOxC6R90TGuJ1tEg1sitjOuti5X0b6OKw
 xQL2OWqwg8Dp5NWLXabcxfZ3aRvSHBJhJ9cbg2UAQPuGGpv/OSyQ1XSKoSZv54VFzeTd
 auAYGIQczCFsox59sFg+++gonY6/PHn5vnhi6h2tM2OX/AMcmCNXIGlbxdVZkx3ovAXH
 yWwkDWNnDtekd0KjWPQHV2wbTnEZAdwhBA6ogA49h0OtIk1MC+ywGsdwEGeP48+8uGIE
 MyiOpxOg5TbI4oltEUCbjfJbKFZ+FcFXCpwyU9AWRu5hlMMj+9YZaYRbNm7t7ub90/gO
 pJ6A==
X-Gm-Message-State: APjAAAXS5SZpcDD0ZL7iDX2NbxrPEW4REmaLMtA8GEqyi9hhhgHIwi2n
 Az0s8WuYa+hxVfa761JPUcENAA==
X-Google-Smtp-Source: APXvYqyoFsyL2cutxTggf3qDr+OOkW0Oz1q3z+xfrTZjKh+r4xd51RDP+krn1dUIjRTEOyWyezyQYA==
X-Received: by 2002:a1c:1dd7:: with SMTP id d206mr28916243wmd.5.1576494455553; 
 Mon, 16 Dec 2019 03:07:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm21124370wrr.80.2019.12.16.03.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:32 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 15F3A1FF87;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/16] testing and logging changes for master
Date: Mon, 16 Dec 2019 11:07:16 +0000
Message-Id: <20191216110732.24027-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series will be my first post 4.2 PR this week. It contains a
number of testing related fixes including enabling builds for arm64,
ppc64 and s390x hosts. We also start defaulting to out-of-tree builds
in anticipation of it's deprecation.

As there is no obvious tree for logging changes I've also included
Robert's RCU series which makes the changing the the output logfile
safe and atomic.

Everything has already had a fair bit of review but if you want to
have a look be my guest. I plan to send the PR by the end of the week.

Alex Bennée (1):
  configure: allow disable of cross compilation containers

Paolo Bonzini (1):
  ci: build out-of-tree

Robert Foley (6):
  Fix double free issue in qemu_set_log_filename().
  Cleaned up flow of code in qemu_set_log(), to simplify and clarify.
  Add a mutex to guarantee single writer to qemu_logfile handle.
  qemu_log_lock/unlock now preserves the qemu_logfile handle.
  Add use of RCU for qemu_logfile.
  Added tests for close and change of logfile.

Thomas Huth (7):
  travis.yml: Run tcg tests with tci
  iotests: Provide a function for checking the creation of huge files
  iotests: Skip test 060 if it is not possible to create large files
  iotests: Skip test 079 if it is not possible to create large files
  tests/hd-geo-test: Skip test when images can not be created
  tests/test-util-filemonitor: Skip test on non-x86 Travis containers
  travis.yml: Enable builds on arm64, ppc64le and s390x

Wainer dos Santos Moschetta (1):
  tests/vm: Allow to set qemu-img path

 docs/devel/testing.rst        |   6 +-
 configure                     |   9 ++-
 include/exec/log.h            |  33 +++++++++--
 include/qemu/log.h            |  48 ++++++++++++---
 accel/tcg/cpu-exec.c          |   4 +-
 accel/tcg/translate-all.c     |   4 +-
 accel/tcg/translator.c        |   4 +-
 exec.c                        |   4 +-
 hw/net/can/can_sja1000.c      |   4 +-
 net/can/can_socketcan.c       |   5 +-
 target/cris/translate.c       |   4 +-
 target/i386/translate.c       |   5 +-
 target/lm32/translate.c       |   4 +-
 target/microblaze/translate.c |   4 +-
 target/nios2/translate.c      |   4 +-
 target/tilegx/translate.c     |   6 --
 target/unicore32/translate.c  |   4 +-
 tcg/tcg.c                     |  28 +++++----
 tests/hd-geo-test.c           |  12 +++-
 tests/test-logging.c          |  80 +++++++++++++++++++++++++
 tests/test-util-filemonitor.c |  11 ++++
 util/log.c                    | 100 ++++++++++++++++++++++++--------
 .cirrus.yml                   |   8 ++-
 .gitlab-ci.yml                |  28 ++++++---
 .shippable.yml                |   4 +-
 .travis.yml                   | 106 +++++++++++++++++++++++++++++++---
 tests/qemu-iotests/005        |   5 +-
 tests/qemu-iotests/060        |   3 +
 tests/qemu-iotests/079        |   3 +
 tests/qemu-iotests/220        |   6 +-
 tests/qemu-iotests/common.rc  |  10 ++++
 tests/tcg/configure.sh        |   6 +-
 tests/vm/Makefile.include     |   1 +
 tests/vm/basevm.py            |   5 ++
 tests/vm/centos               |   2 +-
 tests/vm/fedora               |   4 +-
 tests/vm/freebsd              |   3 +-
 tests/vm/netbsd               |   3 +-
 tests/vm/openbsd              |   3 +-
 tests/vm/ubuntu.i386          |   2 +-
 40 files changed, 465 insertions(+), 120 deletions(-)

-- 
2.20.1


