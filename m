Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46657C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1015F24955
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJHdBE5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1015F24955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLUXP-0004bi-6R
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 12:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jLUWi-000452-Ij
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jLUWf-0005Hj-NH
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:23:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58560
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jLUWe-0005GY-D2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586190182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxmaTqODPIaCMShCB30Yg/K0azFQdKGPtHSK4wEs7Ww=;
 b=FJHdBE5CQFlEi9NPDeRmq/ZpoAXuTH72frLDEE5oJwVA+HdBzTyPQfM3CKey9LXPNZHoXw
 ZATdw8gZOAf+qQYvY1ilFEeDnVAij3LRNKpiu1Qzvb5DrtgG+iryy+UKIkT5eTIDeLV4qe
 B540O25sGobE/+DwvMRSngl1U4HR9wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-cNZnx1QyNLq0-qFzEM8gUg-1; Mon, 06 Apr 2020 12:23:00 -0400
X-MC-Unique: cNZnx1QyNLq0-qFzEM8gUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 916FF107ACC9;
 Mon,  6 Apr 2020 16:22:59 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E275DCDBE2;
 Mon,  6 Apr 2020 16:22:57 +0000 (UTC)
Date: Mon, 6 Apr 2020 18:22:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [RFC PATCH v2 7/7] vfio-ccw: Add support for the CRW irq
Message-ID: <20200406182255.129a6798.cohuck@redhat.com>
In-Reply-To: <20200206214509.16434-8-farman@linux.ibm.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
 <20200206214509.16434-8-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  6 Feb 2020 22:45:09 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> The CRW irq will be used by vfio-ccw to notify the userspace
> about any CRWs the userspace needs to handle. Let's add support
> for it.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v1->v2:
>      - Add a loop to continually read region while data is
>        present, queueing CRWs as found [CH]
>     v0->v1: [EF]
>      - Check vcdev->crw_region before registering the irq,
>        in case host kernel does not have matching support
>      - Split the refactoring changes to an earlier (new) patch
>        (and don't remove the "num_irqs" check in the register
>        routine, but adjust it to the check the input variable)
>      - Don't revert the cool vfio_set_irq_signaling() stuff
>      - Unregister CRW IRQ before IO IRQ in unrealize
>      - s/crw1/crw0/
> 
>  hw/vfio/ccw.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 

> @@ -265,6 +266,40 @@ static void vfio_ccw_reset(DeviceState *dev)
>      ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
>  }
>  
> +static void vfio_ccw_crw_notifier_handler(void *opaque)
> +{
> +    VFIOCCWDevice *vcdev = opaque;
> +    struct ccw_crw_region *region = vcdev->crw_region;
> +    CRW crw;
> +    int size;
> +    uint8_t rsc, erc;
> +
> +    if (!event_notifier_test_and_clear(&vcdev->crw_notifier)) {
> +        return;
> +    }
> +
> +    do {
> +        memset(region, 0, sizeof(*region));
> +        size = pread(vcdev->vdev.fd, region, vcdev->crw_region_size,
> +                     vcdev->crw_region_offset);
> +
> +        if (size == -1) {
> +            error_report("vfio-ccw: Read crw region failed with errno=%d", errno);
> +            break;
> +        }
> +
> +        if (size == 0 || region->crw0 == 0) {

Does it make any sense to expect both of them as an indication that
there are no more crws at the moment? Grabbing a zeroed crw makes the
most sense as a stop condition, I think.

Also, I'm not sure anymore whether having space for two crws makes too
much sense. If we have a case in the future where we get two chained
crws, the code will retry anyway and just fetch the chained crw and
queue it, wouldn't it?

> +            /* No more CRWs to queue */
> +            break;
> +        }
> +
> +        memcpy(&crw, &region->crw0, sizeof(CRW));
> +        rsc = (crw.flags & 0x0f00) >> 8;
> +        erc = crw.flags & 0x003f;

I think we already have something for that... ah yes,
CRW_FLAGS_MASK_RSC and CRW_FLAGS_MASK_ERC.

> +        css_queue_crw(rsc, erc, 0, 0, crw.rsid);

...or maybe an alternative interface that allows us to queue a
ready-made crw?

> +    } while (1);
> +}
> +
>  static void vfio_ccw_io_notifier_handler(void *opaque)
>  {
>      VFIOCCWDevice *vcdev = opaque;


