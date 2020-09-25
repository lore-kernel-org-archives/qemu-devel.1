Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71849C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E8121D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCUTh8nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E8121D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLhZn-0000tE-LH
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 02:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLhYG-0000GP-N4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLhYE-0007N5-Cb
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:49:52 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601016589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rawo+kqxPr06Wb9YPsOTh5MrSm8jODeAi9KYAlSKAmY=;
 b=fCUTh8nWjCHOhN0eMaKf8uVSiybFTul/ab5UKLnsecIPC0HNlTNqosS3t20fHp7NCOwTTh
 e9wajDOULqIzw3FN3z0qqT/KHj7dz74zvaZHuSKvo6ZTJdQAc+bfQW3fZ3KExtZRrOocRG
 u79It46n2AI14ewaHCDd4SVccGFlCk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-x0g3IXuCNR-v5AgZfvTOFw-1; Fri, 25 Sep 2020 02:49:47 -0400
X-MC-Unique: x0g3IXuCNR-v5AgZfvTOFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55471AD501;
 Fri, 25 Sep 2020 06:49:46 +0000 (UTC)
Received: from [10.36.112.211] (ovpn-112-211.ams2.redhat.com [10.36.112.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D592100238E;
 Fri, 25 Sep 2020 06:49:40 +0000 (UTC)
Subject: Re: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
 <c51f9ebd-5303-9919-1469-c99ff6a461b1@redhat.com>
 <d9032b0f-80e2-2eca-637d-251eb1f8f001@maciej.szmigiero.name>
 <4787eb88-a663-5f9a-ea44-d0a884907e12@redhat.com>
 <25a4ba26-aeca-48c2-c787-5f2f5d45d47d@maciej.szmigiero.name>
 <89363efe-84e8-11c1-62d9-824f46a20590@redhat.com>
 <2a1ee343-0bc9-92af-5b94-8244b96ba6b5@maciej.szmigiero.name>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <28ab7005-c31c-239e-4659-e5287f4c5468@redhat.com>
Date: Fri, 25 Sep 2020 08:49:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2a1ee343-0bc9-92af-5b94-8244b96ba6b5@maciej.szmigiero.name>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 25.09.20 00:37, Maciej S. Szmigiero wrote:
> On 23.09.2020 14:48, David Hildenbrand wrote:
> (...)
>>>
>>> I know that this a source of significant hot removal slowdown, especially
>>> when a "ripple effect" happens on removal:
>>> 1) There are 3 extra DIMMs plugged into the guest: A, B, C.
>>>    A and B are nearly empty, but C is nearly full.
>>>
>>> 2) The host does not know anything which DIMM is empty and which is full,
>>>    so it requests the guest to unplug the stick C,
>>
>> In theory, the host can simply track inflation requests. In practice,
>> guests tend to sometimes re-access balloon-inflated memory (e.g., simple
>> kexec-style reboot under Linux, kdump on older Linux versions), so it's
>> not completely safe to do.
> 
> You are describing Linux situation here, while this driver targets
> Windows.

Yeah, this stuff is also broken with Linux under Hyper-V IIRC (I
remember fixing kdump/makedumpfile to not touch inflated pages).

> 
> I think the issues you describe (kexec, etc.) are probably fixable once
> somebody is determined enough to do so.
> 
> I mean, either the old kernel needs to transfer information about
> "forbidden" memory areas to the new kernel or the new kernel needs to
> query these somehow (probably only if is receives a "do it" flag from
> the old kernel).

One idea is to notify the host like "I'll reuse any page again". But
doing that via virtio while your dying isn't always possible. So the new
kernel would have to do it - but then virtio-balloon would have to be up
and running extremely early during boot, before any possibly-inflated
page gets touched - also a head scratcher. Then, what if your new kernel
doesn't support virtio-balloon ... not easy.

[...]

> But that's just really ugly - realistically the virtio-balloon
> protocol will need to be changed in such case.

