Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8593DC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462C720693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJ21sXRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462C720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNgV-0005dS-Cz
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:59:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNep-0004L6-Ly
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNen-0000zv-W3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNen-0000ym-EJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id w1so26953421wrp.2
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=6nZ7otvE8hl7heFHIJUj8KIKUXWQ/qMPumMrlOkY7O0=;
	b=lJ21sXRjVHN/uUY7NkesQ6oby4jBpYPS5PcwMFd6xNG3DW88PjjzyKn2IvuEPFEuu4
	70X4kVwH0PlY2PajZtMX6MDJbHf0WPnpOuzPVT+9fVVb2PEsvNfjfRbHCXaJsHUmY80u
	amELi1UNP5JW/TDll64mK8uSHKO67Hie8QmZ9hf2y3lXkxw2VY0oPfx9k24XmDbYA8nG
	VU9HIY8AMh4SI6UMQpLb94uPHRmyMZFhi7bXP5U6Lud3IGr+ropIg3QyXDIggQZLNCOW
	VU9Atw+Go7/1YoDGIVgFn0GqI14Phj59d8c+7RPU5N7zNeJNI7/fL+9lUfrAVWqa2Til
	iXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=6nZ7otvE8hl7heFHIJUj8KIKUXWQ/qMPumMrlOkY7O0=;
	b=Ie2m3tebluOmjplEqVYwMYU015wYV7HRvbKA15x0VJ5W4tyOFcE5sGqLdD8rWDZmOs
	OkvN0oBt6FL4tATR68vILZ85jlUG+8usPkms6KAUtTVb/I/rYSYY4G9U8CpV2o551f85
	6U6oyuiZiEPzeeiO86/UmkY0Kg0hHDFuc4zU2AoGrhpqte5sclDXBROLZIIDEUKYM+T4
	Po/Hfa1K+XEe2n/q1ljJbEzfGbY1Jg7Z7C0hQ0Deyb7A4Y7FNC1K7MufozmTRAm6gtF9
	jkeZGtVecTh/frZcq+tTp+tpu+MUr/IsnUKHNcYJNwUFr76WwXbQSpTQqHCje2ewLof2
	TFvA==
X-Gm-Message-State: APjAAAUX+OGi/xUhtAMjC7oL5QWPJ5lFhvnK4nL8qpoaDM0dUHHoW1ln
	ndzCpTS1YMrduTrDasozTMXX5w==
X-Google-Smtp-Source: APXvYqyHVQ5dc5UvWeCiX8tPrzBPwJonltWxLZKLgjMuPtMfhYqerlucK6CE8QG+QUaVIOCcPQmZ2A==
X-Received: by 2002:a05:6000:12c8:: with SMTP id
	l8mr50511071wrx.80.1555419467655; 
	Tue, 16 Apr 2019 05:57:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.57.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:57:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:18 +0100
Message-Id: <20190416125744.27770-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PATCH 00/26] target/arm: Implement M profile floating
 point
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125718.Od01CYxP5BheS3eXKWJM0oPiMc3HVkRgC0bWddcGwc4@z>

This patchset implements floating point support for the
M-profile Arm cores and enables it for the Cortex-M4 and
Cortex-M33 (both of which should really have an FPU).

The floating point instructions for M-profile are basically
the same as for A-profile (with some minor differences like
not having all the VFP sysregs, and definitely not having
the old VFP length/stride handling). The major differences are
in the exception handling:
 * on exception entry and exit we may want to stack and
   unstack FP registers, as we do for integer registers
 * M-profile supports a "lazy stacking" mode, which means that
   on exception entry we do not stack the FP registers that
   the calling convention requires us to preserve, but just
   reserve space for them. Then if the exception handler
   executes an FP instruction we spill the FP registers to
   the stack only at that point

There are also two M-profile-only instructions, VLLDM and
VLSTM, which are for guest code to actively trigger the
lazy-stacking.

Most interesting bit to review is probably whether I got the
handling of the new TB flag bits right (in patches 18, 19
and 23), since they have a kind of self-clearing property
that's a bit non-standard.

thanks
-- PMM

Peter Maydell (26):
  target/arm: Make sure M-profile FPSCR RES0 bits are not settable
  hw/intc/armv7m_nvic: Allow reading of M-profile MVFR* registers
  target/arm: Implement dummy versions of M-profile FP-related registers
  target/arm: Disable most VFP sysregs for M-profile
  target/arm: Honour M-profile FP enable bits
  target/arm: Decode FP instructions for M profile
  target/arm: Clear CONTROL_S.SFPA in SG insn if FPU present
  target/arm: Handle SFPA and FPCA bits in reads and writes of CONTROL
  target/arm/helper: don't return early for STKOF faults during stacking
  target/arm: Handle floating point registers in exception entry
  target/arm: Implement v7m_update_fpccr()
  target/arm: Clear CONTROL.SFPA in BXNS and BLXNS
  target/arm: Clean excReturn bits when tail chaining
  target/arm: Allow for floating point in callee stack integrity check
  target/arm: Handle floating point registers in exception return
  target/arm: Move NS TBFLAG from bit 19 to bit 6
  target/arm: Overlap VECSTRIDE and XSCALE_CPAR TB flags
  target/arm: Set FPCCR.S when executing M-profile floating point insns
  target/arm: Activate M-profile floating point context when FPCCR.ASPEN
    is set
  target/arm: New helper function arm_v7m_mmu_idx_all()
  target/arm: New function armv7m_nvic_set_pending_lazyfp()
  target/arm: Add lazy-FP-stacking support to v7m_stack_write()
  target/arm: Implement M-profile lazy FP state preservation
  target/arm: Implement VLSTM for v7M CPUs with an FPU
  target/arm: Implement VLLDM for v7M CPUs with an FPU
  target/arm: Enable FPU for Cortex-M4 and Cortex-M33

 target/arm/cpu.h        |  95 ++++-
 target/arm/helper.h     |   5 +
 target/arm/translate.h  |   3 +
 hw/intc/armv7m_nvic.c   | 261 ++++++++++++
 target/arm/cpu.c        |  20 +
 target/arm/helper.c     | 873 +++++++++++++++++++++++++++++++++++++---
 target/arm/machine.c    |  16 +
 target/arm/translate.c  | 150 ++++++-
 target/arm/vfp_helper.c |   8 +
 9 files changed, 1350 insertions(+), 81 deletions(-)

-- 
2.20.1


