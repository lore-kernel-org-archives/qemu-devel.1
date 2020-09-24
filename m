Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBC8C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C74B21481
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C74B21481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZtE-0008F6-8t
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 18:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kLZsP-0007ou-Ld
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:38:09 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kLZsL-0004CD-Ri
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:38:09 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kLZru-0001DE-RD; Fri, 25 Sep 2020 00:37:38 +0200
Subject: Re: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
To: David Hildenbrand <david@redhat.com>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
 <c51f9ebd-5303-9919-1469-c99ff6a461b1@redhat.com>
 <d9032b0f-80e2-2eca-637d-251eb1f8f001@maciej.szmigiero.name>
 <4787eb88-a663-5f9a-ea44-d0a884907e12@redhat.com>
 <25a4ba26-aeca-48c2-c787-5f2f5d45d47d@maciej.szmigiero.name>
 <89363efe-84e8-11c1-62d9-824f46a20590@redhat.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 Sg==
Message-ID: <2a1ee343-0bc9-92af-5b94-8244b96ba6b5@maciej.szmigiero.name>
Date: Fri, 25 Sep 2020 00:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <89363efe-84e8-11c1-62d9-824f46a20590@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 18:37:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.214,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23.09.2020 14:48, David Hildenbrand wrote:
(...)
>>
>> I know that this a source of significant hot removal slowdown, especially
>> when a "ripple effect" happens on removal:
>> 1) There are 3 extra DIMMs plugged into the guest: A, B, C.
>>    A and B are nearly empty, but C is nearly full.
>>
>> 2) The host does not know anything which DIMM is empty and which is full,
>>    so it requests the guest to unplug the stick C,
> 
> In theory, the host can simply track inflation requests. In practice,
> guests tend to sometimes re-access balloon-inflated memory (e.g., simple
> kexec-style reboot under Linux, kdump on older Linux versions), so it's
> not completely safe to do.

You are describing Linux situation here, while this driver targets
Windows.

I think the issues you describe (kexec, etc.) are probably fixable once
somebody is determined enough to do so.

I mean, either the old kernel needs to transfer information about
"forbidden" memory areas to the new kernel or the new kernel needs to
query these somehow (probably only if is receives a "do it" flag from
the old kernel).

>>
>> 3) The guest copies the content of the stick C to the stick B,
>>
>> 4) Once again, the host does not know anything which DIMM is empty and
>>    which is full, so it requests the guest to unplug the stick B,
>>
>> 5) The guest now has to copy the same data from the stick B to the
>>    stick A, once again.
>>
>> With virtual DIMM sticks + this driver it is the guest which chooses
>> which particular pages to release, hopefully choosing the already unused
>> ones.
>> Once the whole memory behind a DIMM stick is released the host knows
>> that it can be unplugged now without any copying.
>>
>> While it might seem like this will cause a lot of fragmentation in
>> practice Windows seems to try to give out the largest continuous range
>> of pages it is able to find.
>>
>> One can also see in the hv_balloon client driver from the Linux kernel
>> that this driver tries to do 2 MB allocations for as long as it can
>> before giving out single pages.
> 
> Yeah, something similar was proposed for virtio-balloon already (and
> there is a paper about that - see below). For virito-balloon, we were
> not yet convinced that stealing most hugepages from the guest is always
> such a good idea. It at least would have to be configurable, to not mess
> with existing use cases.

Thanks for the paper.

The hv_balloon Linux client driver does large continuous allocations of
ordinary 4k pages, not only transparent hugepages.

Even if the virtio-balloon client driver is changed to do higher-older
allocations the protocol itself only supports transporting individual
page numbers and not ranges.

Either the virtio-balloon protocol will need to be changed to allow
sending page ranges (good) or there will need to be some implicit
agreement between the host and client drivers that pages from a
continuous range will be sent consecutively.
Then the host driver can reassemble the whole range, ending either
when it receives a page outside the range or when a reassembly timeout
happens.

But that's just really ugly - realistically the virtio-balloon
protocol will need to be changed in such case.

