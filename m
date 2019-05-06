Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD86C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C4E2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsUqxGn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C4E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhZo-0005QB-FF
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:38:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhV9-00010n-3N
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhV1-0001DY-2u
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:05 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:32971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhUz-0001B9-3k
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:33:59 -0400
Received: by mail-pg1-x533.google.com with SMTP id h17so818146pgv.0
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=t6K9H9ZedbXjgIHd72pGKvgDa31zNSFMotfLs815cMc=;
	b=TsUqxGn1l4puiWFrkxMIHF3PWwoyi+XukL/yRVilotMAfciEPtIdQPvprUUozJgYik
	kLKvhi6239QYz+BpGkO5paE/iycJ2fVLaOyvQGd72W8v0LjmkI9fdTUq0WIAs0Y5UzbF
	Sgd72zsMPSbuqs32vYlt05HNYKMaa+D+gYmn5xTo7V5UqNlzwJuW0CXQTbOLHXNGL4vD
	YOOyH3sTXMSYnykMG6B9V7Utqg/95LPR9eyXgDxrCO/p83CD8+NJ7rWu/VF6rXz8d5VA
	eUr5l4pMsXd1unsSdFIkbOgn5JSZfBd3SXvs5nsnVW9oHT2vEV0DDJtCuqQ/MOxzipVP
	wQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=t6K9H9ZedbXjgIHd72pGKvgDa31zNSFMotfLs815cMc=;
	b=rVjsRGe9DAFHCRP+2PmweDewEnMa+tBrvTJDnDk/luwAKEy3+hHa1DbWzL2zUktMq2
	8drpUSmbr7Lzpj+Y1GNsqVFzRXIsSK/TNriwzXp0Wum+rYQ+tHaMefOaO6wysz6/u7sP
	pBBQjgJPhZowYmPwKuetTEZBlkLCXlfHZmn5JYhSGDZ05lHN3XZZZ6YYqKNE/ITMdCAQ
	bt7XSL8g4DAhdflpSMZPBrSm/1hc+/Uh5AbJQmIchCBMERv2a/+b2IrBWSKBlgfxYpf5
	sQGZK/AXNJaItoEiEQb5t7dpNeR8i4jS12/8YcPgydy3ZkbzAm7onLSQUiLzJ5NX0ASt
	4KoQ==
X-Gm-Message-State: APjAAAUTZ7iUKWj67Thrpz8fslYdRKQ5gbVXenKedRnu8UDRZ4sSQ798
	4bOHbiwvADf8n+SzjBFDNMjuxM9OXGA=
X-Google-Smtp-Source: APXvYqxbYwWc/BFDeXNRp7yrLE8i/tIYFb3aet65fSAO42my8SGohS/s9gvj6urPgXmWXGNCtR53Tw==
X-Received: by 2002:a63:2b41:: with SMTP id r62mr33749298pgr.403.1557164035536;
	Mon, 06 May 2019 10:33:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.33.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:33:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:29 -0700
Message-Id: <20190506173353.32206-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: [Qemu-devel] [PATCH v4 00/24] Add qemu_getrandom and ARMv8.5-RNG etc
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

Patches without review/ack:

0001-configure-Link-test-before-auto-enabling-gnutls.patch (new)
0002-crypto-Merge-crypto-obj-y-into-libqemuutil.a.patch
0022-target-arm-Implement-ARMv8.5-RNG.patch
0024-target-i386-Implement-CPUID_EXT_RDRAND.patch


r~


Richard Henderson (24):
  configure: Link test before auto-enabling gnutls
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
 target/ppc/int_helper.c             |  42 +++++++----
 ui/vnc.c                            |  53 ++++++--------
 util/guest-random.c                 |  93 +++++++++++++++++++++++++
 vl.c                                |   4 ++
 configure                           |  42 ++++++++---
 crypto/Makefile.objs                |   5 +-
 qemu-options.hx                     |  10 +++
 util/Makefile.objs                  |   1 +
 35 files changed, 562 insertions(+), 243 deletions(-)
 create mode 100644 include/qemu/guest-random.h
 create mode 100644 util/guest-random.c

-- 
2.17.1


