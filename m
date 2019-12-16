Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D62EC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2582067C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2582067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igt6P-0005bS-7L
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1igt4n-0003tF-Ts
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1igt4l-0007mc-QS
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:18:29 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:50356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1igt4l-0007gz-JQ; Mon, 16 Dec 2019 11:18:27 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1igt4h-0003D3-8K; Mon, 16 Dec 2019 17:18:23 +0100
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2 0/5] target/arm/kvm: Adjust virtual time
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Dec 2019 16:18:23 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <CAFEAcA9FprSotg11rS0fM94QiciysZ6kgKhyU4eQfZg7YYaL5Q@mail.gmail.com>
References: <20191212173320.11610-1-drjones@redhat.com>
 <CAFEAcA9FprSotg11rS0fM94QiciysZ6kgKhyU4eQfZg7YYaL5Q@mail.gmail.com>
Message-ID: <4cb9bcfd47dff57c9ae6bb92bae87589@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, drjones@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 guoheyi@huawei.com, bijan.mottahedeh@oracle.com, msys.mizuma@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 213.251.177.50
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
Cc: Andrew Jones <drjones@redhat.com>, bijan.mottahedeh@oracle.com,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-12-16 15:33, Peter Maydell wrote:
> On Thu, 12 Dec 2019 at 17:33, Andrew Jones <drjones@redhat.com> 
> wrote:
>
>> Userspace that wants to set KVM_REG_ARM_TIMER_CNT should beware that
>> the KVM register ID is not correct.  This cannot be fixed because 
>> it's
>> UAPI and if the UAPI headers are used then it can't be a problem.
>> However, if a userspace attempts to create the ID themselves from 
>> the
>> register's specification, then they will get KVM_REG_ARM_TIMER_CVAL
>> instead, as the _CNT and _CVAL definitions have their register
>> parameters swapped.
>
> So, to be clear, you mean that:
>
> (1) the kernel headers say:
>
> /* EL0 Virtual Timer Registers */
> #define KVM_REG_ARM_TIMER_CTL           ARM64_SYS_REG(3, 3, 14, 3, 1)
> #define KVM_REG_ARM_TIMER_CNT           ARM64_SYS_REG(3, 3, 14, 3, 2)
> #define KVM_REG_ARM_TIMER_CVAL          ARM64_SYS_REG(3, 3, 14, 0, 2)
>
> (2) some of the RHSes of these are wrong
>
> (3) but the kernel internally is using the same 'wrong' value, so
> userspace also needs to use that value, ie trust the #defined name
> rather than manufacturing one ?
>
> That's awkward. I think it would be worth at least having a kernel
> patch to add a comment clearly documenting this bug.
>
> (This error seems to only be in the 64-bit ABI, not 32-bit.)

Yeah, this is pretty bad. I wonder how we managed not to notice
this for so long... :-(.

Andrew, could you please write a patch documenting this (both in
the UAPI headers and in the documentation)?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

