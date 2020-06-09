Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BE2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAC5207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiZKRZ2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAC5207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibfP-0000hv-NE
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe3-0007Ze-6I
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe1-0004N2-NF
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id e1so20735409wrt.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ue+XYO4pQ+xQADc7eWTs2mgiQ9kkm7yM6Dj9MusQ59I=;
 b=kiZKRZ2k5fqEHB+r7k9W5Sb+eX8XaJXjwrWQFb/xzp4JwBhpa+VqM/B9lZYHxtV9N1
 IZ+ynS3oUoLIy5crink33VWb/qkhAKQ623zcVOIUmOv3pwPP90TeIBxQWxgB9nTNg1ob
 43RdCHjI2puR0ffiIIAEsZnqspacCnyN/CLVBby/S9ycNQVQQru+sWdA4uMRHXK45xol
 lqXaAMg7NX9lvYANv089FvxdGvxcQ1eXElH+6jYmVOx9HYsa3mclFlsVujoXV0+yydYJ
 /OG85gzJEwBvnruqls3wrpxx0PZoA2qz/5D5+W9NoDhjN+W6bP19kOZb77kVHpTNFq1D
 r5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ue+XYO4pQ+xQADc7eWTs2mgiQ9kkm7yM6Dj9MusQ59I=;
 b=lBdJjHbyUQzzNU19h4RYA+S104RZmzWk8mbFcuhMjOVbYdj5OkOSXImAqRgSjNsx/n
 l2dV2GM278yv7zQMiNvYHwRAhULjlUZrmnaN2r5KQAig2jpgxAx22j5KMaVRQnwGrdnd
 RG4XrQlV2OuNDDqF5cbqJGVdwrdkGqYD0PWH/ohZ/591XEJvTpNQ1zd5qR1zCbwE+2pv
 zePA+tgKnRg6WrfxWUfTAJVRL9Z79aaiIyKkqeSaRxNDhWwx8O1mgtj0Tzm/6grzyOZA
 tFfQxST5WimAZy+NJyhhgGMbiDpsqH4cy6sLufPe1WY556wyKFRx1qryFcP8E3wAqVms
 bmGA==
X-Gm-Message-State: AOAM532iDpG+n/H3GHEyfolkKoVp6Krcy4gR5ntzuWgpj+Q5CHiz2zcQ
 ozTa87XZQUd2cbgmNp9f6gEeJA==
X-Google-Smtp-Source: ABdhPJykE8ZKH+bc+vY9DAOzeIDRz8s6lixLZ8X6wFvrrbQ7m2Ibt+RwtF1uZaNDO5agzsOOIgBUjQ==
X-Received: by 2002:adf:f003:: with SMTP id j3mr3732733wro.228.1591699091926; 
 Tue, 09 Jun 2020 03:38:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm3140415wrr.5.2020.06.09.03.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D4F071FF7E;
 Tue,  9 Jun 2020 11:38:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/17] testing and misc fixes
Date: Tue,  9 Jun 2020 11:37:52 +0100
Message-Id: <20200609103809.23443-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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

The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-06-08 11:04:57 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-080620-1

for you to fetch changes up to a5b04ccd742f6c58a1d305530d9e07ad9731b8e6:

  scripts/coverity-scan: Remove flex/bison packages (2020-06-08 17:04:19 +0100)

----------------------------------------------------------------
Various testing and misc fixes:

  - header cleanups for plugins
  - support wider watchpoints
  - tweaks for unreliable and broken CI
  - docker image fixes and verion bumps
  - linux-user guest_base fixes
  - remove flex/bison from various test images

----------------------------------------------------------------
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

Philippe Mathieu-Daudé (5):
      scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as special header
      tests/docker: Remove flex/bison packages
      tests/vm: Remove flex/bison packages
      cirrus-ci: Remove flex/bison packages
      scripts/coverity-scan: Remove flex/bison packages

 include/qemu/qemu-plugin.h                         |  1 +
 exec.c                                             |  8 ++-
 hw/virtio/vhost.c                                  | 57 ++++++++++++-----
 linux-user/elfload.c                               | 71 +++++++++++++++++++---
 linux-user/mmap.c                                  |  2 +-
 tests/plugin/mem.c                                 |  2 +-
 tests/tcg/arm/commpage.c                           | 61 +++++++++++++++++++
 .cirrus.yml                                        |  2 +-
 .shippable.yml                                     | 12 ++--
 .travis.yml                                        |  5 ++
 hw/virtio/trace-events                             |  3 +-
 scripts/clean-includes                             |  1 +
 scripts/coverity-scan/coverity-scan.docker         |  2 -
 tests/docker/Makefile.include                      |  2 +-
 tests/docker/dockerfiles/centos7.docker            |  2 -
 tests/docker/dockerfiles/centos8.docker            |  2 -
 .../docker/dockerfiles/debian-xtensa-cross.docker  |  2 -
 tests/docker/dockerfiles/debian10.docker           |  2 -
 tests/docker/dockerfiles/debian9.docker            |  2 -
 tests/docker/dockerfiles/fedora.docker             |  2 -
 tests/docker/dockerfiles/ubuntu.docker             |  4 +-
 tests/docker/dockerfiles/ubuntu1804.docker         |  2 +-
 tests/tcg/arm/Makefile.target                      |  2 +
 tests/vm/fedora                                    |  1 -
 tests/vm/freebsd                                   |  1 -
 tests/vm/netbsd                                    |  1 -
 tests/vm/openbsd                                   |  1 -
 tests/vm/ubuntu.i386                               |  2 +-
 28 files changed, 195 insertions(+), 60 deletions(-)
 create mode 100644 tests/tcg/arm/commpage.c

-- 
2.20.1


