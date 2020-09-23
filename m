Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E293C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35402137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK/Y/0VX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35402137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4Dr-0005sr-LD
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL4Co-00050O-HZ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL4Cl-0007mI-9E
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600865342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nOziXEBqSzPd86wdUbFoNUNpAFjE/fcIGP99cNlc3aw=;
 b=VK/Y/0VXn2QQWAIsYOQ1BWFRFMfHZ0manSjgvK5x90MFuzXCXc1B3zYiH+TDmrchkx1g59
 RSmVlRAQM7Pd5k+iJtiArigk9l0BFPC7xa4hNTbEB2u0j1sw0ZZq0vZmWL05vtPCzsO8Ji
 ny3lc/BCgMk6CHf7bnVw8yej9zhA76E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-mTrzz492NfOJ2oi89VEJzw-1; Wed, 23 Sep 2020 08:48:55 -0400
X-MC-Unique: mTrzz492NfOJ2oi89VEJzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50E4D64088;
 Wed, 23 Sep 2020 12:48:54 +0000 (UTC)
Received: from [10.36.112.54] (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA42B5577B;
 Wed, 23 Sep 2020 12:48:48 +0000 (UTC)
Subject: Re: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
 <c51f9ebd-5303-9919-1469-c99ff6a461b1@redhat.com>
 <d9032b0f-80e2-2eca-637d-251eb1f8f001@maciej.szmigiero.name>
 <4787eb88-a663-5f9a-ea44-d0a884907e12@redhat.com>
 <25a4ba26-aeca-48c2-c787-5f2f5d45d47d@maciej.szmigiero.name>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <89363efe-84e8-11c1-62d9-824f46a20590@redhat.com>
Date: Wed, 23 Sep 2020 14:48:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <25a4ba26-aeca-48c2-c787-5f2f5d45d47d@maciej.szmigiero.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> Okay, so while "the ACPI DIMM slot limit does not apply", the KVM memory
>> slot limit (currently) applies, resulting in exactly the same behavior.
>>
>> The only (conceptual difference) I am able to spot is then a
>> notification to the user on reboot, so the guest memory layout can be
>> adjusted (which I consider very ugly, but it's the same thing when
>> mixing ballooning and DIMMs - which is why it's usually never done).
> 
> If you want to shrink a guest at runtime you'll pretty much have to use
> ballooning as {ACPI-based PC, virtual} DIMM stick sizes are far too
> large to make anything but rough adjustments to the guest memory size.

Right.

> 
> In addition to that with ACPI-based PC DIMM hotplug it is the host that
> chooses which particular DIMM stick to unplug while having no feedback
> from the guest how much of each DIMM stick memory range is currently
> in use and so will have to be copied somewhere else.

Yeah, these external requests are bad in general. Not only for
performance - also because they can fail silently (if there is unmovable
data on it).

> 
> I know that this a source of significant hot removal slowdown, especially
> when a "ripple effect" happens on removal:
> 1) There are 3 extra DIMMs plugged into the guest: A, B, C.
>    A and B are nearly empty, but C is nearly full.
> 
> 2) The host does not know anything which DIMM is empty and which is full,
>    so it requests the guest to unplug the stick C,

In theory, the host can simply track inflation requests. In practice,
guests tend to sometimes re-access balloon-inflated memory (e.g., simple
kexec-style reboot under Linux, kdump on older Linux versions), so it's
not completely safe to do.

> 
> 3) The guest copies the content of the stick C to the stick B,
> 
> 4) Once again, the host does not know anything which DIMM is empty and
>    which is full, so it requests the guest to unplug the stick B,
> 
> 5) The guest now has to copy the same data from the stick B to the
>    stick A, once again.
> 
> With virtual DIMM sticks + this driver it is the guest which chooses
> which particular pages to release, hopefully choosing the already unused
> ones.
> Once the whole memory behind a DIMM stick is released the host knows
> that it can be unplugged now without any copying.
> 
> While it might seem like this will cause a lot of fragmentation in
> practice Windows seems to try to give out the largest continuous range
> of pages it is able to find.
> 
> One can also see in the hv_balloon client driver from the Linux kernel
> that this driver tries to do 2 MB allocations for as long as it can
> before giving out single pages.

