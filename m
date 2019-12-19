Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB506227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiHyCyaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB506227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtOq-0000KI-Ei
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNF-0006Xq-Rk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtND-0007z0-Au
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtND-0007t5-1r
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:39 -0500
Received: by mail-wm1-x335.google.com with SMTP id f129so5106965wmf.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ejtvT2GEst/Jf6ZZBqZIeJaPXeRI7sIRFGbYoqeTEu4=;
 b=XiHyCyaU0NtNMmC0flV8OlbZFoGZjUQpAuQzni+2Ukp1BQf5mjbdukFtxblwTDLzI5
 yyzos0b/vUFlDiHSM1705NOFQvv96DIA0nD5aOsfTf6yUOoKa8snq2gVFIw7e5xVsH0a
 lCLmO9fzlMr231gshJECavR5hGHc66oV9APpuq3ODfbfvHFSScszjoRJyY7YT6sO9iXX
 W+dm/TNz7tFr+7jeB3GvEqIJVx/SXW99KwwbPxX1kHNDezTZvMVZwMpXSBT6JtFh/6Ja
 Fj7aVP3F5qWD3pAVWNk3MH3dMtLSLmXMDdEj4zVSdGhNR5xV2HAvXDGEHEck+OFBf8Qs
 SdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ejtvT2GEst/Jf6ZZBqZIeJaPXeRI7sIRFGbYoqeTEu4=;
 b=RDLPiY8fdhQheFpHP/AcuFchYBOqg76T9YO7PFr9qxVei/pPJFvO87Hqq4CO722leL
 W5+P7ljXrg6cjgwA57r+JoTl1quefQZyHsE5xZ/0javuIV3YmZ8L7430veAxZDBfWYB4
 A4sQRSVbzlNXDdP3wrWbC62XoiKO4uqv7iPcNsJFDb1GFdk2IvnDi7zwTVr6T8uYWdSP
 7fkPSqJDPa3GjApJF9kzsazeY/m3Vj3J1Cz38mhTE7rjddLFKNT4aEo+l3MVngaBTSD4
 +NiGvc6v+n9Xb5ztB0RGyKYaTWKK0P3W1Js2Rv/myOwt48rgb5RvIZ2dyuJ5kToGgVWm
 Xngw==
X-Gm-Message-State: APjAAAWKnxDPFO4txZEC5YrN3Hpg1Xlp9JkUYc2oCPpLr6bGvm0uh1Ao
 YNxwSb9a8/0KycSVLLiTGPDMKg==
X-Google-Smtp-Source: APXvYqyhTZteXKLg9evugx6vUwrf2eYi6CVQIjVALvK7W/xkfyyQNX2f+nlAvR3MFg8M/1jlSniAwg==
X-Received: by 2002:a7b:c342:: with SMTP id l2mr9821893wmj.159.1576752577830; 
 Thu, 19 Dec 2019 02:49:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x17sm5878585wrt.74.2019.12.19.02.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 692E81FF87;
 Thu, 19 Dec 2019 10:49:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/25] testing and logging updates
Date: Thu, 19 Dec 2019 10:49:09 +0000
Message-Id: <20191219104934.866-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-tesing-and-misc-191219-1

for you to fetch changes up to 380976f40f909b735acb60d5d424de7eb1b7107e:

  tests/tcg: ensure we re-configure if configure.sh is updated (2019-12-19 08:20:16 +0000)

----------------------------------------------------------------
Various testing and logging updates

  - test tci with Travis
  - enable multiarch testing in Travis
  - default to out-of-tree builds
  - make changing logfile safe via RCU
  - remove redundant tests
  - remove gtester test from docker
  - convert DEBUG_MMAP to tracepoints
  - remove hand rolled glob function
  - trigger tcg re-configure when needed

