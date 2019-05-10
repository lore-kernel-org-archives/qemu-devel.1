Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE60C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990BE217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1gLFe6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990BE217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47490 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9OO-0000JG-Ik
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:33:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9ME-0007IB-JV
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MD-0005xg-Gc
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:54 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:40569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MD-0005x8-7i
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id b3so3137677plr.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=OkPZXGg0Nh2IXPIyKNC1R2CKYIGFO6z1RJMn2bktluY=;
	b=H1gLFe6V2L72CHSW823jCArhXnGXhAJvGbyHVDxEQiqcb8GLXZJQO9563XNWZOHlaN
	9zEZU6GRNQt63yI1tvTUTtpx0DGZHR4bDRwIFcvPVuwOqnUCGbsJbW5iWSHYaHry4fAD
	Q7SyAsQCBiNAF3pAGHkwU6GjwgTQri+C9EwWZi5nHCsUKmwxX1Ecf77fvzrmSzndHsdb
	F5OGef92vk34eNI3GCNMQ3/8c7Z/Pmg5jlIa2gKx5Lg/5SlITxJzQitMDEIZLk4Vrfjl
	bnLpfdeSGeM6qJtiGEnlfKJepEyizqsuo2ZkrdkMIwFTGs5FfaWEidn4bw55yWJf1yn3
	WXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=OkPZXGg0Nh2IXPIyKNC1R2CKYIGFO6z1RJMn2bktluY=;
	b=imFQ+bMUR/DcrEaH929SXDBHmwVdoJL3baGhJXx2rm6TE3L5U6zLx+M4OnAl9Iqymw
	ve8aZ+oQ9KEQn/uXuYELEF5LG9K2o4oNFhmpvbtg+0hpnMCF1P6vygwU9v00lP4mOgQI
	1jw1tTjJGiF1PVurjKi+2i6lV7N0yh/YCxHBWmp/UBVWbPgTv22F/RdeQ5frRqv9c5Md
	BpKXmDAxciIlRp4w1Da8zIkm3mICvG0IXqVjMf79+v1wp3WEQN3wM4EQJGx5Qp9Cna4I
	iz4KCUkfx70+Sc/Dp1APovmnE60gG2RIjljbqGhSpGsnWACHOdEVabPt9JF63dFntifZ
	3tWQ==
X-Gm-Message-State: APjAAAX5UEoMO4QKDoiCbSRuCwv1l1zT3nuuAlFbwiYL3pJneR2wA3TJ
	RRIFtDT+GMrazGn+ssBoSzsJbkTmGJE=
X-Google-Smtp-Source: APXvYqyUHb3XZ84OmxsGzNmd5w+s9aux2K14HH+vtXsIx4gKn7gr49itsHv9QGPDLKSzsEeXlS77rQ==
X-Received: by 2002:a17:902:e104:: with SMTP id
	cc4mr12946897plb.254.1557509451309; 
	Fri, 10 May 2019 10:30:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.30.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:30:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:24 -0700
Message-Id: <20190510173049.28171-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::635
Subject: [Qemu-devel] [PATCH v6 00/25] Add qemu_getrandom and ARMv8.5-RNG etc
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only the new patch 24 lacks review.

Changes since v5:
  * Merge crypto-obj-y into util-obj-y (patch 2).
  * Fix leftover crypto-obj-aes-y reference (patch 2).
  * Add ARM_CP_IO to the RNG registers (patch 22).
  * Issue gen_io_start/end around ppc DARN (new patch 24).
  * Issue gen_io_start/end around x86 rdrand (patch 25).

Changes since v4:
  * Do not autoenable nettle or gcrypt if linking is broken.
    Fixes --static on fedora 30.
  * Delay removal of srand() for -seed.
  * Do not loop for -1 result for ppc64 DARN.

Changes since v3:
  * Do not autoenable gnutls if linking is broken.
    Fixes --static on ubuntu 18.04.

Changes since v2:
  * Changes from review.
    - getrandom is not exclusive of /dev/urandom fallback.
    - vnc fails gracefully on crypto failure.
    - a great renaming.
  * Drop the "nonblock" argument, as it's not deliverable from the backend.
  * Propagate Error back through qemu_guest_getrandom.
  * Add qemu_guest_getrandom_nofail to centralize "Argh! Death!".
  * Convert hw/misc/
  * Implement ppc darn.
  * Implement x86 rdrand.

