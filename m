Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26532C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5A021873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEAYZSK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5A021873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa2z-0005EW-OU
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54877)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa2P-0003Eq-AS
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa2N-00055T-Ht
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa2N-00054H-6Z
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id f5so6143349pgu.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6KA+gc1dIKgd05kqZ8UxzAGdqlOGfEAi9ehKvHg8DoQ=;
 b=NEAYZSK0aJCFjG/tbry43VvaWRqmMzndg4URBM/4qwbWexneungCUeSUoCQwzmCka3
 R8xTThnfHWe/E5XQ8NOqWZjGLNJ3hPNqcjvevT2njYW+IRgZgwm6ABi6i2kYWE5htTi+
 7Wx66YOCbfWwWD3qtUQ+p5RxKOlpuIxQbTunTIRe0u+wk6LlF5MJ0b7orhFOOGXOf7TN
 AAahMzuxjJtvfvBCT2RD8sdBpkOMZ9S/ASHZL2eixnSQZzMNbWzijaXF9gwP0YhTNfE4
 Wfew93qiE6RBXCdhDVJPmxBur3PRhCF2ONC62oSLkSEi95bBQbssW1fC8JBRC6Z0xWNK
 /YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6KA+gc1dIKgd05kqZ8UxzAGdqlOGfEAi9ehKvHg8DoQ=;
 b=Wi/dUitwuDGBC3W0jpmEZ6apsl5rFas9xnGEs88htBmNyyhANQge9ohvmy5xwn+J5m
 EwlDExGGeK6GUdLuFTI2Gpjfy3CUTqNGJhHn7rcvN2UT/Xcy8DaXuk4VjxrZsRGMX1TN
 1FHsan4rXDYxQBBq059q03UvauIH2/jpT5Os0CxZxH4NZjPhbBwPpkw1dJVPW1E5SxDB
 tizjiiuEq4q7pAp7FNAAW0gMuUbITdj6vY2zO8U4FGynWnaWmcfOcZh2+4P7VgMpvVGX
 I6Spb7JntgHQVUfE7QkW3EiP7SOSdDqvJTClWNkEBkn2qeKEM4VFdXOQwVbpGDNzDXSX
 LLqQ==
X-Gm-Message-State: APjAAAWHAHWQMrdzfXkZlo8FS+DyteS65/FPXpCcnoQgml1v/eBy9gp8
 xQ68jrSvXtVu1zNI2/DSWtQMZDYK7J0=
X-Google-Smtp-Source: APXvYqwctYbYbn/AuJOftozT+QWTWFp/BQ69dMEfOVuKa9zjnN/GswSVrt/3dsurLb6KkPTPk3Gy/Q==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr29544117pgh.325.1563570208269; 
 Fri, 19 Jul 2019 14:03:28 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:02 -0700
Message-Id: <20190719210326.15466-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH for-4.2 00/24] target/arm: Implement ARMv8.1-VHE
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

About half of this patch set is cleanup of the qemu tlb handling
leading up to the actual implementation of VHE, and the biggest
piece of that: The EL2&0 translation regime.

Testing so far has been limited to booting a debian 9 system with
a 4.9 kernel, and a fedora 30 system with a 5.1 kernel.  Both have
KVM enabled, and both report enabling VHE is successful.


r~


Richard Henderson (24):
  cputlb: Add tlb_set_asid_for_mmuidx
  cputlb: Add tlb_flush_asid_by_mmuidx and friends
  target/arm: Install ASIDs for long-form from EL1
  target/arm: Install ASIDs for short-form from EL1
  target/arm: Install ASIDs for EL2
  target/arm: Define isar_feature_aa64_vh
  target/arm: Enable HCR_E2H for VHE
  target/arm: Add CONTEXTIDR_EL2
  target/arm: Add TTBR1_EL2
  target/arm: Update CNTVCT_EL0 for VHE
  target/arm: Add the hypervisor virtual counter
  target/arm: Add VHE system register redirection and aliasing
  target/arm: Split out vae1_tlbmask, vmalle1_tlbmask
  target/arm: Simplify tlb_force_broadcast alternatives
  target/arm: Reorganize ARMMMUIdx
  target/arm: Add regime_has_2_ranges
  target/arm: Update arm_mmu_idx for VHE
  target/arm: Update arm_sctlr for VHE
  target/arm: Install asids for E2&0 translation regime
  target/arm: Flush tlbs for E2&0 translation regime
  target/arm: Update arm_phys_excp_target_el for TGE
  target/arm: Update regime_is_user for EL2&0
  target/arm: Update {fp,sve}_exception_el for VHE
  target/arm: Enable ARMv8.1-VHE in -cpu max

 include/exec/cpu-all.h     |  11 +
 include/exec/cpu-defs.h    |   2 +
 include/exec/exec-all.h    |  35 ++
 include/qom/cpu.h          |   1 +
 target/arm/cpu-qom.h       |   1 +
 target/arm/cpu.h           | 259 +++++-----
 target/arm/internals.h     |  62 ++-
 target/arm/translate.h     |   2 +-
 accel/tcg/cputlb.c         |  77 +++
 target/arm/arch_dump.c     |   2 +-
 target/arm/cpu.c           |   2 +
 target/arm/cpu64.c         |   1 +
 target/arm/debug_helper.c  |  50 +-
 target/arm/helper-a64.c    |   2 +-
 target/arm/helper.c        | 985 ++++++++++++++++++++++++++-----------
 target/arm/m_helper.c      |   6 +-
 target/arm/pauth_helper.c  |   9 +-
 target/arm/translate-a64.c |  14 +-
 target/arm/translate.c     |  17 +-
 19 files changed, 1058 insertions(+), 480 deletions(-)

-- 
2.17.1


