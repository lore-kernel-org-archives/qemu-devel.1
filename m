Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03524C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FAA20663
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 19:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FAA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKSq8-0002oJ-Q4
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 15:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKSop-0001UP-DV
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKSom-0002jc-DD
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKSom-0002iL-4e
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 15:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BBAC710C093C
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 19:49:12 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85FCB6012E;
 Tue, 15 Oct 2019 19:49:09 +0000 (UTC)
Date: Tue, 15 Oct 2019 16:49:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] apic: Use 32bit APIC ID for migration instance ID
Message-ID: <20191015194907.GA4084@habkost.net>
References: <20191015075444.10955-1-peterx@redhat.com>
 <20191015075444.10955-3-peterx@redhat.com>
 <20191015092218.GC3073@work-vm> <20191015101641.GD8666@xz-x1>
 <20191015110253.GF3073@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015110253.GF3073@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 15 Oct 2019 19:49:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 12:02:53PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Tue, Oct 15, 2019 at 10:22:18AM +0100, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > Migration is silently broken now with x2apic config like this:
> > > > 
> > > >      -smp 200,maxcpus=288,sockets=2,cores=72,threads=2 \
> > > >      -device intel-iommu,intremap=on,eim=on
> > > > 
> > > > After migration, the guest kernel could hang at anything, due to
> > > > x2apic bit not migrated correctly in IA32_APIC_BASE on some vcpus, so
> > > > any operations related to x2apic could be broken then (e.g., RDMSR on
> > > > x2apic MSRs could fail because KVM would think that the vcpu hasn't
> > > > enabled x2apic at all).
> > > > 
> > > > The issue is that the x2apic bit was never applied correctly for vcpus
> > > > whose ID > 255 when migrate completes, and that's because when we
> > > > migrate APIC we use the APICCommonState.id as instance ID of the
> > > > migration stream, while that's too short for x2apic.
> > > > 
> > > > Let's use the newly introduced initial_apic_id for that.
> > > 
> > > I'd like to understand a few things:
> > >    a) Does this change the instance ID of existing APICs on the
> > > migration stream? 
> > >      a1) Ever for <256 CPUs?
> > 
> > No.
> > 
> > >      a2) For >=256 CPUs?
> > 
> > Yes.
> > 
> > > 
> > >     [Because changing the ID breaks migration]
> > 
> > But if we don't change it, the stream is broken too. :)
> > 
> > Then the destination VM will receive e.g. two apic_id==0 instances (I
> > think the apic_id==256 instance will wrongly overwrite the apic_id==0
> > one), while the vcpu with apic_id==256 will use the initial apic
> > values.
> > 
> > So IMHO we should still fix this, even if it changes the migration
> > stream.  At least we start to make it right.
> 
> Yes, that makes sense.
> It deserves a doc mention somewhere.
> 
> > > 
> > >   b) Is the instance ID constant - I can see it's a property on the
> > >      APIC, but I cna't see who sets it
> > 
> > For each vcpu, I think yes it should be a constant as long as the
> > topology is the same.  This is how I understand it to be set:
> > 
> > (1) In pc_cpus_init(), we init these:
> > 
> >     possible_cpus = mc->possible_cpu_arch_ids(ms);
> >     for (i = 0; i < ms->smp.cpus; i++) {
> >         pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
> >     }
> > 
> > (2) In x86_cpu_apic_create(), we apply the apic_id to "id" property:
> > 
> >     qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
> 
> OK, that's fine - as long as it's constaatn and not guest influenced.

The guest may change the CPU APIC ID (although they rarely do),
but I believe X86CPU::apic_id is always going to be the initial
APIC ID.  I'll double check (and maybe send a patch to rename it
to initial_apic_id).

-- 
Eduardo

