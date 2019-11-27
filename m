Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C64C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7CC2070A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7CC2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZtP4-000552-Gc
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 04:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iZtO4-0004cr-RQ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iZtO3-0000BB-Km
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:13:28 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:37995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1iZtO3-00007c-E9
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:13:27 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iZtNz-0005g6-Ld; Wed, 27 Nov 2019 10:13:23 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] target/arm: Honor =?UTF-8?Q?HCR=5FEL=32=2ETID=33=20tr?=
 =?UTF-8?Q?apping=20requirements?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Nov 2019 09:13:23 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <11f7be55-a53d-bab1-c2e6-edbca1abb554@linaro.org>
References: <20191123115618.29230-1-maz@kernel.org>
 <11f7be55-a53d-bab1-c2e6-edbca1abb554@linaro.org>
Message-ID: <1d254223a9dc031c902bdf976f472025@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, will@kernel.org, kvmarm@lists.cs.columbia.edu
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Will Deacon <will@kernel.org>,
 qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-11-26 21:04, Richard Henderson wrote:
> On 11/23/19 11:56 AM, Marc Zyngier wrote:
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
> BTW, Peter, this appears to have been the bug that was causing me so 
> many
> problems on my VHE branch.  Probably *exactly* this bug wrt ptrauth,
> since that would also be included with -cpu max.
>
> I am now able to boot a kvm guest kernel to the point of the no 
> rootfs panic,
> which I wasn't before.
>
> I can only think that I mis-identified the true cause in Lyon.
>
> Anyway, thanks Marc!

Hehe, glad it fixed more than just my pet issue! :-)

         M.
-- 
Jazz is not dead. It just smells funny...

