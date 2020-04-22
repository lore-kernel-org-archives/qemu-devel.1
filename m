Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1BFC55186
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E022073A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmrmCLbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E022073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRCo7-0006So-G0
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jRCmQ-0005q1-G0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jRCmP-0008Ph-Sh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:38:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29473
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jRCmP-0008A5-Dt
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587551936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDXb4yHTWnQGnfBsN9zMjdWJafh6Lew+W/jiTsIy16M=;
 b=RmrmCLbfUSoySSB5QMFbdd1sZONEngmolvTuWybw+d6KuS/OpR4YEoW44ucaApdC4bm4Wp
 7bgdJXGHFO3YVJ5V5JD1HkCb0y1ePDlZrOzKBV8VJ1iqNaddt9mxYf47sX6RyB/JdxG5+a
 XIKvBxWE89xTX+LzQrMfDzgDdJ33Y5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-tfzo9bVtOwGd5vWMVNb5iw-1; Wed, 22 Apr 2020 06:38:52 -0400
X-MC-Unique: tfzo9bVtOwGd5vWMVNb5iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5BF81B18BC9;
 Wed, 22 Apr 2020 10:38:50 +0000 (UTC)
Received: from gondolin (ovpn-112-195.ams2.redhat.com [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A29A5DA87;
 Wed, 22 Apr 2020 10:38:48 +0000 (UTC)
Date: Wed, 22 Apr 2020 12:38:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] vfio-ccw: Add support for the CRW irq
Message-ID: <20200422123846.1ff58298.cohuck@redhat.com>
In-Reply-To: <20200417023440.70514-8-farman@linux.ibm.com>
References: <20200417023440.70514-1-farman@linux.ibm.com>
 <20200417023440.70514-8-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 04:34:40 +0200
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
>     v2->v3:
>      - Remove "size==0" check in CRW notifier [CH]
>      - Remove intermediate rsc/erc variables, use css_queue_crw_cont() [CH]
>      - s/crw0/crw/ [CH]
>     
>     v1->v2:
>      - Add a loop to continually read region while data is
>        present, queueing CRWs as found [CH]
>     
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
>  hw/vfio/ccw.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
(...)
> @@ -264,6 +265,39 @@ static void vfio_ccw_reset(DeviceState *dev)
>      ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
>  }
>  
> +static void vfio_ccw_crw_notifier_handler(void *opaque)
> +{
> +    VFIOCCWDevice *vcdev = opaque;
> +    struct ccw_crw_region *region = vcdev->crw_region;
> +    CRW crw;
> +    int size;
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
> +            error_report("vfio-ccw: Read crw region failed with errno=%d",
> +                         errno);
> +            break;
> +        }
> +
> +        if (region->crw == 0) {
> +            /* No more CRWs to queue */
> +            break;
> +        }
> +
> +        memcpy(&crw, &region->crw, sizeof(CRW));
> +
> +        css_queue_crw_cont(crw);
> +    } while (1);

Do you want to clear the notifier again at the end? If the kernel had
queued more crws, it would have made the notifier pending again.

> +}
> +
>  static void vfio_ccw_io_notifier_handler(void *opaque)
>  {
>      VFIOCCWDevice *vcdev = opaque;
(...)

Else looks good to me.


