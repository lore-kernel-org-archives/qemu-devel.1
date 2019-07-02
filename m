Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402AC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28B92054F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtlNzjSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28B92054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGBw-0002oW-6E
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49552)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiGAm-0001oE-PP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiGAl-00048f-O4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:38:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiGAl-00047x-HD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:38:03 -0400
Received: by mail-oi1-x242.google.com with SMTP id u15so12500504oiv.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Zfi5EpYlBZL5im6wvgycqk/6T+h9Vx8MvpZvIdL+As=;
 b=jtlNzjSzJxMNqqgH5q6o1yna7i/9ZSNFNMoxBWyQSXASQS6aW3NA5IbibHfqxndiVH
 dZXgUr4YtbePchSi02fG5Qd/IoC8nnUKB8czD9RjaltUTBuhSdbjiOAmb3NfmGNQ/loM
 26lUqZ/hBUZzih7tnGQSVq0NKi9Zc/IhWfXv/cQBMIVXkCqQSn9CIXlHJCDPgM4f494e
 lZagsa0u0D9szoFz0BQJz6xm94RFsFPoyb+R0QsLmUSzk3IWinbyzBZWG7+oxLVRWOBr
 EW3CYwBcQL+j62KpOM1XaMW5OualNkJoCX5VW1s/0c6ua8mtfmPXIRjq0qmlrCEObuy+
 ZBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Zfi5EpYlBZL5im6wvgycqk/6T+h9Vx8MvpZvIdL+As=;
 b=kfLgudp0nttDUQVzMDll/icolbDtq1voF4MIO6d5cO1QlNuKcsI3YQPMPcNNoxQb+E
 RMHRfJcQ29D5SGu7zCC1zQBagFdNzj1mnGtBBhgPV82OLqhMhWEUgIc6DT/O/PxHPfEC
 BIbzfs03aDgRuQC/9GSDFmSQ4aQ3eIMg+CL5xnrngsNAIBaxNfYAK1qF1DaZUTeDwbKp
 juW+aA0fYebLwsws/QUVFM3vbvoB2cUvfUZYxgzTvAc+R5oNMtLs+ExZiKFKZu+SmADe
 IYlLXcmKruPXsuhd73ZGO5QoHO/WnoyRO70YMuDAy4Ick3OSnd+ZCaqFKE8YShBP/+Ts
 ZDcg==
X-Gm-Message-State: APjAAAWjveZCdltvsSIvXHm2FbEIvGOgTheRe8MjgT4kvG6O9ZE1IvVn
 F5LNXeyu1Y1bDP6BFEPz6YUw4lmPjaPEeDb/jlb1HQ==
X-Google-Smtp-Source: APXvYqxv5FVGOs8sfX92NPl/wwCwdKeWb0NuaY40MotSWc6//hgOtyOslUwXa9DVUPz9Utof3NylIyGhPIt+oHTe+V0=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr2621659oic.170.1562063882578; 
 Tue, 02 Jul 2019 03:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <156046151566.26543.17274661862206856605.stgit@gimli.home>
 <156046164094.26543.10016703921328261988.stgit@gimli.home>
In-Reply-To: <156046164094.26543.10016703921328261988.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 11:37:51 +0100
Message-ID: <CAFEAcA_nGMfUYpSiaw7xhRjacZQhY1U780ehA0UR0StyBwammg@mail.gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 3/3] vfio/common: Introduce
 vfio_set_irq_signaling helper
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
Cc: Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Jun 2019 at 22:51, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> The code used to assign an interrupt index/subindex to an
> eventfd is duplicated many times. Let's introduce an helper that
> allows to set/unset the signaling for an ACTION_TRIGGER,
> ACTION_MASK or ACTION_UNMASK action.
>
> In the error message, we now use errno in case of any
> VFIO_DEVICE_SET_IRQS ioctl failure.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Hi; coverity reports (CID 1402196) a possible unchecked return value
in this code:


> @@ -592,26 +550,10 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>       * be re-asserted on unmask.  Nothing to do if already using QEMU mode.
>       */
>      if (vector->virq >= 0) {
> -        int argsz;
> -        struct vfio_irq_set *irq_set;
> -        int32_t *pfd;
> -
> -        argsz = sizeof(*irq_set) + sizeof(*pfd);
> -
> -        irq_set = g_malloc0(argsz);
> -        irq_set->argsz = argsz;
> -        irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> -                         VFIO_IRQ_SET_ACTION_TRIGGER;
> -        irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
> -        irq_set->start = nr;
> -        irq_set->count = 1;
> -        pfd = (int32_t *)&irq_set->data;
> +        int32_t fd = event_notifier_get_fd(&vector->interrupt);
>
> -        *pfd = event_notifier_get_fd(&vector->interrupt);
> -
> -        ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> -
> -        g_free(irq_set);
> +        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, NULL);

In vfp_msix_vector_release() we call vfio_set_irq_signaling(),
but we don't check the returned error value, whereas in the other
7 places we call the function we do check. Is there some missing
error handling here ?

thanks
-- PMM

