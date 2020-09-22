Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32976C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F16221EF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F16221EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKray-0001EG-A7
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 19:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kKra5-0000h8-V4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 19:20:17 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:60362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kKra3-0004cN-7M
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 19:20:17 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kKrZi-0001tg-EN; Wed, 23 Sep 2020 01:19:54 +0200
Subject: Re: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
To: David Hildenbrand <david@redhat.com>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
 <c51f9ebd-5303-9919-1469-c99ff6a461b1@redhat.com>
 <d9032b0f-80e2-2eca-637d-251eb1f8f001@maciej.szmigiero.name>
 <4787eb88-a663-5f9a-ea44-d0a884907e12@redhat.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 Sg==
Message-ID: <25a4ba26-aeca-48c2-c787-5f2f5d45d47d@maciej.szmigiero.name>
Date: Wed, 23 Sep 2020 01:19:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4787eb88-a663-5f9a-ea44-d0a884907e12@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 19:20:05
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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

On 22.09.2020 09:26, David Hildenbrand wrote:
> On 22.09.20 00:22, Maciej S. Szmigiero wrote:
>> Hi David,
>>
>> Thank you for your comments.
>>
(...)
>>
>> The idea is to use virtual DIMM sticks for hot-adding extra memory at
>> runtime, while using ballooning for runtime adjustment of the guest
>> memory size within the current maximum.
>>
>> When the guest is rebooted the virtual DIMMs configuration is adjusted
>> by the software controlling QEMU (some are removed and / or some are
>> added) to give the guest the same effective memory size as it had before
>> the reboot.
> 
> Okay, so while "the ACPI DIMM slot limit does not apply", the KVM memory
> slot limit (currently) applies, resulting in exactly the same behavior.
>
> The only (conceptual difference) I am able to spot is then a
> notification to the user on reboot, so the guest memory layout can be
> adjusted (which I consider very ugly, but it's the same thing when
> mixing ballooning and DIMMs - which is why it's usually never done).

If you want to shrink a guest at runtime you'll pretty much have to use
ballooning as {ACPI-based PC, virtual} DIMM stick sizes are far too
large to make anything but rough adjustments to the guest memory size.

In addition to that with ACPI-based PC DIMM hotplug it is the host that
chooses which particular DIMM stick to unplug while having no feedback
from the guest how much of each DIMM stick memory range is currently
in use and so will have to be copied somewhere else.

I know that this a source of significant hot removal slowdown, especially
when a "ripple effect" happens on removal:
1) There are 3 extra DIMMs plugged into the guest: A, B, C.
   A and B are nearly empty, but C is nearly full.

2) The host does not know anything which DIMM is empty and which is full,
   so it requests the guest to unplug the stick C,

3) The guest copies the content of the stick C to the stick B,

4) Once again, the host does not know anything which DIMM is empty and
   which is full, so it requests the guest to unplug the stick B,

5) The guest now has to copy the same data from the stick B to the
   stick A, once again.

With virtual DIMM sticks + this driver it is the guest which chooses
which particular pages to release, hopefully choosing the already unused
ones.
Once the whole memory behind a DIMM stick is released the host knows
that it can be unplugged now without any copying.

While it might seem like this will cause a lot of fragmentation in
practice Windows seems to try to give out the largest continuous range
of pages it is able to find.

One can also see in the hv_balloon client driver from the Linux kernel
that this driver tries to do 2 MB allocations for as long as it can
before giving out single pages.

The reason why ballooning and DIMMs wasn't being used together previously
is probably because virtio-balloon will (at least on Windows) mark the
ballooned out pages as in use inside the guest, preventing the removal
of the DIMM stick backing them.

In addition to the above, virtio-balloon is also very slow, as the whole
protocol operates on single pages only, not on page ranges.
There might also be some interference with Windows memory management
causing an extra slowdown in comparison to the native Windows DM
protocol.

If the KVM slot limit starts to be a problem in practice then we can
think what can be done about it.
It's always one obstacle less.

I see that the same KVM slot limit probably applies also for virtio-mem,
since it uses memory-backend-ram as its backing memory device, too,
right?

If not, then how do you map a totally new memory range into the guest
address space without consuming a KVM memory slot?
If that's somehow possible then maybe the same mechanism can simply be
reused for this driver.

> [...]
> 
>>
>> So, yes, it will be a problem if the user expands their running guest
>> ~256 times, each time making it even bigger than previously, without
>> rebooting it even once, but this does seem to be an edge use case.
> 
> IIRC, that's exactly what dynamic memory under Windows does in automatic
> mode, no? Monitor the guests, distribute memory accordingly - usually in
> smaller steps. But I am no expert on Hyper-V.

Yes, they call their automatic mode "Dynamic Memory" in recent Windows
versions.

This is a bit confusing because even if you disable this feature
the Hyper-V hypervisor will still provide this Dynamic Memory Protocol
service and use it to resize the guest on (user) demand.
Just it won't do such resize on its own but only when explicitly
requested.

Don't know if they internally have any limit that is similar to the KVM
memory slot limit, though.

