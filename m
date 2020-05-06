Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911E5C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4D320714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvdM2U1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4D320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIp5-0007la-CN
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo0-00067G-JP
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:33706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWInx-0007wv-Ey
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id h9so1912706wrt.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kysom4i8NwH5auTulZbYwaQkg2dMIuW11Qe11nlqzl0=;
 b=lvdM2U1MkXwBH3wYb+DNpAxjbIr4daSTWeT4l1dyVH/2IgsF1FLSUodJmFOqDC3GlJ
 AZseuIm/Xh2JWWDi3xvx4PecLYnzbkhu+ujC8Ya1vasK0cHqBa78HU1cFEzA702bGbu9
 LiMpNqi2GHvPwzxYLlHzN33LlArIJNFGLALtwk8NXq3XeO8SDJZb69hhyDh5ZHI6NdxY
 W/iijqi/qrgYlpKPMfFcrSdBOjeLi041wYC5HpHbXYyK23rjCnPrI5xY02q1RR/xwC6D
 jWYAUvBd7jkM4U0M//FQyIpO9OycaG8QZ35s6jXKje0qu4BJvqXVLUA43qRk6QDYWnFT
 1Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kysom4i8NwH5auTulZbYwaQkg2dMIuW11Qe11nlqzl0=;
 b=GF7Xo5tP1nwB5X3KBQ1e2EYypOYgpX652Zj0SPimWvH2DPm514S0pdklvEGsHRQ4mb
 2PSfvlupfxhzjjSMgpsO4v4ljQ4dd2ZEA67NgnoVMzXPgfK5S/FhDFGO17ogqY3hXitj
 zkLKWSJ+4K9nx7hA+tITSIII+WypO8lEgFZUOLKlcvPz9ux30bsg9yL5MjJxGx1R/TZU
 k/3Tpb306onCTg31FxqRLDKu5Et08VCwvcROPOWCiB9DPnLzRg3EFH1wIA321GUwNVM6
 Lo24nRLVkMA7MbjJZhYTJVjgdFmdoTV6n4N1NEMsx0TuBERnq0wUxauTXDwT5e0fl7nG
 7DRw==
X-Gm-Message-State: AGi0PuYb2KBstQvezkYdnsEt46CqnFO2dqSXkakCCuQNwmYewD2CBJ1o
 YM+5tcBc5ebaOwi+MBmxAeU3Ey7jjqo=
X-Google-Smtp-Source: APiQypJ6zuEixh5269VicW24mmvC9u2mnFAk3axfIp22X86rIqceioeXrN2Rl3t0k9e7Tpq1r/rgJA==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr9883839wro.116.1588766732518; 
 Wed, 06 May 2020 05:05:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z1sm2741114wmf.15.2020.05.06.05.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AC9091FF7E;
 Wed,  6 May 2020 13:05:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/14] testing and gdbstub updates
Date: Wed,  6 May 2020 13:05:15 +0100
Message-Id: <20200506120529.18974-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

The following changes since commit f19d118bed77bb95681b07f4e76dbb700c16918d:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2020-05-04' into staging (2020-05-05 15:47:44 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-gdbstub-060520-1

for you to fetch changes up to a976ed3ffdede7f64c89ac235d0154d048981b5f:

  target/m68k: fix gdb for m68xxx (2020-05-06 09:29:26 +0100)

----------------------------------------------------------------
Testing and gdbstub updates:

  - travis: drop macosx, tweak ppc64 native
  - cirrus: fix FreeBSD, guard against future breakage
  - gdbstub: support socket debug for linux-user
  - gdbstub: add multiarch tests
  - gdbstub: fixes for m68k

----------------------------------------------------------------
Alex Bennée (11):
      .travis.yml: show free disk space at end of run
      .travis.yml: drop MacOSX
      .cirrus.yml: bump FreeBSD to the current stable release
      .travis.yml: reduce the load on [ppc64] GCC check-tcg
      configure: favour gdb-multiarch if we have it
      tests/tcg: better trap gdb failures
      tests/tcg: drop inferior.was_attached() test
      gdbstub: eliminate gdbserver_fd global
      gdbstub/linux-user: support debugging over a unix socket
      tests/guest-debug: use the unix socket for linux-user tests
      tests/tcg: add a multiarch linux-user gdb test

KONRAD Frederic (1):
      target/m68k: fix gdb for m68xxx

Li-Wen Hsu (1):
      .cirrus.yml: bootstrap pkg unconditionally

Philippe Mathieu-Daudé (1):
      gdbstub: Introduce gdb_get_float64() to get 64-bit float registers

 configure                                   |   4 +-
 include/exec/gdbstub.h                      |  25 ++++--
 bsd-user/main.c                             |   8 +-
 gdbstub.c                                   | 119 ++++++++++++++++++++++------
 linux-user/main.c                           |  12 +--
 target/m68k/cpu.c                           |  52 ++++++++----
 target/m68k/helper.c                        |   3 +-
 target/ppc/gdbstub.c                        |   4 +-
 target/ppc/translate_init.inc.c             |   2 +-
 .cirrus.yml                                 |   4 +-
 .travis.yml                                 |  31 +-------
 gdb-xml/m68k-core.xml                       |  29 +++++++
 tests/guest-debug/run-test.py               |  30 ++++++-
 tests/tcg/aarch64/Makefile.target           |   5 +-
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py |   4 -
 tests/tcg/aarch64/gdbstub/test-sve.py       |   4 -
 tests/tcg/cris/Makefile.target              |   1 +
 tests/tcg/multiarch/Makefile.target         |  14 ++++
 tests/tcg/multiarch/gdbstub/sha1.py         |  81 +++++++++++++++++++
 19 files changed, 328 insertions(+), 104 deletions(-)
 create mode 100644 gdb-xml/m68k-core.xml
 create mode 100644 tests/tcg/multiarch/gdbstub/sha1.py


-- 
2.20.1


