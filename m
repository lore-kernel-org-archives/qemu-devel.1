Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DBAC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5229F206B8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5229F206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJpy-00049l-Ey
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.price@arm.com>)
 id 1kGJlK-0001Uy-DR
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:25:06 -0400
Received: from foss.arm.com ([217.140.110.172]:53080)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steven.price@arm.com>) id 1kGJlE-0001uT-22
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:25:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A14DC1063;
 Thu, 10 Sep 2020 03:24:58 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FED23F68F;
 Thu, 10 Sep 2020 03:24:56 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To: Richard Henderson <richard.henderson@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20200904160018.29481-1-steven.price@arm.com>
 <8e661984-70bc-790c-8636-39dcd8b00131@linaro.org>
From: Steven Price <steven.price@arm.com>
Message-ID: <842807ac-562a-36ce-8061-aa323341b605@arm.com>
Date: Thu, 10 Sep 2020 11:24:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8e661984-70bc-790c-8636-39dcd8b00131@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=steven.price@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 05:21:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <Peter.Maydell@arm.com>, Haibo Xu <Haibo.Xu@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2020 01:33, Richard Henderson wrote:
> On 9/4/20 9:00 AM, Steven Price wrote:
>>   3. Doesn't provide any new methods for the VMM to access the tags on
>>      memory.
> ...
>> (3) may be problematic and I'd welcome input from those familiar with
>> VMMs. User space cannot access tags unless the memory is mapped with the
>> PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
>> for the user space process (assuming the VMM enables tag checking for
>> the process)...
> 
> The latest version of the kernel patches for user mte support has separate
> controls for how tag check fail is reported.  Including
> 
>> +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults
> 
> That may be less than optimal once userland starts uses tags itself, e.g.
> running qemu itself with an mte-aware malloc.
> 
> Independent of that, there's also the TCO bit, which can be toggled by any
> piece of code that wants to disable checking locally.

Yes, I would expect the TCO bit is the best option for wrapping accesses 
to make them unchecked.

> However, none of that is required for accessing tags.  User space can always
> load/store tags via LDG/STG.  That's going to be slow, though.

Yes as things stand LDG/STG is the way for user space to access tags. 
Since I don't have any real hardware I can't really comment on speed.

> It's a shame that LDGM/STGM are privileged instructions.  I don't understand
> why that was done, since there's absolutely nothing that those insns can do
> that you can't do with (up to) 16x LDG/STG.

It is a shame, however I suspect this is because to use those 
instructions you need to know the block size held in GMID_EL1. And at 
least in theory that could vary between CPUs.

> I think it might be worth adding some sort of kernel entry point that can bulk
> copy tags, e.g. page aligned quantities.  But that's just a speed of migration
> thing and could come later.

When we have some real hardware it would be worth profiling this. At the 
moment I've no idea whether the kernel entry overhead would make such an 
interface useful from a performance perspective or not.

Steve

