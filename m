Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4503C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EBB20740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EBB20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZIit-0008LS-I7
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 13:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iZIfW-00063E-1S
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iZIU6-0003yc-Vx
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:49:16 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:42668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1iZIU4-0003xi-6P
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:49:13 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iZIU0-0006sM-23; Mon, 25 Nov 2019 18:49:08 +0100
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm: Honor =?UTF-8?Q?HCR=5FEL=32=2ETID=33=20tr?=
 =?UTF-8?Q?apping=20requirements?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Nov 2019 17:49:07 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <CAFEAcA87ceF_0ifLn1t9CxyEwJ-rwW8h4QauJGk+ATphJaWa6Q@mail.gmail.com>
References: <20191123115618.29230-1-maz@kernel.org>
 <CAFEAcA_MQpJ=8UFnP=Qnt+4GWMUO_AtJBBNz-bM2L2wf5htuaQ@mail.gmail.com>
 <4d8c4763da39d5bfb1800735f90d82d1@www.loen.fr>
 <CAFEAcA87ceF_0ifLn1t9CxyEwJ-rwW8h4QauJGk+ATphJaWa6Q@mail.gmail.com>
Message-ID: <15acc2b5111716b10ab7624a1ee45ce7@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, will@kernel.org
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
Cc: Will Deacon <will@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-11-25 17:27, Peter Maydell wrote:
> On Mon, 25 Nov 2019 at 17:08, Marc Zyngier <maz@kernel.org> wrote:
>>
>> On 2019-11-25 16:21, Peter Maydell wrote:
>> > Missing .accessfn for ID_AA4PFR2_EL1_RESERVED ?
>>
>> Indeed, I oversaw that one. I'll fix it and repost it together with
>> the extra patches to handle TID1 and TID2.
>
> Given that rc3 (last chance, more or less, for bugfixes for 4.2)
> is tomorrow, I propose that I take this patch with the
> +              .accessfn = access_aa64idreg,
> line for ID_AA64PFR2_EL1_RESERVED squashed in. I think
> TID1/TID2 and the MMFR-from-aarch32 parts are less urgent ?

That'd be great, thank you.

TID2 is only a nice to have (it allows us to virtualize the cache
hierarchy, only a performance optimization for fairly stupid 32bit
guests), and TID1 is so far unused by Linux.

I also had a look at TID0, but couldn't find any of the Jazelle
stuff in QEMU...

>> > These are the AArch64 accessors for the aarch32 MVFR registers,
>> > but this trap bit is also supposed to trap aarch32 accesses to
>> > the MVFR registers, which are via the vmrs insn. That needs
>> > to be done in trans_VMSR_VMRS(); we can do that with a
>> > followup patch, since the mechanism there is completely different.
>>
>> Holy cow! I'm afraid that my newly acquired QEMU-foo is missing
>> a few key options. Does it mean we need to generate a trapping
>> instruction, as opposed to take the exception on access?
>
> We will need to generate a call to a helper function which
> does the access check (and possibly raises an exception).
> We can't determine at translate time whether the insn is
> going to cause an exception, because the TID3 bit is not one
> of the fairly limited set of information which we put into
> the TB flags and allow to be baked into the generated code.
> (In theory we could add it, but we don't have very many TB
> flags so we only do that for cases where the overhead of doing
> the check at runtime matters.)

Ah! I guess you're referring to the HELPER() stuff in the various
target/arm/*_helper.c files? If so, I think I see how to do it.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

