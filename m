Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA722C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A78720B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A78720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOHD-0002Hm-PG
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52394)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hbOFE-0001Sh-30
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hbOFC-0001nS-4y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:50:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hbOFA-0001kl-9g
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:50:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 518ADC07014A;
 Thu, 13 Jun 2019 11:50:05 +0000 (UTC)
Received: from work-vm (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AF5C1001B28;
 Thu, 13 Jun 2019 11:50:00 +0000 (UTC)
Date: Thu, 13 Jun 2019 12:49:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190613114957.GB2911@work-vm>
References: <db36d006-3bdc-47fe-9987-519440446c4e@ozlabs.ru>
 <20190103173753.GJ2316@work-vm>
 <d4b8695c-3d37-ba92-d62b-e067b77274c8@ozlabs.ru>
 <20190207114953.GB2773@work-vm>
 <16486ff4-eb62-b4f2-78f8-a1ec7e3fbb0b@redhat.com>
 <30a5a208-249f-106e-f885-94caf9b82970@ozlabs.ru>
 <f346fdcb-1849-3397-7f4c-2d6ee07fcd7c@ozlabs.ru>
 <aca6d2ae-806f-55b3-d9d5-f5a2cfd760b9@ozlabs.ru>
 <a66cc0e6-3629-8f07-65d3-aefff9dcd2d5@ozlabs.ru>
 <467c5374-34e6-c8d4-26c1-246f5cf31ec6@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467c5374-34e6-c8d4-26c1-246f5cf31ec6@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 13 Jun 2019 11:50:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH qemu v2] hmp: Print if memory section is
 registered with an accelerator
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
> 
> 
> On 21/05/2019 16:37, Alexey Kardashevskiy wrote:
> > Ping, anyone? I still enjoy seeing "kvm" next to MRs in "info mtree -f"
> > in my local QEMU :)
> 
> 
> "Still feeling it" :)
> Ping?

Fundamentally you've got to convince Paolo that it's the
right approach to identifying KVM RAM.

Dave

