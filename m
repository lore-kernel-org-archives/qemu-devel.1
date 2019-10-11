Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1DFC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D948E2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATF8CZGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D948E2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxI6-0003ya-L6
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGg-0002AH-8Q
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGe-0007VS-O5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:55:49 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:45679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGe-0007V5-JM
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:55:48 -0400
Received: by mail-yw1-xc41.google.com with SMTP id x65so3633525ywf.12
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0PIckjc+jDPiUlR/QPCiF7wRLH0buusyiLHFkX56XIE=;
 b=ATF8CZGP3jKyOcu2xyN4V/rsokVjTh6f3oh+Gb6BUFfLFFDKfDk/RYHYEOWBkc839q
 NC/Fmc2OzXKJLp6dIjWMLJ+3ckcx6EUiSoTee8TStKHnbsSh4ZGLF6Ukd5eoCtr9X//1
 815PNZNU5W6DDgPWwe52/TMN0lc/C3j774yISr+cxu8Jo52BW3qjPINc+aW5YSiNgEk8
 aWStEtg2GwMZdwU1JymqzJITdhLJ7ODLBTczxHR7akaHh8HYPFDI7J6AfWZe3M9mdJDH
 PwE2lgYjzrs1zciE/y6xenlnjJX2Od4m7C+5WH/XWs8PGNtinWxXLhly8dTZq1lxb9sx
 AeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0PIckjc+jDPiUlR/QPCiF7wRLH0buusyiLHFkX56XIE=;
 b=JSxcld5WDkaxAiRR3b0xVXx6u1Tv94Ri8AnE03lkD+muy66kANKrFpC2jRTcm9BQBb
 EhT+4NomBlCiuwUVuNvuzl8NJPJVWw9HX+uGo1gKhVuvxpahszr7bP835Gx7JPaEOjHN
 7PpKqv7TskLw6iw2N7yCeon1CSD8KluO3Nr0JDlQou4msgJrH4neDZdHDErqY3ns5VyD
 vsOL7+7lrMSjjGWqVD6FGbrMoxZ5Y5dJyqPLBaT5mOE6NpMcF4z7AKeT7MbkQWDlCrBO
 6H5+VTWr/olN6cckaLvF++VlsZHfqSlX+3J9p0M51b0NMkRhx6jzn0PhIV1ZAxHgJYJy
 COSw==
X-Gm-Message-State: APjAAAWPaldMRcplrXDvGkHykRPEpxoliKg2kFM5CrX8ldy4XpjcfHp9
 B1+OLZAE+ahQBt7Jk6kYP+ifp3qw9wY=
X-Google-Smtp-Source: APXvYqyWyr02v66TSSYoFnTc4QKG618LzawAKGGMUNcZOiEBd0DxkwZTpMQ5KGr4JBCijU0UVmaadQ==
X-Received: by 2002:a81:5b46:: with SMTP id p67mr2810079ywb.228.1570809347611; 
 Fri, 11 Oct 2019 08:55:47 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:55:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/20] target/arm: Reduce overhead of cpu_get_tb_cpu_state
Date: Fri, 11 Oct 2019 11:55:26 -0400
Message-Id: <20191011155546.14342-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v5:
  * Fix the debug assertion ifdef in the final patch.
  * Add more calls to arm_rebuild_hflags: CPSR and M-profile
    These become two new patches, 18 & 19.
  * Update some comments per review. (Alex)

Changes since v4:
  * Split patch 1 into 15 smaller patches.
  * Cache the new DEBUG_TARGET_EL field.
  * Split out m-profile hflags separately from a-profile 32-bit.
  * Move around non-cached tb flags as well, avoiding repetitive
    checks for m-profile or other mutually exclusive conditions.

  I haven't officially re-run the performance test quoted in the
  last patch, but I have eyeballed "perf top", and have dug into
  the compiled code a bit, which resulted in a few of the new
  cleanup patches (e.g. cs_base, arm_mmu_idx_el, and
  arm_cpu_data_is_big_endian).

Changes since v3:
  * Rebase.
  * Do not cache XSCALE_CPAR now that it overlaps VECSTRIDE.
  * Leave the new v7m bits as uncached.  I haven't figured
    out all of the ways fpccr is modified.

Changes since v2:
  * Do not cache VECLEN, VECSTRIDE, VFPEN.
    These variables come from VFP_FPSCR and VFP_FPEXC, not from
    system control registers.
  * Move HANDLER and STACKCHECK to rebuild_hflags_a32,
    instead of building them in rebuild_hflags_common.

Changes since v1:
  * Apparently I had started a last-minute API change, and failed to
    covert all of the users, and also failed to re-test afterward.
  * Retain assertions for --enable-debug-tcg.


Richard Henderson (20):
  target/arm: Split out rebuild_hflags_common
  target/arm: Split out rebuild_hflags_a64
  target/arm: Split out rebuild_hflags_common_32
  target/arm: Split arm_cpu_data_is_big_endian
  target/arm: Split out rebuild_hflags_m32
  target/arm: Reduce tests vs M-profile in cpu_get_tb_cpu_state
  target/arm: Split out rebuild_hflags_a32
  target/arm: Split out rebuild_hflags_aprofile
  target/arm: Hoist XSCALE_CPAR, VECLEN, VECSTRIDE in
    cpu_get_tb_cpu_state
  target/arm: Simplify set of PSTATE_SS in cpu_get_tb_cpu_state
  target/arm: Hoist computation of TBFLAG_A32.VFPEN
  target/arm: Add arm_rebuild_hflags
  target/arm: Split out arm_mmu_idx_el
  target/arm: Hoist store to cs_base in cpu_get_tb_cpu_state
  target/arm: Add HELPER(rebuild_hflags_{a32,a64,m32})
  target/arm: Rebuild hflags at EL changes
  target/arm: Rebuild hflags at MSR writes
  target/arm: Rebuild hflags at CPSR writes
  target/arm: Rebuild hflags for M-profile.
  target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

 target/arm/cpu.h           |  84 +++++---
 target/arm/helper.h        |   4 +
 target/arm/internals.h     |   9 +
 linux-user/syscall.c       |   1 +
 target/arm/cpu.c           |   1 +
 target/arm/helper-a64.c    |   3 +
 target/arm/helper.c        | 383 ++++++++++++++++++++++++-------------
 target/arm/m_helper.c      |   6 +
 target/arm/machine.c       |   1 +
 target/arm/op_helper.c     |   4 +
 target/arm/translate-a64.c |  13 +-
 target/arm/translate.c     |  28 ++-
 12 files changed, 363 insertions(+), 174 deletions(-)

-- 
2.17.1