----------------------------------------------------------------
Alex Bennée (8):
      configure: allow disable of cross compilation containers
      linux-user: convert target_mprotect debug to tracepoint
      linux-user: convert target_mmap debug to tracepoint
      linux-user: add target_mmap_complete tracepoint
      linux-user: log page table changes under -d page
      linux-user: convert target_munmap debug to a tracepoint
      trace: replace hand-crafted pattern_glob with g_pattern_match_simple
      tests/tcg: ensure we re-configure if configure.sh is updated

Paolo Bonzini (2):
      ci: build out-of-tree
      docker: gtester is no longer used

Robert Foley (6):
      Fix double free issue in qemu_set_log_filename().
      Cleaned up flow of code in qemu_set_log(), to simplify and clarify.
      Add a mutex to guarantee single writer to qemu_logfile handle.
      qemu_log_lock/unlock now preserves the qemu_logfile handle.
      Add use of RCU for qemu_logfile.
      Added tests for close and change of logfile.

Thomas Huth (8):
      travis.yml: Run tcg tests with tci
      iotests: Provide a function for checking the creation of huge files
      iotests: Skip test 060 if it is not possible to create large files
      iotests: Skip test 079 if it is not possible to create large files
      tests/hd-geo-test: Skip test when images can not be created
      tests/test-util-filemonitor: Skip test on non-x86 Travis containers
      travis.yml: Enable builds on arm64, ppc64le and s390x
      travis.yml: Remove the redundant clang-with-MAIN_SOFTMMU_TARGETS entry

Wainer dos Santos Moschetta (1):
      tests/vm: Allow to set qemu-img path

 docs/devel/testing.rst        |   6 ++-
 configure                     |   9 +++-
 include/exec/log.h            |  34 +++++++++++--
 include/qemu/log.h            |  48 +++++++++++++++---
 accel/tcg/cpu-exec.c          |   4 +-
 accel/tcg/translate-all.c     |   4 +-
 accel/tcg/translator.c        |   4 +-
 bsd-user/main.c               |   2 +-
 exec.c                        |   4 +-
 hw/net/can/can_sja1000.c      |   4 +-
 linux-user/main.c             |   2 +-
 linux-user/mmap.c             |  56 ++++-----------------
 net/can/can_socketcan.c       |   5 +-
 target/cris/translate.c       |   4 +-
 target/i386/translate.c       |   5 +-
 target/lm32/translate.c       |   4 +-
 target/microblaze/translate.c |   4 +-
 target/nios2/translate.c      |   4 +-
 target/tilegx/translate.c     |   6 ---
 target/unicore32/translate.c  |   4 +-
 tcg/tcg.c                     |  28 +++++++----
 tests/hd-geo-test.c           |  12 ++++-
 tests/test-logging.c          |  80 ++++++++++++++++++++++++++++++
 tests/test-util-filemonitor.c |  11 +++++
 trace/control.c               |  35 +------------
 util/log.c                    | 100 ++++++++++++++++++++++++++++---------
 .cirrus.yml                   |   8 ++-
 .gitlab-ci.yml                |  28 ++++++++---
 .shippable.yml                |   4 +-
 .travis.yml                   | 112 ++++++++++++++++++++++++++++++++++++------
 linux-user/trace-events       |   6 +++
 tests/docker/common.rc        |   7 +--
 tests/qemu-iotests/005        |   5 +-
 tests/qemu-iotests/060        |   3 ++
 tests/qemu-iotests/079        |   3 ++
 tests/qemu-iotests/220        |   6 +--
 tests/qemu-iotests/common.rc  |  10 ++++
 tests/tcg/Makefile.prereqs    |   2 +-
 tests/tcg/configure.sh        |   6 ++-
 tests/vm/Makefile.include     |   1 +
 tests/vm/basevm.py            |   5 ++
 tests/vm/centos               |   2 +-
 tests/vm/fedora               |   4 +-
 tests/vm/freebsd              |   3 +-
 tests/vm/netbsd               |   3 +-
 tests/vm/openbsd              |   3 +-
 tests/vm/ubuntu.i386          |   2 +-
 47 files changed, 486 insertions(+), 216 deletions(-)

-- 
2.20.1


