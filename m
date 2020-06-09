Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C19C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838CE2072F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pab4awms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838CE2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikZc-0007kW-Gz
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikYk-000768-97
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:22 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikYj-0005VH-3m
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:21 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh7so3352plb.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NoArgk7nZzhsns19BF0yYOXImTnaLNKTkzcsndfYr8c=;
 b=pab4awmsQatazt6kUPycHWZK2qwAQmDfRmNX8SoyU2j6xsfdUbaCL9fV/fMSNKa4oR
 USPu+1FnCbLGS859OyAMqSye1CclZQUFt+n6yrekOjfYZRHqACeHawa1/2Giq0mtGJwG
 gKeC0LlZCwEXWktfwRSGRwemKIgBJX2AYtLW1EtqtxrnnC6/ZUkx3P5IntqX3/EcK45y
 i4Rjp/Y60NtbaDNcttPUpMgplb4feuc8Ye3guSzgLcDhsx7eAGwb3aYTIDz+wnhX1csm
 cegAHXFPt8Ln9WMkZML0Vdcm/AS369GbJQCOZA4JFgFXpOe4FKWzsZ1b9DJaxG/NL2k9
 FNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NoArgk7nZzhsns19BF0yYOXImTnaLNKTkzcsndfYr8c=;
 b=UHrxale5PcU3QTGi4Xw4kN+PVh0XsjnAkBkZv+9IjL1QqcEE13GDjmunD86kL5kodd
 FUooJP7SkxjowCWWnbQBewujR/MMRnZwewvMryK6d65LjN3Qm6HnWic1Xq0daUa4QzQH
 EuroDL2DBOHF5WNcEUJTbHAZyfVM8OVuvlxnB1517AhS4QCjL+CaNAauGp3O5PrxM55d
 efJb6LVM3xbDNwCfEuAGWzH7q1xtoI8GHrS6maVAKvnQUz79TNKn1q7HfMjoJtghW4k6
 NNpS7KIkXlP/SUQUCHaSDhEc2TCEY+/FIdjrmuPYIZfl/4jUKK92mXKi8kYD3gppmkGG
 LmCw==
X-Gm-Message-State: AOAM530nvVWOBx5bs23U3W1RZkqHN90P4YU5qcYxaz2eftOQIAULiivn
 9+X58CN7kPwt9k4uImFG9r3LIw+3EIPaAQ==
X-Google-Smtp-Source: ABdhPJws3atXqjLXrpRy/bQ1S4maqJKWEiMc3sF0OcXCKdZIU3SkwJetRtWsbg6P3DIHmGwr79U+hA==
X-Received: by 2002:a17:90a:224a:: with SMTP id
 c68mr6086602pje.21.1591733359010; 
 Tue, 09 Jun 2020 13:09:19 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:18 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/13] Add Thread Sanitizer support to QEMU
Date: Tue,  9 Jun 2020 16:07:25 -0400
Message-Id: <20200609200738.445-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Changes in v3:
- Fixed issue in tsan changes to start_switch_fiber(), 
  found by --enable-sanitizers testing.
- Removed the UC_TRACE() code.
- Removed the tb_destroy callback.

v2: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg01534.html

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
 accel/tcg/translate-all.c                  |  17 ++++
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
 include/tcg/tcg.h                          |   1 +
 tcg/tcg.c                                  |   9 ++
 tests/Makefile.include                     |   9 +-
 tests/docker/dockerfiles/ubuntu2004.docker |  65 +++++++++++++
 tests/docker/test-tsan                     |  44 +++++++++
 tests/qtest/Makefile.include               |   7 +-
 tests/tsan/blacklist.tsan                  |  10 ++
 tests/tsan/suppressions.tsan               |  14 +++
 util/coroutine-ucontext.c                  |  66 +++++++++++--
 util/qemu-thread-posix.c                   |   2 +
 util/qht.c                                 |   1 +
 23 files changed, 541 insertions(+), 37 deletions(-)
 create mode 100644 include/qemu/tsan.h
 create mode 100644 tests/docker/dockerfiles/ubuntu2004.docker
 create mode 100755 tests/docker/test-tsan
 create mode 100644 tests/tsan/blacklist.tsan
 create mode 100644 tests/tsan/suppressions.tsan

-- 
2.17.1


