Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FBAC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8B120679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8B120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxD8T-0000B1-Rr
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hxD86-00087e-5X
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hxD85-0000eZ-0A
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:25:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hxD84-0000eF-Nk
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B64193172D8F;
 Mon, 12 Aug 2019 16:25:03 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B6E736FB;
 Mon, 12 Aug 2019 16:24:54 +0000 (UTC)
Date: Mon, 12 Aug 2019 10:24:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190812102453.3c05ab43@x1.home>
In-Reply-To: <20190812074531.28970-1-peterx@redhat.com>
References: <20190812074531.28970-1-peterx@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 12 Aug 2019 16:25:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 09:45:27 +0200
Peter Xu <peterx@redhat.com> wrote:

> This is a RFC series.
> 
> The VT-d code has some defects, one of them is that we cannot detect
> the misuse of vIOMMU and vfio-pci early enough.
> 
> For example, logically this is not allowed:
> 
>   -device intel-iommu,caching-mode=off \
>   -device vfio-pci,host=05:00.0

Do we require intel-iommu with intremap=on in order to get x2apic for
large vCPU count guests?  If so, wouldn't it be a valid configuration
for the user to specify:

   -device intel-iommu,caching-mode=off,intremap=on \
   -device vfio-pci,host=05:00.0

so long as they never have any intention of the guest enabling DMA
translation?  Would there be any advantage to this config versus
caching-mode=on?  I suspect the overhead of CM=1 when only using
interrupt remapping is small to non-existent, but are there other
reasons for running with CM=0, perhaps guest drivers not supporting it?

I like the idea of being able to nak an incompatible hot-add rather
than kill the VM, we could narrow that even further to look at not only
whether caching-mode support is enabled, but also whether translation
is enabled on the vIOMMU.  Ideally we might disallow the guest from
enabling translation in such a configuration, but the Linux code is not
written with the expectation that the hardware can refuse to enable
translation and there are no capability bits to remove the DMA
translation capability of the IOMMU.  Still, we might want to think
about which is the better user experience, to have the guest panic when
DMA_GSTS_TES never becomes set (as it seems Linux would do) or to have
QEMU exit, or as proposed here, prevent all configurations where this
might occur.  Thanks,

Alex

> Because the caching mode is required to make vfio-pci devices
> functional.
> 
> Previously we did this sanity check in vtd_iommu_notify_flag_changed()
> as when the memory regions change their attributes.  However that's
> too late in most cases!  Because the memory region layouts will only
> change after IOMMU is enabled, and that's in most cases during the
> guest OS boots.  So when the configuration is wrong, we will only bail
> out during the guest boots rather than simply telling the user before
> QEMU starts.
> 
> The same problem happens on device hotplug, say, when we have this:
> 
>   -device intel-iommu,caching-mode=off
> 
> Then we do something like:
> 
>   (HMP) device_add vfio-pci,host=05:00.0,bus=pcie.1
> 
> If at that time the vIOMMU is enabled in the guest then the QEMU
> process will simply quit directly due to this hotplug event.  This is
> a bit insane...
> 
> This series tries to solve above two problems by introducing two
> sanity checks upon these places separately:
> 
>   - machine done
>   - hotplug device
> 
> This is a bit awkward but I hope this could be better than before.
> There is of course other solutions like hard-code the check into
> vfio-pci but I feel it even more unpretty.  I didn't think out any
> better way to do this, if there is please kindly shout out.
> 
> Please have a look to see whether this would be acceptable, thanks.
> 
> Peter Xu (4):
>   intel_iommu: Sanity check vfio-pci config on machine init done
>   qdev/machine: Introduce hotplug_allowed hook
>   pc/q35: Disallow vfio-pci hotplug without VT-d caching mode
>   intel_iommu: Remove the caching-mode check during flag change
> 
>  hw/core/qdev.c         | 17 +++++++++++++++++
>  hw/i386/intel_iommu.c  | 40 ++++++++++++++++++++++++++++++++++------
>  hw/i386/pc.c           | 21 +++++++++++++++++++++
>  include/hw/boards.h    |  9 +++++++++
>  include/hw/qdev-core.h |  1 +
>  qdev-monitor.c         |  7 +++++++
>  6 files changed, 89 insertions(+), 6 deletions(-)
> 