Yeah, something similar was proposed for virtio-balloon already (and
there is a paper about that - see below). For virito-balloon, we were
not yet convinced that stealing most hugepages from the guest is always
such a good idea. It at least would have to be configurable, to not mess
with existing use cases.

> 
> The reason why ballooning and DIMMs wasn't being used together previously
> is probably because virtio-balloon will (at least on Windows) mark the
> ballooned out pages as in use inside the guest, preventing the removal
> of the DIMM stick backing them.

Same on Linux - but the pages are movable, such they can at least moved
around to offline + unplug a DIMM.

Some of the reasons why ballooning + DIMMs are not used as far as I know is:
- Management issues. Using it without some managing instance
  (plug/unplug DIMM, control balloon) is impossible. Try using it with
  bare QEMU - basically impossible.
- Memory Hotplug limitations: Maximum DIMM count. Minimum DIMM size that
  an OS can use (e.g., >= 128MiB under Linux, sometimes even 1GB). The
  granularity restrictions you mentioned apply.
- Memory Hotplug reliability: It can happen easily that hotplugging a
  DIMM / onlining it under Linux fails (e.g., minimum DIMM size). "What
  you think the guests actually has as available memory might be wrong".
  If you ignore that (and you don't even get notified) and adjust the
  balloon later, your (Linux) guest might be in trouble. Assume
  you hotplug a 8GB to a 2G VM and later try to inflate the balloon to
  4GB ... so you need reliable monitoring and error handling.

So yeah, I can understand how hv-balloon tries to work around some of
these issues.

> 
> In addition to the above, virtio-balloon is also very slow, as the whole
> protocol operates on single pages only, not on page ranges.
> There might also be some interference with Windows memory management
> causing an extra slowdown in comparison to the native Windows DM
> protocol.

Yes, because I assume Windows doesn't really care too much about
optimizing for virtio-balloon. There isn't too much external developers
can do about that. See below for hugepage ballooning in virtio-balloon.

> 
> If the KVM slot limit starts to be a problem in practice then we can
> think what can be done about it.
> It's always one obstacle less.

I'm not a friend of leaving the challenging/fundamental problems to be
sported out in the future (e.g., resizing initial boot memory, dealing
with fundamental limits - like KVM memory slots or VMA). But I get how
it's easier to get something running this way :)

> 
> I see that the same KVM slot limit probably applies also for virtio-mem,
> since it uses memory-backend-ram as its backing memory device, too,
> right?

Yes, one memory backend per virtio-mem device. You usually have one
device per NUMA node.

> 
> If not, then how do you map a totally new memory range into the guest
> address space without consuming a KVM memory slot?
> If that's somehow possible then maybe the same mechanism can simply be
> reused for this driver.

So, virtio-mem will (in the future, still to be upstreamed by me) use
resizeable memory regions / ramblocks / KVM memory slots. The region can
grow (e.g., memory hotplug) and shrink (e.g., during reboot, but later
also if unplugged memory would allow for it). Nice thing is that
migration code fully supports resizeable ramblocks already.

Resizes are triggered by the virtio-mem device, so stuff is completely
handled inside QEMU. For hv-balloon, you could grow the region when
required (e.g., balloon X, whereby X is > ram size after inflating), and
shrink during reboot (or whenever it might be valid to shrink). However,
you cannot "rip out" anything in between, you'll have to rely on
MADV_DONTNEED until the guests reboots (well, just like basic
ballooning) and you can definitely shrink the region.

That's the tradeoff virtio-mem decided to take for now to be able to
manage any size changes + migration completely in QEMU, avoiding any
coordination with an external entity (e.g., libvirt in your example)
when resizing a guest.

> 
>> [...]
>>
>>>
>>> So, yes, it will be a problem if the user expands their running guest
>>> ~256 times, each time making it even bigger than previously, without
>>> rebooting it even once, but this does seem to be an edge use case.
>>
>> IIRC, that's exactly what dynamic memory under Windows does in automatic
>> mode, no? Monitor the guests, distribute memory accordingly - usually in
>> smaller steps. But I am no expert on Hyper-V.
> 
> Yes, they call their automatic mode "Dynamic Memory" in recent Windows
> versions.
> 
> This is a bit confusing because even if you disable this feature
> the Hyper-V hypervisor will still provide this Dynamic Memory Protocol
> service and use it to resize the guest on (user) demand.
> Just it won't do such resize on its own but only when explicitly
> requested.

Interesting, thanks.

> 
> Don't know if they internally have any limit that is similar to the KVM
> memory slot limit, though.

That would be interesting for me - like which limits do actually apply
under Hyper-V.

[...]

> 
>> If you already notify the user on a reboot, the user can just kill the
>> VM and start it with an adjusted boot memory size. Yeah, that's ugly,
>> but so is the whole "adjust DIMM/balloon configuration during a reboot
>> from outside QEMU".
>>
>> BTW, how would you handle: Start guest with 10G. Inflate balloon to 5G.
>> Reboot. There are no virtual DIMMs to adjust.
> 
> You'll typically want to avoid relaunching QEMU as much as possible
> since things like chardev sockets and a VNC connection will disconnect
> if the QEMU process exits.
> Not to mention that it takes some time for it to actually start again.

Exactly my thoughts, that's why I tried to avoid that as well with
virtio-mem.

> 
> However, there is a trade-off here: one can either start the guest with
> a relatively large boot memory size, but then shrinking the guest means
> that it will see the whole boot memory size again during reboot, until
> it is ballooned down again after it has connected to the DM protocol.

Yeah, one of the main issues of memory ballooning.

> 
> Or it can be started with a small boot memory size, but this means that
> few virtual DIMMs might always be inserted (their size and / or count
> can be optimized during the next reboot or if they become unused due
> to ballooning).
> 
> Or one can choose some point in between these two scenarios.
>  
> I think a virtio-mem user has to choose a similar trade-off between
> the boot memory size and the size and count of plugged-in virtio-mem
> devices, right?

Partially yes, partially no. It doesn't really care about the second
case you mention ("few virtual DIMMs might always be inserted") due to
the way it works. And it does noever have to deal with "inflate balloon
after/during reboot".

A virtio-mem device manages only its assigned memory, it does not work
on random system memory like memory ballooning. So you can never unplug
initial memory.

However, you can do something like

-m 4G,maxmem=104G

and define a virtio-mem device with a maximum size of 100G and an
initial size of - say 16G. When booting up, the guest will detect the
additional 16GB and have effectively 20GB. However, you can only ever
shrink back down to 4GB (e.g., reliably during a reboot).

And it might not always be desirable (at least under Linux) to have
little boot memory - say the CMA allocator might want to reserve bigger
chunks of memory early during boot - if the initial memory size is too
small, this can fail easily.

[...]

>>
>>> Windows will generally leave some memory free when processing balloon
>>> requests, although the precise amount varies between few hundred MB to
>>> values like 1+ GB.
>>>
>>> Usually it runs stable even with these few hundred MBs of free memory
>>> remaining but I have seen occasional crashes at shutdown time in this
>>> case (probably something critical failing to initialize due to the
>>> system running out of memory).
>>>
>>> While the above command was just a quick example, I personally think
>>> it is the guest who should be enforcing a balloon floor since it is
>>> the guest that knows its internal memory requirements, not the host.
>>
>> Even the guest has no idea about the (future) working set size. That's a
>> known problem.
>>
>> There are always cases where the calculation is wrong, and if the
>> monitoring process isn't fast enough to react and adjust the guest size,
>> your things will end up baldy in your guest. Just as the reboot case you
>> mentioned, where the VM crashes.
> 
> The actual Hyper-V hypervisor somehow manages not to over-balloon its
> guests to the point that they run of of memory and crash.
> So this is definitely doable (with a margin of safety).
> 
> However, such heuristics are really an issue for the software
> controlling QEMU and so are outside the scope of this driver.

Yeah, just like any heuristic, it can be wrong. I wonder if we could add
something similar for virtio-balloon (at least don't immediately deflate
until your VM dies ...).

> 
> By the way, that's why DM guests emit a STATUS message each second
> with various memory counters (translated into a QMP event by this driver)
> - to give its host hints about the guest memory pressure.

Right, we have something similar for virtio-balloon, via the stats VQ.
IIRC, it's used by auto-ballooning mechanisms implemented in openstack
(I'd say similar to dynamic memory, it just won't try to increase the
size of a guest using new DIMMs).

>>
>>>>>
>>>>> Future directions:
>>>>> * Allow sharing the ballooning QEMU interface between hv-balloon and
>>>>>   virtio-balloon drivers.
>>>>>   Currently, only one of them can be added to the VM at the same time.
>>>>
>>>> Yeah, that makes sense. Only one at a time.
>>>
>>> Having only one *active* at a time makes sense, however it ultimately
>>> would be nice to be able to have them both inserted into a VM:
>>> one for Windows guests and one for Linux ones.
>>> Even though only one obviously would be active at the same time.
>>
>> I don't think that's the right way forward - that should be configured
>> when the VM is started.
>>
>> Personal opinion: I can understand the motivation to implement
>> hypervisor-specific devices to better support closed-source operating
>> systems. But I doubt we want to introduce+support ten different
>> proprietary devices based on proprietary standards doing roughly the
>> same thing just because closed-source operating systems are too lazy to
>> support open standards properly.
>>
> 
> What do you mean by "ten" proprietary devices?
> Is there another balloon protocol driver currently in the tree other
> than virtio-balloon running over various buses?

Maybe OSX wants to be next and re-invent the wheel with a proprietary
balloon driver for a custom hypervisor. I think you get the idea.

What I'm saying is that I'd much rather want to see Windows
improve+extend virtio-balloon and such (virtio-mem), instead of
requiring hypervisors to implement undocumented, proprietary devices to
get stuff running somewhat smoothly in modern cloud environments. I have
the feeling that quite some stuff you mention can simply be "fixed" by
extending/improving virtio-baloon under Windows - for example, inflation
speed can be improved significantly by inflating in bigger chunks. See

https://dl.acm.org/doi/10.1145/3240302.3240420

In contrast to hv-balloon *we* can extend/improve the
interface/stadnard/implementation on both sides (host/guest).

> 
> People are running Windows guests using QEMU, too.
> 
> That's why there are dozen or so Hyper-V enlightenments implemented,
> even though they duplicate KVM PV stuff or that there is kvmvapic
> with its Windows guest live-patching.

IIRC the Hyper-V enlightenment stuff is properly publicly documented -
whereby last time I checked, the hv-balloon is completely undocumented
and has to be reverse engineered from the Linux implementation. Please
correct me if I'm wrong - I am not able to spot references in your cover
letter as well - I'd be interested into that!

> 
> Not to mention many, many devices like e1000 or VMware vmxnet3 even
> though virtio-net exists or PIIX IDE even though virtio-{blk,scsi} exist.
> Or the applesmc driver, which is cleanly designed to help run just
> one proprietary OS.

IIRC we need the devices either to bootstrap - e.g., use e1000 until we
can install virtio-net once the guest is up and running, or to support
older, unmodified guests. I'd like to stress that what you are proposing
is different in that sense. Your Windows VM will work just fine without
a hv-balloon device.

Again, just my personal opinion, I don't make any decisions around here :)

-- 
Thanks,

David / dhildenb


