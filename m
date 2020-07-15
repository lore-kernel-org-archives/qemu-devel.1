Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A92C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4626206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muQN5+iF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4626206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvf5P-0005Tl-0b
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 06:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvf4l-00054e-Tp
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:55:48 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvf4j-0007jr-T9
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:55:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id k6so2140338wrn.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7qWK0GjZ82MFKop4yjjGP+l/StdHfNhEBJIU+kpPJe4=;
 b=muQN5+iFqgp7c2nAiDs0Z7RbaTb5y+GZrn6GmFobii6pjo/TaoqW+T14wwW0uwFeb0
 DdECdJ41Br//VxAmExBX3JO9FGFoxvSvrQpqcteC/iiHaV8KX1enmPH+OOCZXBodzKWi
 /c8NYYGBKrNWEleXOdVpI03dMQu4KPU3upM6ITm3R65ToDhcy9tQR+e7R6dmuqGKD6sY
 Z9rsD2MzAB4W4n725XBingTfl5qi7VrIZYqxJKugvArXXheuRY16xoWl6c5ujBzcTU75
 dQUaryTkaVr26HIQpC2dKpBGFVmUb8Uwf9KA5Vth0b6XJX9sd2YYcuRh3Xw8X50nMolP
 7yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7qWK0GjZ82MFKop4yjjGP+l/StdHfNhEBJIU+kpPJe4=;
 b=IjIpDD/rYILtqxheo80GglY8b3/5ZfqJgyx3jsKQ2ISnNCjJRYCN6xWlkyDW4gBDuq
 g4w447zzEz3Yr5TYmY2xwJotzMRN082mOBtacszpfSqMFhr5yHTc2EQ0pvD6f9eMpSDO
 RNgPs4CexGiojE2fhGIefYkwm4xbriAR/RSrR0GlmEhNxfx7bZru0bwofjElOVBoMT2x
 GZhnkz/Vz/Qvr7oeGBGKQDTh7AamujgmCi2zyYy/WAbz/WdoGqDJGSEtEA5+iRhdblTy
 zsiLpLwz/Oon30yIeUOWxFPzre7xOgRqwH4VXnGsesgvQg8ZaBRYV8y1l+mZi4UCgHrE
 2EJA==
X-Gm-Message-State: AOAM531rHxmZDIlV/ZBbA2O0tWt0LjSK+uiRKsKqbAyPcXcG4y/NrvW3
 VJexRHgbkVee8uxzCKePRhG1sg==
X-Google-Smtp-Source: ABdhPJxy3DfJHXgvqySyzw6wVNbOnQpTOn/fJ6lLYXSTgTzhFOkqub/0pRIVNSppxn+0nZ/VwAMVOQ==
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr11106326wrn.9.1594810543935;
 Wed, 15 Jul 2020 03:55:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm3551792wrb.78.2020.07.15.03.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 03:55:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A57D1FF7E;
 Wed, 15 Jul 2020 11:55:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 0/8] final misc fixes for 5.1-rc0
Date: Wed, 15 Jul 2020 11:55:42 +0100
Message-Id: <20200715105542.14428-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Dropped configure patch

---
The following changes since commit c920fdba39480989cb5f1af3cc63acccef021b54:

  Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2020-07-13-tag' into staging (2020-07-14 21:21:58 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-misc-for-rc0-150720-2

for you to fetch changes up to 406b53c9ca669b8551d4cde27f2cde03135d0d1d:

  plugins: expand the bb plugin to be thread safe and track per-cpu (2020-07-15 11:52:43 +0100)

----------------------------------------------------------------
Final fixes for 5.1-rc0

  - minor documentation nit
  - docker.py bootstrap fixes
  - tweak containers.yml wildcards
  - fix float16 nan detection
  - conditional use of -Wpsabi
  - fix missing iotlb data for plugins
  - proper locking for helper based bb count

----------------------------------------------------------------
Alex Bennée (5):
      docs/devel: fix grammar in multi-thread-tcg
      docker.py: fix fetching of FROM layers
      tests/plugins: don't unconditionally add -Wpsabi
      cputlb: ensure we save the IOTLB data in case of reset
      plugins: expand the bb plugin to be thread safe and track per-cpu

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
 tests/docker/docker.py                     | 16 +++--
 tests/docker/dockerfiles/ubuntu2004.docker |  3 -
 tests/plugin/Makefile                      | 22 +++++--
 11 files changed, 172 insertions(+), 31 deletions(-)

-- 
2.20.1


