Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B1C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DFC21738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DFC21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37931 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCK4X-0005N4-0h
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 04:19:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCK3c-00050U-R3
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCK3b-0002Df-Ih
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:18:40 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:34163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hCK3b-00028T-7f
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:18:39 -0400
Received: from player763.ha.ovh.net (unknown [10.109.146.163])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 53486EE019
	for <qemu-devel@nongnu.org>; Fri,  5 Apr 2019 10:18:36 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player763.ha.ovh.net (Postfix) with ESMTPSA id 5446F471AFBA;
	Fri,  5 Apr 2019 08:18:27 +0000 (UTC)
Date: Fri, 5 Apr 2019 10:18:26 +0200
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@linux.ibm.com>
Message-ID: <20190405101826.0255f9c5@bahia.lan>
In-Reply-To: <cd08ddbc-d289-04a5-c9ae-d7618fc22308@linux.ibm.com>
References: <155323635511.18748.18133954505098138975.stgit@aravinda>
	<155323643836.18748.13006461397179281455.stgit@aravinda>
	<20190325062256.GO29295@umbus>
	<1fdde5df-408a-f81d-d9ac-eb9636324b54@linux.vnet.ibm.com>
	<20190404231707.GB25513@umbus.fritz.box>
	<cd08ddbc-d289-04a5-c9ae-d7618fc22308@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1106759609355180472
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.109.80
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 3/6] target/ppc: Handle NMI
 guest exit
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405081826.vqCxwqcv1Zll9Ou1ZoCJlTtPYJdSbLzDQJ1qNGDUUKY@z>

On Fri, 5 Apr 2019 16:04:27 +1100
Alexey Kardashevskiy <aik@linux.ibm.com> wrote:

> On 05/04/2019 10:17, David Gibson wrote:
> > On Thu, Apr 04, 2019 at 02:40:45PM +0530, Aravinda Prasad wrote:  
> >>
> >>
> >> On Monday 25 March 2019 11:52 AM, David Gibson wrote:  
> >>> On Fri, Mar 22, 2019 at 12:03:58PM +0530, Aravinda Prasad wrote:  
> >>>> Memory error such as bit flips that cannot be corrected
> >>>> by hardware are passed on to the kernel for handling.
> >>>> If the memory address in error belongs to guest then
> >>>> the guest kernel is responsible for taking suitable action.
> >>>> Patch [1] enhances KVM to exit guest with exit reason
> >>>> set to KVM_EXIT_NMI in such cases. This patch handles
> >>>> KVM_EXIT_NMI exit.
> >>>>
> >>>> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
> >>>>     (e20bbd3d and related commits)
> >>>>
> >>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>> ---
> >>>>  hw/ppc/spapr_events.c  |   22 ++++++++++++++++++++++
> >>>>  include/hw/ppc/spapr.h |    1 +
> >>>>  target/ppc/kvm.c       |   16 ++++++++++++++++
> >>>>  target/ppc/kvm_ppc.h   |    2 ++
> >>>>  4 files changed, 41 insertions(+)
> >>>>  
> >>
> >> [...]
> >>  
> >>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >>>> index 2427c8e..a593448 100644
> >>>> --- a/target/ppc/kvm.c
> >>>> +++ b/target/ppc/kvm.c
> >>>> @@ -1738,6 +1738,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> >>>>          ret = 0;
> >>>>          break;
> >>>>  
> >>>> +    case KVM_EXIT_NMI:
> >>>> +        DPRINTF("handle NMI exception\n");  
> >>>
> >>> tracepoints are generally preferred to new DPRINTFs.  
> >>
> >> I see DPRINTFs used in all other exit reasons in this function. Do you
> >> want me to change this particular exit case to tracepoints? I think it
> >> is better to keep this DPRINTF as of now and change all the DPRINTFs to
> >> tracepoints in a separate patch set.  
> > 
> > Ah, good point.   
> 
> imho not. The kvm.c already knows about traces (there are two) and even
> if every other trace in kvm_arch_handle_exit() is DPRINTF (enabled all
> at once), having at least one which can be enabled without QEMU
> recompile and separately from the others is a small but nice bonus
> before someone gets rid of DPRINTF.
> 

Done.

https://patchwork.ozlabs.org/project/qemu-devel/list/?series=101141

> 
> > Tracepoints are generally preferred, but since
> > DPRINTFs are in use here, stick with that (at some point it would be
> > good to change the whole file, but that's out of scope here).  
> 
> 


