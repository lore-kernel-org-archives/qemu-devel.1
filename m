Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B5C4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076D823A5B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076D823A5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKUHE-0004BO-2R
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kKUCp-00064B-18
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:22:43 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:56134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kKUCl-0002j4-Vg
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:22:42 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kKUCQ-0005w5-LC; Tue, 22 Sep 2020 00:22:18 +0200
Subject: Re: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
To: David Hildenbrand <david@redhat.com>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
 <c51f9ebd-5303-9919-1469-c99ff6a461b1@redhat.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 Sg==
Message-ID: <d9032b0f-80e2-2eca-637d-251eb1f8f001@maciej.szmigiero.name>
Date: Tue, 22 Sep 2020 00:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c51f9ebd-5303-9919-1469-c99ff6a461b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 18:22:30
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
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

Thank you for your comments.

First, I want to underline that this driver targets Windows guests,
where ability to modify and adapt the guest memory management
code is extremely limited.

While it does work with Linux guests, too, this is definitely not its
native environment.

It also has to support rather big guests, up to 1 TB of RAM, so
performance-related things are important.

Further answers are bellow.

On 21.09.2020 11:10, David Hildenbrand wrote:
> On 20.09.20 15:25, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This series adds a Hyper-V Dynamic Memory Protocol driver (hv-balloon)
>> and its protocol definitions.
>> Also included is a driver providing backing devices for memory hot-add
>> protocols ("haprots").
>>
>> A haprot device works like a virtual DIMM stick: it allows inserting
>> extra RAM into the guest at run time.
>>
>> The main differences from the ACPI-based PC DIMM hotplug are:
>> * Notifying the guest about the new memory range is not done via ACPI but
>> via a protocol handler that registers with the haprot framework.
>> This means that the ACPI DIMM slot limit does not apply.
>>
>> * A protocol handler can prevent removal of a haprot device when it is
>> still in use by setting its "busy" field.
>>
>> * A protocol handler can also register an "unplug" callback so it gets
>> notified when an user decides to remove the haprot device.
>> This way the protocol handler can inform the guest about this fact and / or
>> do its own cleanup.
>>
>> The hv-balloon driver is like virtio-balloon on steroids: it allows both
>> changing the guest memory allocation via ballooning and inserting extra
>> RAM into it by adding haprot virtual DIMM sticks.
>> One of advantages of these over ACPI-based PC DIMM hotplug is that such
>> memory can be hotplugged in much smaller granularity because the ACPI DIMM
>> slot limit does not apply.
> 
> Reading further below, it's essentially DIMM-based memory hotplug +
> virtio-balloon - except the 256MB DIMM limit. But reading below, I don't
> see how you want to avoid the KVM memory slot limit that's in a similar
> size (I recall 256*2 due to 2 address spaces). 

The idea is to use virtual DIMM sticks for hot-adding extra memory at
runtime, while using ballooning for runtime adjustment of the guest
memory size within the current maximum.

When the guest is rebooted the virtual DIMMs configuration is adjusted
by the software controlling QEMU (some are removed and / or some are
added) to give the guest the same effective memory size as it had before
the reboot.

So, yes, it will be a problem if the user expands their running guest
~256 times, each time making it even bigger than previously, without
rebooting it even once, but this does seem to be an edge use case.

In the future it would be better to automatically turn the current
effective guest size into its boot memory size when the VM restarts
(the VM will then have no virtual DIMMs inserted after a reboot), but
doing this requires quite a few changes to QEMU, that's why it isn't
there yet.

The above is basically how Hyper-V hypervisor handles its memory size
changes and it seems to be as close to having a transparently resizable
guest as reasonably possible.


> Or avoid VMA limits when wanting to grow a VM big in very tiny steps over
> time (e.g., adding 64MB at a time).

Not sure if you are taking about VMA limits inside the host or the guest.
>>
>> In contrast with ACPI DIMM hotplug where one can only request to unplug a
>> whole DIMM stick this driver allows removing memory from guest in single
>> page (4k) units via ballooning.
>> Then, once the guest has released the whole memory backed by a haprot
>> virtual DIMM stick such device is marked "unused" and can be removed from
>> the VM, if one wants so.
>> A "HV_BALLOON_HAPROT_UNUSED" QMP event is emitted in this case so the
>> software controlling QEMU knows that this operation is now possible.
>>
>> The haprot devices are also marked unused after a VM reboot (with a
>> corresponding "HV_BALLOON_HAPROT_UNUSED" QMP event).
>> They are automatically reinserted (if still present) after the guest
>> reconnects to this protocol (a "HV_BALLOON_HAPROT_INUSE" QMP event is then
>> emitted).
>>
>> For performance reasons, the guest-released memory is tracked in few range
>> trees, as a series of (start, count) ranges.
>> Each time a new page range is inserted into such tree its neighbors are
>> checked as candidates for possible merging with it.
>>
>> Besides performance reasons, the Dynamic Memory protocol itself uses page
>> ranges as the data structure in its messages, so relevant pages need to be
>> merged into such ranges anyway.
>>
>> One has to be careful when tracking the guest-released pages, since the
>> guest can maliciously report returning pages outside its current address
>> space, which later clash with the address range of newly added memory.
>> Similarly, the guest can report freeing the same page twice.
>>
>> The above design results in much better ballooning performance than when
>> using virtio-balloon with the same guest: 230 GB / minute with this driver
>> versus 70 GB / minute with virtio-balloon.
> 
> I assume these numbers apply with Windows guests only. IIRC Linux
> hv_balloon does not support page migration/compaction, while
> virtio-balloon does. So you might end up with quite some fragmented
> memory with hv_balloon in Linux guests - of course, usually only in
> corner cases.