Yes, and there were RFCs already.

https://lkml.kernel.org/r/1589276501-16026-1-git-send-email-teawater@gmail.com

[...]

> 
>>>
>>> If the KVM slot limit starts to be a problem in practice then we can
>>> think what can be done about it.
>>> It's always one obstacle less.
>>
>> I'm not a friend of leaving the challenging/fundamental problems to be
>> sported out in the future (e.g., resizing initial boot memory, dealing
>> with fundamental limits - like KVM memory slots or VMA). But I get how
>> it's easier to get something running this way :)
> 
> Constraints can be removed step-by-step, when they actually start tobite.

Not if they are fundamental. Try implementing vfio support for memory
ballooning, you're going to have a hard time.

> 
> It is unrealistic to have a perfect guest resize solution in a single
> patch series upfront, the issue is just too complex.

I disagree, but that's a different discussion. :)

> 
>>>
>>> I see that the same KVM slot limit probably applies also for virtio-mem,
>>> since it uses memory-backend-ram as its backing memory device, too,
>>> right?
>>
>> Yes, one memory backend per virtio-mem device. You usually have one
>> device per NUMA node.
> 
> So if you want to dynamically manage most of the guest memory these
> virtio-mem devices + their backends will be very large
> (circa 1/4 guest size each for a 4-node machine).

Right, or even bigger, depending on the setup.

> 
> That means in practice they won't ever be able to be hot-removed before
> the VM is rebooted since there will very likely be at least single stuck
> page in each of these backing devices preventing their removal.
> (If hot-removal support is ever enabled for virtio-mem, it looks like it
> is not possible yet even on a VM reboot).

Yeah, hot-removing a virtio-mem device is not one of the important use
cases (it's completely blocked). If you want to unplug memory, adjust
the requested size.

There are plans to support it in the future (for example during reboot),
but I barely see a need for it currently (especially once we support
resizeable memory backends upstream).

> 
> And I can see that removing a single RAM block in virio-mem is done 
> by discarding it via MADV_DONTNEED, just like in ballooning.
> Only the minimum block size is 2 MB and not 4 KB so all consecutive
> 512 pages in a block will need to be free in order to discard it.

Right, that was a decision to avoid issues known from base-page-size
based ballooning (like fragmenting guest memory, big tracking bitmaps,
incompatibility with vfio, breaking THP and degrading performance,
incompatibility with hugetlbfs ...)

[...]

> 
> During a reboot, virtual DIMM config optimization can be used for now,
> while the best, long-term, solution would be to actually do what the
> Hyper-V hypervisor does in this case: resize the boot memory to match
> the target guest size.
> 
> This way the whole issue of the guest seeing only the boot memory part,
> not the dynamic part, during its boot will no longer be there.
> 

Yeah, I had the same thought back when designing virtio-mem (and looking
into similar handling), but decided that it's impossible to get right -
at least in NUMA setups (and regarding migration). But I can see that
Hyper-V Dynamic Memory doesn't care too much about NUMA at all (and
NUMA-aware ballooning has its own set of issues).

[...]

> 
> So the virtio-mem trade-off is between the size of the boot memory and
> the dynamically managed part(s).
> And also the block size, as as far I can see, a single stuck page in
> a block will prevent it from being discarded.

Yes. It's really something in-between memory ballooning and DIMM-based
memory hot(un)plug. The block size will be comparatively large in some
setups (esp., with vfio). You're definitely not able to squeeze out the
page of your guest - we have virtio-balloon for that if one really wants
to do that - not the target use case of virtio-mem.

> 
> Of course, we are talking about Linux guests here - Windows guest
> will see just the boot memory part.

Yes, until we have support for it.
[...]

> Even if we switched virtio-balloon to bigger allocations and made the
> protocol return page ranges the allocation is still done by simply
> using an ordinary alloc_pages()-equivalent API.
> I don't see any exported Windows kernel API for allocating balloon
> memory.
> 
> The same goes for adding new RAM.
> 
> The above alone means that supporting virtio-mem semantics on current
> Windows versions is likely not possible.

