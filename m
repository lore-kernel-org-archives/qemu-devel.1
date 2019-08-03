Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90283C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5673C2073D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/WffFcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5673C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htz5q-0007re-IB
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4X-0005s9-VC
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4W-00073F-NQ
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:05 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4W-00071n-FQ
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:04 -0400
Received: by mail-pf1-x441.google.com with SMTP id q10so37607147pff.9
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mdp2g3jSgzrGtd9KtHgOE+2yumLnmy9dW9qf3A8Vh/A=;
 b=M/WffFczN/fF0BKujryYFO7wtRBF0xlsTxmkm/n2qqwNGBn6fj5IZIGUl+y0zN4O+J
 MqJ2/KI0Opah1zmQsgGJOj7gNoXROcEpWp+jO+W+LeZr6nobami600pIy/qAOL+RxVfL
 FWXxV8hJmxoqxVK7ebqkI1wdU056Y4fwXjaEU/0AP7Zbm+mZ7jDiFzlQmfDsMysXQOv1
 FnK2GHwLpHzSr4TF5pYvHEnlkwnQh2bIHyVQcUgd2vpu2Nv0XPLfkKiUgfPE8UVYtC/w
 N4HUJHTF35aN3vSEQpudO3w8Dk2ZW/ZsdjJ6h8ouC9GbcTcDXj23fuVr8pwtkdAtuyCO
 CsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mdp2g3jSgzrGtd9KtHgOE+2yumLnmy9dW9qf3A8Vh/A=;
 b=UWuXTfTgnzxOyJi/ukkPsXg2/29zWrGet0GBjgGY/oXySJJImUs3APAhCD+SUBogPy
 5I3sq42LuG4ne+DU8fhxbWq/zTQbgygWSJW95jHxHpDZlIjW5yLZV8zYJTVtXnirm51B
 QohIt8g7rduUVfK149lH5bgaE63/2F3QjKlWfsavOMl8sO2urD58KT5fH7OASlsQwI4r
 goPwaupWxdVxEsZk4ST+XN1blsTovH3So0vtDg1rXylrqMJ0n0h/+3SldDD6DWztunGg
 6HF1qjhz8FeFa5gYvhhn5dTnUZETAWrMgCI7tPWT0ElzOvvH1AJ4P5RnQnqoDJDOOAoi
 lqvQ==
X-Gm-Message-State: APjAAAULtjWo1q7l/R7nPEKZhlHMBSspaNrR64nJZnJc5aZU1p2bBXJz
 Bik3z1njGvfVBwQ+Dl9wWyTg2KnumNc=
X-Google-Smtp-Source: APXvYqym32Jjcqm6Y5uD9VOGwQumhKcN0/1ZruKLacdjKeyh1L+2lBKh7SShcpX6bfXFE13wffbkKw==
X-Received: by 2002:aa7:8705:: with SMTP id b5mr13375773pfo.27.1564858083031; 
 Sat, 03 Aug 2019 11:48:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:26 -0700
Message-Id: <20190803184800.8221-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 00/34] target/arm: Implement ARMv8.1-VHE
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

Changes since v2:
  * arm_mmu_idx was incomplete; test TGE+E2H not just E2H.
  * arm_sctlr was incomplete; now uses arm_mmu_idx to avoid
    duplication of tests.
  * Update aa64_zva_access and ctr_el0_access for EL2.

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

Richard Henderson (32):
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
  target/arm: Update aa64_zva_access for EL2
  target/arm: Update ctr_el0_access for EL2
  target/arm: Install asids for E2&0 translation regime
  target/arm: Flush tlbs for E2&0 translation regime
  target/arm: Update arm_phys_excp_target_el for TGE
  target/arm: Update regime_is_user for EL2&0
  target/arm: Update {fp,sve}_exception_el for VHE
  target/arm: Enable ARMv8.1-VHE in -cpu max

 include/exec/cpu-all.h     |   11 +
 include/exec/cpu-defs.h    |    2 +
 include/exec/exec-all.h    |   35 ++
 include/qom/cpu.h          |    2 +
 target/arm/cpu-qom.h       |    1 +
 target/arm/cpu.h           |  261 ++++-----
 target/arm/internals.h     |   62 ++-
 target/arm/translate.h     |    2 +-
 accel/tcg/cputlb.c         |   81 +++
 target/arm/cpu.c           |    2 +
 target/arm/cpu64.c         |   20 +
 target/arm/debug_helper.c  |   50 +-
 target/arm/helper-a64.c    |    2 +-
 target/arm/helper.c        | 1042 +++++++++++++++++++++++++-----------
 target/arm/m_helper.c      |    6 +-
 target/arm/pauth_helper.c  |   13 +-
 target/arm/translate-a64.c |   13 +-
 target/arm/translate.c     |   17 +-
 18 files changed, 1134 insertions(+), 488 deletions(-)

-- 
2.17.1


