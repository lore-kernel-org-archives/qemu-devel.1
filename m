Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564BBC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2439521D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F12q7TL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2439521D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHdT-00052r-DJ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcN-0003LW-39
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcJ-0003wL-B4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f18so4419721wml.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L2383ygox23OkXNGUUP7eYuUraK/rzJVGt7aIDSFsLs=;
 b=F12q7TL7D2oHKEZ2QfH0fK3+sQ4UIqcvKLfIqcaZBMM1R6Z5VV1RRYBRLIwpEobGuq
 yHoGXvziLQbwCKt7xQYTIchWlIQ7Mu7j39nWBOx+57V+dFlSGOZrFoS1go/mfJ29g2o0
 n6QbahsfUL+vVaFkFkSqjQqhN8ensXOalcLAU8CNMYMQsOvttXXc10kAaFw+1yIz+ASx
 uR/p5UnjlBoEX2yh3SC4ggdSXOhvqdypinbO65hRAoemyMhC/RPRUyFD3OX3liWiUZF2
 HB3tMKGFzLTsdGNnkQbi8YPQQQ/hqT9bWoY8vV5kCmIp80KatcHmoSMtYjUk7YO+JcTQ
 Q7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L2383ygox23OkXNGUUP7eYuUraK/rzJVGt7aIDSFsLs=;
 b=b3NFi8lIfQIUy466Fua3b/7Ru2K8Ptdg0QnTZYsCQONaiPnzSX2gWdfg7npjDc6MJ+
 8igXobCGtk5n747EZCY2eUxbdeFhOpo/cgm19GcHloPrg0Vz/GfVAy8uQ0p/FsmaXjjS
 wIN8XRE/rAs+YJCKRa78NOo+LySt9390ndxT/hUBktgYOgmufWdqgvLyjRkU/det67t4
 Zyc7zpL8oWSgAoQkdXGtzjlTd+0G7eYsy1QmUiYW8E80JLYOc4xS1eUM1uym4kGrmLCf
 ZCY/03akwl3tzoCbnqnptN5nli6njVhGLNu1/zKJdPfenqUWb2/uLEKsAaAZHkmknDxH
 8kKQ==
X-Gm-Message-State: AOAM532wh7b4pcDsw+sJ4Yx0Tp7Z/hgB1s//i2npAoyX/aJ8SqpWiomN
 kRFQ0z71kx30BR4AEju/MG8h6Q==
X-Google-Smtp-Source: ABdhPJwVsJHaEBSZl8u7jlD5tpR9/MC4rXc2HNyQmDmz/9cRkk002c0dM/d2UgfvdmBl7BusZUUB6g==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr3372432wmc.109.1594720369516; 
 Tue, 14 Jul 2020 02:52:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k11sm30852815wrd.23.2020.07.14.02.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:52:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D1161FF7E;
 Tue, 14 Jul 2020 10:52:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 0/9] final misc fixes for 5.1-rc0
Date: Tue, 14 Jul 2020 10:52:38 +0100
Message-Id: <20200714095247.19573-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c46:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-request' into staging (2020-07-13 16:58:44 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-misc-for-rc0-140720-1

for you to fetch changes up to 4e6400c97024c2660b6db8aab1f0677744449f36:

  plugins: expand the bb plugin to be thread safe and track per-cpu (2020-07-14 09:08:25 +0100)

----------------------------------------------------------------
Final fixes for 5.1-rc0

  - minor documentation nit
  - clean all deps on re(configure)
  - docker.py bootstrap fixes
  - tweak containers.yml wildcards
  - fix float16 nan detection
  - conditional use of -Wpsabi
  - fix missing iotlb data for plugins
  - proper locking for helper based bb count

----------------------------------------------------------------
Alex Bennée (6):
      docs/devel: fix grammar in multi-thread-tcg
      configure: remove all dependencies on a (re)configure
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
 configure                                  | 18 +++---
 include/hw/core/cpu.h                      | 16 +++++
 include/qemu/typedefs.h                    |  1 +
 accel/tcg/cputlb.c                         | 38 +++++++++++-
 fpu/softfloat-specialize.inc.c             |  4 +-
 tests/plugin/bb.c                          | 97 ++++++++++++++++++++++++++----
 .gitlab-ci.d/containers.yml                |  1 +
 tests/docker/docker.py                     | 16 +++--
 tests/docker/dockerfiles/ubuntu2004.docker |  3 -
 tests/plugin/Makefile                      | 22 +++++--
 11 files changed, 178 insertions(+), 40 deletions(-)

-- 
2.20.1


