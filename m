Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8CBC3B1B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE07206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkRx+UJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE07206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2f8t-0007wY-NP
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7a-0005lM-Fc
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7Z-0000b1-1W
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7Y-0000aE-Pt
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a9so11560036wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lfMPkGIi4UJZPQtmandbg313ggqz9J+Qto9iPFBLaMY=;
 b=SkRx+UJGypsRPUL5ZKYHtYgJCALUdvzPpymRrqiGQWXayr58X4GrFAvOh1i12uH9GQ
 aJhdfgTNf2JBTz9e8ZI4dWMFL1sXkpMG+xKwKOSJBXBSBawKbD04z49FlMapA294gSxh
 Wr6zP5of4zzKJP9fhZKmaVVVQCvBNdIkBtxf5xioP1G4tXH6NnxJyrL1Yv5Q1ZYEuaQn
 /wmaYnTGEa4H44yOqPqk7feiw9aAantNvaA0ZJBgwgq94GBpHAYq1NM6nmv/55ZmeWAq
 qSVqDYnYY0rkuotrILfmHsiqPP5TH526Q72TSLzaatvgsNFjm9GpFiNjmVm3cqG3UHKg
 R4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lfMPkGIi4UJZPQtmandbg313ggqz9J+Qto9iPFBLaMY=;
 b=biA9jqVfQ6IB5gCr67w0CcTHRuvTWMvtQljnUGC02iyd0hUeraQMiTk7B3HX5Irf3B
 VT2LY2OpQH5OuahOEQEMQbhzs9Nned3VKSWjNCciQAfADg552h6B8JaGWHuIWXpZJh8p
 9kTathisAdgCAVWiijBjEEG89qZMAOOv5CWZoCgfFRFLSyhgaYaCuySsCTNZEi629xD6
 Ze3K2GHXoNHgPP1uru4Y7YamqsdMH28rYyPeUVBHo5gm9kNQdZ/cJ1JvPmkH7UB7Z7eD
 AxfB50apSSmqM2Q7oZ7FGwFdCY7xAUyqEhj5yUfWCzcFCT+0YGqU4rxw1yDLW1Sz61D4
 P1VQ==
X-Gm-Message-State: APjAAAWoL9FAQGd7qv21qZ3xEV0YBiuRC7XtIGJYoko1zhQ7ZQH6qyHV
 NquJGMnxN4qLZef2iYOhmt4CMg==
X-Google-Smtp-Source: APXvYqw0iiN/EyVQaqX0x8/Vpf3LEbNSVl610zoQ+McMNv2HCqBW3Ctf0cfTWETR+PDvxwAZDeRhHg==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr5872005wmi.107.1581702679252; 
 Fri, 14 Feb 2020 09:51:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/21] arm: ARMv8.1- and v8.4-PMU, ID reg cleanup, [H]ACTLR2
Date: Fri, 14 Feb 2020 17:50:55 +0000
Message-Id: <20200214175116.9164-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


This patchset implements the ARMv8.1-PMU and ARMv8.4-PMU architecture
extensions. These are fairly small changes on top of the basic
PMUv3 we already implement, and in fact we already had most of
the v8.1-PMU functionality implemented but unadvertised.

In the course of doing this, I found that our naming and use of
isar_feature ID register test functions was slightly inconsistent,
so the first few patches straighten this out and align on an
_aa32_/_aa64_/_any_ convention for which ID registers to test.

The ARMv8.1-PMU extension requires:
 * the evtCount field in PMETYPER<n>_EL0 is 16 bits, not 10
 * MDCR_EL2.HPMD allows event counting to be disabled at EL2
 * two new required events, STALL_FRONTEND and STALL_BACKEND
 * ID register bits in ID_AA64DFR0_EL1 and ID_DFR0
We already implement all of that except the new events;
for QEMU our CPU never "stalls" in that sense, so we can
just implement them as always-reads-zero.

The ARMv8.4-PMU extension adds:
 * one new required event, STALL (again, reads-as-zero)
 * one new system register PMMIR_EL1, which provides information
   about the PMU implementation. Since the only currently defined
   field in it relates to an event we don't provide, we can
   validly implement the register as RAZ.

