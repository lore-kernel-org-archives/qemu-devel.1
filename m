Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADE9C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B2320881
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0gudha+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B2320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcxQ-0003c3-7w
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:19:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv4-0002P0-KO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv3-0006Wo-IG
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:16:58 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcv3-0006Vj-B2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:16:57 -0400
Received: by mail-pf1-x441.google.com with SMTP id b76so5074pfb.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Jmxq8pOlAwfl3F50eFuuzmJLrdIBBNFUSo2LQdUjDJU=;
	b=R0gudha+BWDi5tb4vB+mC0H86MENW7byMaalyOt05Ru/0nU5aEtzMv4rKOt4gFNn5k
	N939mNlMauI52C/VVignFzQ0YtCGQYBOgLUbUZ1cBlvVuY/p8HY9esmG45xtcQ+o8vn4
	xtZa/TRp/U0fYGS54q6ZJdwE3J22YVOLtaTlvPdePsAQ/8IGtNOPlp400l4mrAP7uQAt
	JJ4JDkddH0AjGExzvdeqna6xOSznrZL0Lgia+ZjvIoF+OH3D+hHqWuAbn22DTEEnyNsr
	6kVkqdOFjK/LkWt99rnP+To0O8izseEr65CMzyAt3fLFHrKWFAW8bGZzCopF0GuUUUT/
	dEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Jmxq8pOlAwfl3F50eFuuzmJLrdIBBNFUSo2LQdUjDJU=;
	b=YTDcg2mCkDKssJPxnjwdvltj51cHnufy7jbU/hFaTpkPAjETfBPPKWsQuA6BStxOwW
	jWmZaHJ6s9ZYQb0qxOpMHveGCqKUZr3+26agd0aouzGolcH/j70XzQtSHw4hWshMXD8h
	OdyCKcxwTstBr+4wQuIrZorr8utp59T/QORgpbkq4GCCgTrpTOwY7hKcS4hgb20zQKI8
	7TKsv8mqdgk3cHcYVaouE0VBBScIq/1Akz1xx3HDKtylfp+PZNhJuWY85LH6u8tSr2eY
	T+X1vcqyaqifOy3CLvF/EhJS27OWcYX2o21zS73vgMR9N8T8k8IW3NJVAp0vCRhnBfLl
	gNsg==
X-Gm-Message-State: APjAAAWB/P3sSVd5hIUvGj+tCrMKQb2Wg5jiZTZVQT1ZhBmhysDGfaT5
	mZp5ojsepaFgtgsui4rNROroCvnh7ks=
X-Google-Smtp-Source: APXvYqxVX8DbGVNxSMGe64ylZKUd7GrlU+Kae6ih/WB6Qp6gQU57zurqFGvpLZWwmDj3/UuWTo8tog==
X-Received: by 2002:a62:5b81:: with SMTP id
	p123mr43856746pfb.158.1557861415403; 
	Tue, 14 May 2019 12:16:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.16.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:16:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:29 -0700
Message-Id: <20190514191653.31488-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 00/24] Add qemu_getrandom and ARMv8.5-RNG etc
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v6:
  * Drop the crypto-obj-y, crypto-aes-obj-y, and configure changes.
    This fixes the regression visible in make check-unit, due to
    objects not being pulled in from libqemuutil.a.
  * Add a crypto-rng-obj-y, and force it to be random-platform.o.
    This avoids attempting to link the crypto libraries into the
    user-only binaries.  Which in turn means we can drop all of
    the configure changes to cope with the crypto libraries not
    having the static libraries packaged by recent distros.

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


Richard Henderson (24):
  build: Link user-only with crypto-rng-obj-y
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
  linux-user: Call qcrypto_random_init if not using -seed
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

 Makefile                            |   6 +-
 Makefile.objs                       |   1 +
 Makefile.target                     |   3 +-
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
 linux-user/main.c                   |  33 +++++----
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
 configure                           |  18 ++++-
 crypto/Makefile.objs                |   1 +
 qemu-options.hx                     |  10 +++
 util/Makefile.objs                  |   1 +
 36 files changed, 566 insertions(+), 221 deletions(-)
 create mode 100644 include/qemu/guest-random.h
 create mode 100644 util/guest-random.c

-- 
2.17.1


