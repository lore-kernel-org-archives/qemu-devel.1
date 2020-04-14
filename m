Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DB1C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863582064A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugmg9ZRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863582064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORqZ-0007TQ-M5
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpN-0005t8-GG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpM-0005tH-65
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:37 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpL-0005ss-Vx
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:36 -0400
Received: by mail-wr1-x42a.google.com with SMTP id d27so6805361wra.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y0IWu5OXnoNPgqTCkYNBaKix2IxxULyLtRLl5UjfPys=;
 b=ugmg9ZRH0ezU+iA2J8fo5RTdnBIb1JYr/yzUYUPYfa8GXFW6cLdkeczpSa06TvqY5g
 QbeO/rNqJGJbiPGshzAEQO6xYgSdonhqg6j7l8Jqsp858MBzcq/3mwkl3oVM3qoTft1W
 y6CP/DPkJzJiwm0lM7VG2vEWQFYkwjw4SV2hUSWScc4H2VWPBEhrPkCNrSqrlrpO2y0R
 SthRDWSHuzCFEwrDffD7n0nJLO3GvSY6iANyZPL/2Wi5Tj1nMvTvIGxbQ9nBjbPx/vZ1
 NKC+n3VkPMBrNgr+n9qwNTPEFMWX309g2vmOdnl+d6A3KTKYMpZL4r3NO+ytp+3f9Rbb
 Tznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y0IWu5OXnoNPgqTCkYNBaKix2IxxULyLtRLl5UjfPys=;
 b=o6z1syXleU9t5oVkS2N9iX8F3eIiQf6OkwRSS7arkoDOykTcVJWfKXH95cmro9Ll4N
 cQBhGxTpcMZBd07v+ZVMplZXpnPZFHX/ZwNfSqWOYUq9Q4DEAfF04jyd3gLMHCjVI2Ri
 t4hqAGNQTWGl9T6UzaP6USwplX3JwYKQKMobsMgP1sSPDLPESXy+DKLT8WhEIFfmFHJH
 /UQJPeIODFNnXw1OgYbWhA/BounHU3e3WAf1hjaPtmTIsGZ1YnqE8Rao+lJ4sMP+X332
 iEyshbEgRZQNTPXCptp+G6ZOxYZ+LpV+T7w+AaIH24In8JDx4AO3nhnWO9Wdwq1u9u3+
 RETA==
X-Gm-Message-State: AGi0PuaL66xuVc8odnkJoWqWkG8UvtHka3A7yQ01vxesJrSTHNrbUj5b
 OUP4wLySiKf6t4MNLzffPpOZew==
X-Google-Smtp-Source: APiQypKjUlL+BO3JkXzX57eme78QNp4bSAE94ThkRBFvVtaWlERpLVQRqx/ZUjfQTu0Gbb5YS+72kQ==
X-Received: by 2002:adf:db41:: with SMTP id f1mr5330739wrj.13.1586894793575;
 Tue, 14 Apr 2020 13:06:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b85sm20541056wmb.21.2020.04.14.13.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 563671FF7E;
 Tue, 14 Apr 2020 21:06:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 for 5.0-rc3 00/17] more randome fixes (user, pie,
 docker and gdbstub)
Date: Tue, 14 Apr 2020 21:06:14 +0100
Message-Id: <20200414200631.12799-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

This is version 2 of my random fixes for rc3 series. In no particular
order we have:

  - A trivial fix to /proc/self/stat output
  - An attempt to fix broken PIE builds for Windows (please test!)
  - Some fixes to get "make docker-all-tests" running again
  - A tweak to .gitignore 
  - A couple of bugs found in the gdbstub GByteArray conversion
  - A new test case for linux-user gdbstub support
  - Which found a few more gdbstub bugs :-/

The m68k FPU patch is definitely a hack but it seemed easier than
disabling completely. The chatter on #gdb seems to be there is some
combination of qemu and gdb tress that does work but I suspect this
needs some maintainer action.

I've dropped the MacOSX travis patch as Travis has hopefully sorted
itself out.

I've also included the guest base re-factoring patches as it makes it
easier for me to soak test the tree with the sanitiser although those
actual fixes won't go into 5.0 at this late stage.

The following patches need review:

 - tests/tcg: add a multiarch linux-user gdb test
 - tests/tcg: drop inferior.was_attached() test
 - target/m68k: hack around the FPU register support (HACK!)
 - linux-user: completely re-write init_guest_space

Alex Bennée (9):
  linux-user: completely re-write init_guest_space
  .gitignore: include common build sub-directories
  tests/docker: add docs FEATURE flag and use for test-misc
  configure: redirect sphinx-build check to config.log
  configure: disable PIE for Windows builds
  linux-user: fix /proc/self/stat handling
  target/m68k: hack around the FPU register support (HACK!)
  tests/tcg: drop inferior.was_attached() test
  tests/tcg: add a multiarch linux-user gdb test

Peter Xu (1):
  gdbstub: i386: Fix gdb_get_reg16() parameter to unbreak gdb

Philippe Mathieu-Daudé (4):
  target/m68k/helper: Fix m68k_fpu_gdb_get_reg() use of GByteArray
  gdbstub: Do not use memset() on GByteArray
  gdbstub: Introduce gdb_get_float32() to get 32-bit float registers
  gdbstub: Introduce gdb_get_float64() to get 64-bit float registers

Richard Henderson (3):
  exec/cpu-all: Use bool for have_guest_base
  accel/tcg: Relax va restrictions on 64-bit guests
  linux-user/ppc: Fix padding in mcontext_t for ppc64

 configure                                   |   5 +-
 include/exec/cpu-all.h                      |  25 +-
 include/exec/gdbstub.h                      |  29 ++
 linux-user/qemu.h                           |  31 +-
 target/alpha/cpu-param.h                    |  15 +-
 accel/tcg/translate-all.c                   |  15 +-
 bsd-user/main.c                             |   4 +-
 linux-user/elfload.c                        | 503 ++++++++++----------
 linux-user/flatload.c                       |   6 +
 linux-user/main.c                           |  27 +-
 linux-user/ppc/signal.c                     |  69 ++-
 linux-user/syscall.c                        |  43 +-
 target/arm/gdbstub.c                        |   3 +-
 target/i386/gdbstub.c                       |   2 +-
 target/m68k/helper.c                        |  14 +-
 target/ppc/gdbstub.c                        |   4 +-
 target/ppc/translate_init.inc.c             |   2 +-
 target/sh4/gdbstub.c                        |   6 +-
 target/xtensa/gdbstub.c                     |   6 +-
 .gitignore                                  |   1 +
 gdb-xml/m68k-fp.xml                         |  16 +-
 tests/docker/dockerfiles/debian10.docker    |   2 +
 tests/docker/dockerfiles/debian9.docker     |   2 -
 tests/docker/dockerfiles/fedora.docker      |   2 +-
 tests/docker/dockerfiles/travis.docker      |   2 +-
 tests/docker/dockerfiles/ubuntu.docker      |   2 +-
 tests/docker/dockerfiles/ubuntu1804.docker  |   2 +-
 tests/docker/test-misc                      |   2 +
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py |   3 -
 tests/tcg/aarch64/gdbstub/test-sve.py       |   3 -
 tests/tcg/multiarch/Makefile.target         |  15 +
 tests/tcg/multiarch/gdbstub/sha1.py         |  81 ++++
 32 files changed, 522 insertions(+), 420 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/sha1.py

-- 
2.20.1


