Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4D0C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A402075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=connect-hku-hk.20150623.gappssmtp.com header.i=@connect-hku-hk.20150623.gappssmtp.com header.b="UK5fFz+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A402075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=connect.hku.hk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMR3j-0003Te-T8
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 01:48:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMR2Z-00036A-J5
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMR2X-0006r0-GE
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:47:23 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:41007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hMR2V-0006lw-Hv
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:47:20 -0400
Received: by mail-yw1-xc44.google.com with SMTP id o65so1669410ywd.8
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=wjqEbOpVDMVf/hBm3tJWrKczkF6hYNVMuVVVKeaawAc=;
	b=UK5fFz+uvTt+2YFNyRG+RC9WLt1GBFdnkTo/GQ5WeGlyYx1/uNer+v51cgCTKpw3Bm
	6/78d3jazOYxyIDe/JE/Q4NZuYZS0OChY7jaFqYuRZomOA6ck+BIjgyyKapJhxTDafjA
	/fG2KkGZDj1M6Q4rrgvG/6EJiEvVJx1dRwG+zJLaRScgtMvTWNuc11I12nB1mr/+2bPK
	cMbPFXG4dC9f5NwGQXK1/lpLzlTNoyyEI9zbGkFUDtHJoqAIHBVQJ1CMK0HT0btvz6si
	QEqGKb3OW70I/v8VO0DQS94bMMr4BHrcZfWLOwF/nD5hZxHwnMFFzanf0SOcwMAuffDb
	6HBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=wjqEbOpVDMVf/hBm3tJWrKczkF6hYNVMuVVVKeaawAc=;
	b=o8INX4fEcUYskrsPCKOFtgrgT1EhKCFVPfoK0AgHmCMOmMQXVWiyRz77NBqpUaXlJy
	kvRmFKdICKai5OWwVCiRquEO4oWvS11UfG1JBcQTQxmXlRGQ/WUZlgn4mQ086vk1tbda
	0tuq3IlXGAQkOiFAiOtHn4jVHPvGhE8ZuxTuRr3pJvr3jAuFgd2pm5pidI5hfrBKAHAS
	QrcZOdhj7DEbb3FVnZxlCT7PW21exa5JnPTLtVceUiKxE2ah/07VOYIHw/Nagl/T9y1L
	DbR00x3CVhhlDfDaIXQeNFMv+enQez3+s7Ntc3HG6b0xaBAsdsKjIpl+O+o2eTfpg5lc
	JSkA==
X-Gm-Message-State: APjAAAWrHVUZQHABSOpxB51zc9iCs2MYuRyDf80gSQey0RilWhkJ4hSR
	j6vByBc6PPehbxQd91KuMgaUzbz1bDUZb0qrl/7K6uhR
X-Google-Smtp-Source: APXvYqynANkc1fOh28LQinwnY7flB8xJflKmYFzJyrIXgabZJYcX1hXEdhcMQciJDYxQVUKG1/PPTbt8MReT0BiykIg=
X-Received: by 2002:a25:850e:: with SMTP id w14mr6459865ybk.13.1556862436266; 
	Thu, 02 May 2019 22:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190501081039.58938-1-liboxuan@connect.hku.hk>
	<20190501085805.GA8174@lap1>
	<CALM0=-=cbHTajGz8R4Who9eKh=sfa19H_nMuH4PFO8vVq2=drQ@mail.gmail.com>
	<20190501135807.GA11932@lap1> <87y33q5hmw.fsf@zen.linaroharston>
In-Reply-To: <87y33q5hmw.fsf@zen.linaroharston>
From: "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date: Fri, 3 May 2019 13:46:40 +0800
Message-ID:
 <CALM0=-m9y31XHuqzi=36AuxQmM7YBCXc_AW2fc=xAF-LV5Tofg@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] hw/virtio/virtio-mmio: Convert DPRINTF
 to traces
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Yuval Shaia <yuval.shaia@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503054640.tBLhOzUM56ah-smYEyb87ROXSfGFl0v1QwaTMdbiAgs@z>

Hi Yuval and Alex,

Thanks for the suggestions. I'll update and send a patch v3 soon.

Best regards,
Boxuan Li

