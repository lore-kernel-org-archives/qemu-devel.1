Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A18C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFAA208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIgyyhhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFAA208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBv89-0008EJ-Vy
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6O-00065t-Ld
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6N-0001bs-Fi
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:24 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:44728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6N-0001an-AP
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id d9so608427plo.11
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=87Rk2Cus7V553zmUHZsKztsptlyw22li5a6Jn7L7yqM=;
 b=jIgyyhhICLIjSLjLOWshNGCsIO3EQvMaTa7iEm8NKuV8QZ9UJwuQRkCjtsLUCR/QXg
 XKMmD8xH12NDTBtCYLD+TkhKFfDGqEgPzV88rbZ6iFwkVM2af8liN5kEmH8Tw+JnuDzV
 5zke21LSBMF6RyJt++Eemyl69h26vEMSG+opDF6jCVJajDO6Jc6XpM1khqY5QopSvYzw
 8sHfRpjfBGXtBCgxcwKxj081Tu83gSMsZZS4SzVpYMDXmgYdn/6I8zC02ho71Zq8VmBg
 3xt3IJWm9Ydwfvkp08rcPY1MympoADfyvXSQQw80QxRLooMnIsdQ9o4Kf86gErCoEz7y
 mopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=87Rk2Cus7V553zmUHZsKztsptlyw22li5a6Jn7L7yqM=;
 b=k0pzMY4JlQsNOoKFDKyMUeDU8X/+BwrOuzFnmxtIvYeyLji+VHr4pCp4qQfz6/5vgN
 laQs72xBFMOnChPtyYzti6wMlDy+9G8WwqTEVdE9ywU+XweSZqc/xRrx4JPg2A9cdOZO
 m9MUN/WkUaiO8qDphKLYbAalkHK2uogzSz3EHWE8fCwPl+f63gM1FCMg/t2yHvvKI5o1
 Ap2G4hLLCMNXmN1HIFEIvytmdfPr52p7+yPE4oITINW3MgGF5Z1QisaWSjhpCJ0RQ7Rz
 lhT9dS2/It4nM1fX+AtOvBaQ6DGP0uj2aQPamAe/Q5Gtaq3vC22aWqZLNsyWQjosMeH3
 IiOw==
X-Gm-Message-State: ANhLgQ1tXy/inOPCX9UTm4bDZ3UNu79xo7ABJFdYd+onBixhptyxmxQU
 Tao3yJKdvc2tdUDByuUssRrukmYpz/s=
X-Google-Smtp-Source: ADFU+vtYWP4MqbZ+/OM1oIF+0mswM8Kxmuh3FAjA8/WWmiz72mieAHJLdiCxQ37ywLqEr/DZtYvMpg==
X-Received: by 2002:a17:90a:8d86:: with SMTP id
 d6mr1870847pjo.119.1583909061773; 
 Tue, 10 Mar 2020 23:44:21 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/16] target/arm: sve load/store improvements
Date: Tue, 10 Mar 2020 23:44:04 -0700
Message-Id: <20200311064420.30606-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The goal here is to support MTE, but there's some cleanup to do.

Technically, we have sufficient interfaces in cputlb.c now, but it
requires multiple tlb lookups on different interfaces to do so.

Adding probe_access_flags() allows probing the tlb and getting out
some of the flags buried in the tlb comparator, such as TLB_MMIO
and TLB_WATCHPOINT.  In addition, we get no-fault semantics,
which we don't have via probe_acccess().

Adding cpu_probe_watchpoint() allows to *not* stop a first-fault
or no-fault load when the page contains a watchpoint, but the actual
access does not hit.

Having these available means that we can handle all of the watchpoints
for a given set of loads/stores all at once, before we begin doing any
actual memory operations.  Further, the actual memory operation on a
page of ram that has a watchpoint can still use the fast path.

Looking forward to MTE, we can examine the Tagged bit on a per-page
basis and avoid dozens of mte_check calls that must be Unchecked.
That comes later, in a new version of the MTE patch set, but I do
add comments for where the checks should be added.


r~


Richard Henderson (16):
  accel/tcg: Add block comment for probe_access
  accel/tcg: Add probe_access_flags
  exec: Add cpu_probe_watchpoint
  target/arm: Use cpu_*_data_ra for sve_ldst_tlb_fn
  target/arm: Drop manual handling of set/clear_helper_retaddr
  target/arm: Add sve infrastructure for page lookup
  target/arm: Adjust interface of sve_ld1_host_fn
  target/arm: Use SVEContLdSt in sve_ld1_r
  target/arm: Handle watchpoints in sve_ld1_r
  target/arm: Use SVEContLdSt for multi-register contiguous loads
  target/arm: Update contiguous first-fault and no-fault loads
  target/arm: Use SVEContLdSt for contiguous stores
  target/arm: Reuse sve_probe_page for gather first-fault loads
  target/arm: Reuse sve_probe_page for scatter stores
  target/arm: Reuse sve_probe_page for gather loads
  target/arm: Remove sve_memopidx

 include/exec/cpu-all.h     |   13 +-
 include/exec/exec-all.h    |   39 +
 include/hw/core/cpu.h      |    7 +
 target/arm/internals.h     |    5 -
 accel/tcg/cputlb.c         |  178 +--
 accel/tcg/user-exec.c      |   36 +-
 exec.c                     |   19 +
 target/arm/sve_helper.c    | 2238 +++++++++++++++++++-----------------
 target/arm/translate-sve.c |   17 +-
 9 files changed, 1404 insertions(+), 1148 deletions(-)

-- 
2.20.1


