Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3523C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC5D218C3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5hzOTJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC5D218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55561 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxXM-0002Co-Gl
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:40:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVb-00017P-8v
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVa-0006v4-5f
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:38:59 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:37006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIxVZ-0006ul-TL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:38:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 8so7693650pfr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=BylkCymyyB50CR2x4M/Bb3g3J5k1+5Ug35McuGT9beU=;
	b=L5hzOTJXTmnXL09G69c970CLU75pjjfFNeEVENcFvUBJNVy6KodJNPfMvoDlCxwMBo
	dTtD2eFwXI2Q15ZHTlNOzbYQSquVjsoUGanlahB0YLdvfjLhZRSeiMKY21GbDJWEpR6w
	zmw2YemdwBCA9DFjn1hLYD3wke1W/uq1MAEeIy/6eMaFwuW5I2CQhoeukshuUhFp7gPY
	POWO7WcyUPvc7T5dn+1ZcI2QRLpiGE/oIWEC0uyoZU54kRtBNLoeYGQoNzYf198FIAcR
	jpt9kGmPZmORWhFaTVYDh5hlNzI/MteMRqQ0RGm8Veu9tmYSZugwdRHnf1eo9tCS3w52
	BEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=BylkCymyyB50CR2x4M/Bb3g3J5k1+5Ug35McuGT9beU=;
	b=tPZLkTdHLAg7g86X6t9H49lqGrScrOHby3Fyblx8OO3WE4aJhjCymt2PobO1XLKjqb
	1RR1nHdCS/stT3siqKWSicdr4vfCRShPGeo+nDoSze7RK6NZMJdZwWhUPCv9SilyNb+Z
	g/N+37ZI16vMdMYFvNZrvTTIvr6TPVWxophaU/exB9NEF6GYBBwvgVo0NFQA9OuXjdWW
	f+GMBXLsBGh2PeQxgfCLNoHB8ffn4jpHuLtT9jc5WBQvUwTUV68ZfHls6tZajDB3YGWi
	qestkcfmxWGMcSqiY9UheA0LZzD1QjHn4jNFonvyw/Ile7jDtwQPEkzK5QKSCueL5ZMZ
	hwjQ==
X-Gm-Message-State: APjAAAUXcik0Iu+GRcE0GEnmn30JroH8hm6xtVt2EFtOMCuouBPFd4mL
	uca2OUubrfHsClivMBoulZPwYwAQolI=
X-Google-Smtp-Source: APXvYqxgb74GjXfyw6dYmbRtkbNykjNYGKBY+i3mfGtWM1O19xAh/I6QUG+Lhd1XHcs+Hd58izw+yw==
X-Received: by 2002:a63:f218:: with SMTP id v24mr25069680pgh.326.1556033936015;
	Tue, 23 Apr 2019 08:38:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c25sm24366591pfo.69.2019.04.23.08.38.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 08:38:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 08:38:46 -0700
Message-Id: <20190423153853.19790-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: [Qemu-devel] [PATCH v2 0/7] tcg: Restart TB generation on overflow
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423153846.LWuAsZTI5hV_05hPQ-fOvK_gqrQ6jdJ2itSsneRYp58@z>

This is for lauchpad 1824853.  The v1 patch set fixed this for
x86 as a host.  This goes further to handle the other cases in
which a TB can become too large, resulting in overflows from
relocations.

Finally, the last two patches take advantage of this.  Since
we now have a reliable way to try again if a relocation overflows,
we can avoid adding extra nops on the off-chance we have to deal
with very large TBs.

There is possibly room for additional work in tcg/riscv, with
respect to its short conditional branches.  But that's probably
best left to someone who can test that properly.


r~


Richard Henderson (7):
  tcg: Hoist max_insns computation to tb_gen_code
  tcg: Restart after TB code generation overflow
  tcg: Restart TB generation after relocation overflow
  tcg: Restart TB generation after constant pool overflow
  tcg: Restart TB generation after out-of-line ldst overflow
  tcg/ppc: Allow the constant pool to overflow at 32k
  tcg/arm: Restrict constant pool displacement to 12 bits

 include/exec/exec-all.h       |  4 +-
 include/exec/translator.h     |  3 +-
 tcg/tcg.h                     | 15 +++----
 accel/tcg/translate-all.c     | 53 +++++++++++++++++++----
 accel/tcg/translator.c        | 15 +------
 target/alpha/translate.c      |  4 +-
 target/arm/translate.c        |  4 +-
 target/cris/translate.c       | 10 +----
 target/hppa/translate.c       |  5 +--
 target/i386/translate.c       |  4 +-
 target/lm32/translate.c       | 10 +----
 target/m68k/translate.c       |  4 +-
 target/microblaze/translate.c | 10 +----
 target/mips/translate.c       |  4 +-
 target/moxie/translate.c      | 11 +----
 target/nios2/translate.c      | 14 +-----
 target/openrisc/translate.c   |  4 +-
 target/ppc/translate.c        |  4 +-
 target/riscv/translate.c      |  4 +-
 target/s390x/translate.c      |  4 +-
 target/sh4/translate.c        |  4 +-
 target/sparc/translate.c      |  4 +-
 target/tilegx/translate.c     | 12 +-----
 target/tricore/translate.c    | 16 +------
 target/unicore32/translate.c  | 10 +----
 target/xtensa/translate.c     |  4 +-
 tcg/aarch64/tcg-target.inc.c  | 16 ++++---
 tcg/arm/tcg-target.inc.c      | 73 ++++++++++++++-----------------
 tcg/i386/tcg-target.inc.c     |  6 ++-
 tcg/mips/tcg-target.inc.c     |  6 ++-
 tcg/ppc/tcg-target.inc.c      | 42 +++++++++---------
 tcg/riscv/tcg-target.inc.c    | 16 +++++--
 tcg/s390/tcg-target.inc.c     | 20 +++++----
 tcg/tcg-ldst.inc.c            | 18 ++++----
 tcg/tcg-pool.inc.c            | 12 +++---
 tcg/tcg.c                     | 81 ++++++++++++++++++-----------------
 36 files changed, 246 insertions(+), 280 deletions(-)

-- 
2.17.1