All I can say is, that there are (unofficial?) APIs :) (e.g., the ones
used by DM). But yeah, that's what you get with closed-source operating
systems - and personally, I think, it shouldn't be us that have to suffer.

> 
>>>
>>> People are running Windows guests using QEMU, too.
>>>
>>> That's why there are dozen or so Hyper-V enlightenments implemented,
>>> even though they duplicate KVM PV stuff or that there is kvmvapic
>>> with its Windows guest live-patching.
>>
>> IIRC the Hyper-V enlightenment stuff is properly publicly documented -
> 
> They are only documented from the guest perspective - basically what
> the guest of a Hyper-V hypervisor can possibly use.
> 
> There is nothing in the Hyper-V TLFS which of the functionality it
> documents is supported or required by any Windows version or how
> Windows guests actually make use of these features.
> 
> Not to mention that the documented interface could say the guest can
> expect values A or B or C for parameter X, which is technically true, 
> however the actual Hyper-V hypervisor always uses A and that's what
> Windows will expect.
>  

Interesting, thanks.

>> whereby last time I checked, the hv-balloon is completely undocumented
>> and has to be reverse engineered from the Linux implementation. Please
>> correct me if I'm wrong - I am not able to spot references in your cover
>> letter as well - I'd be interested into that!
> 
> The DM protocol is rather straightforward - the Linux driver contains
> well-commented definitions of its messages.
> 
> For a hot add the host simply provides the start page frame number and
> the count of pages to add and in response receives the number of pages
> the guest was actually able to hot add.
> 
> For a balloon request the host provides a count of pages it wants the
> guest to free and the guest responds with page ranges it has managed
> to release.
> The reverse happens for an unballoon request.
> 
> The protocol consists of just a few simple messages, well described
> in the Linux driver.
> 
> The VMBus part of the protocol works in the same way as in other VMBus
> devices.
> 

Yeah, but then there are things like

https://lkml.kernel.org/r/20200107130950.2983-1-Tianyu.Lan@microsoft.com

that left me clueless - it seems like we're missing some things, maybe
there is more (I am pretty sure there is more ... :) )? (I do some work
on the Linux hv_balloon driver every now of then when working on
optimizing the other balloon drivers / virtio-mem).

>>>
>>> Not to mention many, many devices like e1000 or VMware vmxnet3 even
>>> though virtio-net exists or PIIX IDE even though virtio-{blk,scsi} exist.
>>> Or the applesmc driver, which is cleanly designed to help run just
>>> one proprietary OS.
>>
>> IIRC we need the devices either to bootstrap - e.g., use e1000 until we
>> can install virtio-net once the guest is up and running, or to support
>> older, unmodified guests. I'd like to stress that what you are proposing
>> is different in that sense. Your Windows VM will work just fine without
>> a hv-balloon device.
> 
> There are also "accelerator" devices like kvmvapic or proprietary devices
> where an older open standard exists, like sii3112 SATA, even though
> IDE / AHCI can be used to bootstrap the guest.
> The sii3112 driver was only added in 2017, although the hardware that
> it emulates comes from early 21st century.
> 
>> Again, just my personal opinion, I don't make any decisions around here :)
>>
> 
> Thanks for taking the time to provide your feedback and insight,

I'll try to give your series a look. I can definitely say that

1) I dislike that an external entity has to do vDIMM adaptions /
ballooning adaptions when rebooting or when wanting to resize a guest.

2) I am not sure ignoring the kvm memory slot limit is a good idea. (or
the fundamental issue of resizing boot memory - ever)

Once you have the current approach upstream (vDIMMs, ballooning), there
is no easy way to change that later (requires deprecating, etc.).

But we talked about that already.

-- 
Thanks,

David / dhildenb


