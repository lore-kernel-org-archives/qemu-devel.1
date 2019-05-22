Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB74C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AB820879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/fIfVMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AB820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49889 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWgf-0007gZ-IW
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:14:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOt-0008Ln-6n
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWC6-00080c-9p
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:31 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:37544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWC6-000805-3D
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:30 -0400
Received: by mail-yb1-xb44.google.com with SMTP id z12so1260630ybr.4
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=3HXhWiXhtEMLGfFYkgwloyr++oYbdfXbGtlmckF18hg=;
	b=S/fIfVMU1NMGhqWi/MAvHe57MZq5QObzlMWiPTXxSKcTvc4QOD2QKQWn1zcFLXaodT
	Y7cLo8wH/pUUL0Q5Bh4F0Wl1kSoDfVui0qhQuj4E60+3u00Qb9v/lNK3kQvaLeCNdMIW
	lFs8MAocRqLCtQztlJxwz6lDLKidUcfCfKcx4j1+gu+BscPy6dcCEE+rbN6ohQK8yxPK
	Jk6wsk8jhHCwltCXU9xsHW9oKe2kJoZcY9TJS8IyYiEQ16wGVxFW/zn9upe8jk/Imivp
	VgMn9qVkBxccd18SI277zkHTCkpZyN+Xo7jENyS270Y3AUbDyqzAnE9A0txysuK4SB1T
	qkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=3HXhWiXhtEMLGfFYkgwloyr++oYbdfXbGtlmckF18hg=;
	b=fwya1f0QVTGhJ0iTapcwvCYtmrSNrVT+ghSlVOB9UPssZrWjPi7gPrxAKDAgog+R+N
	TUnx3tKfv0PytNpmBK18p/0W02ONB5xF+GJzdT8pxC3j0NxpCBcqxqcr4xfubz9hgSi5
	9EAX60trZwuxRLRrk3ICWo4R/p6p7bW/zZl6Zz+HcEMCESIL8owrpm+krZX8FnpnmQfy
	xYJDQN1aQTtr+mXqwWUjPWCFyA69Eru456aauoJl7ywCQEvibsJOTXjfsnSyet44MoKC
	pcv+xEZblDOQCluGXzghx0nOmXFf+P21Ob/zJ8WYWzbL4OP+PnymoXdCNIBDsUscFPpf
	349Q==
X-Gm-Message-State: APjAAAV0jKGetnMD6YXUIKm7XErvVdkQe2drFMY5fN/uTIbLQ5ElAjdm
	0+Ad6D7We8rPxcrfN1lfloNRJ5p5Lqk=
X-Google-Smtp-Source: APXvYqwMFDTBS+TWRh1mvMRwI7FdKOumyWVoDv86y5oGm/3H5b5xnT/GeBEelpJdigJRwFiNIgKbhQ==
X-Received: by 2002:a05:6902:4c4:: with SMTP id
	v4mr11903229ybs.522.1558550548319; 
	Wed, 22 May 2019 11:42:28 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:01 -0400
Message-Id: <20190522184226.17871-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [PULL 00/25] Add qemu_getrandom and ARMv8.5-RNG etc
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is v8, rebased to avoid a conflict with 8d5d515a0fb
("build: chardev is only needed for softmmu targets"),
which affected patch 2.

Daniel and Laurent gave me acks for issuing a pull request
touching their subsystems.  The reasonable thing seemed to
be to put those into the log for the signed tag itself.


r~


The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-rng-20190522

for you to fetch changes up to 369fd5ca66810b2ddb16e23a497eabe59385eceb:

  target/i386: Implement CPUID_EXT_RDRAND (2019-05-22 12:38:54 -0400)

----------------------------------------------------------------
Introduce qemu_guest_getrandom.
Use qemu_guest_getrandom in aspeed, nrf51, bcm2835, exynos4210 rng devices.
Use qemu_guest_getrandom in target/ppc darn instruction.
Support ARMv8.5-RNG extension.
Support x86 RDRAND extension.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Laurent Vivier <laurent@vivier.eu>

----------------------------------------------------------------
Richard Henderson (25):
      configure: Link test before auto-enabling crypto libraries
      build: Link user-only with crypto random number objects
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
      target/ppc: Use gen_io_start/end around DARN
      target/ppc: Use qemu_guest_getrandom for DARN
      target/i386: Implement CPUID_EXT_RDRAND

 Makefile                            |   4 +-
 Makefile.objs                       |   2 +-
 Makefile.target                     |   4 +-
 include/crypto/random.h             |   2 +-
 include/qemu/guest-random.h         |  68 +++++++++++++++++++++++
 include/qom/cpu.h                   |   1 +
 linux-user/aarch64/target_syscall.h |   2 -
 target/arm/cpu.h                    |  17 ++++--
 target/i386/helper.h                |   2 +
 cpus.c                              |   9 ++++
 crypto/random-gcrypt.c              |   2 +-
 crypto/random-gnutls.c              |   2 +-
 crypto/random-platform.c            | 104 +++++++++++++++++++++---------------
 hw/misc/aspeed_scu.c                |  10 +---
 hw/misc/bcm2835_rng.c               |  32 +++++------
 hw/misc/exynos4210_rng.c            |  11 ++--
 hw/misc/nrf51_rng.c                 |   4 +-
 linux-user/aarch64/cpu_loop.c       |  25 +--------
 linux-user/elfload.c                |   8 ++-
 linux-user/main.c                   |  33 +++++++-----
 linux-user/syscall.c                |  34 ++++++++++--
 target/arm/cpu64.c                  |   1 +
 target/arm/helper.c                 |  64 ++++++++++++++++++----
 target/arm/pauth_helper.c           |  18 +++----
 target/i386/cpu.c                   |   5 +-
 target/i386/int_helper.c            |  21 ++++++++
 target/i386/translate.c             |  62 +++++++++++++++------
 target/ppc/int_helper.c             |  39 +++++++++-----
 target/ppc/translate.c              |  21 +++++---
 ui/vnc.c                            |  53 ++++++++----------
 util/guest-random.c                 |  93 ++++++++++++++++++++++++++++++++
 vl.c                                |   4 ++
 configure                           |  87 ++++++++++++++++++++----------
 crypto/Makefile.objs                |  11 ++--
 qemu-options.hx                     |  10 ++++
 util/Makefile.objs                  |   1 +
 36 files changed, 610 insertions(+), 256 deletions(-)
 create mode 100644 include/qemu/guest-random.h
 create mode 100644 util/guest-random.c

