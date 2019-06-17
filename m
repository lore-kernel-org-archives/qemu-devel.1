Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF489C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE6020833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE6020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcoRZ-00049q-Mz
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 06:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hcoQM-0003Gj-Oc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 05:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hcoQL-0004gh-Ot
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 05:59:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hcoQL-0004Pt-Fp; Mon, 17 Jun 2019 05:59:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7025D3086222;
 Mon, 17 Jun 2019 09:59:06 +0000 (UTC)
Received: from gondolin (dhcp-192-192.str.redhat.com [10.33.192.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 322B382282;
 Mon, 17 Jun 2019 09:59:01 +0000 (UTC)
Date: Mon, 17 Jun 2019 11:58:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Message-ID: <20190617115858.3f6c8d6b.cohuck@redhat.com>
In-Reply-To: <e09fb36f-af61-f4bc-e525-ccdc0c08dce3@linux.ibm.com>
References: <20190614092705.11025-1-cohuck@redhat.com>
 <790578fe-9d90-bfa1-a540-f7f054d8293f@linux.ibm.com>
 <5fd0fe9a-9f1e-15f1-b440-e3c505e6f3ea@redhat.com>
 <e09fb36f-af61-f4bc-e525-ccdc0c08dce3@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 17 Jun 2019 09:59:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vfio-ccw: use vfio_set_irq_signaling
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
Cc: Auger Eric <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 11:41:41 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 6/14/19 11:06 AM, Auger Eric wrote:
> > Hi Eric,
> > 
> > On 6/14/19 4:30 PM, Eric Farman wrote:  
> >>
> >>
> >> On 6/14/19 5:27 AM, Cornelia Huck wrote:  
> >>> Use the new helper.
> >>>
> >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >>> ---
> >>>  hw/vfio/ccw.c | 68 +++++++++++----------------------------------------
> >>>  1 file changed, 14 insertions(+), 54 deletions(-)
> >>>
> >>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> >>> index 03a2becb3ec9..3dc08721a3db 100644
> >>> --- a/hw/vfio/ccw.c
> >>> +++ b/hw/vfio/ccw.c
> >>> @@ -197,10 +197,7 @@ read_err:
> >>>  static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
> >>>  {
> >>>      VFIODevice *vdev = &vcdev->vdev;
> >>> -    struct vfio_irq_info *irq_info;
> >>> -    struct vfio_irq_set *irq_set;
> >>> -    size_t argsz;
> >>> -    int32_t *pfd;
> >>> +    int fd;
> >>>  
> >>>      if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
> >>>          error_setg(errp, "vfio: unexpected number of io irqs %u",
> >>> @@ -208,72 +205,35 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
> >>>          return;
> >>>      }
> >>>  
> >>> -    argsz = sizeof(*irq_info);
> >>> -    irq_info = g_malloc0(argsz);
> >>> -    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
> >>> -    irq_info->argsz = argsz;
> >>> -    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> >>> -              irq_info) < 0 || irq_info->count < 1) {
> >>> -        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> >>> -        goto out_free_info;
> >>> -    }
> >>> -  
> >>
> >> Don't we still need this hunk?  (And the out_free_info label stuff that
> >> cleans it up.)  I don't see vfio_set_irq_signaling() covering it.  
> > 
> > Looks this IRQ index is always implemented and exposed by the driver,
> > isn't it? In such a case it shouldn't be needed to test its presence?  
> 
> Right; if we were running on an old kernel, both ioctl's would fail the
> same way since they were added concurrently.  So the check today doesn't
> seem very useful.
> 
> But since it's there, and we're taking it out, it got me wondering
> whether there are/were intentions to expand GET_IRQ_INFO in the future.
> I'm not aware of any reason vfio-ccw would need to, but want some
> confirmation that I'm not overlooking anything.

It seems I actually was a bit too delete-happy... I did not intend to
rip out that code at all, it just somehow was suddenly gone :)

Checking is probably not strictly needed, but let me send a v2 that
does not delete it (and only converts to the new interface).

