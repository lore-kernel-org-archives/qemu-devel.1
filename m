Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE50FC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBF62086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8Ov91TP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBF62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZVB-0007pB-N7
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTh-0005hO-88
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTf-00043F-9c
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:40 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTc-0003uX-C2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:36 -0500
Received: by mail-wr1-x429.google.com with SMTP id u6so13526094wrt.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pOWADl33ItxnHLnQPh02kJSDMI6+RBZACRYlGT5q2kA=;
 b=f8Ov91TPgNR7MnEPQ5eXQmWueQiHZnuJ4bVhI7UAbktZ+fGBFDLzzESpXQua3JY59M
 b/b2CvHXmusdrAPVN42FcwjdnyDTWiuoAsTlaiGu6AXxcKkgOgXUw7fzKHB37XW/9GxU
 UXq6JadmCzUTTLWa5B0iDn51kefFEWRnfk3CB++jXUl01w3uNMmdbcJ+cv9hPsU9rgDs
 DJY4JFf9Z4gms4GJAmz0Syw/TB3wRrFYplpZ8RuL3Ty+46m4DMcqV97v3atmMc9bZQYU
 TxlAbYbDyqPrYqBwOKcbEu/i1rUhpXz6XsDx0mhWxeWFWI3j26SDFwVbMsTiIOcARum2
 jwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pOWADl33ItxnHLnQPh02kJSDMI6+RBZACRYlGT5q2kA=;
 b=JGridasCShE0JxzF3v/qhUALHRXxki8CLVGudsMhE05YOTMpsy/Xhu9YttqW4IYtUX
 d3zAr4UwmOdOzjANFkk+ulX65Lw+l/YCLCCzJAKgdHae2VD1dc2baHRtdu9bCwsmy1Ii
 eHxrYolLjFgzG30gHf1BdkSV1QXkI6tyaZhLTiKB83p6uxmXjifDNcL73eeH5amG8xFP
 +ZMW8KclVtJp903UhjyxjmbgB/gO09jMaePqraQ17hOuuoZxoK5ETlsqhL4rRf2blKPy
 fmhQdcsaudo72tSPx2V7x3XeomfXVhwJ1My+4hyDKV/Mdv3wv/q+LCVkbN2HxxhDYjfk
 85VQ==
X-Gm-Message-State: APjAAAVpCf3N0mntGD6/5CmQVICqoKYXhgeznwmsye/6Aj52kPa2gMqs
 LjicEKNRFiT9D2NQIjntgFOZnQ==
X-Google-Smtp-Source: APXvYqwrgooQpZp+nYDAYx2QFK1oTEN2lNKqH8+3pT5mBgx4lwOdHWaejIZbCHe3TNDhV1Hx9ljmqQ==
X-Received: by 2002:adf:d850:: with SMTP id k16mr9419458wrl.216.1581442649904; 
 Tue, 11 Feb 2020 09:37:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/13] arm: Implement ARMv8.1-PMU and ARMv8.4-PMU
Date: Tue, 11 Feb 2020 17:37:13 +0000
Message-Id: <20200211173726.22541-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset implements the ARMv8.1-PMU and ARMv8.4-PMU architecture
extensions. These are fairly small changes on top of the basic
PMUv3 we already implement, and in fact we already had most of
the v8.1-PMU functionality implemented but unadvertised.

In the course of doing this, I found that our naming and use of
isar_feature ID register test functions was slightly inconsistent,
so the first few patches straighten this out and align on:

 * functions which test AArch32 ID registers always have an
   _aa32_ infix in their name, and can only be used if we
   know the CPU has AArch32 (eg in codegen in translate.c)
   or if "false" is the right answer for a no-AArch32 CPU
   (eg registering AArch32-only system registers, or
   determining whether to allow guest writes to sysreg bits
   that are writeable only on the AArch32 version of the reg)
 * functions which test AArch64 ID registers always have an
   _aa64_ infix in their name, and can only be used if
   we know the CPU has AArch64 or if "false" is the right
   answer for a no-AArch64 CPU
 * functions with an _any_ infix always return the logical
   OR of the _aa32_ and _aa64_ tests, and should be used
   when we want to know "does this feature exist" in code
   that might be called for AArch32 or AArch64

I have audited all the callsites of isar_feature tests and they
almost all followed this naming convention and usage already.  We
were missing the _aa32_ infix in the arm_div, thumb_div and jazelle
tests, and we needed an _any_ version of the function for fp16
(specifically whether FP(S)CR.FZ16 is writeable) and for predinv
(whether to register the sysregs).

Having got those preliminaries out of the way, we can define _aa32_,
_aa64_ and _any_ versions of "do I have a PMUv3 with the v8.1
extensions?", and use them when implementing the extended
functionality.

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

The final two patches fix some bugs I discovered while
running this through Eric's recent kvm-unit-tests PMU tests:
 * we had the wrong definition of the PMCR.DP bit position
 * we incorrectly implemented PMCR.LC as RAZ/WI

I've tested this with Eric's unit tests, and by running 'perf test'
in a VM (which had some failures but none which seemed to be related
to these changes).  I don't generally use the perf emulation, so
testing would be welcome from people who do.

Based-on: 20200210120146.17631-1-peter.maydell@linaro.org
("target/arm: Implement ARMv8.1-VMID16 extension")
purely to avoid possible textual conflicts.

thanks
-- PMM


Peter Maydell (13):
  target/arm: Add _aa32_ to isar_feature functions testing 32-bit ID
    registers
  target/arm: Add isar_feature_any_fp16 and document naming/usage
    conventions
  target/arm: Define and use any_predinv isar_feature test
  target/arm: Factor out PMU register definitions
  target/arm: Add and use FIELD definitions for ID_AA64DFR0_EL1
  target/arm: Use FIELD macros for clearing ID_DFR0 PERFMON field
  target/arm: Define an aa32_pmu_8_1 isar feature test function
  target/arm: Add _aa64_ and _any_ versions of pmu_8_1 isar checks
  target/arm: Implement ARMv8.1-PMU extension
  target/arm: Implement ARMv8.4-PMU extension
  target/arm: Provide ARMv8.4-PMU in '-cpu max'
  target/arm: Correct definition of PMCRDP
  target/arm: Correct handling of PMCR_EL0.LC bit

 target/arm/cpu.h        |  87 +++++++++++++-
 hw/intc/armv7m_nvic.c   |   2 +-
 linux-user/elfload.c    |   4 +-
 target/arm/cpu.c        |  37 +++---
 target/arm/cpu64.c      |  20 +++-
 target/arm/helper.c     | 248 ++++++++++++++++++++++++----------------
 target/arm/translate.c  |   6 +-
 target/arm/vfp_helper.c |   2 +-
 8 files changed, 273 insertions(+), 133 deletions(-)

-- 
2.20.1


