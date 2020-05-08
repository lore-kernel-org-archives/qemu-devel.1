Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC5C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 14:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2831E24955
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 14:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2831E24955
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX3dd-0006on-AT
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 10:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jX3cq-0005lu-5i
 for qemu-devel@nongnu.org; Fri, 08 May 2020 10:05:16 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:38038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jX3co-0003ig-JO
 for qemu-devel@nongnu.org; Fri, 08 May 2020 10:05:15 -0400
Received: from player168.ha.ovh.net (unknown [10.110.103.18])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 1AAE9160907
 for <qemu-devel@nongnu.org>; Fri,  8 May 2020 16:05:10 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id DBE5612224D13;
 Fri,  8 May 2020 14:05:06 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: Fix NMI system reset SRR1 value
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200507114824.788942-1-npiggin@gmail.com>
 <55ff4f45-4e1f-e0af-7b25-0c197dd41e19@kaod.org>
 <1588908336.cr0wsknhb6.astroid@bobo.none>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7f6094bb-ad7f-7b84-6b3b-7ae2b7ccd9ef@kaod.org>
Date: Fri, 8 May 2020 16:05:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588908336.cr0wsknhb6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7428124639062821696
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrkeefgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhephfffgeelfeejudevuedvvdeigeduteetveffhfffudeggfegleeljeeuieefuedvnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudeikedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.72.216; envelope-from=clg@kaod.org;
 helo=16.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 10:05:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> of a pending interrupt. It occurs on a SMP PowerNV machine when it is 
>> stressed with IO, such as scp of a big file. 
>>
>> I am suspecting more and more an issue with an interrupt being handled 
>> when the CPU is coming out of idle. I haven't seen anything wrong in
> 
> So you can't hit it when booting Linux with powersave=off?

no. I uploaded 32GB steadily at 3.0MB/s on a smp 2 machine. 

When powersave is on, a P8 or P9 machine will miss an interrupt quite 
quickly. This assert can catch a symptom of the failure  :

    @@ -75,6 +83,9 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_
         if (level) {
             env->pending_interrupts |= 1 << n_IRQ;
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
    +        if (!(env->pending_interrupts & (1 << n_IRQ))) {
    +            g_assert_not_reached();
    +        }
         } else {
             env->pending_interrupts &= ~(1 << n_IRQ);
             if (env->pending_interrupts == 0) {

env->pending_interrupts is reseted in ppc_set_irq() setting it. I think 
it is the CPU handling the external IO interrupt which is kicked to wake 
up in cpu_interrupt(). The IRQ level goes out of sync with what the device 
expects and things go bad very quickly after. 

But this is post mortem. I need to find the right spot where to put an 
assert() to analyze. But, adding too much traces closes the window ...

> Do we model stop with EC=0 properly? Looks like helper_pminsn seems to
> be doing the right thing there.

Yes. It seems so. The CPUs enter nap and come out with PACA_IRQ_EE set.

>> the models. Unless this maybe :
>>
>>     /* Pretend to be returning from doze always as we don't lose state */
>>     *msr |= (0x1ull << (63 - 47));
>>
>> I am not sure how in sync it is with PSSCR.
> 
> That should be okay, the hardware can always enter a shallower state 
> than was asked for. Linux will handle it. For testing purpose, we could
> model deeper states by scribbling on registers and indicating state loss.
> 
> Aide from SRR1 sleep state value, Linux uses the SRR1 wake reason value 
> to run the interrupt handler, but even if we got SRR1 wrong, Linux 
> eventually enables MSR[EE] so the interrupt should get replayed then 
> (this is what Linux used to do until we added the wake-reason processing 
> for improved performance).
> 
> But we do appear to get those right in powerpc_reset_wakeup().

yes. Still digging.

Thanks,

C.


