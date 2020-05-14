Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9AEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE5520657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+1y4xEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE5520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFgV-0005BR-66
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZFex-0002eT-2o
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:20:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44167
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZFew-0003IS-6z
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589469628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDIXc0CCE1Ocf+J9K9gV4w4fLq+QlPigwwJGeIWaaAY=;
 b=X+1y4xEpu6EeDWneWoTsUdQbqXBTaSrNhDI2KvyE5w6ZyQ1sBovt+k8HNtBy0t+R+2AMHq
 bexmx25YEhHnnjxZ8A9VNNDs1zB/osJubz2Ijx38XEJEYDPxhxVflbfduEiUGmudTB4+jC
 X45RPNp/figDOYSv56g760xlgGGStZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-UzWEHQOMOOyvDGc9Ipfffw-1; Thu, 14 May 2020 11:20:27 -0400
X-MC-Unique: UzWEHQOMOOyvDGc9Ipfffw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0871319057A1;
 Thu, 14 May 2020 15:20:26 +0000 (UTC)
Received: from gondolin (unknown [10.40.192.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB9BB5D9E8;
 Thu, 14 May 2020 15:20:24 +0000 (UTC)
Date: Thu, 14 May 2020 17:20:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jared Rossi <jrossi@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] vfio-ccw: allow non-prefetch ORBs
Message-ID: <20200514172021.5a66bc56.cohuck@redhat.com>
In-Reply-To: <20200512181535.18630-2-jrossi@linux.ibm.com>
References: <20200512181535.18630-1-jrossi@linux.ibm.com>
 <20200512181535.18630-2-jrossi@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 14:15:35 -0400
Jared Rossi <jrossi@linux.ibm.com> wrote:

> Remove the explicit prefetch check when using vfio-ccw devices.
> This check does not trigger in practice as all Linux channel programs
> are intended to use prefetch.
> 
> It is no longer required to force the PFCH flag when using vfio-ccw
> devices.

That's not quite true: Only kernels that include the currently-queued
patch do not require it. Maybe

"Newer Linux kernel versions do not require to force the PFCH flag with
vfio-ccw devices anymore."

?

> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/vfio/ccw.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 50cc2ec75c..e649377b68 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -74,16 +74,9 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>      struct ccw_io_region *region = vcdev->io_region;
>      int ret;
>  
> -    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
> -        if (!(vcdev->force_orb_pfch)) {
> -            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
> -            sch_gen_unit_exception(sch);
> -            css_inject_io_interrupt(sch);
> -            return IOINST_CC_EXPECTED;
> -        } else {
> -            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> -            warn_once_pfch(vcdev, sch, "PFCH flag forced");
> -        }
> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH) && vcdev->force_orb_pfch) {
> +        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> +        warn_once_pfch(vcdev, sch, "PFCH flag forced");
>      }
>  
>      QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));

Let me spell out what happens:
- PFCH bit set -> no change
- PFCH bit not set, but force_orb_pfch set -> no change
- neither PFCH bit nor force_orb_pfch set:
  - older kernels: QEMU makes the request, the kernel rejects it, guest
    gets a unit exception (same result for the guest as before, only a
    different code flow)
  - newer kernels: QEMU makes the request, the kernel forwards the
    request (logging a rate-limited warning); the result depends on
    whether the guest actually tries to rewrite the channel program or
    not

I think that is what we want, and I think I'll queue this patch with
the tweaked commit message, but I'd like a second opinion.

(We should also deprecate force_orb_pfch in the future.)


