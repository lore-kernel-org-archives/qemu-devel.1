Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0706C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85045206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85045206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBCze-0008Dj-M0
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 03:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iBCys-0007PV-Ej
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iBCyr-0006RM-B8
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:05:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iBCyn-0006LN-Kd; Fri, 20 Sep 2019 03:05:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABE3B86E86F;
 Fri, 20 Sep 2019 07:05:20 +0000 (UTC)
Received: from [10.36.117.220] (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2016D19D7A;
 Fri, 20 Sep 2019 07:05:09 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] Allow memory_region_register_iommu_notifier() to
 fail
To: Peter Xu <peterx@redhat.com>
References: <20190919121845.29520-1-eric.auger@redhat.com>
 <20190920061628.GD12858@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <29a66cfd-b363-9c8a-4bc1-998ae4e3fbea@redhat.com>
Date: Fri, 20 Sep 2019 09:05:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190920061628.GD12858@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 20 Sep 2019 07:05:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 9/20/19 8:16 AM, Peter Xu wrote:
> On Thu, Sep 19, 2019 at 02:18:40PM +0200, Eric Auger wrote:
>> This series allows the memory_region_register_iommu_notifier()
>> to fail. As of now, when a MAP notifier is attempted to be
>> registered along with SMMUv3, Intel iommu without caching mode
>> or AMD IOMMU, we exit in the IOMMU MR notify_flag_changed()
>> callback. In case of VFIO assigned device hotplug, this could be
>> handled more nicely directly within the VFIO code, simply rejecting
>> the hotplug without exiting. This is what the series achieves
>> by handling the memory_region_register_iommu_notifier() returned
>> value.
> 
> Could I ask what's the code path for ARM when the hot plug failed?  Is
> that vfio_realize() then vfio_connect_container() will fail with this?
> 
>     if (container->error) {
>         ret = container->error;
>         error_setg_errno(errp, -ret,
>                          "memory listener initialization failed for container");
>         goto listener_release_exit;
>     }
> 
Yes that path is exercised.

> If so, I would again suggest you to use Error** in patch 1.  IMHO we
> can let vfio_listener_region_add() to be the first one to use the
> Error** so that instead of this:
> 
>     /*
>      * On the initfn path, store the first error in the container so we
>      * can gracefully fail.  Runtime, there's not much we can do other
>      * than throw a hardware error.
>      */
>     if (!container->initialized) {
>         if (!container->error) {
>             container->error = ret;
>         }
>     } else {
>         hw_error("vfio: DMA mapping failed, unable to continue");
>     }

OK. I agree that's better. That's also more code change ;-)

But let's do it!

Thank you for the review!

Best Regards

Eric
> 
> We can also cache the Error** into container and return to user if the
> user is using QMP which should be better than the int number (or
> again, maybe return both errors?).  IIUC error_report() will not work
> for QMP.
> 
> Regards,
> 

