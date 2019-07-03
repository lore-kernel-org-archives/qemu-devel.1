Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F04C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601AA2189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601AA2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiagn-0000AA-Cx
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48501)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hiafe-0007tq-0K
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hiafc-0005dF-Vw
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hiafZ-0005RA-Rm; Wed, 03 Jul 2019 04:31:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A52D811DC;
 Wed,  3 Jul 2019 08:31:03 +0000 (UTC)
Received: from [10.36.116.95] (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C594987C4;
 Wed,  3 Jul 2019 08:30:59 +0000 (UTC)
To: Alex Williamson <alex.williamson@redhat.com>, cohuck@redhat.com,
 farman@linux.ibm.com, alifm@linux.ibm.com
References: <156209642116.14915.9598593247782519613.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6ecc4061-ffa6-4190-c2ef-b33bdf49c155@redhat.com>
Date: Wed, 3 Jul 2019 10:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <156209642116.14915.9598593247782519613.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 03 Jul 2019 08:31:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vfio-ccw: Test vfio_set_irq_signaling()
 return value
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On 7/2/19 9:41 PM, Alex Williamson wrote:
> Coverity doesn't like that most callers of vfio_set_irq_signaling() check
> the return value and doesn't understand the equivalence of testing the
> error pointer instead.  Test the return value consistently.
> 
> Reported-by: Coverity (CID 1402783)
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/ccw.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 6d0296fe4d9c..16f200e6fe6a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -327,9 +327,8 @@ static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
>  {
>      Error *err = NULL;
>  
> -    vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> -                           VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err);
> -    if (err) {
> +    if (vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>          error_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
>      }
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>  
> 
> 

