Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B81C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5224A2182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPaTt2Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5224A2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuJY-0007r4-F3
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:27:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHi-0006Ij-SZ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHg-00012Z-VN
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:14 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:40647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHZ-0000sZ-DD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:07 -0400
Received: by mail-pg1-x534.google.com with SMTP id d31so2124713pgl.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=2u+WrSd8xo/S0FMY/ihl1INQm5pe2wd8l2cCz5+JKpI=;
	b=bPaTt2YxNyEJiKkcuoRwBwJ0sMKu17PEx8mDImj/dNM5FOpMIAFhMDVipkB2K7YrwC
	n/xvvTEqXL2+IuPmEPRYS15r9JFg/zIsscSrWY4NUOHFbaAZQTG00QVp75ehPFKdjCoA
	IIjHM27tThbJUz1Z4dsTFM6z42q+6zBdaPd2mN8odbRUFjdA+ikCagWzsGQaBG/mGPDc
	Ju1Wyq753ODGy8k1+JD9+jlTbTDZeqklzCEfyNi+/GPfvRHKgWKqKvXnDeYedg4cI5lW
	TGBUOmhce2igCHNKUH5hCgMOuhmQR7WW9PYLzrRc0LoGqXfrMqM2t8oM57ldU4vh7HFk
	JVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=2u+WrSd8xo/S0FMY/ihl1INQm5pe2wd8l2cCz5+JKpI=;
	b=GzXly/U5JimO9FiQ8rgzoxgp1DbWiOUHjwKeunooAL9Vq4qOndUOqaU18BBLPQYTCU
	sBOb9l4E8SG/mwnrOsr1B3rQRmSKBa3qOmizbjUhJHTmR3GQd6sckaEHeqb0RUE6Yccm
	Yd+Vz39mVcG9eWfuzesCGK4tvcVGk8SjVDYvmR8V9jSl44Lr6dcMSN1LvkkMc1zkMGNQ
	jA8AUMzvrPm+70aKAV64k+g6l8VWU7mFUwf8yqUVUC4lFexs9732bqJVHB+WOLUJRgmQ
	6r+luDuwmolR30v+y06atjNycDF1D64kSj9J/JFL5XTn1h5GSSMZs9ZL5kH4PeYhTCZE
	EIvA==
X-Gm-Message-State: APjAAAUCZD6PLm82FcuOAKARR9HN5Fnyw2cEgEG1JxkDfLCFAEOteZLB
	zIxhyEmSsjw0kogSPAYgIgJSFPWrlXA=
X-Google-Smtp-Source: APXvYqw6RF1kxZ0HOJaAOZNHfVSECcJ/mNOtJRDjqXk+QVBAm3yOhGs/boXSMhIsSfAHCfNh2FnIPg==
X-Received: by 2002:a63:a849:: with SMTP id i9mr9918831pgp.205.1557451500206; 
	Thu, 09 May 2019 18:25:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.24.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:24:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:34 -0700
Message-Id: <20190510012458.22706-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::534
Subject: [Qemu-devel] [PATCH v5 00/24] Add qemu_getrandom and ARMv8.5-RNG etc
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

Patches without review/ack:
0001-configure-Link-test-before-auto-enabling-crypto-l.patch
0002-crypto-Merge-crypto-obj-y-into-libqemuutil.a.patch
0022-target-arm-Implement-ARMv8.5-RNG.patch

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

Richard Henderson (24):
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
  target/i386: Implement CPUID_EXT_RDRAND

 Makefile                            |  12 ++--
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
 target/i386/translate.c             |  55 +++++++++++----
 target/ppc/int_helper.c             |  39 +++++++----
 ui/vnc.c                            |  53 ++++++--------
 util/guest-random.c                 |  93 +++++++++++++++++++++++++
 vl.c                                |   4 ++
 configure                           |  87 +++++++++++++++--------
 crypto/Makefile.objs                |   5 +-
 qemu-options.hx                     |  10 +++
 util/Makefile.objs                  |   1 +
 35 files changed, 586 insertions(+), 261 deletions(-)
 create mode 100644 include/qemu/guest-random.h
 create mode 100644 util/guest-random.c

-- 
2.17.1


