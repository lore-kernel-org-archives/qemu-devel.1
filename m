Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6632CC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2900220753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJYTeLWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2900220753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMeXt-0003Sx-9A
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWN-00020b-CO
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWM-0005c3-3Y
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeWL-0005bT-MP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id x25so294207wmc.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OeN3eXdkXia8ZkoSZAXoSX+KIk4vlSNaSTigpp+WF0g=;
 b=UJYTeLWj4xgku/+Yjp6XdCxSzIlgFEuErA6dTEOnFyDo6J558oUqBFeymIZY92dOgp
 Hs+qsAVYokQzJq7KJLA7epgf/Wd1ugMUPnaw65EDxN2jrItZjt2bQEgT7cHumg2DzR+r
 hGHUfNW8Di8JurKRed3Sdo8YCuZhTmIWKq4gOoAD9oeePYv8uiEDmvF1nDZi5b/iavxs
 hu3ELNa99Q8m4E9PyJyPG+4eko7yTYaRK2R8mN00GkCInXd1zoRz955Az0TsWl6+MGxq
 XGNvitbV4E2GIWtt7Eg0dpwa65SRKXy6lfSJI/Uk8b9MM3YH2FgRJUnKhJI+U/E0nSXe
 c1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OeN3eXdkXia8ZkoSZAXoSX+KIk4vlSNaSTigpp+WF0g=;
 b=dfslEhLrBkwq5AC+Objm4F6hqotTI70nlkaKn0q6kKQpbLkfr4aGy4kyDRJIKz5ck1
 p4lWDwWGvZLUBSxfN/soevg9HoH+yOdkAcjVeeAm3RkLHxRitowiGojcMhzmdllJQcxj
 F7r1nyFH5qQpYNgtxtLyGRa2GMyxY0AwqEnSElC9+NNP84Cz/GL6KaR0BseQfdx5UYXa
 hpg0N2Nwt4sQ1Wn1HZRSzhWlJeQm+Bspd796eYLG8vlOeskvHysTSNCrN8rFjlMUFQsj
 KJfEM+jUd2LnRn5Kd6gS0BgYKNjUgntetyNcT+j/l2/k1CcDbz3IOKkrJbSJVVxkctk6
 2U0A==
X-Gm-Message-State: AGi0PubqGX50+DbBCSYv7P4i65BascH5WMTYdCP/K8KkiaUuy0fDMmj7
 6H5MGWbYHTsXNUbFcDTIYZeZfce/NBk=
X-Google-Smtp-Source: APiQypKpxIdg1PrHGWUfWo6vGikmqRNamCG24plMV2iNpX1gubm46Er+WIZ0+Wb36zu9gjqa/RIXoQ==
X-Received: by 2002:a1c:7f91:: with SMTP id a139mr1673582wmd.164.1586466932097; 
 Thu, 09 Apr 2020 14:15:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k185sm5340125wmb.7.2020.04.09.14.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:15:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 064011FF7E;
 Thu,  9 Apr 2020 22:15:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 5.0-rc3 v1 00/11] more random fixes
Date: Thu,  9 Apr 2020 22:15:18 +0100
Message-Id: <20200409211529.5269-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

Here are some more random fixes for the tree. In no particular order
we have:

  - A couple of bugs found in the gdbstub GByteArray conversion
  - A trivial fix to /proc/self/stat output
  - An attempt to fix broken PIE builds for Windows (please test!)
  - Some fixes to get "make docker-all-tests" running again
  - Some travis MacOSX tweaks

I've also included the guest base re-factoring patches as it makes it
easier for me to soak test the tree with the sanitiser although those
actual fixes won't go into 5.0 at this late stage.

The following patches need review:

 - linux-user: fix /proc/self/stat handling
 - configure: disable PIE for Windows builds
 - configure: redirect sphinx-build check to config.log
 - tests/docker: add docs FEATURE flag and use for test-misc
 - linux-user: completely re-write init_guest_space

Alex Bennée (5):
  linux-user: completely re-write init_guest_space
  tests/docker: add docs FEATURE flag and use for test-misc
  configure: redirect sphinx-build check to config.log
  configure: disable PIE for Windows builds
  linux-user: fix /proc/self/stat handling

Peter Xu (1):
  gdbstub: i386: Fix gdb_get_reg16() parameter to unbreak gdb

Philippe Mathieu-Daudé (2):
  target/m68k/helper: Fix m68k_fpu_gdb_get_reg() use of GByteArray
  .travis.yml: Build OSX 10.14 with Xcode 10.0

Richard Henderson (3):
  exec/cpu-all: Use bool for have_guest_base
  accel/tcg: Relax va restrictions on 64-bit guests
  linux-user/ppc: Fix padding in mcontext_t for ppc64

 configure                                  |   3 +-
 include/exec/cpu-all.h                     |  25 +-
 linux-user/qemu.h                          |  31 +-
 target/alpha/cpu-param.h                   |  15 +-
 accel/tcg/translate-all.c                  |  15 +-
 bsd-user/main.c                            |   4 +-
 linux-user/elfload.c                       | 503 ++++++++++-----------
 linux-user/flatload.c                      |   6 +
 linux-user/main.c                          |  27 +-
 linux-user/ppc/signal.c                    |  69 ++-
 linux-user/syscall.c                       |  43 +-
 target/i386/gdbstub.c                      |   2 +-
 target/m68k/helper.c                       |   4 +-
 .travis.yml                                |   4 +-
 tests/docker/dockerfiles/debian10.docker   |   2 +
 tests/docker/dockerfiles/debian9.docker    |   2 -
 tests/docker/dockerfiles/fedora.docker     |   2 +-
 tests/docker/dockerfiles/travis.docker     |   2 +-
 tests/docker/dockerfiles/ubuntu.docker     |   2 +-
 tests/docker/dockerfiles/ubuntu1804.docker |   2 +-
 tests/docker/test-misc                     |   2 +
 21 files changed, 375 insertions(+), 390 deletions(-)

-- 
2.20.1


