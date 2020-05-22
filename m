Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7881CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3461D20663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yB8ubhOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3461D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAL3-0003OR-AY
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAJq-0002Dq-NN
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:14:46 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAJp-00063f-Aj
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:14:46 -0400
Received: by mail-pf1-x443.google.com with SMTP id z26so5386664pfk.12
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sFHjTX1zL5AczVMgvyCVTsi50UNpeo8tSVccx1eQGh4=;
 b=yB8ubhOg0FWiHQJFNQhpV+O9e0PJJ/sI707Q/BqfGoOBOFdwAUN+jiJ7ddoCFHMcUm
 QcOmwtzSu4fxowiyd1OVkSnkLpuDdmslsMWhGoAF8CleSpQYVSltNDGoU0twhNmuJbNj
 DheOl+oUcS4KCwnT6U2BcVqQFqGE+mSqR9iREKiMRi2rYTmmJbQ5baqgFTWe+3Knt7Ff
 q+l4fG4+9Y4WTUp0kEwMSSGIPLBeeE08opr23zO6XB7rD1hIsUx8VsRW1ZhBvPJcJc6a
 cdNHc795GJN0Vr3xtn6BFVmjH++bQQrVsDjx5eqlBWIdT+MCYVcj1wOD9Su1k54ouTeA
 ykxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sFHjTX1zL5AczVMgvyCVTsi50UNpeo8tSVccx1eQGh4=;
 b=Yihji+rDF+/cx4W1kuzYLmuP9Qj+pROqV/Z3+hRJbktLSAdgtL7swadNAdl3PZcQ5S
 TkMI3inNc1WYbcHyHhZAcrgLaOqUi9KcRwCl94hqk0rr/A0sRSIvBY9K3JyQ13c7oBEe
 1vlokxeA6Va4HKv/wIz3k3cdviB6tCgXonFG03aB9Ue0W4yRH9KrmDFvjW0FO3JPEklD
 IYLpx0DDdn1a6aMMknmZytEbg4t1NKrmXuLxTU4QSB3VyH03qyQEs1shgVpUw93UmtT5
 uUumIPCVVJTJV6M9AtirPM0HCygDM1MMyMCm+/PVZtldGzSu/p1bLjbptqcbBindElcI
 ODXw==
X-Gm-Message-State: AOAM531X8n9YAOX+Ivg3RqyPz+8GJ151eRrndnqzACOM7p/EiBSKbso0
 du4uUFtDIntc5YshDflgCQaIw4nLphtMMw==
X-Google-Smtp-Source: ABdhPJx2QAmG0kmR7v7idZJH3/mqYX91DzcITXsPbMq5iTjoJaXpPhhoGrJa1586NN3sstERwSZ6Tg==
X-Received: by 2002:a63:ae44:: with SMTP id e4mr14494482pgp.428.1590164083277; 
 Fri, 22 May 2020 09:14:43 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:14:42 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/19] Add Thread Sanitizer support to QEMU
Date: Fri, 22 May 2020 12:07:36 -0400
Message-Id: <20200522160755.886-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x443.google.com
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

This patch series continues the work done by Emilio Cota and others to add
Thread Sanitizer (TSan) support to QEMU.

The starting point for this work was Emilio's branch here:
https://github.com/cota/qemu/commits/tsan
specifically this commit: 0be125fc0afd47218b34d2019abdd19b644f3199

The purpose of this patch is not to fix all the TSan warnings, but to enable
the TSan support so that QEMU developers can start using the tool.  
We found this tool useful and even ran it on our recent changes in
the cpu-locks series.
Clearly there is work to do here to clean up all the warnings. :)  
We have made a start to cleaning up these warnings by getting a VM to boot 
cleanly with no TSan warnings.  
We have also made an effort to introduce enough of the TSan suppression
mechanisms, so that others can continue this work.

This series adds support for:
- configure option for --enable-tsan.
- testing.rst has the full details on how to use TSan with docker
  and also outside of docker.
- Docker builds with TSan.
  - We added an Ubuntu 20.04 docker that supports TSan builds.
  - Something like this will build TSan
    make docker-test-build@ubuntu2004 DEBUG=1 TSAN=1
  - Testing with TSan is also supported with docker,
    although, be forwarned that test-quick currently fails.  
    See "Issues" section below for the current failures.
    make docker-test-quick@ubuntu2004 DEBUG=1 TSAN=1
  - We recommend using the DEBUG=1 option and launching the test 
   (like test-quick) from inside the docker so that when the test is done,
    you can review the warnings from inside the docker.
  - testing.rst has the full details on how to use TSan with docker.
- We added a blacklist file for files/functions
  TSan should ignore at compile time.
- And added a suppression file for TSan to suppress certain warnings at
  run time.  
  We found both of these mechanisms are needed when suppressing warnings.
- It is also worth mentioning that we were able to suppress/fix enough errors
  to allow an Ubuntu 18.04 aarch64 VM to boot with zero TSan warnings.  
  When we started this effort, there were ~300 warnings reported by 
  TSan during the same VM boot !

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

Robert Foley (11):
  tests/docker: Added docker build support for TSan.
  include/qemu: Added tsan.h for annotations.
  accel/tcg: Fixed tsan warnings related to parallel_cpus
  configure: added tsan support for blacklist.
  accel/tcg: Fixed tsan warnings.
  util/async: Fixed tsan warnings
  qht: Fix tsan warnings.
  util: fixed tsan warnings in thread_pool.c
  util: Added tsan annotate for thread name.
  target/arm: Fix tsan warning in cpu.c
  docs: Added details on TSan to testing.rst

 accel/tcg/cpu-exec.c                       |  4 +-
 accel/tcg/cputlb.c                         | 15 ++++
 accel/tcg/tcg-all.c                        |  4 +-
 accel/tcg/tcg-runtime.c                    |  7 +-
 accel/tcg/translate-all.c                  | 25 +++++-
 configure                                  | 40 +++++++++
 cpus-common.c                              | 25 ++----
 cpus.c                                     | 16 +++-
 docs/devel/testing.rst                     | 72 ++++++++++++++++
 exec.c                                     |  1 +
 hw/core/cpu.c                              |  3 +-
 include/exec/exec-all.h                    | 10 ++-
 include/hw/core/cpu.h                      |  6 +-
 include/qemu/thread.h                      | 38 ++++++++-
 include/qemu/tsan.h                        | 48 +++++++++++
 include/tcg/tcg.h                          |  3 +-
 linux-user/syscall.c                       |  4 +-
 target/arm/cpu.c                           |  2 +-
 tcg/tcg.c                                  | 19 ++++-
 tests/docker/Makefile.include              |  2 +
 tests/docker/common.rc                     | 19 +++++
 tests/docker/dockerfiles/ubuntu2004.docker | 65 +++++++++++++++
 tests/tsan/blacklist.tsan                  |  5 ++
 tests/tsan/suppressions.tsan               | 14 ++++
 util/async.c                               | 11 ++-
 util/coroutine-ucontext.c                  | 97 ++++++++++++++++++++--
 util/qemu-thread-posix.c                   |  2 +
 util/qht.c                                 |  4 +
 util/thread-pool.c                         |  5 +-
 29 files changed, 514 insertions(+), 52 deletions(-)
 create mode 100644 include/qemu/tsan.h
 create mode 100644 tests/docker/dockerfiles/ubuntu2004.docker
 create mode 100644 tests/tsan/blacklist.tsan
 create mode 100644 tests/tsan/suppressions.tsan

-- 
2.17.1