Two patches fix some bugs I discovered while running this through
Eric's recent kvm-unit-tests PMU tests:
 * we had the wrong definition of the PMCR.DP bit position
 * we incorrectly implemented PMCR.LC as RAZ/WI

I also fix some random minor bugs I noticed while cleaning up the
ID register handling.

Finally there's an implementation of ACTLR2 and HACTLR2 sysregs;
these are pretty trivial but required from Armv8.2 onward. This is
strictly speaking unrelated to perf, but the patch depends on all
the preceding cleanup stuff.

I don't generally use the perf emulation, so testing would be
welcome from people who do.

Changes v1->v2:
 * now rebased on master, so patch 1 fixes up an extra new use of
   isar_feature_jazelle
 * patch 2 is new: take_aarch32_exception should check aa32_pan, not aa64_pan
 * minor fixups per review comments (mostly using 64-bit versions
   of extract/deposit where appropriate)
 * added code to get values of ID registers from KVM
 * when I added that code I ran into a bunch of problems which
   stemmed from our using the 32-bit DBGDIDR as the source of truth
   about numbers of breakpoints etc, which then breaks if the host
   KVM CPU is AArch64-only, so some patches clean that up
 * patch 18 fixes a cut-n-paste error I noticed where we were reading
   entirely the wrong register in aa32_pan and aa32_ats1e1
 * patch 19 adds an isar_feature test to replace an opencoded examination
   of an ID register field
 * patch 20 uses FIELD_EX32 for 32-bit ID registers rather than FIELD_EX64
 * patch 21 implements ACTLR2 and HACTLR2

Patches 1, 3-9, and 13-17 have already been reviewed;
2, 10-12, and 18-21 are new in v2.

thanks
-- PMM



Peter Maydell (21):
  target/arm: Add _aa32_ to isar_feature functions testing 32-bit ID
    registers
  target/arm: Check aa32_pan in take_aarch32_exception(), not aa64_pan
  target/arm: Add isar_feature_any_fp16 and document naming/usage
    conventions
  target/arm: Define and use any_predinv isar_feature test
  target/arm: Factor out PMU register definitions
  target/arm: Add and use FIELD definitions for ID_AA64DFR0_EL1
  target/arm: Use FIELD macros for clearing ID_DFR0 PERFMON field
  target/arm: Define an aa32_pmu_8_1 isar feature test function
  target/arm: Add _aa64_ and _any_ versions of pmu_8_1 isar checks
  target/arm: Stop assuming DBGDIDR always exists
  target/arm: Move DBGDIDR into ARMISARegisters
  target/arm: Read debug-related ID registers from KVM
  target/arm: Implement ARMv8.1-PMU extension
  target/arm: Implement ARMv8.4-PMU extension
  target/arm: Provide ARMv8.4-PMU in '-cpu max'
  target/arm: Correct definition of PMCRDP
  target/arm: Correct handling of PMCR_EL0.LC bit
  target/arm: Test correct register in aa32_pan and aa32_ats1e1 checks
  target/arm: Use isar_feature function for testing AA32HPD feature
  target/arm: Use FIELD_EX32 for testing 32-bit fields
  target/arm: Correctly implement ACTLR2, HACTLR2

 target/arm/cpu.h          | 143 +++++++++++++++---
 target/arm/internals.h    |  44 +++++-
 hw/intc/armv7m_nvic.c     |  10 +-
 linux-user/elfload.c      |   4 +-
 target/arm/cpu.c          | 150 +++++++++---------
 target/arm/cpu64.c        |  58 ++++---
 target/arm/debug_helper.c |   6 +-
 target/arm/helper.c       | 311 ++++++++++++++++++++++----------------
 target/arm/kvm32.c        |  25 +++
 target/arm/kvm64.c        |  46 ++++++
 target/arm/translate.c    |   6 +-
 target/arm/vfp_helper.c   |   2 +-
 12 files changed, 544 insertions(+), 261 deletions(-)

-- 
2.20.1


