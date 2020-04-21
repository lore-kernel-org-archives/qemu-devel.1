Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8FCC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EDC2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BylQYOJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EDC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4Pf-0000M8-IJ
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1jQz0D-0003uc-Di
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1jQz0D-00041u-1l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sashal@kernel.org>) id 1jQz0C-00040k-HV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:56:16 -0400
Received: from localhost (unknown [137.135.114.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CD4D1206D9;
 Tue, 21 Apr 2020 19:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587498974;
 bh=xPugJXtBDtdc5k1y/O0zEVTc7QjdHvDoYHPn2VLQFFI=;
 h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
 From;
 b=BylQYOJaqcJ3c3usRhV5MlZ8blrIP5jXMyuhzHbkxWfqr2NOtKUBiMR+IzSIEcTwe
 zvNrpqCqfnhkDW1jsCYwyxu/RT1Oyu8m9GXgMkJCLKRglRSMQHotgf4qF4TYrNsRTI
 8DZeYfuBCzcZQJ7C+cKOZg4GyxdFzSRio6ZIIVMA=
Date: Tue, 21 Apr 2020 19:56:12 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Huacai Chen <chenhc@lemote.com>
To: Xing Li <lixing@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/15] KVM: MIPS: Fix VPN2_MASK definition for variable
 cpu_vmbits
In-Reply-To: <1586763024-12197-4-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-4-git-send-email-chenhc@lemote.com>
Message-Id: <20200421195613.CD4D1206D9@mail.kernel.org>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=sashal@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 15:56:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 198.145.29.99
X-Mailman-Approved-At: Tue, 21 Apr 2020 21:28:40 -0400
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
Cc: stable@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.6.5, v5.5.18, v5.4.33, v4.19.116, v4.14.176, v4.9.219, v4.4.219.

v5.6.5: Build OK!
v5.5.18: Build OK!
v5.4.33: Build OK!
v4.19.116: Build OK!
v4.14.176: Build OK!
v4.9.219: Build OK!
v4.4.219: Failed to apply! Possible dependencies:
    029499b47738 ("KVM: x86: MMU: Make mmu_set_spte() return emulate value")
    19d194c62b25 ("MIPS: KVM: Simplify TLB_* macros")
    403015b323a2 ("MIPS: KVM: Move non-TLB handling code out of tlb.c")
    7ee0e5b29d27 ("KVM: x86: MMU: Remove unused parameter of __direct_map()")
    9a99c4fd6586 ("KVM: MIPS: Define KVM_ENTRYHI_ASID to cpu_asid_mask(&boot_cpu_data)")
    9fbfb06a4065 ("MIPS: KVM: Arrayify struct kvm_mips_tlb::tlb_lo*")
    ba049e93aef7 ("kvm: rename pfn_t to kvm_pfn_t")
    bdb7ed8608f8 ("MIPS: KVM: Convert headers to kernel sized types")
    ca64c2beecd4 ("MIPS: KVM: Abstract guest ASID mask")
    caa1faa7aba6 ("MIPS: KVM: Trivial whitespace and style fixes")
    e6207bbea16c ("MIPS: KVM: Use MIPS_ENTRYLO_* defs from mipsregs.h")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha

