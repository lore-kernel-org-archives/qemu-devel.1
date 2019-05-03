Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4FDC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 01:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281D92070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 01:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281D92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMbE-0003WW-8m
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 21:02:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMa0-0002ja-W8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 21:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMZw-0005na-7I
	for qemu-devel@nongnu.org; Thu, 02 May 2019 21:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hMMZv-0005mg-9w; Thu, 02 May 2019 21:01:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 272D830820E6;
	Fri,  3 May 2019 01:01:30 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 996ED1001E61;
	Fri,  3 May 2019 01:01:29 +0000 (UTC)
Date: Thu, 2 May 2019 22:01:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190503010127.GP28722@habkost.net>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-3-git-send-email-like.xu@linux.intel.com>
	<20190404162555.0a2267ee@redhat.com>
	<a765e3ac-45e6-310e-aa66-7036b5717a26@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <a765e3ac-45e6-310e-aa66-7036b5717a26@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 03 May 2019 01:01:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/9] cpu/topology: add general support for
 machine properties
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	like.xu@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503010127.KxHfpzwvRMJVJrSZgnUcez-aph9lAoI3neMwYmiG_y8@z>

On Tue, Apr 30, 2019 at 03:30:31PM +0800, Like Xu wrote:
> On 2019/4/4 22:25, Igor Mammedov wrote:
> > On Fri, 29 Mar 2019 16:48:38 +0800
> > Like Xu <like.xu@linux.intel.com> wrote:
> > 
> 
> <snipp>
> > 
> > > diff --git a/cpus.c b/cpus.c
> > > index e83f72b..834a697 100644
> > > --- a/cpus.c
> > > +++ b/cpus.c
> > > @@ -2067,6 +2067,10 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
> > >   void qemu_init_vcpu(CPUState *cpu)
> > >   {
> > > +    MachineState *ms = MACHINE(qdev_get_machine());
> > > +    unsigned int smp_cores = ms->topo.smp_cores;
> > > +    unsigned int smp_threads = ms->topo.smp_threads;
> > 
> > (***)
> > for once it probably will crash *-user builds

Will it?  cpus.o is compiled only on CONFIG_SOFTMMU.

> > and secondly the purpose of getting rid of smp_foo globals
> > is disentangle layer violations and not replace it with another global
> > (qdev_get_machine()).
> 
> I am happy to follow this rule on cpu-topo refactoring work, but sometimes
> calling qdev_get_machine() is inevitable.

I agree with Igor's goal, but let's do it one step at a time.
Replacing the smp_* globals with qdev_get_machine() is a step in
the right direction, IMO.


> 
> > 
> > What should be done is to make a properties of nr_cores/nr_threads and set
> > them from the parent object that creates CPUs. The point is CPUs shouldn't
> > reach out outside itself to fish out data bits it needs, it's responsibility
> > of creator to feed to being create CPU needed properties.
> > 
> > This kind of refactoring probably deserves its own series and should precede
> > -smp refactoring as it doesn't depend on CpuTopology at all.

I don't see why it should precede -smp refactoring.

We have a very specific user-visible goal here: making one extra
CPU topology option (CPU dies) available on PC only.  Asking the
author to refactor some code while implementing that is
reasonable.  Requiring the author to touch every single place
where a CPU object is created in QEMU just to avoid a
qdev_get_machine() call doesn't seem reasonable.


> > 
> 
> The division of responsibility for this case (refactoring qemu_init_vcpu)
> seems to be a poisonous apple.
> 
> The prerequisite for setting cpu-> nr_cores / nr_threads from the parent is
> that the CPU has been created, so if any process during initialization needs
> this topo information, it will use the default values form
> cpu_common_initfn() instead of user-configured parameters.
> 
> We may not want to repeat those assignment operations using the new values
> and what do you think, Igor?

I believe we need a better CPU creation API that all machines can
use, otherwise all of them will have to duplicate the same code
between object_new() and object_propert_set_bool("realized", true).

But I really don't think designing and implementing this new API
should be a requirement to get useful work done.

-- 
Eduardo

