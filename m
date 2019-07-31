Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD5C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B91720659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGsSntKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B91720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvNm-0005pW-7K
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMY-0003ve-CX
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMX-0003GR-4Y
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMW-0003Fp-UV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:17 -0400
Received: by mail-pl1-x642.google.com with SMTP id m9so30878031pls.8
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uzXV5HLfF+FU/RryNG65fjgIjJymPTRX0BzRxR8xdnQ=;
 b=UGsSntKITTmN6I+19W1OAe02o6viPBqZK+IkOyTqZkcpwfnRlG3dgZ26uh+T5mjdhJ
 04q/Q8BeHh4ITZbHy/WHKBiZ6SN/TkXGCingEb3wr9m7VgZL/fCV4Y5KvkUKKaOq+6kr
 Vr3BUx/ZATslD3FOa7DnYYJeOQ/ln3XZ4Ag7tqRa/t+kOdkGjzejBzHksWMuhggaL5cX
 W3uG1hwV+g/0FNMwImFwU4d8OGF4EhkbZN3Z3vE3O4glxABe+mmyoc0UYwknpNBK13ms
 WALDz5BtHBFxNM+M9dTmq4pvD9VpmDPzSdssBjYvjfQ1CaI8E9c0erZCdpkK3WwDPUxM
 UZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uzXV5HLfF+FU/RryNG65fjgIjJymPTRX0BzRxR8xdnQ=;
 b=QALi/XOgSWOyffWYpUZS1ut/8plFGPnNxcP05JWJrx0yaFQ8WjtC/jRoe4+/t6/stW
 Ln/31jSuOs35kYzEmrsCQ3rrz1U1qJQU4Ua966R13Pdv2EtIB2eaUt6rcCI6ynz1trPS
 wVUDL+0MUDphUvYbC4JEsI2exqIBA5rPQPJh4zCBVKgW42t4JsBXvjcwR229mMTWRlA2
 cuYQixDk+dSzHMzAU5XJhG1GGZ3L8k6t2UHXT9RMyxAsYAgB93nTDpaDmHCzKtGNSH+2
 GV/21YmRhemclYVXeHrFU/7fkRF0ZSIxBgdX6TBMwDQFqMNYepinSqlu/UEpwbhAdfU0
 fCkg==
X-Gm-Message-State: APjAAAVYiivlTCVdKtkTPhLWn+f6T1H94IKQj+4S4fF8TTWEtPAs/Jre
 g9pF517mDcoqcMrg5XMJjl8uP/iRDPI=
X-Google-Smtp-Source: APXvYqyifwAob4uYGIzCTmix12IafdixE6Uo4eepaTB4923sVmp1ZsnXYkGQj9KI/XPe2kvd02ZJXw==
X-Received: by 2002:a17:902:2929:: with SMTP id
 g38mr101488206plb.163.1564605495556; 
 Wed, 31 Jul 2019 13:38:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:41 -0700
Message-Id: <20190731203813.30765-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 00/32] target/arm: Implement ARMv8.1-VHE
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

About half of this patch set is cleanup of the qemu tlb handling
leading up to the actual implementation of VHE, and the biggest
piece of that: The EL2&0 translation regime.

Changes since v1:
  * Merge feedback from AJB.
  * Split out 7 renaming patches from "Reorganize ARMMMUIdx".
  * Alex's MIDR patch keeps the nested KVM from spitting warnings.

I have tested 

  qemu-system-aarch64 -accel kvm -cpu host -M virt,gic-version-host \
    -m 512 -bios /usr/share/edk2/aarch64/QEMU_EFI.fd -nographic

with fedora 30 system qemu, itself booted with

  ../bld/aarch64-softmmu/qemu-system-aarch64 \
    -cpu max -M virt,gic-version=3,virtualization=on \
    -drive if=virtio,file=./f30.q,format=qcow2 \
    -m 4G -nographic

It took a while, but eventually the nested bios arrived at the
pxe boot sequence.  Thankfully (?), the f30 shipped bios has
debug enabled, so there's some sense of progress in the meantime.


r~


Alex Bennée (2):
  target/arm: check TGE and E2H flags for EL0 pauth traps
  target/arm: generate a custom MIDR for -cpu max

Richard Henderson (30):
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
  target/arm: Rename ARMMMUIdx*_S12NSE* to ARMMMUIdx*_E10_*
  target/arm: Rename ARMMMUIdx_S2NS to ARMMMUIdx_Stage2
  target/arm: Rename ARMMMUIdx_S1NSE* to ARMMMUIdx_Stage1_E*
  target/arm: Rename ARMMMUIdx_S1SE* to ARMMMUIdx_SE*
  target/arm: Rename ARMMMUIdx*_S1E3 to ARMMMUIdx*_SE3
  target/arm: Rename ARMMMUIdx_S1E2 to ARMMMUIdx_E2
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
 include/qom/cpu.h          |   2 +
 target/arm/cpu-qom.h       |   1 +
 target/arm/cpu.h           | 260 +++++-----
 target/arm/internals.h     |  62 ++-
 target/arm/translate.h     |   2 +-
 accel/tcg/cputlb.c         |  81 +++
 target/arm/arch_dump.c     |   2 +-
 target/arm/cpu.c           |   2 +
 target/arm/cpu64.c         |  20 +
 target/arm/debug_helper.c  |  50 +-
 target/arm/helper-a64.c    |   2 +-
 target/arm/helper.c        | 983 ++++++++++++++++++++++++++-----------
 target/arm/m_helper.c      |   6 +-
 target/arm/pauth_helper.c  |  13 +-
 target/arm/translate-a64.c |  13 +-
 target/arm/translate.c     |  17 +-
 19 files changed, 1088 insertions(+), 476 deletions(-)

-- 
2.17.1


