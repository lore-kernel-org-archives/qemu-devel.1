Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE70C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCF220872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCF220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2oi-0005gp-Ap
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pagupta@redhat.com>) id 1iD2nw-0005Cv-TL
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1iD2nv-0002o4-Lq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1iD2nv-0002ns-GF
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:37:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 94FED308AA12;
 Wed, 25 Sep 2019 08:37:42 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BB1160872;
 Wed, 25 Sep 2019 08:37:42 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 774AD1808876;
 Wed, 25 Sep 2019 08:37:42 +0000 (UTC)
Date: Wed, 25 Sep 2019 04:37:42 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <1911476948.2948619.1569400662114.JavaMail.zimbra@redhat.com>
In-Reply-To: <3162a686-90c8-9ace-0258-37464390ca45@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com> <87h850ssnb.fsf@redhat.com>
 <3162a686-90c8-9ace-0258-37464390ca45@redhat.com>
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.223, 10.4.195.3]
Thread-Topic: Introduce the microvm machine type
Thread-Index: REiSp/FSnA9gx3Er3v5VaYMdGNUqFQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 25 Sep 2019 08:37:42 +0000 (UTC)
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 philmd@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, kvm@vger.kernel.org, imammedo@redhat.com,
 pbonzini@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> >>> Microvm is a machine type inspired by both NEMU and Firecracker, and
> >>> constructed after the machine model implemented by the latter.
> >>>
> >>> It's main purpose is providing users a minimalist machine type free
> >>> from the burden of legacy compatibility, serving as a stepping stone
> >>> for future projects aiming at improving boot times, reducing the
> >>> attack surface and slimming down QEMU's footprint.
> >>>
> >>> The microvm machine type supports the following devices:
> >>>
> >>>  - ISA bus
> >>>  - i8259 PIC
> >>>  - LAPIC (implicit if using KVM)
> >>>  - IOAPIC (defaults to kernel_irqchip_split = true)
> >>>  - i8254 PIT
> >>>  - MC146818 RTC (optional)
> >>>  - kvmclock (if using KVM)
> >>>  - fw_cfg
> >>>  - One ISA serial port (optional)
> >>>  - Up to eight virtio-mmio devices (configured by the user)
> >>
> >> So I assume also no ACPI (CPU/memory hotplug), correct?
> > 
> > Correct.
> > 
> >> @Pankaj, I think it would make sense to make virtio-pmem play with
> >> virtio-mmio/microvm.
> > 
> > That would be great. I'm also looking forward for virtio-mem (and an
> > hypothetical virtio-cpu) to eventually gain hotplug capabilities in
> > microvm.
> 
> @Pankaj, do you have time to look into the virtio-pmem thingy? I guess
> the virtio-mmio rapper shouldn't be too hard (very similar to the
> virtio-pci wrapper - luckily I insisted to make it work independently
> from PCI BARs and ACPI slots ;) ). The microvm bits would be properly
> setting up device memory and wiring up the hotplug handlers, similar as
> done in the other PC machine types (maybe that comes for free?).

Yes, I can look at.

> 
> virtio-pmem will allow (in read-only mode) to place the rootfs on a fake
> NVDIMM, as done e.g., in kata containers. We might have to include the
> virtio-pmem kernel module in the initramfs, shouldn't  be too hard. Not
> sure what else we'll need to make virtio-pmem get used as a rootfs.

Sure, will work on it.

Thanks,
Pankaj

> 
> > 
> > Thanks,
> > Sergio.
> > 
> 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
> 