> 
>>
>> The reason why ballooning and DIMMs wasn't being used together previously
>> is probably because virtio-balloon will (at least on Windows) mark the
>> ballooned out pages as in use inside the guest, preventing the removal
>> of the DIMM stick backing them.
> 
> Same on Linux - but the pages are movable, such they can at least moved
> around to offline + unplug a DIMM.
> 
> Some of the reasons why ballooning + DIMMs are not used as far as I know is:
> - Management issues. Using it without some managing instance
>   (plug/unplug DIMM, control balloon) is impossible. Try using it with
>   bare QEMU - basically impossible.

We'll it's not impossible, just needs some manual reconfiguration.

But such advanced usage scenarios usually are using QEMU with an
external controller anyway.

> - Memory Hotplug limitations: Maximum DIMM count. Minimum DIMM size that
>   an OS can use (e.g., >= 128MiB under Linux, sometimes even 1GB). The
>   granularity restrictions you mentioned apply.

Windows has a memory hotplug granularity of 1 MB.

> - Memory Hotplug reliability: It can happen easily that hotplugging a
>   DIMM / onlining it under Linux fails (e.g., minimum DIMM size). "What
>   you think the guests actually has as available memory might be wrong".
>   If you ignore that (and you don't even get notified) and adjust the
>   balloon later, your (Linux) guest might be in trouble. Assume
>   you hotplug a 8GB to a 2G VM and later try to inflate the balloon to
>   4GB ... so you need reliable monitoring and error handling.

The DM "hot add" message has a "page_count" field to tell the host
how much memory the guest has actually added.

Quoting the DM protocol header file:
> Hot adds may also fail due to low resources; in this case, the guest must
> not complete this message until the hot add can succeed, and the host must
> not send a new hot add request until the response is sent.
> If VSC fails to hot add memory DYNMEM_NUMBER_OF_UNSUCCESSFUL_HOTADD_ATTEMPTS
> times it fails the request.

The host also knows the current guest memory size from its STATUS
messages.

> So yeah, I can understand how hv-balloon tries to work around some of
> these issues.
>
>>
>> In addition to the above, virtio-balloon is also very slow, as the whole
>> protocol operates on single pages only, not on page ranges.
>> There might also be some interference with Windows memory management
>> causing an extra slowdown in comparison to the native Windows DM
>> protocol.
> 
> Yes, because I assume Windows doesn't really care too much about
> optimizing for virtio-balloon. There isn't too much external developers
> can do about that. See below for hugepage ballooning in virtio-balloon.

Exactly, that's why the DM protocol is the best thing we have to offer
for Windows guests right now.

>>
>> If the KVM slot limit starts to be a problem in practice then we can
>> think what can be done about it.
>> It's always one obstacle less.
> 
> I'm not a friend of leaving the challenging/fundamental problems to be
> sported out in the future (e.g., resizing initial boot memory, dealing
> with fundamental limits - like KVM memory slots or VMA). But I get how
> it's easier to get something running this way :)

Constraints can be removed step-by-step, when they actually start tobite.

It is unrealistic to have a perfect guest resize solution in a single
patch series upfront, the issue is just too complex.

>>
>> I see that the same KVM slot limit probably applies also for virtio-mem,
>> since it uses memory-backend-ram as its backing memory device, too,
>> right?
> 
> Yes, one memory backend per virtio-mem device. You usually have one
> device per NUMA node.

So if you want to dynamically manage most of the guest memory these
virtio-mem devices + their backends will be very large
(circa 1/4 guest size each for a 4-node machine).

That means in practice they won't ever be able to be hot-removed before
the VM is rebooted since there will very likely be at least single stuck
page in each of these backing devices preventing their removal.
(If hot-removal support is ever enabled for virtio-mem, it looks like it
is not possible yet even on a VM reboot).

And I can see that removing a single RAM block in virio-mem is done 
by discarding it via MADV_DONTNEED, just like in ballooning.
Only the minimum block size is 2 MB and not 4 KB so all consecutive
512 pages in a block will need to be free in order to discard it.

>>
>> If not, then how do you map a totally new memory range into the guest
>> address space without consuming a KVM memory slot?
>> If that's somehow possible then maybe the same mechanism can simply be
>> reused for this driver.
> 
> So, virtio-mem will (in the future, still to be upstreamed by me) use
> resizeable memory regions / ramblocks / KVM memory slots. The region can
> grow (e.g., memory hotplug) and shrink (e.g., during reboot, but later
> also if unplugged memory would allow for it). Nice thing is that
> migration code fully supports resizeable ramblocks already.
> 
> Resizes are triggered by the virtio-mem device, so stuff is completely
> handled inside QEMU. For hv-balloon, you could grow the region when
> required (e.g., balloon X, whereby X is > ram size after inflating), and
> shrink during reboot (or whenever it might be valid to shrink). However,
> you cannot "rip out" anything in between, you'll have to rely on
> MADV_DONTNEED until the guests reboots (well, just like basic
> ballooning) and you can definitely shrink the region.
> 
> That's the tradeoff virtio-mem decided to take for now to be able to
> manage any size changes + migration completely in QEMU, avoiding any
> coordination with an external entity (e.g., libvirt in your example)
> when resizing a guest.

For hv-balloon (that is, Windows guests), it seems to me that the slot
resizing would be a viable solution for growing the guest without
hitting the KVM slot limit or requiring a VM reboot.

For shrinking such guests it isn't really necessary since DM ballooning
is enough until a reboot happens.

During a reboot, virtual DIMM config optimization can be used for now,
while the best, long-term, solution would be to actually do what the
Hyper-V hypervisor does in this case: resize the boot memory to match
the target guest size.

This way the whole issue of the guest seeing only the boot memory part,
not the dynamic part, during its boot will no longer be there.

(...)
>>
>> Or it can be started with a small boot memory size, but this means that
>> few virtual DIMMs might always be inserted (their size and / or count
>> can be optimized during the next reboot or if they become unused due
>> to ballooning).
>>
>> Or one can choose some point in between these two scenarios.
>>  
>> I think a virtio-mem user has to choose a similar trade-off between
>> the boot memory size and the size and count of plugged-in virtio-mem
>> devices, right?
> 
> Partially yes, partially no. It doesn't really care about the second
> case you mention ("few virtual DIMMs might always be inserted") due to
> the way it works. And it does noever have to deal with "inflate balloon
> after/during reboot".
> 
> A virtio-mem device manages only its assigned memory, it does not work
> on random system memory like memory ballooning. So you can never unplug
> initial memory.
> 
> However, you can do something like
> 
> -m 4G,maxmem=104G
> 
> and define a virtio-mem device with a maximum size of 100G and an
> initial size of - say 16G. When booting up, the guest will detect the
> additional 16GB and have effectively 20GB. However, you can only ever
> shrink back down to 4GB (e.g., reliably during a reboot).
>
> And it might not always be desirable (at least under Linux) to have
> little boot memory - say the CMA allocator might want to reserve bigger
> chunks of memory early during boot - if the initial memory size is too
> small, this can fail easily.
> 

So the virtio-mem trade-off is between the size of the boot memory and
the dynamically managed part(s).
And also the block size, as as far I can see, a single stuck page in
a block will prevent it from being discarded.

Of course, we are talking about Linux guests here - Windows guest
will see just the boot memory part.

(...)
>>>
>>>>>>
>>>>>> Future directions:
>>>>>> * Allow sharing the ballooning QEMU interface between hv-balloon and
>>>>>>   virtio-balloon drivers.
>>>>>>   Currently, only one of them can be added to the VM at the same time.
>>>>>
>>>>> Yeah, that makes sense. Only one at a time.
>>>>
>>>> Having only one *active* at a time makes sense, however it ultimately
>>>> would be nice to be able to have them both inserted into a VM:
>>>> one for Windows guests and one for Linux ones.
>>>> Even though only one obviously would be active at the same time.
>>>
>>> I don't think that's the right way forward - that should be configured
>>> when the VM is started.
>>>
>>> Personal opinion: I can understand the motivation to implement
>>> hypervisor-specific devices to better support closed-source operating
>>> systems. But I doubt we want to introduce+support ten different
>>> proprietary devices based on proprietary standards doing roughly the
>>> same thing just because closed-source operating systems are too lazy to
>>> support open standards properly.
>>>
>>
>> What do you mean by "ten" proprietary devices?
>> Is there another balloon protocol driver currently in the tree other
>> than virtio-balloon running over various buses?
> 
> Maybe OSX wants to be next and re-invent the wheel with a proprietary
> balloon driver for a custom hypervisor. I think you get the idea.
> 
> What I'm saying is that I'd much rather want to see Windows
> improve+extend virtio-balloon and such (virtio-mem), instead of
> requiring hypervisors to implement undocumented, proprietary devices to
> get stuff running somewhat smoothly in modern cloud environments. I have
> the feeling that quite some stuff you mention can simply be "fixed" by
> extending/improving virtio-baloon under Windows - for example, inflation
> speed can be improved significantly by inflating in bigger chunks. See
> 
> https://dl.acm.org/doi/10.1145/3240302.3240420
> 
> In contrast to hv-balloon *we* can extend/improve the
> interface/stadnard/implementation on both sides (host/guest).

Even if we switched virtio-balloon to bigger allocations and made the
protocol return page ranges the allocation is still done by simply
using an ordinary alloc_pages()-equivalent API.
I don't see any exported Windows kernel API for allocating balloon
memory.

The same goes for adding new RAM.

The above alone means that supporting virtio-mem semantics on current
Windows versions is likely not possible.

>>
>> People are running Windows guests using QEMU, too.
>>
>> That's why there are dozen or so Hyper-V enlightenments implemented,
>> even though they duplicate KVM PV stuff or that there is kvmvapic
>> with its Windows guest live-patching.
> 
> IIRC the Hyper-V enlightenment stuff is properly publicly documented -

They are only documented from the guest perspective - basically what
the guest of a Hyper-V hypervisor can possibly use.

There is nothing in the Hyper-V TLFS which of the functionality it
documents is supported or required by any Windows version or how
Windows guests actually make use of these features.

Not to mention that the documented interface could say the guest can
expect values A or B or C for parameter X, which is technically true, 
however the actual Hyper-V hypervisor always uses A and that's what
Windows will expect.
 
> whereby last time I checked, the hv-balloon is completely undocumented
> and has to be reverse engineered from the Linux implementation. Please
> correct me if I'm wrong - I am not able to spot references in your cover
> letter as well - I'd be interested into that!

The DM protocol is rather straightforward - the Linux driver contains
well-commented definitions of its messages.

For a hot add the host simply provides the start page frame number and
the count of pages to add and in response receives the number of pages
the guest was actually able to hot add.

For a balloon request the host provides a count of pages it wants the
guest to free and the guest responds with page ranges it has managed
to release.
The reverse happens for an unballoon request.

The protocol consists of just a few simple messages, well described
in the Linux driver.

The VMBus part of the protocol works in the same way as in other VMBus
devices.

>>
>> Not to mention many, many devices like e1000 or VMware vmxnet3 even
>> though virtio-net exists or PIIX IDE even though virtio-{blk,scsi} exist.
>> Or the applesmc driver, which is cleanly designed to help run just
>> one proprietary OS.
> 
> IIRC we need the devices either to bootstrap - e.g., use e1000 until we
> can install virtio-net once the guest is up and running, or to support
> older, unmodified guests. I'd like to stress that what you are proposing
> is different in that sense. Your Windows VM will work just fine without
> a hv-balloon device.

There are also "accelerator" devices like kvmvapic or proprietary devices
where an older open standard exists, like sii3112 SATA, even though
IDE / AHCI can be used to bootstrap the guest.
The sii3112 driver was only added in 2017, although the hardware that
it emulates comes from early 21st century.

> Again, just my personal opinion, I don't make any decisions around here :)
> 

Thanks for taking the time to provide your feedback and insight,
Maciej

