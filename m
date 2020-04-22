Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1BBC38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C740720672
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpl34NWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C740720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR77r-0005eY-T2
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74X-0000QK-PH
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74T-0004ZD-KD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:17 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:38923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR74T-0004VH-6i
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id 18so443298pfx.6
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pKbOEWyU9fNjeLYwA9C79bvgdQrUPgdTmUZ8kMVD8Co=;
 b=cpl34NWfMv1tdZjFn30IoeUxm3ibIczCV842NGy2PQ0bkWQC5AZiCl2zCP7xdR7IAj
 BNGhIbFiUWfmoMpmxVv1ruuHDufwVulGO3y4rrVuSuWFzbhmcChqRsdp2qW05ckoM9I2
 cxdfJnl9eXhjpNs92as4UU+BszpadzE2QWeIEIyUQfkrtVkQHH6pUvPJJNW7lKbQCYsm
 MNSSTsFFCoz1EoDVDDNeWBsfn5lJ/v7SooszQq8d76WyhkqKCkovQev+qlPax9KcXqfe
 a81/EAn8jXfNJJhNWsM6VVtRbHTWvau180b8bwD6UAd65V+y+ITgN/mJVAsesFSIW93p
 T2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pKbOEWyU9fNjeLYwA9C79bvgdQrUPgdTmUZ8kMVD8Co=;
 b=n7Mnmz28HqiLLIbnzd2qsMbky8Q1+miZUjo4VkjVZ+MjzhHNFDNULTghl+z20yOS3G
 fH0gAG2Su23v3HTNkVJNsPo8USiqW/THDCSToYaSSYNXl0R4RmP58+9RT61HT3CQSQA1
 DTZJH1p10PGdFrKmsOV22Q7fTQ8btowrT/uUC7olPvCfe+eLefVWLoIK08o77OYj1ob9
 6ioNmzHJ4jhWCfkawu/YcaD7m9Tq2v1+ncoDJLAyfLoC1rS11sTWEoxVr1U5WoQP6eW4
 wRqUGmQdBKqikEuyUZSuZORpQt+kdwMN9ph1fNSx43CGQ6xpUhejSL32aSrQ09JFRwb/
 /1fA==
X-Gm-Message-State: AGi0PuZ6boTEhLq6K1B5MnigFJykgKjWs0+dMVl37MkMpArH8xP9lgFw
 Ovt7IqqvAdBPmXRmXl75a1buRgiEy0s=
X-Google-Smtp-Source: APiQypLAWyNgHAXaZW+byesRwXyMmtzEult6Y5cXwtmWTS7ISej9myi0ejyAMpSNg9PccjJPIgzGBA==
X-Received: by 2002:a63:d510:: with SMTP id c16mr25175137pgg.123.1587529991233; 
 Tue, 21 Apr 2020 21:33:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm4129613pfd.107.2020.04.21.21.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 21:33:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/18] target/arm: sve load/store improvements
Date: Tue, 21 Apr 2020 21:32:51 -0700
Message-Id: <20200422043309.18430-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::433
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

Because there was a separate v2 of one of the patches,
avoid confusion and call the whole thing v3.

The goal here is to support MTE, but there's some cleanup to do.

Technically, we have sufficient interfaces in cputlb.c now, but it
requires multiple tlb lookups on different interfaces to do so.

Adding probe_access_flags() allows probing the tlb and getting out
some of the flags buried in the tlb comparator, such as TLB_MMIO
and TLB_WATCHPOINT.  In addition, we get no-fault semantics,
which we don't have via probe_acccess().

Looking forward to MTE, we can examine the Tagged bit on a per-page
basis and avoid dozens of mte_check calls that must be Unchecked.
That comes later, in a new version of the MTE patch set, but I do
add comments for where the checks should be added.

Version 3 drops cpu_probe_watchpoint, because while adding new
documentation I found we already had cpu_watchpoint_address_matches
which could do the job.


r~


Richard Henderson (18):
  exec: Add block comments for watchpoint routines
  exec: Fix cpu_watchpoint_address_matches address length
  accel/tcg: Add block comment for probe_access
  accel/tcg: Add probe_access_flags
  accel/tcg: Add endian-specific cpu_{ld,st}* operations
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

 docs/devel/loads-stores.rst |   39 +-
 include/exec/cpu-all.h      |   13 +-
 include/exec/cpu_ldst.h     |  277 ++++-
 include/exec/exec-all.h     |   39 +
 include/hw/core/cpu.h       |   23 +
 target/arm/internals.h      |    5 -
 accel/tcg/cputlb.c          |  413 ++++---
 accel/tcg/user-exec.c       |  247 +++-
 exec.c                      |    2 +-
 target/arm/sve_helper.c     | 2237 +++++++++++++++++++----------------
 target/arm/translate-sve.c  |   17 +-
 11 files changed, 1985 insertions(+), 1327 deletions(-)

-- 
2.20.1


