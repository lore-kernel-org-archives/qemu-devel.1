Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A29C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420C62182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYL35neT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420C62182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOwDf-00044F-Dq
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:29:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBo-0002w0-Bc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBn-0001M6-3W
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:16 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOwBm-0001KP-Ta
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:15 -0400
Received: by mail-pf1-x443.google.com with SMTP id 13so2408375pfw.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 20:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kYPvR/+3oXoM1cgriFFufz2gVs7DQlnW5GngOT7E9H8=;
	b=yYL35neTghlReS1E0H4blVXqlra6l8YuWplq0b0FCOswSQnBFlJjkScr+IGCK2mmRr
	hoAa62HQ8ckBe0VY8wJ+Gw9XD1c0g7ikv39uq54pvVqPWhPDCMMWiSvM2sq5EJCqVSba
	/dlaoPJQAKb2EfyEC7/RL3F/9Sp7GUvXhQ9atTyMafJQVYnn+++FZN03Tn6CTH0qdLz2
	r/G9KM8zQRUaxQjx0gH1pl0HJjCdNauFwJibFbtSjGsY1cJfRmxUKuSXKhJA7NoYPMFA
	F1CAuRhwiT5HRyW5CYagJC2JtPQZ/ZN2s3dntg8X5Axlb33B+UIGt4S4Ddaj6m8Gm5VT
	otwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kYPvR/+3oXoM1cgriFFufz2gVs7DQlnW5GngOT7E9H8=;
	b=C0369nkNsjRhEBmXSPD6SDwtwUIMMbybayaG/Yz7lSZ+XApTymn3fqWGlaMr4h9818
	yTtxhJDEMybkcrvuSGyCre8vDAXN5A2uVZPT3F/FexFKXIedjifnkixAWjmsb+rFj5Yg
	iR8PH8GRelEskCaZ4v5qm70eLtpYZgt61oGNm+l/eHLCtJeqgVdrlUcKc5SgrOl/W3gm
	/gKmHllWf/bhiUYePiCdkEB08N0l3Q+FVE3L5X/Yig8hVyz+8Erg7EE26jZlZH7A8q5j
	1MFfKtNlv9gBka8vEV4ZcUHxcBAm+o9vSCE/fksgb10a4qjeZ+31PQLO3LCuKaNenzSf
	YPWw==
X-Gm-Message-State: APjAAAXmyBKWlYi6LuqWxY0KfkrtnhZYXADT6v5pobVY5qoFhFiRTbHA
	h4xguUOAqvH4j+dxpf1kJEFGxaw5t6s=
X-Google-Smtp-Source: APXvYqxp7UI/3P7GBlisd0dK6fnsWbvJD2oIvqyOn+RQR0K5rq78WIZPmTWPaHDAF4/npqfP8xn7cQ==
X-Received: by 2002:a63:a84c:: with SMTP id i12mr10862267pgp.115.1557458833034;
	Thu, 09 May 2019 20:27:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	t26sm6259695pgk.62.2019.05.09.20.27.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 20:27:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 20:27:02 -0700
Message-Id: <20190510032710.23910-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 0/8] linux-user sparc fixes
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 1 was posted back in July 2018.  Oops.  ;-)

https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg05788.html

--- v1 cover letter

There are at least 4 separate bugs preventing clone from working.

(1) cpu_copy left both cpus sharing the same register window (!)

(2) cpu_clone_regs did not initialize %o1, so the new thread path
    in the guest __clone was always taken, even for the parent
    (old %o1 value was newsp, and so non-zero).

(3) cpu_clone_regs did not advance the pc past the syscall in the
    child, which meant that the child re-executed the syscall
    (and because of (1), with essentially random inputs).

(4) clone did not flush register windows, which would cause the
    parent stack to be clobbered by the child writing out old
    windows in order to allocate a new one.
    
This is enough for Alex's atomic-test to make progress, but not
quite enough for it to actually work.  What I'm seeing now is a
legitimate SEGV for a write to a r-xp memory segment.  I'll need
to examine the testcase further to see why that is happening.

---

I have now traced the remaining problem to cpu_clone_regs putting the
newsp into the frame pointer, not the stack pointer.  In fixing this,
I define a set of WREG_* constants in target/sparc/cpu.h, and then go
on to fix some related problems in linux-user/sparc/signal.c.


r~


Richard Henderson (8):
  linux-user: Disallow setting newsp for fork
  linux-user: Pass the parent env to cpu_clone_regs
  target/sparc: Define an enumeration for accessing env->regwptr
  linux-user/sparc: Use WREG constants in sparc/target_cpu.h
  linux-user/sparc: Use WREG constants in sparc/signal.c
  linux-user/sparc: Fix cpu_clone_regs
  linux-user/sparc: Flush register windows before clone
  scripts/qemu-binfmt-conf: Update for sparc64

 linux-user/aarch64/target_cpu.h    |  3 +-
 linux-user/alpha/target_cpu.h      |  3 +-
 linux-user/arm/target_cpu.h        |  3 +-
 linux-user/cris/target_cpu.h       |  3 +-
 linux-user/hppa/target_cpu.h       |  3 +-
 linux-user/i386/target_cpu.h       |  3 +-
 linux-user/m68k/target_cpu.h       |  3 +-
 linux-user/microblaze/target_cpu.h |  3 +-
 linux-user/mips/target_cpu.h       |  3 +-
 linux-user/nios2/target_cpu.h      |  3 +-
 linux-user/openrisc/target_cpu.h   |  4 +-
 linux-user/ppc/target_cpu.h        |  3 +-
 linux-user/riscv/target_cpu.h      |  3 +-
 linux-user/s390x/target_cpu.h      |  3 +-
 linux-user/sh4/target_cpu.h        |  3 +-
 linux-user/sparc/target_cpu.h      | 41 ++++++++-----
 linux-user/tilegx/target_cpu.h     |  3 +-
 linux-user/xtensa/target_cpu.h     |  3 +-
 target/sparc/cpu.h                 | 33 ++++++++++
 linux-user/sparc/cpu_loop.c        |  3 +
 linux-user/sparc/signal.c          | 96 ++++++++++--------------------
 linux-user/syscall.c               |  9 ++-
 scripts/qemu-binfmt-conf.sh        |  8 ++-
 23 files changed, 141 insertions(+), 101 deletions(-)

-- 
2.17.1


