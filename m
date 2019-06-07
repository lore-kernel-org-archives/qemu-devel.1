Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C56C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2545D208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2545D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZA8g-0005hW-7K
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 04:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54083)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hZA4w-0001jo-PA
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hZA4v-0007QZ-IT
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:18:26 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:42554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hZA4p-0006mp-2x
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:18:20 -0400
Received: from player693.ha.ovh.net (unknown [10.108.54.133])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id F3C4810CF96
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 10:18:04 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id 6F84569179A4;
 Fri,  7 Jun 2019 08:17:59 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
References: <155984093894.2803172.8618224129384655510.stgit@bahia.lan>
 <20190607001901.GC3760@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2d02c8d1-d9f4-efd0-5059-6ca24e622107@kaod.org>
Date: Fri, 7 Jun 2019 10:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607001901.GC3760@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2142587523543501651
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegiedgtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.148
Subject: Re: [Qemu-devel] [PATCH] spapr: Don't use the "dual" interrupt
 controller mode with an old hypervisor
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/06/2019 02:19, David Gibson wrote:
> On Thu, Jun 06, 2019 at 07:08:59PM +0200, Greg Kurz wrote:
>> If KVM is too old to support XIVE native exploitation mode, we might end
>> up using the emulated XIVE after CAS. This is sub-optimal if KVM in-kernel
>> XICS is available, which is the case most of the time.
> 
> This is intentional.  A predictable guest environment trumps performance.

I don't agree. 

If the user does not specify any specific interrupt mode, we should favor 
the faster one. 

Here is the current matrix (with this patch) for guests running on an 
old KVM, that is without KVM XIVE support. Let's discuss on what we
want. 

                        kernel_irqchip

           (default) 
ic-mode     allowed           off            on 

dual        XICS KVM       XICS emul.(3)   XICS KVM         (default mode)
xics        XICS KVM       XICS emul.      XICS KVM    
xive        XIVE emul.(1)  XIVE emul.     QEMU failure (2)


(1) QEMU warns with "warning: kernel_irqchip requested but unavailable: 
    IRQ_XIVE capability must be present for KVM" 
(2) QEMU fails with "kernel_irqchip requested but unavailable: 
    IRQ_XIVE capability must be present for KVM" 
(3) That is wrong I think, we should get XIVE emulated.


what you would want is XIVE emulation when ic-mode=dual and 
kernel_irqchip=allowed, which is the behavior with this patch (but there
are reboot bugs)

 
>> Also, an old KVM may not allow to destroy and re-create the KVM XICS, which
>> is precisely what "dual" does during machine reset. This causes QEMU to try
>> to switch to emulated XICS and to crash because RTAS call de-registration
>> isn't handled correctly. We could possibly fix that, but again we would
>> still end up with an emulated XICS or XIVE.
> 
> Ugh, that's a problem.

Yes. It's another problem around the way we cleanup the allocated resources.
It should be another patch.

> 
>> "dual" is definitely not a good choice with older KVMs. Internally force
>> XICS when we detect this.
> 
> But this is not an acceptable solution.  Silently changing the guest
> visible environment based on host capabilities is never ok. 

If the host (KVM) doesn't have a capability, what is the point of trying 
to use it if we can do better. I know you are considering KVM/QEMU as a
whole but who would run with kernel_irqchip=off ?

> We must
> either give the guest environment that the user has requested, or fail
> outright.

'dual' mode means both and the user is not requesting XIVE. We are changing 
the priority of choices from :

 1. KVM XIVE
 2. QEMU XIVE
 3. KVM XICS
 4. QEMU XICS

to:

 1. KVM XIVE
 2. KVM XICS
 3. QEMU XIVE
 4. QEMU XICS

which is better I think.

C.


> 
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>> ---
>>  hw/ppc/spapr_irq.c |   10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 3156daf09381..d788bd662a7a 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -18,6 +18,7 @@
>>  #include "hw/ppc/xics_spapr.h"
>>  #include "cpu-models.h"
>>  #include "sysemu/kvm.h"
>> +#include "kvm_ppc.h"
>>  
>>  #include "trace.h"
>>  
>> @@ -668,6 +669,15 @@ static void spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>>              return;
>>          }
>>      }
>> +
>> +    /*
>> +     * KVM may be too old to support XIVE, in which case we'd rather try
>> +     * to use the in-kernel XICS instead of the emulated XIVE.
>> +     */
>> +    if (kvm_enabled() && !kvmppc_has_cap_xive() &&
>> +        spapr->irq == &spapr_irq_dual) {
>> +        spapr->irq = &spapr_irq_xics;
>> +    }
>>  }
>>  
>>  /*
>>
> 