As I previously mentioned, this driver targets mainly Windows guests.

And Windows seems to be rather determined to free the requested number
of pages: waiting for the guest to reply to a 2GB balloon request
sometimes takes 2-3 seconds.
So i guess it does some kind of memory compaction during that request
processing time.

>>
>> During a ballooning operation most of time is spent waiting for the guest
>> to come up with newly freed page ranges, processing the received ranges on
>> the host side (in QEMU / KVM) is nearly instantaneous.
>>
>> The unballoon operation is also pretty much instantaneous:
>> thanks to the merging of the ballooned out page ranges 200 GB of memory can
>> be returned to the guest in about 1 second.
>> With virtio-balloon this operation takes about 2.5 minutes.
>>
>> These tests were done against a Windows Server 2019 guest running on a
>> Xeon E5-2699, after dirtying the whole memory inside guest before each
>> balloon operation.
>>
>> Using a range tree instead of a bitmap to track the removed memory also
>> means that the solution scales well with the guest size: even a 1 TB range
>> takes just few bytes of memory.
>> Example usage:
>> * Add "-device vmbus-bridge,id=vmbus-bridge -device hv-balloon,id=hvb"
>>   to the QEMU command line and set "maxmem" value to something large,
>>   like 1T.
>>
>> * Use QEMU monitor commands to add a haprot virtual DIMM stick, together
>>   with its memory backend:
>>   object_add memory-backend-ram,id=mem1,size=200G
>>   device_add mem-haprot,id=ha1,memdev=mem1
>>   The first command is actually the same as for ACPI-based DIMM hotplug.
>>
>> * Use the ballooning interface monitor commands to force the guest to give
>>   out as much memory as possible:
>>   balloon 1
> 
> At least under virtio-balloon with Linux, that will pretty sure trigger
> a guest crash. Is something like that expected to work with Windows
> guests reasonably well?

Windows will generally leave some memory free when processing balloon
requests, although the precise amount varies between few hundred MB to
values like 1+ GB.

Usually it runs stable even with these few hundred MBs of free memory
remaining but I have seen occasional crashes at shutdown time in this
case (probably something critical failing to initialize due to the
system running out of memory).

While the above command was just a quick example, I personally think
it is the guest who should be enforcing a balloon floor since it is
the guest that knows its internal memory requirements, not the host.

For this reason the hv_balloon client driver inside the Linux kernel
implements its own, rough balloon floor - see compute_balloon_floor().

On the other hand, one can also argue that the user wish should be
respected as much as possible.

>>   The ballooning interface monitor commands can also be used to resize
>>   the guest up and down appropriately.
>>
>> * One can check the current guest size by issuing a "info balloon" command.
>>   This is useful to know what is happening, since large ballooning or
>>   unballooning operations take some time to complete.
> 
> So, every time you want to add more memory (after the balloon was
> deflated) to a guest, you have to plug a new mem-haprot device, correct?

Yes.

> So your QEMU user has to be well aware of how to balance "balloon" and
> "object_add/device_add/object_del_device_del" commands to achieve the
> desired guest size.

In this case the VM user does not interact directly with the QEMU process.

Rather, the user tells the software controlling QEMU (think: libvirt)
their wish how large they want the guest to be and this software then
does everything what is necessary to achieve such target and make it
persistent across guest reboots.

 
>>
>> * Once the guest releases the whole memory backed by a haprot device
>>   (or is restarted) a "HV_BALLOON_HAPROT_UNUSED" QMP event will be
>>   generated.
>>   The haprot device then can be removed, together with its memory backend:
>>   device_del ha1
>>   object_del mem1
> 
> So, you rely on some external entity to properly shrink a guest again
> (e.g., during reboot).

Yes.

>>
>> Future directions:
>> * Allow sharing the ballooning QEMU interface between hv-balloon and
>>   virtio-balloon drivers.
>>   Currently, only one of them can be added to the VM at the same time.
> 
> Yeah, that makes sense. Only one at a time.

Having only one *active* at a time makes sense, however it ultimately
would be nice to be able to have them both inserted into a VM:
one for Windows guests and one for Linux ones.
Even though only one obviously would be active at the same time.

>>
>> * Allow new haport devices to reuse the same address range as the ones
>>   that were previously deleted via device_del monitor command without
>>   having to restart the VM.
>>
>> * Add vmstate / live migration support to the hv-balloon driver.
>>
>> * Use haprot device to also add memory via virtio interface (this requires
>>   defining a new operation in virtio-balloon protocol and appropriate
>>   support from the client virtio-balloon driver in the Linux kernel).
> 
> Most probably not the direction we are going to take. We have virtio-mem
> for clean, fine-grained, NUMA-aware, paravirtualized memory hot(un)plug
> now, and we are well aware of various issues with (base-page size based)
> memory ballooning that are fairly impossible to solve (especially in the
> context of vfio).
> 

Thanks,
Maciej

