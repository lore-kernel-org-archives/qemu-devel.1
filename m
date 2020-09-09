Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5637DC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D914421D80
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDdlMdSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914421D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFyHM-0001SQ-Pp
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGR-0008OO-E7
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGP-0006WO-LI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id o5so2491743wrn.13
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rG94hKRoVshdQh3a7521VAVuAxq1uMswWmYZISRE+co=;
 b=iDdlMdSyBBl3RO0Zs7hMFUPbfoskXgITg+xhIicZTYU/iF2PWLoxMLHJX1evlyKoib
 eMwr90forIJXHp70alyLQapLdTRXHUhTQAulGBrgzhYzwpRBfDQQRHQMtuR07rVbM0O6
 j+GctnDbOwS7BmFaKX7qi+TEYXdLwo7xW+4/4WoqjRWCE27NQWb40ZnTxm0bCMDDyPb2
 71ZgYD5tJ6jtMTozopsmC0HP7qYZlGFkYRSlRIhVY8Cdd+E+eUTqGH9d+KNvIS+qqo5d
 +Oc9+AuHSc+4iYxOSiPOgKRr1k6fRwjby8daZsYyWBcZiXhmjH6m0HL1VQI0n2mZ6WAl
 ykjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rG94hKRoVshdQh3a7521VAVuAxq1uMswWmYZISRE+co=;
 b=rLF2mtCo/FhAGaqC8VcvXT1iU4qH5pXa4cJd2uU8c7aVey67EocUbIGl2d+3hCoiYa
 a9siDClW1uTyH48Rq+aYq2wYEvo1a43LTRKstSigZVDASPX++sCiKMvw8AmkG7dCqjAN
 yHM+/o1nGwoC6/2ueMVDvwrLL3/sfNIU/Xb+NoNdbDur8eozAb9CdJK70JZphCP/Lcju
 8x+GcUEnX8Pus3ntWxe+zUpxGGgUtK1RjtBop9irQ3yeKL7V769RG0Z9p33pARaOV5i4
 jMubY1i/wuybob1VN6xIH7t2M+S2+PabbVcNBU7fct5nUjQ2Yg+LjzBxywEsvC6YfxzA
 U3OQ==
X-Gm-Message-State: AOAM531JkUWZdme35GXX7AWdMlX0XAYpmR/p9t4FBr8BRs1EIilyykkn
 CIL9ebp7zoHv1G5M1uLUaKr7ug==
X-Google-Smtp-Source: ABdhPJzuSXVHrHL9v9QxjgZujwTMJssamfW20dgKHJJF1h3WdZw86nIf6XMqZwX7P9eJXgLIjBvgsQ==
X-Received: by 2002:adf:eb86:: with SMTP id t6mr3346635wrn.411.1599650863889; 
 Wed, 09 Sep 2020 04:27:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m1sm3580427wmc.28.2020.09.09.04.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 04:27:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C0E21FF7E;
 Wed,  9 Sep 2020 12:27:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 00/10] testing and misc updates
Date: Wed,  9 Sep 2020 12:27:31 +0100
Message-Id: <20200909112742.25730-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should form the basis for my next PR. I've brought one patch from
my plugins tree (split between tests and contrib) which avoids the
overly long test times. There is a new patch to squash a compiler
warning and also Phillipe's tweaks to the acceptance tests while we
decide what to do about the larger problem of disappearing binaries.

The following still need review:

 - plugins: move the more involved plugins to contrib
 - hw/i386: make explicit clearing of pch_rev_id
 - configure: don't enable ppc64abi32-linux-user by default
 - tests/meson.build: fp tests don't need CONFIG_TCG
 - CODING_STYLE.rst: flesh out our naming conventions.

Alex Bennée (7):
  CODING_STYLE.rst: flesh out our naming conventions.
  tests/meson.build: fp tests don't need CONFIG_TCG
  target/mips: simplify gen_compute_imm_branch logic
  docs/system/deprecated: mark ppc64abi32-linux-user for deprecation
  configure: don't enable ppc64abi32-linux-user by default
  hw/i386: make explicit clearing of pch_rev_id
  plugins: move the more involved plugins to contrib

Gerd Hoffmann (1):
  usb-host: restrict workaround to new libusb versions

Pavel Dovgaluk (1):
  tests: bump avocado version

Philippe Mathieu-Daudé (1):
  tests/acceptance: Add Test.fetch_asset(cancel_on_missing=True)

 docs/devel/tcg-plugins.rst                    | 142 ++++++++++++++++++
 docs/system/deprecated.rst                    |   7 +
 CODING_STYLE.rst                              |  37 ++++-
 configure                                     |  48 +++---
 Makefile                                      |  11 ++
 {tests/plugin => contrib/plugins}/hotblocks.c |   0
 {tests/plugin => contrib/plugins}/hotpages.c  |   0
 {tests/plugin => contrib/plugins}/howvec.c    |   0
 {tests/plugin => contrib/plugins}/lockstep.c  |   0
 hw/i386/pc_piix.c                             |   2 +-
 hw/usb/host-libusb.c                          |   2 +-
 target/mips/translate.c                       |  12 +-
 .travis.yml                                   |   2 +-
 MAINTAINERS                                   |   3 +-
 contrib/plugins/Makefile                      |  42 ++++++
 tests/Makefile.include                        |   4 +-
 tests/acceptance/avocado_qemu/__init__.py     |  12 ++
 tests/meson.build                             |   3 +-
 tests/plugin/meson.build                      |   4 +-
 tests/requirements.txt                        |   2 +-
 tests/tcg/Makefile.target                     |   3 +-
 21 files changed, 293 insertions(+), 43 deletions(-)
 rename {tests/plugin => contrib/plugins}/hotblocks.c (100%)
 rename {tests/plugin => contrib/plugins}/hotpages.c (100%)
 rename {tests/plugin => contrib/plugins}/howvec.c (100%)
 rename {tests/plugin => contrib/plugins}/lockstep.c (100%)
 create mode 100644 contrib/plugins/Makefile

-- 
2.20.1


