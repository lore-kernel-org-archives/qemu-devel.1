Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37114C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F357A20721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qk39QB5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F357A20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeez7-0003yG-6s
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeeyK-00035i-3y
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:22:52 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeeyI-00038d-EH
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:22:51 -0400
Received: by mail-pl1-x644.google.com with SMTP id bg4so1163654plb.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WUZT8MmOayZGLSCYKoc1qodVCAWn7YuXqviDoocPmbE=;
 b=qk39QB5SZxtjxxmxaGGuXThdjRLQm7aj/9L6/Ud2yo5TeIbBv5WvoTpe3iUYulhF6E
 jWYvp+8iMY9x3HzTGQ7vRMxVjWocnMFkiEFcoLI+zMUaCW9wSOIuiRsgjA8SNFJ5u1gp
 KQ5xRfeE5899EeiZGYHQEzf24dou4ulRS6LtbweQqgWfjuZB8F8uz4JeXc685j0B8WeH
 a5vAaQywnuisX9l5+W81ItDo7zFtj599A/O6+l62qqhVUUrS+DgIs9Xrom813z2CqJre
 bEc7OmfRZIsARUGba7l4uut7kN9CkZ58l0ARPjtIxNACBkFcCb6hpkVTCyvD290HC9Wh
 Pw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WUZT8MmOayZGLSCYKoc1qodVCAWn7YuXqviDoocPmbE=;
 b=q0iBiMqvizvrzPkZHD7vOALFbujbOfi0QJT//PvSPZa0S9czvo1Rj9JvYbPobbQVEH
 LQL2hF3hcqn17vOrF2nUFM8e2guhLHPILxnNtNHH7c7WO6fHBns865VMdywv93Lfewcu
 DuR1SnR+KL0B8VR1jKyA6pOY/GaBj0uSEcGwwJzlsV3ETn+aZPeUayWYg3LuN9C4QbIn
 IPLRPGA3CtO9jF/6OVfwgbKss3xMk08W3yMdsBZ52I8aKTLoEFIInTFDdAojihEbSz9+
 ri8SopDMvJ1I1F9AFzBSsJ3OchXUaQGhh2AkqRDB7EuIgbRvnloYPCbpqgjarVNGOvj5
 T2mA==
X-Gm-Message-State: AOAM5304tFSTLEUSTDz+CTdlR24SwEtcJO1D2J4GxQdhg5Bh7pz4oO3Z
 jalE2pAk8UB/IXPkU38q4jQASpS8OXBphA==
X-Google-Smtp-Source: ABdhPJyJ7TkjVJDOpzaIIvB5NzcjSokPjC0kWgwfKZiupHzOV4d20gI738QYmEF3Mgep4p18eJ7lPA==
X-Received: by 2002:a17:90a:d191:: with SMTP id
 fu17mr9696225pjb.228.1590758567768; 
 Fri, 29 May 2020 06:22:47 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e16sm6946374pgg.8.2020.05.29.06.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:22:46 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 00/12] Add Thread Sanitizer support to QEMU
Date: Fri, 29 May 2020 09:21:43 -0400
Message-Id: <20200529132143.702-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes in v1:
- Refocused the patch more on enabling TSan and less on removing warnings.
- Because of this we removed several patches from the series that
  were fixing and/or suppressing warnings.
- Removed from the series some patches that had overlap with the
  per-cpu-lock patch.  We will let the per-cpu-lock patch fix those warnings.
- Removed built-in support for blacklist.   
  The idea here being that all warnings should eventually be fixed and
  this blacklist is for test/debug.
- Enhanced the documentation on TSan support in testing.rst.
- Improved the comments in tsan.h.
- Changed configure to error out if --enable-tsan provided but
  TSan not available.

This patch series continues the work done by Emilio Cota and others to add
Thread Sanitizer (TSan) support to QEMU.

The starting point for this work was Emilio's branch here:
https://github.com/cota/qemu/commits/tsan
specifically this commit: 0be125fc0afd47218b34d2019abdd19b644f3199

The main purpose of this patch is to enable TSan support so that 
QEMU developers can start using the tool.  
We found this tool useful and even ran it on our recent changes in
the cpu-locks series, which fixes many warnings.
Clearly there is work to do here to clean up all the warnings. :)
We have also made an effort to introduce enough of the TSan suppression
mechanisms, so that others can continue this work.

This series adds support for:
- configure option for --enable-tsan.
- testing.rst has the full details on how to use TSan with or without docker,
  including all the suppression mechanisms.
- We added an Ubuntu 20.04 docker that supports TSan builds.
- We added an example blacklist file for files or functions TSan should ignore 
  at compile time.  This can now be specified manually.
- Added a suppression file for TSan to suppress certain warnings at run time.
- Added tsan.h with annotations which also can be used to suppress warnings.

Issues:
- When running docker-test-quick under TSan there are several tests which hang
  - The unit tests which seem to hang under TSan:
    test-char, test-qdev-global-props, and test-qga.  
  - If we comment out those tests, check-unit finishes, albeit with 
    a couple of warnings. :)

Emilio G. Cota (7):
  cpu: convert queued work to a QSIMPLEQ
  thread: add qemu_spin_destroy
  cputlb: destroy CPUTLB with tlb_destroy
  qht: call qemu_spin_destroy for head buckets
  tcg: call qemu_spin_destroy for tb->jmp_lock
  translate-all: call qemu_spin_destroy for PageDesc
  thread: add tsan annotations to QemuSpin

Lingfeng Yang (1):
  configure: add --enable-tsan flag + fiber annotations for
    coroutine-ucontext

Robert Foley (4):
  tests/docker: Added docker build support for TSan.
  include/qemu: Added tsan.h for annotations.
  util: Added tsan annotate for thread name.
  docs: Added details on TSan to testing.rst

 accel/tcg/cputlb.c                         |  15 +++
 accel/tcg/translate-all.c                  |  19 +++-
 configure                                  |  41 ++++++++
 cpus-common.c                              |  25 ++---
 cpus.c                                     |  14 ++-
 docs/devel/testing.rst                     | 113 +++++++++++++++++++++
 exec.c                                     |   1 +
 hw/core/cpu.c                              |   1 +
 include/exec/exec-all.h                    |   8 ++
 include/hw/core/cpu.h                      |   6 +-
 include/qemu/thread.h                      |  38 ++++++-
 include/qemu/tsan.h                        |  71 +++++++++++++
 include/tcg/tcg.h                          |   3 +-
 tcg/tcg.c                                  |  19 +++-
 tests/docker/Makefile.include              |   2 +
 tests/docker/common.rc                     |  19 ++++
 tests/docker/dockerfiles/ubuntu2004.docker |  65 ++++++++++++
 tests/tsan/blacklist.tsan                  |  10 ++
 tests/tsan/suppressions.tsan               |  14 +++
 util/coroutine-ucontext.c                  |  97 ++++++++++++++++--
 util/qemu-thread-posix.c                   |   2 +
 util/qht.c                                 |   1 +
 22 files changed, 547 insertions(+), 37 deletions(-)
 create mode 100644 include/qemu/tsan.h
 create mode 100644 tests/docker/dockerfiles/ubuntu2004.docker
 create mode 100644 tests/tsan/blacklist.tsan
 create mode 100644 tests/tsan/suppressions.tsan

-- 
2.17.1


