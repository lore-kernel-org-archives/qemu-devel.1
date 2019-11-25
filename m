Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80794C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A2220679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A2220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZHxv-000119-FX
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 12:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iZHqW-0006qB-F2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iZHqV-0000dH-44
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:08:20 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:32813)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1iZHqU-0000ct-Tf
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:08:19 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iZHqS-0006PU-07; Mon, 25 Nov 2019 18:08:16 +0100
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm: Honor =?UTF-8?Q?HCR=5FEL=32=2ETID=33=20tr?=
 =?UTF-8?Q?apping=20requirements?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Nov 2019 17:08:15 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <CAFEAcA_MQpJ=8UFnP=Qnt+4GWMUO_AtJBBNz-bM2L2wf5htuaQ@mail.gmail.com>
References: <20191123115618.29230-1-maz@kernel.org>
 <CAFEAcA_MQpJ=8UFnP=Qnt+4GWMUO_AtJBBNz-bM2L2wf5htuaQ@mail.gmail.com>
Message-ID: <4d8c4763da39d5bfb1800735f90d82d1@www.loen.fr>
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

On 2019-11-25 16:21, Peter Maydell wrote:
> On Sat, 23 Nov 2019 at 11:56, Marc Zyngier <maz@kernel.org> wrote:
>>
>> HCR_EL2.TID3 mandates that access from EL1 to a long list of id
>> registers traps to EL2, and QEMU has so far ignored this 
>> requirement.
>>
>> This breaks (among other things) KVM guests that have PtrAuth 
>> enabled,
>> while the hypervisor doesn't want to expose the feature to its 
>> guest.
>> To achieve this, KVM traps the ID registers (ID_AA64ISAR1_EL1 in 
>> this
>> case), and masks out the unsupported feature.
>>
>> QEMU not honoring the trap request means that the guest observes
>> that the feature is present in the HW, starts using it, and dies
>> a horrible death when KVM injects an UNDEF, because the feature
>> *really* isn't supported.
>>
>> Do the right thing by trapping to EL2 if HCR_EL2.TID3 is set.
>>
>> Reported-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>> There is a number of other trap bits missing (TID[0-2], for 
>> example),
>> but this at least gets a mainline Linux going with cpu=max.
>
> I guess this ought to go into 4.2, given that it gets recent
> Linux guest kernels to work.
>
>
>> @@ -6185,11 +6221,13 @@ void register_cp_regs_for_features(ARMCPU 
>> *cpu)
>>              { .name = "ID_AA64PFR0_EL1", .state = 
>> ARM_CP_STATE_AA64,
>>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
>>                .access = PL1_R, .type = ARM_CP_NO_RAW,
>> +              .accessfn = access_aa64idreg,
>>                .readfn = id_aa64pfr0_read,
>>                .writefn = arm_cp_write_ignore },
>>              { .name = "ID_AA64PFR1_EL1", .state = 
>> ARM_CP_STATE_AA64,
>>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
>>                .access = PL1_R, .type = ARM_CP_CONST,
>> +              .accessfn = access_aa64idreg,
>>                .resetvalue = cpu->isar.id_aa64pfr1},
>>              { .name = "ID_AA64PFR2_EL1_RESERVED", .state = 
>> ARM_CP_STATE_AA64,
>>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
>> @@ -6198,151 +6236,188 @@ void register_cp_regs_for_features(ARMCPU 
>> *cpu)
>>              { .name = "ID_AA64PFR3_EL1_RESERVED", .state = 
>> ARM_CP_STATE_AA64,
>>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
>>                .access = PL1_R, .type = ARM_CP_CONST,
>> +              .accessfn = access_aa64idreg,
>>                .resetvalue = 0 },
>
> Missing .accessfn for ID_AA4PFR2_EL1_RESERVED ?

Indeed, I oversaw that one. I'll fix it and repost it together with
the extra patches to handle TID1 and TID2.

>
>>              { .name = "ID_AA64ZFR0_EL1", .state = 
>> ARM_CP_STATE_AA64,
>>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
>>                .access = PL1_R, .type = ARM_CP_CONST,
>> +              .accessfn = access_aa64idreg,
>>                /* At present, only SVEver == 0 is defined anyway.  
>> */
>>                .resetvalue = 0 },
>
>>              { .name = "MVFR0_EL1", .state = ARM_CP_STATE_AA64,
>>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
>>                .access = PL1_R, .type = ARM_CP_CONST,
>> +              .accessfn = access_aa64idreg,
>>                .resetvalue = cpu->isar.mvfr0 },
>
> These are the AArch64 accessors for the aarch32 MVFR registers,
> but this trap bit is also supposed to trap aarch32 accesses to
> the MVFR registers, which are via the vmrs insn. That needs
> to be done in trans_VMSR_VMRS(); we can do that with a
> followup patch, since the mechanism there is completely different.

Holy cow! I'm afraid that my newly acquired QEMU-foo is missing
a few key options. Does it mean we need to generate a trapping
instruction, as opposed to take the exception on access?

I'd very much appreciate some guidance here.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