>>
>> In the future it would be better to automatically turn the current
>> effective guest size into its boot memory size when the VM restarts
>> (the VM will then have no virtual DIMMs inserted after a reboot), but
>> doing this requires quite a few changes to QEMU, that's why it isn't
>> there yet.
> 
> Will most probably never happen as reshuffling the layout of your boot
> memory (especially with NUMA) within QEMU can break live migration in
> various ways.

That's why this functionality is not in the current driver version as
it is a bit hard to implement :)

> If you already notify the user on a reboot, the user can just kill the
> VM and start it with an adjusted boot memory size. Yeah, that's ugly,
> but so is the whole "adjust DIMM/balloon configuration during a reboot
> from outside QEMU".
>
> BTW, how would you handle: Start guest with 10G. Inflate balloon to 5G.
> Reboot. There are no virtual DIMMs to adjust.

You'll typically want to avoid relaunching QEMU as much as possible
since things like chardev sockets and a VNC connection will disconnect
if the QEMU process exits.
Not to mention that it takes some time for it to actually start again.

However, there is a trade-off here: one can either start the guest with
a relatively large boot memory size, but then shrinking the guest means
that it will see the whole boot memory size again during reboot, until
it is ballooned down again after it has connected to the DM protocol.

Or it can be started with a small boot memory size, but this means that
few virtual DIMMs might always be inserted (their size and / or count
can be optimized during the next reboot or if they become unused due
to ballooning).

Or one can choose some point in between these two scenarios.
 
I think a virtio-mem user has to choose a similar trade-off between
the boot memory size and the size and count of plugged-in virtio-mem
devices, right?

>>
>> The above is basically how Hyper-V hypervisor handles its memory size
>> changes and it seems to be as close to having a transparently resizable
>> guest as reasonably possible.
> 
> "having a transparently resizable _Windows_ guests right now" :)

Right.

(...)
> 
>>> I assume these numbers apply with Windows guests only. IIRC Linux
>>> hv_balloon does not support page migration/compaction, while
>>> virtio-balloon does. So you might end up with quite some fragmented
>>> memory with hv_balloon in Linux guests - of course, usually only in
>>> corner cases.
>>
>> As I previously mentioned, this driver targets mainly Windows guests.
> 
> ... and you cannot enforce that people will only use it with Windows
> guests :)
If people want to run this driver with Linux or port the hv_balloon
client driver from the Linux kernel to, for example, GNU Hurd and run
the DM protocol there then they are free to do so.
Just it really isn't this driver target environment.

> [...]
> 
>> Windows will generally leave some memory free when processing balloon
>> requests, although the precise amount varies between few hundred MB to
>> values like 1+ GB.
>>
>> Usually it runs stable even with these few hundred MBs of free memory
>> remaining but I have seen occasional crashes at shutdown time in this
>> case (probably something critical failing to initialize due to the
>> system running out of memory).
>>
>> While the above command was just a quick example, I personally think
>> it is the guest who should be enforcing a balloon floor since it is
>> the guest that knows its internal memory requirements, not the host.
> 
> Even the guest has no idea about the (future) working set size. That's a
> known problem.
> 
> There are always cases where the calculation is wrong, and if the
> monitoring process isn't fast enough to react and adjust the guest size,
> your things will end up baldy in your guest. Just as the reboot case you
> mentioned, where the VM crashes.

The actual Hyper-V hypervisor somehow manages not to over-balloon its
guests to the point that they run of of memory and crash.
So this is definitely doable (with a margin of safety).

However, such heuristics are really an issue for the software
controlling QEMU and so are outside the scope of this driver.

By the way, that's why DM guests emit a STATUS message each second
with various memory counters (translated into a QMP event by this driver)
- to give its host hints about the guest memory pressure.

> [...]
> 
>>>>
>>>> Future directions:
>>>> * Allow sharing the ballooning QEMU interface between hv-balloon and
>>>>   virtio-balloon drivers.
>>>>   Currently, only one of them can be added to the VM at the same time.
>>>
>>> Yeah, that makes sense. Only one at a time.
>>
>> Having only one *active* at a time makes sense, however it ultimately
>> would be nice to be able to have them both inserted into a VM:
>> one for Windows guests and one for Linux ones.
>> Even though only one obviously would be active at the same time.
> 
> I don't think that's the right way forward - that should be configured
> when the VM is started.
> 
> Personal opinion: I can understand the motivation to implement
> hypervisor-specific devices to better support closed-source operating
> systems. But I doubt we want to introduce+support ten different
> proprietary devices based on proprietary standards doing roughly the
> same thing just because closed-source operating systems are too lazy to
> support open standards properly.
> 

What do you mean by "ten" proprietary devices?
Is there another balloon protocol driver currently in the tree other
than virtio-balloon running over various buses?

People are running Windows guests using QEMU, too.

That's why there are dozen or so Hyper-V enlightenments implemented,
even though they duplicate KVM PV stuff or that there is kvmvapic
with its Windows guest live-patching.

Not to mention many, many devices like e1000 or VMware vmxnet3 even
though virtio-net exists or PIIX IDE even though virtio-{blk,scsi} exist.
Or the applesmc driver, which is cleanly designed to help run just
one proprietary OS.

Thanks,
Maciej

