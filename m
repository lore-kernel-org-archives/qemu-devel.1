Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6BFC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 08:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F68020679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 08:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F68020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxSNy-0006cx-B3
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 04:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hxSNb-0006D1-Fr
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 04:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hxSNa-0005rO-DG
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 04:42:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hxSNa-0005qy-5N
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 04:42:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4662C053FDC;
 Tue, 13 Aug 2019 08:42:04 +0000 (UTC)
Received: from [10.72.12.191] (ovpn-12-191.pek2.redhat.com [10.72.12.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A9F382463;
 Tue, 13 Aug 2019 08:41:50 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190812074531.28970-1-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <319f1d6a-ef55-cc1b-98d6-f99b365bd88a@redhat.com>
Date: Tue, 13 Aug 2019 16:41:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812074531.28970-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 13 Aug 2019 08:42:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Bandan Das <bsd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/12 =E4=B8=8B=E5=8D=883:45, Peter Xu wrote:
> This is a RFC series.
>
> The VT-d code has some defects, one of them is that we cannot detect
> the misuse of vIOMMU and vfio-pci early enough.
>
> For example, logically this is not allowed:
>
>    -device intel-iommu,caching-mode=3Doff \
>    -device vfio-pci,host=3D05:00.0
>
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
>    -device intel-iommu,caching-mode=3Doff
>
> Then we do something like:
>
>    (HMP) device_add vfio-pci,host=3D05:00.0,bus=3Dpcie.1
>
> If at that time the vIOMMU is enabled in the guest then the QEMU
> process will simply quit directly due to this hotplug event.  This is
> a bit insane...
>
> This series tries to solve above two problems by introducing two
> sanity checks upon these places separately:
>
>    - machine done
>    - hotplug device
>
> This is a bit awkward but I hope this could be better than before.
> There is of course other solutions like hard-code the check into
> vfio-pci but I feel it even more unpretty.  I didn't think out any
> better way to do this, if there is please kindly shout out.
>
> Please have a look to see whether this would be acceptable, thanks.
>
> Peter Xu (4):
>    intel_iommu: Sanity check vfio-pci config on machine init done
>    qdev/machine: Introduce hotplug_allowed hook
>    pc/q35: Disallow vfio-pci hotplug without VT-d caching mode
>    intel_iommu: Remove the caching-mode check during flag change
>
>   hw/core/qdev.c         | 17 +++++++++++++++++
>   hw/i386/intel_iommu.c  | 40 ++++++++++++++++++++++++++++++++++------
>   hw/i386/pc.c           | 21 +++++++++++++++++++++
>   include/hw/boards.h    |  9 +++++++++
>   include/hw/qdev-core.h |  1 +
>   qdev-monitor.c         |  7 +++++++
>   6 files changed, 89 insertions(+), 6 deletions(-)
>

Do we need a generic solution other than an Intel specific one?

Thanks


