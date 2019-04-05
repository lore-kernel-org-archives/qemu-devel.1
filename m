Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17ABC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 00:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988DB217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 00:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Tjhcyztm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988DB217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCCug-0003Lb-Mt
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 20:40:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtO-0002fa-GV
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtN-000301-F4
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:33493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hCCtN-0002vu-5c
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:37 -0400
Received: by mail-pf1-x429.google.com with SMTP id i19so2270855pfd.0
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=subject:date:message-id:mime-version:content-transfer-encoding:cc
	:from:to; bh=xBcSx1NuN+sLuSutJPr9vM3zpuUc7W5f8kTqR5tR3Hc=;
	b=TjhcyztmZVmxFdA62RPF9Ac6JCMwM/a2uIzgasPLiuaajCczXrCoM1DGbAkNpTWQQO
	9yRTBez33BCodwbxmcBgVB6D8jVU0GHO1nyyegPJlgIvVnZCUMA4GIB9Pm9wUvBJB87i
	v+Ng8d2iPTZdY7F3DLKCK6ldzbaLnw8n8mVKkcHUpf/uxKNsuw2ov7h+XWkI9fZJ6zCx
	1RAaNMa257cH20cZliI4ReJ1+KoMVZfHnEEN21SO7J4/cueBkl9qdQofoiDbbKV1AKjW
	zVFwvWwXwcsoKP3PIVenWePqTjsXSAG7+tYZHU/f8SIEw9rLVxAwm7zXgnwXh3iC2ULY
	fDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:mime-version
	:content-transfer-encoding:cc:from:to;
	bh=xBcSx1NuN+sLuSutJPr9vM3zpuUc7W5f8kTqR5tR3Hc=;
	b=SgvnrakyTSqE4BRXWx5slG5b71gp/4a0AQWmZrbbQj8Ew9w+HOTJ77DP+PxEitLcwl
	oOetA4NudnWSCKT5/DqwbtVP8WooMsLaC5/c3FsATmhQhBVlXlHhqBhYSEHcL1N2Tv3Z
	ev+uNuOE958FARw1W4N/wOJ/jxSLUCXsElg0caA2pxGX6Z0f+TFEIt5C2A0GhyEAuYjV
	CumQxUF9qdpV62pBzYlenwlXKzvHxrfOfRnQAiQxmctyhokEVQYeXALeHRnC3R/ccP9m
	6AlzCzatSTTCKSVqmXNo0kRvbfnYA+09aYWk+CwMs2wAI02b8Q0rK3SiCNxFR8TXJOX4
	mneg==
X-Gm-Message-State: APjAAAUzN0q9+Nq0JJikOd9bQDOEFnMoI1ObYXQVqGrktXwKK5LSyv1L
	It1W64Il5GB/sq6NB2yPQyRJoA==
X-Google-Smtp-Source: APXvYqwnHP9b/IL2x3q8hKme0KwXl87gTmZqcL5rjp7xpLQRiWQ+wactcWHYCRqEh8/TFdLyH5I/IQ==
X-Received: by 2002:a63:494f:: with SMTP id y15mr9050666pgk.56.1554424775825; 
	Thu, 04 Apr 2019 17:39:35 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	g4sm36262606pfm.115.2019.04.04.17.39.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Apr 2019 17:39:34 -0700 (PDT)
Date: Thu,  4 Apr 2019 17:39:22 -0700
Message-Id: <20190405003924.1906-1-palmer@sifive.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: [Qemu-devel] [PULL] RISC-V Patches for 4.0-rc3, v2
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405003922.wIMPvPzJZZk4GnX6BITwOQt9ZsvYy-WvsMFZV6mwZSU@z>

The following changes since commit 061b51e9195670e9d190cdec46fabcb3c77763fb:

  Update version for v4.0.0-rc2 release (2019-04-02 17:01:20 +0100)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.0-rc3-v2

for you to fetch changes up to 79bcac250f96ba1d4fdecfdc6e3363c9024703a4:

  riscv: plic: Log guest errors (2019-04-04 16:36:21 -0700)

----------------------------------------------------------------
RISC-V Patches for 4.0-rc3, v2

This patch set contains a pair of tightly coupled PLIC bug fixes:

* We were calculating the PLIC addresses incorrectly.
* We were installing the wrong number of PLIC interrupts.

The two bugs togther resulted in a mostly-working system, but they're
impossible to seperate because fixing one bug would result in
significant breakage.  As a result they're in the same patch.

There is also a cleanup to use qemu_log_mask(LOG_GUEST_ERROR,...) for
error reporting.

As far as I know these are the last outstanding RISC-V patches for 4.0.

v2 no longer fails "make check" for me... sorry!

----------------------------------------------------------------
Alistair Francis (2):
      riscv: plic: Fix incorrect irq calculation
      riscv: plic: Log guest errors

 hw/riscv/sifive_plic.c      | 16 +++++++++++-----
 include/hw/riscv/sifive_e.h |  2 +-
 include/hw/riscv/sifive_u.h |  4 ++--
 include/hw/riscv/virt.h     |  2 +-
 4 files changed, 15 insertions(+), 9 deletions(-)