Changes since v1:
  * Build crypto-obj-y for linux-user as well.
  * Several patches to tidy crypto/random-platform.c.
  * Use getrandom(2) in crypto/random-platform.c.
  * Use qcrypto_random_bytes in ui/vnc.c.
  * In qemu_getrandom:
    - Use g_rand_int instead of srand48.
    - Use qcrypto_random_bytes instead of getrandom directly.


r~


Richard Henderson (25):
  configure: Link test before auto-enabling crypto libraries
  crypto: Merge crypto-obj-y into libqemuutil.a
  crypto: Reverse code blocks in random-platform.c
  crypto: Do not fail for EINTR during qcrypto_random_bytes
  crypto: Use O_CLOEXEC in qcrypto_random_init
  crypto: Use getrandom for qcrypto_random_bytes
  crypto: Change the qcrypto_random_bytes buffer type to void*
  ui/vnc: Split out authentication_failed
  ui/vnc: Use gcrypto_random_bytes for start_auth_vnc
  util: Add qemu_guest_getrandom and associated routines
  cpus: Initialize pseudo-random seeds for all guest cpus
  linux-user: Initialize pseudo-random seeds for all guest cpus
  linux-user: Call qcrypto_init if not using -seed
  linux-user: Use qemu_guest_getrandom_nofail for AT_RANDOM
  linux-user/aarch64: Use qemu_guest_getrandom for PAUTH keys
  linux-user: Remove srand call
  aspeed/scu: Use qemu_guest_getrandom_nofail
  hw/misc/nrf51_rng: Use qemu_guest_getrandom_nofail
  hw/misc/bcm2835_rng: Use qemu_guest_getrandom_nofail
  hw/misc/exynos4210_rng: Use qemu_guest_getrandom
  target/arm: Put all PAC keys into a structure
  target/arm: Implement ARMv8.5-RNG
  target/ppc: Use qemu_guest_getrandom for DARN
  target/ppc: Use gen_io_start/end around DARN
  target/i386: Implement CPUID_EXT_RDRAND

 Makefile                            |  14 ++--
 Makefile.objs                       |   8 +--
 Makefile.target                     |   4 --
 include/crypto/random.h             |   2 +-
 include/qemu/guest-random.h         |  68 ++++++++++++++++++
 include/qom/cpu.h                   |   1 +
 linux-user/aarch64/target_syscall.h |   2 -
 target/arm/cpu.h                    |  17 +++--
 target/i386/helper.h                |   2 +
 cpus.c                              |   9 +++
 crypto/random-gcrypt.c              |   2 +-
 crypto/random-gnutls.c              |   2 +-
 crypto/random-platform.c            | 104 +++++++++++++++++-----------
 hw/misc/aspeed_scu.c                |  10 +--
 hw/misc/bcm2835_rng.c               |  32 ++++-----
 hw/misc/exynos4210_rng.c            |  11 ++-
 hw/misc/nrf51_rng.c                 |   4 +-
 linux-user/aarch64/cpu_loop.c       |  25 +------
 linux-user/elfload.c                |   8 +--
 linux-user/main.c                   |  34 +++++----
 linux-user/syscall.c                |  34 +++++++--
 target/arm/cpu64.c                  |   1 +
 target/arm/helper.c                 |  64 ++++++++++++++---
 target/arm/pauth_helper.c           |  18 ++---
 target/i386/cpu.c                   |   5 +-
 target/i386/int_helper.c            |  21 ++++++
 target/i386/translate.c             |  62 +++++++++++++----
 target/ppc/int_helper.c             |  39 +++++++----
 target/ppc/translate.c              |  21 ++++--
 ui/vnc.c                            |  53 ++++++--------
 util/guest-random.c                 |  93 +++++++++++++++++++++++++
 vl.c                                |   4 ++
 configure                           |  87 +++++++++++++++--------
 crypto/Makefile.objs                |  77 ++++++++++----------
 qemu-options.hx                     |  10 +++
 tests/Makefile.include              |   3 +-
 util/Makefile.objs                  |   1 +
 37 files changed, 644 insertions(+), 308 deletions(-)
 create mode 100644 include/qemu/guest-random.h
 create mode 100644 util/guest-random.c

-- 
2.17.1