> 
> > 
> > 
> > On 24/04/2019 15:32, Alexey Kardashevskiy wrote:
> >> Paolo, ping?
> >>
> >>
> >> On 19/03/2019 18:05, Alexey Kardashevskiy wrote:
> >>>
> >>>
> >>> On 11/02/2019 15:56, Alexey Kardashevskiy wrote:
> >>>>
> >>>>
> >>>> On 09/02/2019 04:26, Paolo Bonzini wrote:
> >>>>> On 07/02/19 12:49, Dr. David Alan Gilbert wrote:
> >>>>>>  //#define DEBUG_UNASSIGNED
> >>>>>> @@ -2924,6 +2926,8 @@ struct FlatViewInfo {
> >>>>>>      int counter;
> >>>>>>      bool dispatch_tree;
> >>>>>>      bool owner;
> >>>>>> +    AccelClass *ac;
> >>>>>> +    const char *ac_name;
> >>>>>>  };
> >>>>>>  
> >>>>>>  static void mtree_print_flatview(gpointer key, gpointer value,
> >>>>>> @@ -2939,6 +2943,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
> >>>>>>      int n = view->nr;
> >>>>>>      int i;
> >>>>>>      AddressSpace *as;
> >>>>>> +    bool system_as = false;
> >>>>>>  
> >>>>>>      p(f, "FlatView #%d\n", fvi->counter);
> >>>>>>      ++fvi->counter;
> >>>>>> @@ -2950,6 +2955,9 @@ static void mtree_print_flatview(gpointer key, gpointer value,
> >>>>>>              p(f, ", alias %s", memory_region_name(as->root->alias));
> >>>>>>          }
> >>>>>>          p(f, "\n");
> >>>>>> +        if (as == &address_space_memory) {
> >>>>>> +            system_as = true;
> >>>>>> +        }
> >>>>>>      }
> >>>>>>  
> >>>>>>      p(f, " Root memory region: %s\n",
> >>>>>> @@ -2985,6 +2993,13 @@ static void mtree_print_flatview(gpointer key, gpointer value,
> >>>>>>          if (fvi->owner) {
> >>>>>>              mtree_print_mr_owner(p, f, mr);
> >>>>>>          }
> >>>>>> +
> >>>>>> +        if (system_as && fvi->ac &&
> >>>>>> +            fvi->ac->has_memory(current_machine,
> >>>>>> +                                int128_get64(range->addr.start),
> >>>>>> +                                MR_SIZE(range->addr.size) + 1)) {
> >>>>>> +            p(f, " %s", fvi->ac_name);
> >>>>>
> >>>>> I don't understand this.  This doesn't check that the memory range
> >>>>> actually matches the memory registered with the accelerator, only that
> >>>>> there is something in that range. 
> >>>>
> >>>>
> >>>> It is checking that a flat range (i.e. what actually works) has a
> >>>> corresponding KVM slot:
> >>>> https://git.qemu.org/?p=qemu.git;a=blob;f=accel/kvm/kvm-all.c;h=4e1de942ce554c734ac2673030031c228a752ac9;hb=HEAD#l201
> >>>>
> >>>>
> >>>>> Why isn't it enough to use "info
> >>>>> mtree" and look at the KVM address space?
> >>>>
> >>>>
> >>>> There is no such thing in my QEMU, did you mean "KVM-SMRAM" (which is
> >>>> missing on spapr)? I am not sure I understand its purpose for the task -
> >>>> it prints all same ranges on my x86 laptop, not just ones which we told
> >>>> KVM about.
> >>>>
> >>>> My task is that if let's say "0000:00:1a.0 BAR 0 mmaps[0]" is split into
> >>>> several sections because MSIX happens to be in a middle of that BAR and
> >>>> it is not system page size aligned, then it is going to be several
> >>>> ranges with no clear indication whether or not these were registered as
> >>>> KVM slots. A memory chunk can be "ram" and not a KVM slot if it is 4K on
> >>>> PPC with 64K system pages, for example.
> >>>>
> >>>>
> >>>> FlatView #0
> >>>>  AS "memory", root: system
> >>>>  AS "cpu-memory-0", root: system
> >>>>  AS "cpu-memory-1", root: system
> >>>>  AS "cpu-memory-2", root: system
> >>>>  AS "cpu-memory-3", root: system
> >>>>  AS "piix3-ide", root: bus master container
> >>>>  AS "virtio-net-pci", root: bus master container
> >>>>  AS "vfio-pci", root: bus master container
> >>>>  Root memory region: system
> >>>>   0000000000000000-00000000000bffff (prio 0, ram): pc.ram kvm
> >>>>   00000000000c0000-00000000000c0fff (prio 0, rom): pc.ram
> >>>> @00000000000c0000 kvm
> >>>>   00000000000c1000-00000000000c3fff (prio 0, ram): pc.ram
> >>>> @00000000000c1000 kvm
> >>>>   00000000000c4000-00000000000e7fff (prio 0, rom): pc.ram
> >>>> @00000000000c4000 kvm
> >>>>   00000000000e8000-00000000000effff (prio 0, ram): pc.ram
> >>>> @00000000000e8000 kvm
> >>>>   00000000000f0000-00000000000fffff (prio 0, rom): pc.ram
> >>>> @00000000000f0000 kvm
> >>>>   0000000000100000-00000000bfffffff (prio 0, ram): pc.ram
> >>>> @0000000000100000 kvm
> >>>>   00000000febc0000-00000000febc0fff (prio 0, ramd): 0000:00:1a.0 BAR 0
> >>>> mmaps[0] kvm
> >>>>   00000000febc1000-00000000febc102f (prio 0, i/o): msix-table
> >>>>   00000000febc1800-00000000febc1807 (prio 0, i/o): msix-pba
> >>>>   00000000febfc000-00000000febfcfff (prio 0, i/o): virtio-pci-common
> >>>>   00000000febfd000-00000000febfdfff (prio 0, i/o): virtio-pci-isr
> >>>>   00000000febfe000-00000000febfefff (prio 0, i/o): virtio-pci-device
> >>>>   00000000febff000-00000000febfffff (prio 0, i/o): virtio-pci-notify
> >>>>   00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
> >>>>   00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
> >>>>   00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
> >>>>   00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios kvm
> >>>>   0000000100000000-000000013fffffff (prio 0, ram): pc.ram
> >>>> @00000000c0000000 kvm
> >>>>
> >>>>
> >>>>
> >>>> FlatView #3
> >>>>  AS "KVM-SMRAM", root: mem-container-smram
> >>>>  Root memory region: mem-container-smram
> >>>>   0000000000000000-00000000000bffff (prio 0, ram): pc.ram
> >>>>   00000000000c0000-00000000000c0fff (prio 0, rom): pc.ram @00000000000c0000
> >>>>   00000000000c1000-00000000000c3fff (prio 0, ram): pc.ram @00000000000c1000
> >>>>   00000000000c4000-00000000000e7fff (prio 0, rom): pc.ram @00000000000c4000
> >>>>   00000000000e8000-00000000000effff (prio 0, ram): pc.ram @00000000000e8000
> >>>>   00000000000f0000-00000000000fffff (prio 0, rom): pc.ram @00000000000f0000
> >>>>   0000000000100000-00000000bfffffff (prio 0, ram): pc.ram @0000000000100000
> >>>>   00000000febc0000-00000000febc0fff (prio 0, ramd): 0000:00:1a.0 BAR 0
> >>>> mmaps[0]
> >>>>   00000000febc1000-00000000febc102f (prio 0, i/o): msix-table
> >>>>   00000000febc1800-00000000febc1807 (prio 0, i/o): msix-pba
> >>>>   00000000febfc000-00000000febfcfff (prio 0, i/o): virtio-pci-common
> >>>>   00000000febfd000-00000000febfdfff (prio 0, i/o): virtio-pci-isr
> >>>>   00000000febfe000-00000000febfefff (prio 0, i/o): virtio-pci-device
> >>>>   00000000febff000-00000000febfffff (prio 0, i/o): virtio-pci-notify
> >>>>   00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
> >>>>   00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
> >>>>   00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
> >>>>   00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
> >>>>   0000000100000000-000000013fffffff (prio 0, ram): pc.ram @00000000c0000000
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>> Perhaps you could add instead an argument to "info mtree" that prints
> >>>>> only the AddressSpace with a given name?
> >>>>
> >>>> Nah, this is not what it is about.
> >>>
> >>>
> >>>
> >>> Still a nack? :)
> >>
> >>
> >>
> > 
> 
> -- 
> Alexey
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

