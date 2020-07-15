Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21542C433E6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E7D20658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/tpuyh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E7D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvfPb-0007Y7-6m
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 07:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvfNT-0005TF-Aw
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:15:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvfNR-0003I3-9Z
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:15:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id w3so5376285wmi.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d4IDwfsKWpY7qibc0zr5Gd3HE/fGp8cCAJEurmJiXVQ=;
 b=d/tpuyh32WLOjYtJcf4/zcGSZw4uhFEYNB3xG2Qcp+IxPoZopgnmXkHO4z8YaRnTld
 0UpdCUSPFPSl2S6nm02gB0cXj2jMv4Ig6TQFK71eFOhwnfSNDkZGMiXutIndQSeeCNdW
 Pn77oCT10Bhh8z20X327Zq/ZWmKy3nZKwrizwUb3gC1T5PcEYU5ACHDJya351AxRF5Ye
 NHEWWJ3CQWkW3CtOWwmhPtp63P4bjwDf1++84Vejk1fEOODaWtrakOHCV2EXTGlpAbdY
 scMMS40UUujqzFP7rUV8QC461Qk8KmGtcfKwutdepNGHIcJrDypNSzKIcXb8oTlAexqO
 dNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d4IDwfsKWpY7qibc0zr5Gd3HE/fGp8cCAJEurmJiXVQ=;
 b=QFLT+vZR38iKOTseoGi4fFr4tqGMwjqoQfxbYZ9BgFIxP0x74XXxtH7ddU/IVeMQKK
 7nLXqWr4m/VJFyg5CALZBQOvPXW4QvLPh+A79Zeh4W8yR5BtR8dv6PiRLFPkR/cWTqmY
 koom/9Z3HMHDXW8oThE7RalRWa7z7TQB0BfPvTUVJziPzNmhPrQKH3TD1jWkdqCITB4H
 1YlPnKWIzz+VrKK7cobirveatjEj2jGkdlA1Jn0t8XPc6Nzl4cA3oCtY/b5cEj0AdXOZ
 6sXSaobHUQiSkuunHig9BDYHowmZacUPQvuLRiUEQy/ge1fWo8RkJTbHSZcfWPTPVQtY
 FDEg==
X-Gm-Message-State: AOAM531nW8OVDiKZh/YjUnqMOtQI/UdtxeEyP+91/mdLSvMIkCY4JHdS
 I621nwXgOdr92nJIE/UURIp2Og==
X-Google-Smtp-Source: ABdhPJwgHUy73gp0e8szfR4NPhsVWsVLeZ8TW4LdzJmTDA08TWuKxZ3Za8qIAa+4SdYf/H8CPBJXDQ==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr8171991wma.8.1594811703153;
 Wed, 15 Jul 2020 04:15:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z132sm3145390wmb.21.2020.07.15.04.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 04:15:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D38D51FF7E;
 Wed, 15 Jul 2020 12:14:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 0/9] final misc fixes for 5.1-rc0
Date: Wed, 15 Jul 2020 12:14:55 +0100
Message-Id: <20200715111455.19237-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Sorry about that, dropped configure patch, added Travis ppc64abi32
patch.

---

The following changes since commit c920fdba39480989cb5f1af3cc63acccef021b54:

  Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2020-07-13-tag' into staging (2020-07-14 21:21:58 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-misc-for-rc0-150720-3

for you to fetch changes up to 0571d280d057b851e3bb3ea7c350b86c950aea6e:

  .travis.yml: skip ppc64abi32-linux-user with plugins (2020-07-15 11:57:17 +0100)

----------------------------------------------------------------
Final fixes for 5.1-rc0

  - minor documentation nit
  - docker.py bootstrap fixes
  - tweak containers.yml wildcards
  - fix float16 nan detection
  - conditional use of -Wpsabi
  - fix missing iotlb data for plugins
  - proper locking for helper based bb count
  - drop ppc64abi32 from the plugin check-tcg test

----------------------------------------------------------------
Alex Bennée (6):
      docs/devel: fix grammar in multi-thread-tcg
      docker.py: fix fetching of FROM layers
      tests/plugins: don't unconditionally add -Wpsabi
      cputlb: ensure we save the IOTLB data in case of reset
      plugins: expand the bb plugin to be thread safe and track per-cpu
      .travis.yml: skip ppc64abi32-linux-user with plugins

LIU Zhiwei (1):
      fpu/softfloat: fix up float16 nan recognition

Thomas Huth (2):
      tests/docker: Remove the libssh workaround from the ubuntu 20.04 image
      gitlab-ci/containers: Add missing wildcard where we should look for changes

 docs/devel/multi-thread-tcg.rst            |  2 +-
 configure                                  |  3 +
 include/hw/core/cpu.h                      | 16 +++++
 include/qemu/typedefs.h                    |  1 +
 accel/tcg/cputlb.c                         | 38 +++++++++++-
 fpu/softfloat-specialize.inc.c             |  4 +-
 tests/plugin/bb.c                          | 97 ++++++++++++++++++++++++++----
 .gitlab-ci.d/containers.yml                |  1 +
 .travis.yml                                |  3 +-
 tests/docker/docker.py                     | 16 +++--
 tests/docker/dockerfiles/ubuntu2004.docker |  3 -
 tests/plugin/Makefile                      | 22 +++++--
 12 files changed, 174 insertions(+), 32 deletions(-)

-- 
2.20.1


