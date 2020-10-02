Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71923C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135E32074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135E32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONJH-0001p8-2J
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.price@arm.com>)
 id 1kON8a-0007oW-Lz
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:38:25 -0400
Received: from foss.arm.com ([217.140.110.172]:60270)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steven.price@arm.com>) id 1kON8X-0003aB-EX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:38:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8A51396;
 Fri,  2 Oct 2020 08:38:20 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EB183F73B;
 Fri,  2 Oct 2020 08:38:16 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] MTE support for KVM guest
To: Andrew Jones <drjones@redhat.com>
References: <20200925093607.3051-1-steven.price@arm.com>
 <20201002143640.uzsz3nhr45payhlb@kamzik.brq.redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <b653bbc8-1ebc-7c1a-9653-5441ca1be4b2@arm.com>
Date: Fri, 2 Oct 2020 16:38:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002143640.uzsz3nhr45payhlb@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=steven.price@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:31:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.256,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Haibo Xu <Haibo.Xu@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>, kvmarm@lists.cs.columbia.edu,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2020 15:36, Andrew Jones wrote:
> On Fri, Sep 25, 2020 at 10:36:05AM +0100, Steven Price wrote:
>> Version 3 of adding MTE support for KVM guests. See the previous (v2)
>> posting for background:
>>
>>   https://lore.kernel.org/r/20200904160018.29481-1-steven.price%40arm.com
>>
>> These patches add support to KVM to enable MTE within a guest. They are
>> based on Catalin's v9 MTE user-space support series[1] (currently in
>> next).
>>
>> Changes since v2:
>>
>>   * MTE is no longer a VCPU feature, instead it is a VM cap.
>>
>>   * Being a VM cap means easier probing (check for KVM_CAP_ARM_MTE).
>>
>>   * The cap must be set before any VCPUs are created, preventing any
>>     shenanigans where MTE is enabled for the guest after memory accesses
>>     have been performed.
>>
>> [1] https://lore.kernel.org/r/20200904103029.32083-1-catalin.marinas@arm.com
>>
>> Steven Price (2):
>>    arm64: kvm: Save/restore MTE registers
>>    arm64: kvm: Introduce MTE VCPU feature
>>
>>   arch/arm64/include/asm/kvm_emulate.h       |  3 +++
>>   arch/arm64/include/asm/kvm_host.h          |  7 +++++++
>>   arch/arm64/include/asm/sysreg.h            |  3 ++-
>>   arch/arm64/kvm/arm.c                       |  9 +++++++++
>>   arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
>>   arch/arm64/kvm/mmu.c                       | 15 +++++++++++++++
>>   arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
>>   include/uapi/linux/kvm.h                   |  1 +
>>   8 files changed, 66 insertions(+), 6 deletions(-)
>>
>> -- 
>> 2.20.1
>>
>>
> 
> Hi Steven,
> 
> These patches look fine to me, but I'd prefer we have a working
> implementation in QEMU before we get too excited about the KVM
> bits. kvmtool isn't sufficient since it doesn't support migration
> (at least afaik). In the past we've implemented features in KVM
> that look fine, but then issues have been discovered when trying
> to enable them from QEMU, where we also support migration. This
> feature looks like there's risk of issues with the userspace side.
> Although these two patches would probably stay the same, even if
> userspace requires more support.

I agree kvmtool isn't a great test because it doesn't support migration. 
The support in this series is just the basic support for MTE in a guest 
and we'd need to wait for the QEMU implementation before deciding 
whether we need any extra support (e.g. kernel interfaces for 
reading/writing tags as discussed before).

However, I don't think there's much danger of the support in this series 
changing - so extra support can be added when/if it's needed, but I 
don't think we need to block these series on that - QEMU can just probe 
for whatever additional support it needs before enabling MTE in a guest. 
I plan to rebase/repost after -rc1 when the user space support has been 
merged.

Steve

