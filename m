Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1577C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0C0206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXieugDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0C0206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGI1-0003a4-Kx
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHM-0002oo-82
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:16 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:50728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHK-0003oL-Fo
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:15 -0400
Received: by mail-pj1-x1041.google.com with SMTP id jz3so2957186pjb.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RprofYQNW6x1Nv673stIX2Y2cOlzYXdlbBgLiN7hT7c=;
 b=HXieugDg5KmOHAbuNE/OMoU4dsibxZqQL/nBmcouhTvd6qZ01lhhSreNppr2dAhkVC
 2LwSzyP/wYZTL0jKaWmk+6xr7Y/2IAfPCOrpB3IUX2FFysdVFdXuudn7ZSIiaAOGPLMK
 jnYu38mE/X1TwMh6NXNj6+QoHvghAJEIn6SfwgDHVhk7VD6ZwjYPQblj6mS5HFyYggfS
 xwIdi5SFYB5hjSyXs+7oIOMJfXyqIURVtNxKv/vhDaXPvJ3GGd9yfMtQPzHWp8hUO8kY
 h+sqOpocoYKIMX3ziGZtG+oJ82m89xAW9mTV5sdTWuQOyhyBuQbb5Z4eO5A0D23WCmGL
 FwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RprofYQNW6x1Nv673stIX2Y2cOlzYXdlbBgLiN7hT7c=;
 b=IVe4rLfzj4SlOEgMf9IeIWe5axpyWYR4VA1E8zvqtMg2D1f6xZLOMgL3lFo8VegPpB
 eoQWdXSnqThcbAeURlOTHG5yDv+uGn9XsecAazXiLTiHdRrmOn90RNympyd4eB3lx4WJ
 KZnmnGv0UVMJM7vqUgvyAw0oCKZ5hwRoSrgydI60gAXEuVUKHxlNx0AgiwdoS/a/GFtL
 XuuTKfGiHbHdObn3tLK1yzgBEfo5Cy3FVz7YI2L739JApan+J0XiqzeuaA+9EpzqcTWB
 jR022hxJrk0dUzTwWatkVuS9yd1N4VC2HcVBmIqV03oQtAL4WkH7ZlraPQbVXFkqwg+1
 iDVQ==
X-Gm-Message-State: AOAM5325uCB8pB/XCF3csZSq3RBGfrE865IfKtajyfwFRdDjh8rxkbqy
 cDTb5WR/D/4oM3sg/V777SgCACl00OdKbg==
X-Google-Smtp-Source: ABdhPJzhclqxTwV030ljQnjdLkvJts2swpDel4mgxlrNINvMDPGdc9D/e0DrHq/VbXj/MQ65fWaRgw==
X-Received: by 2002:a17:90a:69c3:: with SMTP id
 s61mr4334548pjj.212.1591378631842; 
 Fri, 05 Jun 2020 10:37:11 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:11 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/13] Add Thread Sanitizer support to QEMU
Date: Fri,  5 Jun 2020 13:34:09 -0400
Message-Id: <20200605173422.1490-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1041.google.com
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

v1: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08302.html

Changes in v2:
- Fixed make check under TSan.  With the below fixes, make check 
  under TSan completes successfully, albeit with TSan warnings.
  - We found that several unit tests and the qtests hit an issue in TSan,
    which results in a hung test.  This is a known issue: 
    https://github.com/google/sanitizers/issues/1116
  - Under TSan, disable the 3 unit tests that hit this above issue.
  - Under TSan, disable the qtests since they hit this issue too.
- Split out the docker testing for tsan into its own test (test-tsan).
- configure:  Error out if tsan and other sanitizers are used together.
- configure: Cleaned up warnings during tsan build caused by tsan libraries.

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
- test-tsan is a new docker test that builds and runs make check under TSan.
- We added an example blacklist file for files or functions TSan should ignore 
  at compile time.  This can now be specified manually.
- Added a suppression file for TSan to suppress certain warnings at run time.
- Added tsan.h with annotations which also can be used to suppress warnings.

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

Robert Foley (5):
  tests/docker: Added docker build support for TSan.
  include/qemu: Added tsan.h for annotations.
  util: Added tsan annotate for thread name.
  docs: Added details on TSan to testing.rst
  tests:  Disable select tests under TSan, which hit TSan issue.

 accel/tcg/cputlb.c                         |  15 +++
 accel/tcg/translate-all.c                  |  19 +++-
 configure                                  |  47 ++++++++-
 cpus-common.c                              |  25 ++---
 cpus.c                                     |  14 ++-
 docs/devel/testing.rst                     | 107 +++++++++++++++++++++
 exec.c                                     |   1 +
 hw/core/cpu.c                              |   1 +
 include/exec/exec-all.h                    |   8 ++
 include/hw/core/cpu.h                      |   6 +-
 include/qemu/thread.h                      |  38 +++++++-
 include/qemu/tsan.h                        |  71 ++++++++++++++
 include/tcg/tcg.h                          |   3 +-
 tcg/tcg.c                                  |  19 +++-
 tests/Makefile.include                     |   9 +-
 tests/docker/dockerfiles/ubuntu2004.docker |  65 +++++++++++++
 tests/docker/test-tsan                     |  44 +++++++++
 tests/qtest/Makefile.include               |   7 +-
 tests/tsan/blacklist.tsan                  |  10 ++
 tests/tsan/suppressions.tsan               |  14 +++
 util/coroutine-ucontext.c                  |  97 +++++++++++++++++--
 util/qemu-thread-posix.c                   |   2 +
 util/qht.c                                 |   1 +
 23 files changed, 581 insertions(+), 42 deletions(-)
 create mode 100644 include/qemu/tsan.h
 create mode 100644 tests/docker/dockerfiles/ubuntu2004.docker
 create mode 100755 tests/docker/test-tsan
 create mode 100644 tests/tsan/blacklist.tsan
 create mode 100644 tests/tsan/suppressions.tsan

-- 
2.17.1


