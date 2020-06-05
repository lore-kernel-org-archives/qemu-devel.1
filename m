Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C3C206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH/f0nJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C3C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEcW-0005Kz-7p
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbF-0003a0-0u
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbE-0004KN-2p
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id r9so8876659wmh.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=neEGrKcNvn3NJszDbPt9+5JBuroTCHnA1vYPbQh1tCA=;
 b=yH/f0nJjuFYDv0IFMXV5vQveMTfJpF9CnzCl8OPgScNiHBH++1LwbajmrF7pemPJ0P
 oBctCHV4oL5BVwWjmYY2QXkwmBGIB9o0o9PzwXaSox0rhnukxvpRX9wsd8lE4QfVMgqL
 yintLidZcy5vs7a9Q++b14D+YCDiAiZsBrQkWEosZpN3Qy3nSC+UK6dxlqsYKYtKTevS
 cuuLDomfA+osQmqXhcd/A3c1bIKijr20+9q2OPxtoO/ieJEu7mFXBIGZRqP4owmIbUTl
 ZLboe/j/P/ss2y6LDtXO3Awf4fIECYIm8v12iDcCWFFqQVhmCl016uYRJ3IAEJw9jwRT
 d7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=neEGrKcNvn3NJszDbPt9+5JBuroTCHnA1vYPbQh1tCA=;
 b=XqYV4E3J9/BW+XoikHMiGdrZeM2JeaAvrqRfX79NmZtPmVOve+F2E2JG1qu41d4HaF
 L56UCR9whLQ6KreKCgf3qQtskABI5hBqnpgJ1nAeo0yXycA4hL6leZJ+s/hv5qrx2j7f
 0DP8GY3MV/BagGTyGTffqNxkX2e4wlyT2pM/X44nwCStQoovI6dtGvxdeSmBPlaoiC7R
 NblSh66pUUZ26e93/REPz2Tv4XociMo86b4bRuQ69acMv6CRsSXB+hCBLYA11lQwLQS2
 Y7BsUtqJ8DmfBuUPiPaQaP4nLiQ/XbLEmJaXMfi4rfsH4osKXA6h//rqul+pcyErYQHX
 SIIA==
X-Gm-Message-State: AOAM532DMQaUGfgR/eDqGUjNGLogcaJ/WQCrtnLKsL1sSqCVEM2N1YiU
 98wbTdR8z2lN4hzdtA+o+6OnMw==
X-Google-Smtp-Source: ABdhPJxkDneyW8G6Q1m9ijyzVso9qHghQDTEPZB3sdWASSHPGGRM7mYr7zWUnHwbOFu/8mHJDr2Drg==
X-Received: by 2002:a1c:a505:: with SMTP id o5mr3369352wme.143.1591372178711; 
 Fri, 05 Jun 2020 08:49:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f11sm12450305wrm.13.2020.06.05.08.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F27A1FF7E;
 Fri,  5 Jun 2020 16:49:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/14] various fixes for next PR (testing, vhost,
 guest_base fixes)
Date: Fri,  5 Jun 2020 16:49:15 +0100
Message-Id: <20200605154929.26910-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

These are all the patches I've currently got which are ready for a
pull request next week. I've included some patches which are destined
to go in via other trees so I can keep the testing green on the CI.

In summary:

 Some simple plugin cleanups (the reset remain in plugins/next)
 Reliability fixes for travis/shippable
 iotest 194 fix (going in via block tree?)
 docker updates (ubuntu and tricore fix)
 vhost-user and TCG fix
 more linux-user guest_base fixes

I'll certainly include the testing stuff in my PR but if others are
happy for me to include bits touching their areas then shout and I'll
include them in the PR.

The following need review:

 - linux-user: detect overflow of MAP_FIXED mmap
 - linux-user: deal with address wrap for ARM_COMMPAGE on 32 bit
 - linux-user: provide fallback pgd_find_hole for bare chroots
 - tests/docker: fix pre-requisite for debian-tricore-cross
 - hw/virtio/vhost: re-factor vhost-section and allow DIRTY_MEMORY_CODE
 - .shippable: temporaily disable some cross builds
 - exec: flush the whole TLB if a watchpoint crosses a page boundary

Alex Bennée (10):
  tests/plugin: correctly honour io_count
  exec: flush the whole TLB if a watchpoint crosses a page boundary
  .travis.yml: allow failure for unreliable hosts
  .shippable: temporaily disable some cross builds
  tests/docker: fix pre-requisite for debian-tricore-cross
  hw/virtio/vhost: re-factor vhost-section and allow DIRTY_MEMORY_CODE
  linux-user: provide fallback pgd_find_hole for bare chroots
  linux-user: deal with address wrap for ARM_COMMPAGE on 32 bit
  tests/tcg: add simple commpage test case
  linux-user: detect overflow of MAP_FIXED mmap

Emilio G. Cota (1):
  qemu-plugin.h: add missing include <stddef.h> to define size_t

Paolo Bonzini (1):
  docker: update Ubuntu to 20.04

Philippe Mathieu-Daudé (1):
  scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as special header

Vladimir Sementsov-Ogievskiy (1):
  iotests: 194: wait migration completion on target too

 include/qemu/qemu-plugin.h             |  1 +
 exec.c                                 |  8 ++-
 hw/virtio/vhost.c                      | 57 +++++++++++++++------
 linux-user/elfload.c                   | 71 ++++++++++++++++++++++----
 linux-user/mmap.c                      |  2 +-
 tests/plugin/mem.c                     |  2 +-
 tests/tcg/arm/commpage.c               | 61 ++++++++++++++++++++++
 .shippable.yml                         | 12 ++---
 .travis.yml                            |  5 ++
 hw/virtio/trace-events                 |  3 +-
 scripts/clean-includes                 |  1 +
 tests/docker/Makefile.include          |  2 +-
 tests/docker/dockerfiles/ubuntu.docker |  2 +-
 tests/qemu-iotests/194                 | 10 ++++
 tests/qemu-iotests/194.out             |  5 ++
 tests/tcg/arm/Makefile.target          |  2 +
 16 files changed, 206 insertions(+), 38 deletions(-)
 create mode 100644 tests/tcg/arm/commpage.c

-- 
2.20.1


