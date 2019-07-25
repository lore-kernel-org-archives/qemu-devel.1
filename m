Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEABEC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBF7218D4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbAuAMWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBF7218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqabP-00046k-QB
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48817)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqabE-0003i7-4i
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqabB-0005fs-V2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:03:48 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqab8-0005ej-2y
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:03:44 -0400
Received: by mail-oi1-x242.google.com with SMTP id s184so37251326oie.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XoVcQgNmKGpCGVwT0rUIoIDQw3j06A/LSIoSf8tEGHo=;
 b=YbAuAMWOSuzNgCnuaAxdKygbzl794kPyXHnlRirGobsaKp9fAm9f0nQAxkIkt/OtSI
 KjT0xpawFjKRyjH4jcPX33CXeksoAmVcfvM2M3lrsrBNCU+dH2bJmtppjrlZB6OS0f5/
 6hIarZkumQ4Bgj6ErMyY/Gsv8MdBtjvFae2AGtxeNtEBZKKApJJ8uhS/L1bFbZ3xcaIc
 9OnlkNg2KkGiRW/U3HwVw1vw5158d/kKenIoy7svq1H297WFvIGizvyjG8wA2OcOmNTc
 uhX5pJrAsvvcm+x7/M4Uv021KrQy0hplk7Q5k3MLMrVnEMlSxlf4Ylr5mXwglMcMJbXw
 MD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XoVcQgNmKGpCGVwT0rUIoIDQw3j06A/LSIoSf8tEGHo=;
 b=tZXdqJ39WsLCSA3llUUUJyLrlmQ4vDLRkZXSeR7MW71qvvzoAIJ+g9Po8vaKEtRNfH
 XWlQL69S92qBiqszOKfxInCovAY9GwqGm+ZSRb+28PXvJcFFMVSIE8urZv6tgvBjjTqK
 VvWinlSqgsuHo6yp6a4kh0lx8AIm2e4obmtEGnevGQKuZE6PvMNwOxPm2RyLVbWDiBg6
 axq47IDIdPZNEwuJwhGeDaXOfhO993rTyfUVX6ujbvzFmsLBCaGYJRsbjyaaUIhYU7Di
 Q6VX82TB2chzlt+OIV3WdXmON49C+IiUQtK1B3g8fDrxilehBef5icUYIztmRC0ySXxo
 32Eg==
X-Gm-Message-State: APjAAAVky+vphZdyY0KP5SEA0maCIWuzlkTj6Cm1MEgMvHUQ0sYQxz/o
 2bSR8glgG5qTx31tKpGRz4+99IGDPRe6Drgmkxny0Q==
X-Google-Smtp-Source: APXvYqyNRprYB+wXHj0pISUwC4fwscdDMHjY+uUfLOWL17bfYgeEs5q1LbDZkAdCnc22T4FfT+hDwOM4cDqZga7C3CQ=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr41699356oie.48.1564049020063; 
 Thu, 25 Jul 2019 03:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190702121106.28374-1-slp@redhat.com>
 <20190702121106.28374-2-slp@redhat.com>
 <aca80a5c-40b9-ca31-2e22-c2bf5005f7e5@oracle.com>
 <20190725055523-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190725055523-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 11:03:29 +0100
Message-ID: <CAFEAcA9uOxphng=YtRi5XRrM0kFchQJ7TUHHv2-TWbDOW70WMA@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 1/4] hw/virtio: Factorize virtio-mmio
 headers
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 maran.wilson@oracle.com, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 10:58, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 25, 2019 at 10:46:00AM +0100, Liam Merwick wrote:
> > On 02/07/2019 13:11, Sergio Lopez wrote:
> > > Put QOM and main struct definition in a separate header file, so it
> > > can be accesed from other components.
> >
> > typo: accesed -> accessed
> >
> > >
> > > This is needed for the microvm machine type implementation.
> > >
> > > Signed-off-by: Sergio Lopez <slp@redhat.com>
> >
> > One nit below, either way
> >
> > Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> >
> > > ---
> > >   hw/virtio/virtio-mmio.c | 35 +-----------------------
> > >   hw/virtio/virtio-mmio.h | 60 +++++++++++++++++++++++++++++++++++++++++
> > >   2 files changed, 61 insertions(+), 34 deletions(-)
> > >   create mode 100644 hw/virtio/virtio-mmio.h
> > >
> > > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > > index 97b7f35496..87c7fe4d8d 100644
> > > --- a/hw/virtio/virtio-mmio.c
> > > +++ b/hw/virtio/virtio-mmio.c
> > > @@ -26,44 +26,11 @@
> > >   #include "qemu/host-utils.h"
> > >   #include "qemu/module.h"
> > >   #include "sysemu/kvm.h"
> > > -#include "hw/virtio/virtio-bus.h"
> > > +#include "virtio-mmio.h"
> >
> >
> > Virtually all the other includes of virtio-xxx.h files in hw/virtio use the
> > full path - e.g. "hw/virtio/virtio-mmio.h" - maybe do the same to be
> > consistent.
>
> That's for headers under include/.
> Local ones are ok with a short name.

Yes, but we should put this one into include/ as that fits with
our usual arrangement of where we put the headers for devices.

> I'm repeating myself, but still: if you insist on virtio mmio, please
> implement virtio 1 and use that with microvm. We can't keep carrying
> legacy interface into every new machine type.

Agreed (but we've had this discussion on another thread, as you say).

thanks
-- PMM