On Wed, May 1, 2019 at 11:17 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Yuval Shaia <yuval.shaia@oracle.com> writes:
>
> > On Wed, May 01, 2019 at 08:42:35PM +0800, LI, BO XUAN wrote:
> >>    On Wed, May 1, 2019 at 4:58 PM Yuval Shaia <[1]
> yuval.shaia@oracle.com>
> >>    wrote:
> >>
> >>      On Wed, May 01, 2019 at 04:10:39PM +0800, Boxuan Li wrote:
> >>      > Signed-off-by: Boxuan Li <[2]liboxuan@connect.hku.hk>
> >>      > ---
> >>      > v2: Instead of using conditional debugs, convert DPRINTF to
> traces
> >>      > ---
> >>      >  hw/virtio/trace-events  | 13 +++++++++++++
> >>      >  hw/virtio/virtio-mmio.c | 35 ++++++++++++---------------------=
--
> >>      >  2 files changed, 25 insertions(+), 23 deletions(-)
> >>      >
> >>      > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> >>      > index 60c649c4bc..37c781b487 100644
> >>      > --- a/hw/virtio/trace-events
> >>      > +++ b/hw/virtio/trace-events
> >>      > @@ -46,3 +46,16 @@ virtio_balloon_handle_output(const char *nam=
e,
> >>      uint64_t gpa) "section name: %s g
> >>      >  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual)
> >>      "num_pages: %d actual: %d"
> >>      >  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual)
> >>      "actual: %d oldactual: %d"
> >>      >  virtio_balloon_to_target(uint64_t target, uint32_t num_pages)
> >>      "balloon target: 0x%"PRIx64" num_pages: %d"
> >>      > +
> >>      > +# virtio-mmio.c
> >>      > +virtio_mmio_read(int offset) "virtio_mmio_read offset 0x%x"
> >>      > +virtio_mmio_wrong_size_read(void) "wrong size access to
> >>      register!"
> >>      > +virtio_mmio_read_interrupt(void) "read of write-only register"
> >>      > +virtio_mmio_bad_read_offset(void) "bad register offset"
> >>      > +virtio_mmio_write_offset(int offset, uint64_t value)
> >>      "virtio_mmio_write offset 0x%x value 0x%" PRIx64
> >>      > +virtio_mmio_wrong_size_write(void) "wrong size access to
> >>      register!"
> >>      > +virtio_mmio_guest_page(uint64_t size, int shift) "guest page
> size
> >>      0x%" PRIx64 " shift %d"
> >>      > +virtio_mmio_queue_write(int value, int max_size) "mmio_queue
> >>      write %d max %d"
> >>      > +virtio_mmio_write_interrupt(void) "write to readonly register"
> >>      > +virtio_mmio_bad_write_offset(void) "bad register offset"
> >>      > +virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d=
"
> >>      > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> >>      > index 5807aa87fe..4251df399d 100644
> >>      > --- a/hw/virtio/virtio-mmio.c
> >>      > +++ b/hw/virtio/virtio-mmio.c
> >>      > @@ -27,16 +27,7 @@
> >>      >  #include "sysemu/kvm.h"
> >>      >  #include "hw/virtio/virtio-bus.h"
> >>      >  #include "qemu/error-report.h"
> >>      > -
> >>      > -/* #define DEBUG_VIRTIO_MMIO */
> >>      > -
> >>      > -#ifdef DEBUG_VIRTIO_MMIO
> >>      > -
> >>      > -#define DPRINTF(fmt, ...) \
> >>      > -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
> >>      > -#else
> >>      > -#define DPRINTF(fmt, ...) do {} while (0)
> >>      > -#endif
> >>      > +#include "trace.h"
> >>      >
> >>      >  /* QOM macros */
> >>      >  /* virtio-mmio-bus */
> >>      > @@ -107,7 +98,7 @@ static uint64_t virtio_mmio_read(void *opaqu=
e,
> >>      hwaddr offset, unsigned size)
> >>      >      VirtIOMMIOProxy *proxy =3D (VirtIOMMIOProxy *)opaque;
> >>      >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >>      >
> >>      > -    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
> >>      > +    trace_virtio_mmio_read((int)offset);
> >>      >
> >>      >      if (!vdev) {
> >>      >          /* If no backend is present, we treat most registers a=
s
> >>      > @@ -144,7 +135,7 @@ static uint64_t virtio_mmio_read(void
> *opaque,
> >>      hwaddr offset, unsigned size)
> >>      >          }
> >>      >      }
> >>      >      if (size !=3D 4) {
> >>      > -        DPRINTF("wrong size access to register!\n");
> >>      > +        trace_virtio_mmio_wrong_size_read();
> >>      Have you considered using qemu_error_report to report such errors=
?
> >>
> >>    Thanks for the suggestion. I am a newcomer here so my question migh=
t
> be
> >>    a bit dumb: I thought they are warnings instead of errors since
> return
> >>    values are 0. Do you suggest using error_report function and changi=
ng
> >>    return values from 0 to -1?
> >>    Best regards,
> >>    Boxuan Li
> >
> > I think that when driver store invalid data in device register it is an
> > error but the best is to check what other devices do.
>
> We could have:
>
>         qemu_log_mask(LOG_GUEST_ERROR, "%s: wrong size access to
> register!\n". __func__);
>
> --
> Alex Benn=C3=A9e
>
