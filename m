Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9415DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7B5206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTB5rDX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7B5206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjoym-0002hD-FG
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjox1-0000kQ-Dn
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:02:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43721)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjowz-0006sM-KF
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:02:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id l10so10789515wrr.10
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Oib/NlLbmj6BS/rcPhvdpZkDgi+7A6sSV4ZftL4+eg=;
 b=xTB5rDX9MUF7er9pF8Z3LgV68CDhoRvcf2JXVZp3gLRGc2JouMc/teSUKLCIFk6CkS
 itf1jd1qd/Nu9WTfbmigegvmPBBz9JTZnrMwLhKQ/5gHDRmIZi3L/BvbwR2Tw0z3QkVB
 eKPYTMwB7L1OWV0i+7S2agdguTVZ1vgdzbtp3uMN6WrNigLjcdBFcxiUd+3fj+VLLSKk
 60n7rMP3rkVIKSZYAg9dDg+N7ST9axFH9oCc1Si/3FuD5i4lhRiI3z2GUCFRibTI9hkn
 qje9e+V8p31A8V/042P9uOwt8zqr/d1UZejSI1z8YZ+A+l5e8aYUm8hPMVbiaUVRCCCU
 H4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Oib/NlLbmj6BS/rcPhvdpZkDgi+7A6sSV4ZftL4+eg=;
 b=eAk+PbmV8571oYA8+xbL9oQp4Bo4isvx+y8V514p+Z2pffHAT6+ooZSihmJQ3RWVaN
 Wks9wIZ1eFoGtm/as2eaRok0+3WetplvxblAV5KJRBIIf6i70q1WWSPEtJ2/gU4SppC9
 r9+FODABipB4EnM9PVYj+SmOLHUE0OgLqhHYD9814po+CRPWSqAHW2KWad8q9FaFIfT0
 ENLsMxong8SsODPgg1cVx6rUaQ4TCi0dJ8kydbxtxEnAGRGHcNUCjkmq5yPapdRTS7ZG
 B0o+uo1O5wu6+XivHueJuGgRosgLu6XlQza0JTFVIRCWKldv+o9bzm/RPf6ky3b0SNyh
 Hukw==
X-Gm-Message-State: AOAM5333TKrw+tJfQQ9wd5zTfGQUXav65b+YNTHH452Djl4HDYiZC8WS
 hhK2STm+IXwp4tVPaiQJVlAT2Q==
X-Google-Smtp-Source: ABdhPJxVo/lT0Cox0nrJdRYGQaraTRtpAXU7cW0tcoH/wfDkaKSiaE7b+JVYIir5Kzw/3CMoaN7z3Q==
X-Received: by 2002:adf:db47:: with SMTP id f7mr17051376wrj.101.1591988559834; 
 Fri, 12 Jun 2020 12:02:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 67sm11902783wrk.49.2020.06.12.12.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:02:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C12531FF7E;
 Fri, 12 Jun 2020 20:02:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/18] testing/next (tsan, dtc warnings, cross-builds)
Date: Fri, 12 Jun 2020 20:02:19 +0100
Message-Id: <20200612190237.30436-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

This is the current testing/next queue. Aside from the minor bumps and
updates this returns --enable-tsan to the build.

This can help with debugging race conditions. You need a fairly recent
clang to enable it but configure will bug out if it can't be turned
on. Thanks to Robert Foley for picking up Emilio's work and getting it
through the review process.

There are a couple of minor testing updates including re-enabling the
cross-builds I disabled in the last PR I made as, predictably, Debian
finally pushed through the package update just as I turned the tests
off.

I hope to put together a PR on Tuesday.

The following are still missing reviews:

 - cirrus.yml: serialise make check
 - Revert ".shippable: temporaily disable some cross builds"
 - tests/docker: bump fedora to 32

Alex Bennée (3):
  tests/docker: bump fedora to 32
  Revert ".shippable: temporaily disable some cross builds"
  cirrus.yml: serialise make check

Claudio Fontana (2):
  Makefile: dtc: update, build the libfdt target
  Makefile: remove old compatibility gunks

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
  tests: Disable select tests under TSan, which hit TSan issue.

 docs/devel/testing.rst                     | 107 +++++++++++++++++++++
 configure                                  |  48 ++++++++-
 Makefile                                   |  16 +--
 include/exec/exec-all.h                    |   8 ++
 include/hw/core/cpu.h                      |   6 +-
 include/qemu/thread.h                      |  38 +++++++-
 include/qemu/tsan.h                        |  71 ++++++++++++++
 include/tcg/tcg.h                          |   1 +
 accel/tcg/cputlb.c                         |  15 +++
 accel/tcg/translate-all.c                  |  17 ++++
 cpus-common.c                              |  25 ++---
 cpus.c                                     |  14 ++-
 exec.c                                     |   1 +
 hw/core/cpu.c                              |   1 +
 tcg/tcg.c                                  |   9 ++
 util/coroutine-ucontext.c                  |  66 +++++++++++--
 util/qemu-thread-posix.c                   |   2 +
 util/qht.c                                 |   1 +
 .cirrus.yml                                |   6 +-
 .shippable.yml                             |  12 +--
 dtc                                        |   2 +-
 tests/Makefile.include                     |   9 +-
 tests/docker/dockerfiles/fedora.docker     |   2 +-
 tests/docker/dockerfiles/ubuntu2004.docker |  65 +++++++++++++
 tests/docker/test-tsan                     |  44 +++++++++
 tests/qtest/Makefile.include               |   7 +-
 tests/tsan/blacklist.tsan                  |  10 ++
 tests/tsan/suppressions.tsan               |  14 +++
 28 files changed, 557 insertions(+), 60 deletions(-)
 create mode 100644 include/qemu/tsan.h
 create mode 100644 tests/docker/dockerfiles/ubuntu2004.docker
 create mode 100755 tests/docker/test-tsan
 create mode 100644 tests/tsan/blacklist.tsan
 create mode 100644 tests/tsan/suppressions.tsan

-- 
2.20.1


