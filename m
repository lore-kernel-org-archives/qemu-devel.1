Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A71C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02012070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVtStrCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02012070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC8Y-0008UM-39
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC2u-0001Uo-Jh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC2s-0006Lb-LY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:19 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC2s-0006LJ-71
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:18 -0400
Received: by mail-pj1-x1043.google.com with SMTP id y6so901855pjc.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3PhBF8pkPP4h2ikbz02V6XtmjibwE3FfKS6kQ86bTw8=;
 b=TVtStrCmIy5+a+/Rk7gZXooqHZbvgpT1AM3xrltLv32pkog2xLUzg+auUA2zW5qiRI
 ht1gj0Ja0FylNc0zQ5qPAkKrblN0MBqrmF/tHAbLGsV44ndx88GJXY30p5Pvmj5mBDBW
 Yiz4qVKArfMjc5NXABBotka1FTtoZmbfCSjoKWFFJqTNhK5LilITFKXAfo/WlKjGipva
 xk79B0Gl5F0cKNN2VIFzD5fyy8hBscqvSGNmxbMu6/nq+FSLBiBmeBbuNk9WXupNhDUV
 BU2Ynhqc77el3yu9ufDwr99AYZRoEXF6YxqngSZ9gSdBMPzqObtpb7LgZgfbUXUdDHaW
 2J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3PhBF8pkPP4h2ikbz02V6XtmjibwE3FfKS6kQ86bTw8=;
 b=tTWCHCAhzwm9F+3oacK9ajY6UJ/jSd8qQVGiU+q1kWOSW2w6XTc3S1LlB63zFdGTyH
 rxXLXIOEpPAzquSY3fFyD43t838kXrKLmriGfS9rQ7GzWdNfMPiU8zyCmjt4jiRm0qLD
 LP27acF+Z2+Eaq2h4IDlXGVScTUL58fRHo3gbg2foTGh6g8ye7rq2hId7rjWLci5aovD
 07Hj2UKLcR9rSk4HjW+ge+NXTqRAp4gpjKate4vvG3X1Z3qcMH5Xide3u0Hj8IYXcujp
 h6/zjWiQ9+WjMDz1pAzAB8o849tu0ktBJoQMP55PzvK4CgJd7hUwlbG9Hz2fwtkSPhkv
 uVoA==
X-Gm-Message-State: AGi0PuaeHTRokUCSlh+RJGrB0KP7BcYYjUSe7/pulyxdDoiDfTxE89z7
 GcQAb4vk174WcAonAzxbODYfGqdoy1k=
X-Google-Smtp-Source: APiQypLmoKOWvgSnvIgVKN2FiSBuToSvS8tyRCteMZDA3Lort8Nek2hlyErBCzidE1GsxK31ueO8JA==
X-Received: by 2002:a17:90a:df15:: with SMTP id
 gp21mr4093322pjb.2.1588264095460; 
 Thu, 30 Apr 2020 09:28:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/18] target/arm: sve load/store improvements
Date: Thu, 30 Apr 2020 09:27:55 -0700
Message-Id: <20200430162813.17671-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
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

Looking forward to MTE, we can examine the Tagged bit on a per-page
basis and avoid dozens of mte_check calls that must be Unchecked.
That comes later, in a new version of the MTE patch set, but I do
add comments for where the checks should be added.

Version 4 addresses some review comments.
Only 2 patches still unreviewed:

0004-accel-tcg-Add-probe_access_flags.patch
0013-target-arm-Update-contiguous-first-fault-and-no-f.patch


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
 include/exec/cpu_ldst.h     |  283 +++--
 include/exec/exec-all.h     |   39 +
 include/hw/core/cpu.h       |   23 +
 target/arm/internals.h      |    5 -
 accel/tcg/cputlb.c          |  413 ++++---
 accel/tcg/user-exec.c       |  256 +++-
 exec.c                      |    2 +-
 target/arm/sve_helper.c     | 2241 +++++++++++++++++++----------------
 target/arm/translate-sve.c  |   17 +-
 11 files changed, 1999 insertions(+), 1332 deletions(-)

-- 
2.20.1


