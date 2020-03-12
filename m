Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7E3C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A272206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i432OUSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A272206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTk1-0007AY-D4
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTir-0004Yf-NG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTiq-0001eu-G7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:25 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTiq-0001e6-6F
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:24 -0400
Received: by mail-pj1-x1043.google.com with SMTP id m15so2380321pje.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/zHbZh0dod5oMK8gTomTJjtjrWcaZXLW0KPv8APWrNg=;
 b=i432OUSrFBi2EBZjUAVO190uA98WGRNaZI+mm7o//2CETnP4LAaVDpXgFBLgQ/ebkl
 K9vQYas1Jy/E0geOrwJOJFT2R7kUfQ3JBwMiOTDNJfLnlHTx0ogblk+yN2WLxyYfy696
 wX42rXSfpPho9sP7gHY39lWYiWwzW6XmqkdZqcZPT+EENqiivzv9+OPcz2lzRxmeo9MQ
 T8KA4BLnkgAqS1Fs1wMIc8OkXXOgLdd7rota1k822cnC/MmzHx0KG0uyapUU65Kb6OcN
 YVk1QdIttn87tdO9f2UGwgH8qFtHg0Krb/8eHeqiCFf2JfHOlT3HXXXtdCnu4kgWXIzN
 yGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/zHbZh0dod5oMK8gTomTJjtjrWcaZXLW0KPv8APWrNg=;
 b=j+yrgiPuyzE3mYV40bGfI5QWM35Qo7ndxPgByjvKe4V9ugJCE4M/cgYxWrzNhg1PRk
 8BoCeLt5ZLvp23PIKHGys5052auq3smmCCLL5Zbbi2c/Q+e8RqdhfU9cXIa/TTO71BcV
 47vpaCjaDbp6dqbuzLjq1O4oX5qBLz/idZxFmQUa4cBjWSRjY7STtNUquuvNcq8Nanpj
 vvlgodpGuzRnL6qfRvpRZ0IO/6l5xB7+xLo7hKsrKFs0yRJQRe/WbmVeCWZTYs1C8Y67
 Hu8Ld1JI/+O/yShmCsKc0lydu80Jw8qmIBGvt4ZPGBTxnYqNXpUfQy2R3kDAshmR1Ral
 OlNg==
X-Gm-Message-State: ANhLgQ0Pdb3gsBvfEKAw24DvQAUBtSWRsD3aXOA911ynwYJvU84oDP5q
 xJsArifYYQxokCBo7armpQEsrJasDLg=
X-Google-Smtp-Source: ADFU+vuWuZgiJ1wM8xKXS6la8kjMriZV7Tn9uSF63NjGWvV89wit8agYMmmVDnsq2VSylcSv4WpCTw==
X-Received: by 2002:a17:902:694c:: with SMTP id
 k12mr9425175plt.329.1584042141496; 
 Thu, 12 Mar 2020 12:42:21 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/42] target/arm: Implement ARMv8.5-MemTag, system mode
Date: Thu, 12 Mar 2020 12:41:37 -0700
Message-Id: <20200312194219.24406-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've done quite a lot of reorg since v5, so much so that I've dropped
most of the review tags that had been given.

There are a couple of major improvements to note:

* The effective ATA bit is in hflags, noting whether access to the
  allocation tags is enabled by the OS.  This is moderately expensive
  to compute, so it's better to hold on to that.  This allows trivial
  inlining of some of the operations.

* Updates for SVE, and thus

Based-on: <20200311064420.30606-1-richard.henderson@linaro.org>
("target/arm: sve load/store improvements")

* Architecture updates, to F.a released this month.

* There are now real patches for the kernel:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git devel/mte-v2

  Booting that and running my user-mode tests showed up a few bugs.


r~


Richard Henderson (42):
  target/arm: Add isar tests for mte
  target/arm: Improve masking of SCR RES0 bits
  target/arm: Add support for MTE to SCTLR_ELx
  target/arm: Add support for MTE to HCR_EL2 and SCR_EL3
  target/arm: Rename DISAS_UPDATE to DISAS_UPDATE_EXIT
  target/arm: Add DISAS_UPDATE_NOCHAIN
  target/arm: Add MTE system registers
  target/arm: Add MTE bits to tb_flags
  target/arm: Implement the IRG instruction
  target/arm: Implement the ADDG, SUBG instructions
  target/arm: Implement the GMI instruction
  target/arm: Implement the SUBP instruction
  target/arm: Define arm_cpu_do_unaligned_access for user-only
  target/arm: Add helper_probe_access
  target/arm: Implement LDG, STG, ST2G instructions
  target/arm: Implement the STGP instruction
  target/arm: Restrict the values of DCZID.BS under TCG
  target/arm: Simplify DC_ZVA
  target/arm: Implement the LDGM, STGM, STZGM instructions
  target/arm: Implement the access tag cache flushes
  target/arm: Move regime_el to internals.h
  target/arm: Move regime_tcr to internals.h
  target/arm: Add gen_mte_check1
  target/arm: Add gen_mte_checkN
  target/arm: Implement helper_mte_check1
  target/arm: Implement helper_mte_checkN
  target/arm: Add helper_mte_check_zva
  target/arm: Use mte_checkN for sve unpredicated loads
  target/arm: Use mte_checkN for sve unpredicated stores
  target/arm: Use mte_check1 for sve LD1R
  target/arm: Add mte helpers for sve scalar + int loads
  target/arm: Add mte helpers for sve scalar + int stores
  target/arm: Add mte helpers for sve scalar + int ff/nf loads
  target/arm: Handle TBI for sve scalar + int memory ops
  target/arm: Add mte helpers for sve scatter/gather memory ops
  target/arm: Complete TBI clearing for user-only for SVE
  target/arm: Implement data cache set allocation tags
  target/arm: Set PSTATE.TCO on exception entry
  target/arm: Enable MTE
  target/arm: Cache the Tagged bit for a page in MemTxAttrs
  target/arm: Create tagged ram when MTE is enabled
  target/arm: Add allocation tag storage for system mode

 target/arm/cpu.h               |   36 +-
 target/arm/helper-a64.h        |   16 +
 target/arm/helper-sve.h        |  491 +++++++++++
 target/arm/helper.h            |    2 +
 target/arm/internals.h         |  145 ++++
 target/arm/translate-a64.h     |    5 +
 target/arm/translate.h         |   23 +-
 hw/arm/virt.c                  |   52 ++
 linux-user/aarch64/cpu_loop.c  |    7 +
 linux-user/arm/cpu_loop.c      |    7 +
 target/arm/cpu.c               |   79 +-
 target/arm/cpu64.c             |    1 +
 target/arm/helper-a64.c        |   94 +--
 target/arm/helper.c            |  350 ++++++--
 target/arm/mte_helper.c        |  894 ++++++++++++++++++++
 target/arm/op_helper.c         |   16 +
 target/arm/sve_helper.c        |  750 ++++++++++++++---
 target/arm/tlb_helper.c        |   41 +-
 target/arm/translate-a64.c     |  607 ++++++++++++--
 target/arm/translate-sve.c     | 1425 ++++++++++++++++++++------------
 target/arm/translate-vfp.inc.c |    2 +-
 target/arm/translate.c         |   16 +-
 target/arm/Makefile.objs       |    1 +
 23 files changed, 4204 insertions(+), 856 deletions(-)
 create mode 100644 target/arm/mte_helper.c

-- 
2.20.1


