Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034C8C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC00A20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 22:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dl/PvlTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC00A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEKut-0004jT-QZ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 18:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEKuG-0004KZ-Sm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEKuE-0004Jn-Bk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:41:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEKuE-0004ET-3g
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 18:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584484908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OE5xE74N3nqWhtm4h65lZMGaV8qdbFOoAL0hVx3/Q4=;
 b=Dl/PvlTIWtlnEMrh50BkMl1XNJnpMgGwaoxKHJJ+K64UmWrcNeQih3mXa/EFZ2L5O1qcmu
 9qRmKaUQ4PR2ZOx6uwIWs64ERQcxksVzn09gckRih3siJdBO0T9ikDDkiYk5PHVOJIqW8x
 H4+AOssohwTW0+L+7Id1F9VqJrQKH4A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-BYu-1V53PKyISwbyuF7HIw-1; Tue, 17 Mar 2020 18:41:46 -0400
X-MC-Unique: BYu-1V53PKyISwbyuF7HIw-1
Received: by mail-wr1-f70.google.com with SMTP id w11so11368727wrp.20
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 15:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vGXRaYdRGDkLs1wGRBmgsuljII0RxK/M4/v+hyZgPUE=;
 b=R9+vNR0OdW/WDe47qTCrGZbXHOwtQzT6AgEJj3q6IH0pqtHUoWH5sJ1towUsP6xH2g
 PDPtKbbeF73mrNwZ9QPup/FgQZGFMcghnpivOX32IG5KtGUg67QoEW0fgmrdj0bmFABW
 LD0q4aCiijXtA7jQrdFpM1cm/6fjLTjiX1iR7s+5Scale5KT4zcczKRV+9SUhApIvqrF
 pqJqzeEy/mhFd9coJbtmsThJhXzVrFSl+Vrtho+gLzL47cMd6gljvi7ayVMeiLw3ds3+
 cUZDznBNkoCQxqHN8XM325oOPxRt6IbS/UIZuPzr2p7xRsdkx75GAxe11Yuxlsw/BoyF
 myNA==
X-Gm-Message-State: ANhLgQ0DYQjVU6rN8WdpXRm6Cdxw092TomADVTZBxxBKOlWqBfLEb8jC
 mcbJtgMooD7movGM+FbOH0ZzqKDTXX9zxqpXikwQzg4kCDKqF084M4B+igANyXzGF91ycSYActH
 qsipjvf4ju/MQgG4=
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr1374475wrg.340.1584484903375; 
 Tue, 17 Mar 2020 15:41:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuveNXt+EWlqBaeMso3PGHQl+3Gq3ftYSWFhsTJm+UDNQlBdUrp7vEtrUNRLCSINHKkJsgAhQ==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr1374456wrg.340.1584484903059; 
 Tue, 17 Mar 2020 15:41:43 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id i8sm6074299wrw.55.2020.03.17.15.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 15:41:42 -0700 (PDT)
Date: Tue, 17 Mar 2020 18:41:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200317224138.GE233068@xz-x1>
References: <20200317195042.282977-1-peterx@redhat.com>
 <20200317195042.282977-5-peterx@redhat.com>
 <20200317150646.2718d3a6@w520.home> <20200317214108.GD233068@xz-x1>
 <20200317161200.0c41fe60@w520.home>
MIME-Version: 1.0
In-Reply-To: <20200317161200.0c41fe60@w520.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 04:12:00PM -0600, Alex Williamson wrote:
> On Tue, 17 Mar 2020 17:41:08 -0400
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Tue, Mar 17, 2020 at 03:06:46PM -0600, Alex Williamson wrote:
> >=20
> > [...]
> >=20
> > > > diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> > > > index 15747fe2c2..81a17cc2b8 100644
> > > > --- a/hw/intc/ioapic.c
> > > > +++ b/hw/intc/ioapic.c
> > > > @@ -236,8 +236,29 @@ void ioapic_eoi_broadcast(int vector)
> > > >          for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
> > > >              entry =3D s->ioredtbl[n];
> > > > =20
> > > > -            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
> > > > -                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=
=3D IOAPIC_TRIGGER_LEVEL) {
> > > > +            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector) {
> > > > +                continue;
> > > > +            }
> > > > +
> > > > +            /*
> > > > +             * When IOAPIC is in the userspace while APIC is still=
 in
> > > > +             * the kernel (i.e., split irqchip), we have a trick t=
o
> > > > +             * kick the resamplefd logic for registered irqfds fro=
m
> > > > +             * userspace to deactivate the IRQ.  When that happens=
, it
> > > > +             * means the irq bypassed userspace IOAPIC (so the irr=
 and
> > > > +             * remote-irr of the table entry should be bypassed to=
o
> > > > +             * even if interrupt come).  Still kick the resamplefd=
s if
> > > > +             * they're bound to the IRQ, to make sure to EOI the
> > > > +             * interrupt for the hardware correctly.
> > > > +             *
> > > > +             * Note: We still need to go through the irr & remote-=
irr
> > > > +             * operations below because we don't know whether ther=
e're
> > > > +             * emulated devices that are using/sharing the same IR=
Q.
> > > > +             */
> > > > +            kvm_resample_fd_notify(n);
> > > > +
> > > > +            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=
=3D
> > > > +                IOAPIC_TRIGGER_LEVEL) {
> > > >                  continue;
> > > >              }
> > > >   =20
> > >=20
> > > What's the logic for sending resampler notifies before testing if the
> > > ioapic entry is in level triggered mode?  vfio won't use this for
> > > anything other than level triggered.  Inserting it between these chec=
ks
> > > confused me and in my testing wasn't necessary.  Thanks, =20
> >=20
> > I put it there to match the kernel implementation, and IIUC Paolo
> > agreed with that too:
> >=20
> > https://patchwork.kernel.org/patch/11407441/#23190969
> >=20
> > Since we've discussed a few times here, I think I can talk a bit more
> > on how I understand this in case I was wrong...
> >=20
> > Even if we have the fact that all the existing devices that use this
> > code should be using level-triggered IRQs, however... *If* there comes
> > an edge-triggered INTx device and we assign it using vfio-pci, vfio
> > should also mask the IRQ after it generates (according to
> > vfio_intx_handler), is that right?  Then we still need to kick the
> > resamplefd for that does-not-exist device too to make sure it'll work?
>=20
> "edge-triggered INTx" is not a thing that exists.  The PCI spec defines
> interrupt pins as:
>=20
>   2.2.6. Interrupt Pins (Optional)
>=20
>   Interrupts on PCI are optional and defined as "level sensitive,"
>   asserted low (negative true), using open drain output drivers.

Ah OK!  I didn't notice it's a spec-wise answer...

>=20
> Masking of interrupts while they're in-service is not done for edge
> triggered interrupts, we assume that being a discrete interrupt is a
> sufficient rate limiter versus a level triggered interrupt, which is
> continuous and can saturate the host.
>=20
> If it exists before the level check only to match the kernel, maybe a
> comment or todo item to check whether it's the optimal approach for
> both cases should be in order.  I can't think of any reason why we'd
> need it for the sake of edge triggered vfio interrupts in either place.

I guess the KVM implementation of that is still required for the
kernel PIT implementation as Paolo mentioned.  Since this seems to be
confusing and the userspace does not have a real use case for that,
let me repost this patch only so the userspace resamplefd only reacts
to level triggered interrupts.

Thanks,

--=20
Peter Xu


