Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D90C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 23:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE8E20735
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 23:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yF7TFSd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE8E20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWTh4-0005SA-FG
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 19:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sashal@kernel.org>) id 1jWTgA-00052z-2f
 for qemu-devel@nongnu.org; Wed, 06 May 2020 19:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sashal@kernel.org>) id 1jWTg9-0003Tt-2f
 for qemu-devel@nongnu.org; Wed, 06 May 2020 19:42:17 -0400
Received: from localhost (unknown [137.135.114.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2887220735;
 Wed,  6 May 2020 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588808534;
 bh=oTiGYE58Jca6Xx3gU8+PRrpZQe7ddnxuxF7H2ZBOZHY=;
 h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
 From;
 b=yF7TFSd/I7mUzdXd+egLX7pWB/iTLy7UNEgkSIfdWJOX1hx9jHC5W8QCgygMgXSe3
 msEqUSIwaEHOuP1M7mf7+cA59i7sSxpQK5T5LHIzTt/XBJDGhW9sFa6/3N6AMlGHdC
 GFOWnNNDcFp5AW0HIwZecpB09CYRFZjjOdEzgHRY=
Date: Wed, 06 May 2020 23:42:13 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Huacai Chen <chenhc@lemote.com>
To: Xing Li <lixing@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V3 01/14] KVM: MIPS: Define KVM_ENTRYHI_ASID to
 cpu_asid_mask(&boot_cpu_data)
In-Reply-To: <1588500367-1056-2-git-send-email-chenhc@lemote.com>
References: <1588500367-1056-2-git-send-email-chenhc@lemote.com>
Message-Id: <20200506234214.2887220735@mail.kernel.org>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=sashal@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 19:42:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

The bot has tested the following trees: v5.6.10, v5.4.38, v4.19.120, v4.14.178, v4.9.221, v4.4.221.

v5.6.10: Build OK!
v5.4.38: Build OK!
v4.19.120: Build OK!
v4.14.178: Build OK!
v4.9.221: Build OK!
v4.4.221: Failed to apply! Possible dependencies:
    029499b47738 ("KVM: x86: MMU: Make mmu_set_spte() return emulate value")
    19d194c62b25 ("MIPS: KVM: Simplify TLB_* macros")
    403015b323a2 ("MIPS: KVM: Move non-TLB handling code out of tlb.c")
    7ee0e5b29d27 ("KVM: x86: MMU: Remove unused parameter of __direct_map()")
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

