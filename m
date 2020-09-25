Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2EBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5F821741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgHGr84R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5F821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpw0-0000QD-D5
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLppq-0002fY-D6
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLppo-0007ag-6D
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so4062766wrp.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6NYly9DVGNd0iwSQHYlx1RrznyvyAiNTg6sPQ2mc5/4=;
 b=tgHGr84R5wydMnolhzTwswArZh4PrmdnFcY0aICs3QFjpDoi/FBBDXa+8yMMae9hcN
 U/QRm/gRcEvUjSfzychr2T4pWFzfxMAucTFl+hPHQicajB22+uQQy7ENXWYpOytP5Rg5
 aoNA3bVkRH/e02U1tVr1+Eat0JAzcVgBr1X06CJSOMgwHbGdDZe2YT7209B3CCg6F92A
 a7F3dlI4MhHfufkJ5fM+Hen5eTTlPNBYW2pxA7Wd5pUPI+zc2Uwr1f0s2betKFqRa5X0
 57mN60WzoxFlWVeW1LhCqchKGVhq8QlASy9Z/ZB1mWTfj3574jHD+9o1L7PpzgpXpfTR
 3w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6NYly9DVGNd0iwSQHYlx1RrznyvyAiNTg6sPQ2mc5/4=;
 b=eI5AxKNki6ifW6b2b7GpLr405YmZameWk02LBuho857hYXxGhnK3OCNsW8EUzj5Dn3
 c/y0jp/r5OBmsPZZ8pOmCMQuYnQWSrCVmFAfOapstvpVsohWnhlEOyg3iojuPVOjElFu
 poRgamSe/bN+zg9P+67BeSZtrAybGc563d4PU016ugspj04x3stUHKegDVpyvnoodgBh
 cXLuWMuh42R8W3ihlYC3jHOj7xVo97kbyeoKxuNkASzpprKwUX4bq8tfFxabUhB6UMoc
 +KbvQryaafSpnWzBwhsZZgGVe7hJ0JyV4MkmubvaAu4VPmQ841U7pD2wiUckiA7xhqe6
 qVGQ==
X-Gm-Message-State: AOAM533q7RDll3lZw7JCaMTtbkm9K4yXq4xrEt2dwxdWFd0qFZDPBmod
 2UoghXAzfH8biQcozcqhnvKKdg==
X-Google-Smtp-Source: ABdhPJxh8C6ocfKgJORMR5uDz35eOWmaUht41cXmCBdo6+I9JzVUpujqE20PmnLHmRqNQo2h9OXZYg==
X-Received: by 2002:adf:e407:: with SMTP id g7mr5116848wrm.349.1601048430451; 
 Fri, 25 Sep 2020 08:40:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w21sm3499960wmk.34.2020.09.25.08.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 17A571FF7E;
 Fri, 25 Sep 2020 16:40:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/15] testing/next pre-PR (python3.6, check-tcg)
Date: Fri, 25 Sep 2020 16:40:12 +0100
Message-Id: <20200925154027.12672-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is my pre-PR state of testing/next. Mostly it has Thomas'
python3.6 clean-ups for the various CI bits as well as Paolo's fix for
the build system to enable check-tcg to work properly again. I should
cut the PR on Monday.

I think Paolo's fixes are also in another PR but I've left them in
here because a) it makes testing easier and b) it's the 21st century
and git should cope.

Paolo Bonzini (3):
  tests/tcg: reinstate or replace desired parts of rules.mak
  meson: move libudev test
  meson: move libmpathpersist test

Thomas Huth (12):
  migration: Silence compiler warning in global_state_store_running()
  travis.yml: Drop the default softmmu builds
  travis.yml: Update Travis to use Bionic and Focal instead of Xenial
  travis.yml: Drop the superfluous Python 3.6 build
  travis.yml: Drop the Python 3.5 build
  tests/docker: Use Fedora containers for MinGW cross-builds in the
    gitlab-CI
  gitlab-ci: Remove the Debian9-based containers and containers-layer3
  tests/docker: Update the tricore container to debian 10
  shippable.yml: Remove the Debian9-based MinGW cross-compiler tests
  tests/docker: Remove old Debian 9 containers
  gitlab-ci: Increase the timeout for the cross-compiler builds
  configure: Bump the minimum required Python version to 3.6

 docs/conf.py                                  |  4 +-
 configure                                     | 95 ++-----------------
 meson.build                                   | 85 +++++++++++++++--
 migration/global_state.c                      |  4 +-
 .gitlab-ci.d/containers.yml                   | 38 +++-----
 .gitlab-ci.d/crossbuilds.yml                  |  5 +-
 .gitlab-ci.yml                                |  1 -
 .shippable.yml                                |  4 -
 .travis.yml                                   | 55 +++--------
 meson_options.txt                             |  2 +
 tests/docker/Makefile.include                 |  2 +-
 .../dockerfiles/debian-tricore-cross.docker   |  2 +-
 .../dockerfiles/debian-win32-cross.docker     | 38 --------
 .../dockerfiles/debian-win64-cross.docker     | 45 ---------
 tests/docker/dockerfiles/debian9-mxe.docker   | 21 ----
 tests/docker/dockerfiles/debian9.docker       | 32 -------
 .../dockerfiles/fedora-win32-cross.docker     | 42 ++++++++
 .../dockerfiles/fedora-win64-cross.docker     | 38 ++++++++
 tests/qemu-iotests/iotests.py                 |  2 -
 tests/tcg/Makefile.qemu                       | 13 ++-
 tests/tcg/configure.sh                        |  4 +-
 21 files changed, 211 insertions(+), 321 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-win32-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-win64-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian9-mxe.docker
 delete mode 100644 tests/docker/dockerfiles/debian9.docker
 create mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-win64-cross.docker

-- 
2.20.1


