Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCABC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F3A2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dk3+DBUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F3A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4c7-000193-2u
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:26:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aI-0008Nn-R6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aH-00066a-Gs
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:26 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:44935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aH-0005yZ-8n
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:25 -0400
Received: by mail-pg1-x531.google.com with SMTP id z16so1922467pgv.11
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ZfslQmjwCE1j+uCCD7gLdo8uHx3iNuAufU7BFwZRf9s=;
	b=Dk3+DBUM/k58Zp06/KqAeOLaIwl6HCPiU7opocnRh/lAiohfWltiFWUCVgf0gSDPC0
	FBH0OKnyoaTAuR2L5fa+aw0JHzWt0EL19EgZX9vNptEsWF2uH3Rjt2ziq/LKDwWZLyYJ
	+Ctd68ezIrpBfntAgsm+4qMBbsG8BCnc6r1vNt+h3AYqv9pznVmSvPJsMUhypSLZYwfO
	NrGerwdtsIBhvgdVicTjIYYXuXGF4u/GBdt6oXSB7KtyopLomh447HwXNrHV43snoB/G
	TRplBID4DBn+TPetl8TS8OrBr4Rbw3OaLXfPeHhgHRpUxcwV07/UvW3cNElkzE8nIGoC
	vJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ZfslQmjwCE1j+uCCD7gLdo8uHx3iNuAufU7BFwZRf9s=;
	b=rjB0VYX4PDFzVSH9Aa0nwtgmPIWlfJKorlHZlbvu5Ltu4POa8xXMPETW5ffHKjcfzE
	zjHZJRulLqON2SB1hyJSqMF7FK+hTM+eT6JnT+63tHwXx2nmgO4WpbHAtn35lvPQ+Ll+
	TDY+TIi5y9QUOAWa2+tO+djgMf5pY+5ZfgUt4phXlp/ilThkkdDyBUTlQz28ztT3lsl2
	HKT77doMuLx0qWDWYOc1YimWh6hp1+/QGtVQUxoomJhMAisxHY5SJo/9Bkrz7pzmXxbS
	1qzzcuemSYu6uQ9yH/3NgJtd/w+P7YkeUlu6gMQ7oV45FlGmoi82xZDs5DiGrYDluFac
	fYdQ==
X-Gm-Message-State: APjAAAVkUPtjUyOW+Cme5C1LDcXNkbs8HJDTDrUd5mQI8HLdeEElUYol
	6EuWvB1aqZFla8KiYSd0owW8/gjDKLI=
X-Google-Smtp-Source: APXvYqxwnZCOfrcw4gBGU/STcSM3e2RYKj+OCaP7z/8ifeDbgCm9XHzyL8q+cXfTEmnpX2dQyU0bXw==
X-Received: by 2002:a63:5602:: with SMTP id k2mr1798608pgb.295.1556299463276; 
	Fri, 26 Apr 2019 10:24:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:06 -0700
Message-Id: <20190426172421.27133-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::531
Subject: [Qemu-devel] [PULL 00/15] tcg patch queue
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
Message-ID: <20190426172406.lbJtMx9NfUhG6yfh9wQkolHDFsdp5Zp0HMkZp5fkksE@z>

The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:

  Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190426

for you to fetch changes up to ef5dae6805cce7b59d129d801bdc5db71bcbd60d:

  cputlb: Fix io_readx() to respect the access_type (2019-04-25 10:40:06 -0700)

----------------------------------------------------------------
Add tcg_gen_extract2_*.
Deal with overflow of TranslationBlocks.
Respect access_type in io_readx.

----------------------------------------------------------------
David Hildenbrand (1):
      tcg: Implement tcg_gen_extract2_{i32,i64}

Richard Henderson (13):
      tcg: Add INDEX_op_extract2_{i32,i64}
      tcg: Use deposit and extract2 in tcg_gen_shifti_i64
      tcg: Use extract2 in tcg_gen_deposit_{i32,i64}
      tcg/i386: Support INDEX_op_extract2_{i32,i64}
      tcg/arm: Support INDEX_op_extract2_i32
      tcg/aarch64: Support INDEX_op_extract2_{i32,i64}
      tcg: Hoist max_insns computation to tb_gen_code
      tcg: Restart after TB code generation overflow
      tcg: Restart TB generation after relocation overflow
      tcg: Restart TB generation after constant pool overflow
      tcg: Restart TB generation after out-of-line ldst overflow
      tcg/ppc: Allow the constant pool to overflow at 32k
      tcg/arm: Restrict constant pool displacement to 12 bits

Shahab Vahedi (1):
      cputlb: Fix io_readx() to respect the access_type

 include/exec/exec-all.h       |   4 +-
 include/exec/translator.h     |   3 +-
 tcg/aarch64/tcg-target.h      |   2 +
 tcg/arm/tcg-target.h          |   1 +
 tcg/i386/tcg-target.h         |   2 +
 tcg/mips/tcg-target.h         |   2 +
 tcg/ppc/tcg-target.h          |   2 +
 tcg/riscv/tcg-target.h        |   2 +
 tcg/s390/tcg-target.h         |   2 +
 tcg/sparc/tcg-target.h        |   2 +
 tcg/tcg-op.h                  |   6 ++
 tcg/tcg-opc.h                 |   2 +
 tcg/tcg.h                     |  16 +++---
 tcg/tci/tcg-target.h          |   2 +
 accel/tcg/cputlb.c            |   5 +-
 accel/tcg/translate-all.c     |  53 ++++++++++++++---
 accel/tcg/translator.c        |  15 +----
 target/alpha/translate.c      |   4 +-
 target/arm/translate.c        |   4 +-
 target/cris/translate.c       |  10 +---
 target/hppa/translate.c       |   5 +-
 target/i386/translate.c       |   4 +-
 target/lm32/translate.c       |  10 +---
 target/m68k/translate.c       |   4 +-
 target/microblaze/translate.c |  10 +---
 target/mips/translate.c       |   4 +-
 target/moxie/translate.c      |  11 +---
 target/nios2/translate.c      |  14 +----
 target/openrisc/translate.c   |   4 +-
 target/ppc/translate.c        |   4 +-
 target/riscv/translate.c      |   4 +-
 target/s390x/translate.c      |   4 +-
 target/sh4/translate.c        |   4 +-
 target/sparc/translate.c      |   4 +-
 target/tilegx/translate.c     |  12 +---
 target/tricore/translate.c    |  16 +-----
 target/unicore32/translate.c  |  10 +---
 target/xtensa/translate.c     |   4 +-
 tcg/aarch64/tcg-target.inc.c  |  27 +++++++--
 tcg/arm/tcg-target.inc.c      |  98 ++++++++++++++++++--------------
 tcg/i386/tcg-target.inc.c     |  17 +++++-
 tcg/mips/tcg-target.inc.c     |   6 +-
 tcg/optimize.c                |  16 ++++++
 tcg/ppc/tcg-target.inc.c      |  42 +++++++-------
 tcg/riscv/tcg-target.inc.c    |  16 ++++--
 tcg/s390/tcg-target.inc.c     |  20 ++++---
 tcg/tcg-ldst.inc.c            |  18 +++---
 tcg/tcg-op.c                  | 129 +++++++++++++++++++++++++++++++++---------
 tcg/tcg-pool.inc.c            |  12 ++--
 tcg/tcg.c                     |  85 +++++++++++++++-------------
 tcg/README                    |   7 +++
 51 files changed, 451 insertions(+), 309 deletions(-)

