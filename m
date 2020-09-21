Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9968C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BBE20773
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZReOK4/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BBE20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHrx-00059E-1V
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKHqV-0004Iw-4h
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:10:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKHqS-0007a8-5X
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600679446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BaOOIEf2agpARzSo1qTzBXP2bMM63HOdRfG69yv1QR4=;
 b=ZReOK4/cnyXnWun3VKF+IQkejCe3c3wPzwTPHwQApvs5W6XZMAcaCWGHAVMMoScgjd0j6k
 Sb9nLVhRrHebsollYxcV4XCxrk81Ux58hUQuDc7KuI7WBUiaJleZp04xvewSYVvsavorVz
 yHxguJ+L7KKsK36eSVQ26YV6sMSlwi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-sBBJBvaaNKK-I7ROkbUBDQ-1; Mon, 21 Sep 2020 05:10:42 -0400
X-MC-Unique: sBBJBvaaNKK-I7ROkbUBDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA40802B70;
 Mon, 21 Sep 2020 09:10:41 +0000 (UTC)
Received: from [10.36.115.48] (ovpn-115-48.ams2.redhat.com [10.36.115.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09E3B68D5F;
 Mon, 21 Sep 2020 09:10:29 +0000 (UTC)
Subject: Re: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <c51f9ebd-5303-9919-1469-c99ff6a461b1@redhat.com>
Date: Mon, 21 Sep 2020 11:10:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1600556526.git.maciej.szmigiero@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.09.20 15:25, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This series adds a Hyper-V Dynamic Memory Protocol driver (hv-balloon)
> and its protocol definitions.
> Also included is a driver providing backing devices for memory hot-add
> protocols ("haprots").
> 
> A haprot device works like a virtual DIMM stick: it allows inserting
> extra RAM into the guest at run time.
> 
> The main differences from the ACPI-based PC DIMM hotplug are:
> * Notifying the guest about the new memory range is not done via ACPI but
> via a protocol handler that registers with the haprot framework.
> This means that the ACPI DIMM slot limit does not apply.
> 
> * A protocol handler can prevent removal of a haprot device when it is
> still in use by setting its "busy" field.
> 
> * A protocol handler can also register an "unplug" callback so it gets
> notified when an user decides to remove the haprot device.
> This way the protocol handler can inform the guest about this fact and / or
> do its own cleanup.
> 
> The hv-balloon driver is like virtio-balloon on steroids: it allows both
> changing the guest memory allocation via ballooning and inserting extra
> RAM into it by adding haprot virtual DIMM sticks.
> One of advantages of these over ACPI-based PC DIMM hotplug is that such
> memory can be hotplugged in much smaller granularity because the ACPI DIMM
> slot limit does not apply.

Reading further below, it's essentially DIMM-based memory hotplug +
virtio-balloon - except the 256MB DIMM limit. But reading below, I don't
see how you want to avoid the KVM memory slot limit that's in a similar
size (I recall 256*2 due to 2 address spaces). Or avoid VMA limits when
wanting to grow a VM big in very tiny steps over time (e.g., adding 64MB
at a time).

> 
> In contrast with ACPI DIMM hotplug where one can only request to unplug a
> whole DIMM stick this driver allows removing memory from guest in single
> page (4k) units via ballooning.
> Then, once the guest has released the whole memory backed by a haprot
> virtual DIMM stick such device is marked "unused" and can be removed from
> the VM, if one wants so.
> A "HV_BALLOON_HAPROT_UNUSED" QMP event is emitted in this case so the
> software controlling QEMU knows that this operation is now possible.
> 
> The haprot devices are also marked unused after a VM reboot (with a
> corresponding "HV_BALLOON_HAPROT_UNUSED" QMP event).
> They are automatically reinserted (if still present) after the guest
> reconnects to this protocol (a "HV_BALLOON_HAPROT_INUSE" QMP event is then
> emitted).
> 
> For performance reasons, the guest-released memory is tracked in few range
> trees, as a series of (start, count) ranges.
> Each time a new page range is inserted into such tree its neighbors are
> checked as candidates for possible merging with it.
> 
> Besides performance reasons, the Dynamic Memory protocol itself uses page
> ranges as the data structure in its messages, so relevant pages need to be
> merged into such ranges anyway.
> 
> One has to be careful when tracking the guest-released pages, since the
> guest can maliciously report returning pages outside its current address
> space, which later clash with the address range of newly added memory.
> Similarly, the guest can report freeing the same page twice.
> 
> The above design results in much better ballooning performance than when
> using virtio-balloon with the same guest: 230 GB / minute with this driver
> versus 70 GB / minute with virtio-balloon.

I assume these numbers apply with Windows guests only. IIRC Linux
hv_balloon does not support page migration/compaction, while
virtio-balloon does. So you might end up with quite some fragmented
memory with hv_balloon in Linux guests - of course, usually only in
corner cases.

> 
> During a ballooning operation most of time is spent waiting for the guest
> to come up with newly freed page ranges, processing the received ranges on
> the host side (in QEMU / KVM) is nearly instantaneous.
> 
> The unballoon operation is also pretty much instantaneous:
> thanks to the merging of the ballooned out page ranges 200 GB of memory can
> be returned to the guest in about 1 second.
> With virtio-balloon this operation takes about 2.5 minutes.
> 
> These tests were done against a Windows Server 2019 guest running on a
> Xeon E5-2699, after dirtying the whole memory inside guest before each
> balloon operation.
> 
> Using a range tree instead of a bitmap to track the removed memory also
> means that the solution scales well with the guest size: even a 1 TB range
> takes just few bytes of memory.
> Example usage:
> * Add "-device vmbus-bridge,id=vmbus-bridge -device hv-balloon,id=hvb"
>   to the QEMU command line and set "maxmem" value to something large,
>   like 1T.
> 
> * Use QEMU monitor commands to add a haprot virtual DIMM stick, together
>   with its memory backend:
>   object_add memory-backend-ram,id=mem1,size=200G
>   device_add mem-haprot,id=ha1,memdev=mem1
>   The first command is actually the same as for ACPI-based DIMM hotplug.
> 
> * Use the ballooning interface monitor commands to force the guest to give
>   out as much memory as possible:
>   balloon 1

At least under virtio-balloon with Linux, that will pretty sure trigger
a guest crash. Is something like that expected to work with Windows
guests reasonably well?


>   The ballooning interface monitor commands can also be used to resize
>   the guest up and down appropriately.
> 
> * One can check the current guest size by issuing a "info balloon" command.
>   This is useful to know what is happening, since large ballooning or
>   unballooning operations take some time to complete.

So, every time you want to add more memory (after the balloon was
deflated) to a guest, you have to plug a new mem-haprot device, correct?

So your QEMU user has to be well aware of how to balance "balloon" and
"object_add/device_add/object_del_device_del" commands to achieve the
desired guest size.

> 
> * Once the guest releases the whole memory backed by a haprot device
>   (or is restarted) a "HV_BALLOON_HAPROT_UNUSED" QMP event will be
>   generated.
>   The haprot device then can be removed, together with its memory backend:
>   device_del ha1
>   object_del mem1

So, you rely on some external entity to properly shrink a guest again
(e.g., during reboot).

> 
> Future directions:
> * Allow sharing the ballooning QEMU interface between hv-balloon and
>   virtio-balloon drivers.
>   Currently, only one of them can be added to the VM at the same time.

Yeah, that makes sense. Only one at a time.

> 
> * Allow new haport devices to reuse the same address range as the ones
>   that were previously deleted via device_del monitor command without
>   having to restart the VM.
> 
> * Add vmstate / live migration support to the hv-balloon driver.
> 
> * Use haprot device to also add memory via virtio interface (this requires
>   defining a new operation in virtio-balloon protocol and appropriate
>   support from the client virtio-balloon driver in the Linux kernel).

Most probably not the direction we are going to take. We have virtio-mem
for clean, fine-grained, NUMA-aware, paravirtualized memory hot(un)plug
now, and we are well aware of various issues with (base-page size based)
memory ballooning that are fairly impossible to solve (especially in the
context of vfio).

-- 
Thanks,

David / dhildenb


