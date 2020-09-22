Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B7AC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAECB21548
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J22W6XFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAECB21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKchv-0003BW-NS
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKchK-0002m0-J9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKchI-0007zU-Hk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600759603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rwYq/UD6nzwuZq6eAGOQ1jrWjxJFgkGl4KnTrFKERz8=;
 b=J22W6XFrLlqdFa010zkadaJNQYDy0/4PjE3c4PJbYya4dlwej/rbTiB2Vch7Rs7p4mm48X
 wnHkga2JRGY3r2NJ8d6jqeWEr4sXC9zhlqhECspfKljUPlPfp6TG5qG18rARPj6Yijul2t
 2w39vWuS9rmAfNiKdMblzW9a8BReSFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-URiIADCFNLi9pG9oB4_bgQ-1; Tue, 22 Sep 2020 03:26:41 -0400
X-MC-Unique: URiIADCFNLi9pG9oB4_bgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA4F6801AE3;
 Tue, 22 Sep 2020 07:26:39 +0000 (UTC)
Received: from [10.36.113.20] (ovpn-113-20.ams2.redhat.com [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC5D35DA30;
 Tue, 22 Sep 2020 07:26:34 +0000 (UTC)
Subject: Re: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
 <c51f9ebd-5303-9919-1469-c99ff6a461b1@redhat.com>
 <d9032b0f-80e2-2eca-637d-251eb1f8f001@maciej.szmigiero.name>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <4787eb88-a663-5f9a-ea44-d0a884907e12@redhat.com>
Date: Tue, 22 Sep 2020 09:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d9032b0f-80e2-2eca-637d-251eb1f8f001@maciej.szmigiero.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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

On 22.09.20 00:22, Maciej S. Szmigiero wrote:
> Hi David,
> 
> Thank you for your comments.
> 
> First, I want to underline that this driver targets Windows guests,
> where ability to modify and adapt the guest memory management
> code is extremely limited.

Yeah, I know the pain.

[...]

> 
> The idea is to use virtual DIMM sticks for hot-adding extra memory at
> runtime, while using ballooning for runtime adjustment of the guest
> memory size within the current maximum.
> 
> When the guest is rebooted the virtual DIMMs configuration is adjusted
> by the software controlling QEMU (some are removed and / or some are
> added) to give the guest the same effective memory size as it had before
> the reboot.

Okay, so while "the ACPI DIMM slot limit does not apply", the KVM memory
slot limit (currently) applies, resulting in exactly the same behavior.

The only (conceptual difference) I am able to spot is then a
notification to the user on reboot, so the guest memory layout can be
adjusted (which I consider very ugly, but it's the same thing when
mixing ballooning and DIMMs - which is why it's usually never done).

[...]

> 
> So, yes, it will be a problem if the user expands their running guest
> ~256 times, each time making it even bigger than previously, without
> rebooting it even once, but this does seem to be an edge use case.

IIRC, that's exactly what dynamic memory under Windows does in automatic
mode, no? Monitor the guests, distribute memory accordingly - usually in
smaller steps. But I am no expert on Hyper-V.

> 
> In the future it would be better to automatically turn the current
> effective guest size into its boot memory size when the VM restarts
> (the VM will then have no virtual DIMMs inserted after a reboot), but
> doing this requires quite a few changes to QEMU, that's why it isn't
> there yet.

Will most probably never happen as reshuffling the layout of your boot
memory (especially with NUMA) within QEMU can break live migration in
various ways.

If you already notify the user on a reboot, the user can just kill the
VM and start it with an adjusted boot memory size. Yeah, that's ugly,
but so is the whole "adjust DIMM/balloon configuration during a reboot
from outside QEMU".

BTW, how would you handle: Start guest with 10G. Inflate balloon to 5G.
Reboot. There are no virtual DIMMs to adjust.

> 
> The above is basically how Hyper-V hypervisor handles its memory size
> changes and it seems to be as close to having a transparently resizable
> guest as reasonably possible.

"having a transparently resizable _Windows_ guests right now" :)

> 
> 
>> Or avoid VMA limits when wanting to grow a VM big in very tiny steps over
>> time (e.g., adding 64MB at a time).
> 
> Not sure if you are taking about VMA limits inside the host or the guest.

Host. one virtual DIMM corresponds to one VMA. But the KVM memory limit
already applies before that, so it doesn't matter.

[...]

>> I assume these numbers apply with Windows guests only. IIRC Linux
>> hv_balloon does not support page migration/compaction, while
>> virtio-balloon does. So you might end up with quite some fragmented
>> memory with hv_balloon in Linux guests - of course, usually only in
>> corner cases.
> 
> As I previously mentioned, this driver targets mainly Windows guests.

... and you cannot enforce that people will only use it with Windows
guests :)

[...]

> Windows will generally leave some memory free when processing balloon
> requests, although the precise amount varies between few hundred MB to
> values like 1+ GB.
> 
> Usually it runs stable even with these few hundred MBs of free memory
> remaining but I have seen occasional crashes at shutdown time in this
> case (probably something critical failing to initialize due to the
> system running out of memory).
> 
> While the above command was just a quick example, I personally think
> it is the guest who should be enforcing a balloon floor since it is
> the guest that knows its internal memory requirements, not the host.

Even the guest has no idea about the (future) working set size. That's a
known problem.

There are always cases where the calculation is wrong, and if the
monitoring process isn't fast enough to react and adjust the guest size,
your things will end up baldy in your guest. Just as the reboot case you
mentioned, where the VM crashes.

[...]

>>>
>>> Future directions:
>>> * Allow sharing the ballooning QEMU interface between hv-balloon and
>>>   virtio-balloon drivers.
>>>   Currently, only one of them can be added to the VM at the same time.
>>
>> Yeah, that makes sense. Only one at a time.
> 
> Having only one *active* at a time makes sense, however it ultimately
> would be nice to be able to have them both inserted into a VM:
> one for Windows guests and one for Linux ones.
> Even though only one obviously would be active at the same time.

I don't think that's the right way forward - that should be configured
when the VM is started.

Personal opinion: I can understand the motivation to implement
hypervisor-specific devices to better support closed-source operating
systems. But I doubt we want to introduce+support ten different
proprietary devices based on proprietary standards doing roughly the
same thing just because closed-source operating systems are too lazy to
support open standards properly.

-- 
Thanks,

David / dhildenb


