Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BF3C28D18
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC0B2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q4HL3wPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC0B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49967 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYd30-0001n9-RX
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:02:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcyA-00068g-8f
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcy9-00082H-1p
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:14 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYcy8-0007zs-PR
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:12 -0400
Received: by mail-ot1-x341.google.com with SMTP id z24so2087252oto.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=W6HDhQJMBdxe5wJFgzRB2+t1x+cTtvvyIgBUjEbLKfs=;
	b=q4HL3wPqkPUTCX1upK44DzH2jCj02ieD6b0YpeC0R/MEdah0OXekz6TmD6F5cWnHpE
	9RKOu8xmj0bENhBs1Utf2n9JyQTVzR2ItMaIVhWx5tNkXHlEeDG3eAZw9ibK+x+ScRdM
	kDYpw8DTmEqpcMrVAgH7oA4QwyNv+JmlqW94/hbv+AA/RUMotwdFYQKSG4bQA68p+iCa
	pO5cmfXp8XrrZB9GIUERzJBXHl3iYdd0siEL4Yawnrd7u2uxRG9PS6BJw2Cfyf7Hf0yR
	rhe6mW+swv5WxkrLKYXgP+mIbms/UobnPZ3o9ez9hg54ThKb7fFXFnNV4eM9KE6fqLVg
	zypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=W6HDhQJMBdxe5wJFgzRB2+t1x+cTtvvyIgBUjEbLKfs=;
	b=OT/DJVnnoqvsAX2qtMU+gfhOg14gGvE/6/iiPsQZHZQu32f5EWJnx+NdzHu05MPBWM
	3J5VIM29BVl1F9BJ2Nxx3lIpqIcVQwIeWMKJnnL7YzbDgopTiHrkvmte8iNTRKGFiVEB
	5RrCk460rKfxk2+byLK9ezv8vxqRCREZ6ErP+imqjOgHfFjRkejP71GgH/4zc4Mjp4GM
	UhxwqTsnyn/us9K1cFaULx4RGr3Bxf5ATrw40jCifjtGk+IFRDN6kC1rI3ZwsAFBy2/5
	r1HRKSl8TU+vPMg3dYctSSDra2mgHHkEGTThhPVIx6wxvJBSaLHG38zrTZo9YcMF7JJA
	+72Q==
X-Gm-Message-State: APjAAAXgJqxgWBsvfaFavmxUYF0uq7yTtNBDJSzWdWlZvldpEpWiNL1i
	ySGdjLvx/1c9rSiXdMb63Yyu7yh4YsRWIA==
X-Google-Smtp-Source: APXvYqxRxK+q4iCU2GaNKmznya6CNXDRyJ3Wzk9lR6s2ercfVvslIzPp920K8R0q9lzKcEtPrwaRGg==
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr11408179oti.122.1559768231571; 
	Wed, 05 Jun 2019 13:57:11 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id f5sm7414155otl.51.2019.06.05.13.57.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 13:57:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 15:57:00 -0500
Message-Id: <20190605205706.569-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [PATCH v6 0/6] linux-user/aarch64: Support PROT_BTI
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dave Martin has recently posted a kernel patch set for 
supporting ARMv8.5 Branch Target Identification in userland.

  http://lists.infradead.org/pipermail/linux-arm-kernel/2019-May/654654.html

While that support is not yet in the upstream kernel, it looks
to be close to its final form.  Note that the patch set spells
this PROT_BTI_GUARDED, but review suggested to rename to PROT_BTI.

Changes since v5:
  * New function to validate the target PROT parameter for mmap/mprotect.
  * Require BTI in the cpu for PROT_BTI set.
  * Set PSTATE.BTYPE=2 for the signal handler.
    Adjust the smoke test to match.
  * Tidy up the note parsing.


r~


Richard Henderson (6):
  linux-user/aarch64: Reset btype for syscalls and signals
  linux-user: Validate mmap/mprotect prot value
  linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
  include/elf: Add defines related to notes for GNU systems
  linux-user: Parse NT_GNU_PROPERTY_TYPE_0 notes
  tests/tcg/aarch64: Add bti smoke test

 include/elf.h                     |  48 ++++++++++++
 include/exec/cpu-all.h            |   2 +
 linux-user/syscall_defs.h         |   4 +
 linux-user/aarch64/cpu_loop.c     |   7 ++
 linux-user/aarch64/signal.c       |  10 ++-
 linux-user/elfload.c              |  83 ++++++++++++++++++--
 linux-user/mmap.c                 | 122 ++++++++++++++++++++++--------
 target/arm/translate-a64.c        |   6 +-
 tests/tcg/aarch64/bti-1.c         |  77 +++++++++++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   |  69 +++++++++++++++++
 tests/tcg/aarch64/Makefile.target |   3 +
 11 files changed, 387 insertions(+), 44 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

-- 
2.17.1


