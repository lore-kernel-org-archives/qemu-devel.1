Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C795C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D86206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D86206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQuG1-0001qO-Ov
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 09:47:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hQuEd-0001Ce-K7
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hQuEc-0006UA-Jy
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hQuEc-0006Sq-E3
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:46:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 714BB8553B;
	Wed, 15 May 2019 13:46:17 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DD6CD5C1A3;
	Wed, 15 May 2019 13:46:16 +0000 (UTC)
Date: Wed, 15 May 2019 07:46:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Message-ID: <20190515074616.3d6e6b32@x1.home>
In-Reply-To: <CAKXe6SKetRL1uEww7wZeOCU5d8t+qrDDjzk3uBsQuhiQzt5S6w@mail.gmail.com>
References: <CAKXe6SKBgMcq+p7EB1kRWLSbg9NvZg1Mr24UrX8S+kpzq-GR4Q@mail.gmail.com>
	<c707e882-e194-355a-d96c-bfb00a8db247@redhat.com>
	<CAKXe6SKetRL1uEww7wZeOCU5d8t+qrDDjzk3uBsQuhiQzt5S6w@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 15 May 2019 13:46:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Question about the vfio device interrupt
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
Cc: Auger Eric <eric.auger@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 May 2019 18:22:54 +0800
Li Qiang <liq3ea@gmail.com> wrote:

> Auger Eric <eric.auger@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:16=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Hi,
> >
> > On 5/15/19 12:01 PM, Li Qiang wrote: =20
> > > Hello Paolo, Alex and all,
> > >
> > > In vfio_intx_enable_kvm(qemu) I see we associate a resamplefd with the
> > > umask function(vfio_pci_intx_unmask_handler in linux).
> > >
> > >     irq_set =3D g_malloc0(argsz);
> > >     irq_set->argsz =3D argsz;
> > >     irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD | =20
> > VFIO_IRQ_SET_ACTION_UNMASK; =20
> > >     irq_set->index =3D VFIO_PCI_INTX_IRQ_INDEX;
> > >     irq_set->start =3D 0;
> > >     irq_set->count =3D 1;
> > >     pfd =3D (int32_t *)&irq_set->data;
> > >
> > >     *pfd =3D irqfd.resamplefd;
> > >
> > >     ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> > >
> > > I know this resamplefd is triggered when the interrupt controller =20
> > receives =20
> > > an EOI and
> > > then we unmask and re-enabled the VFIO devices' interrupt.
> > >
> > > So I think there  there must be a mask process(so we unmask it later)=
, I
> > > mean there must a
> > > call of function vfio_pci_set_intx_mask(in linux).
> > >
> > > What I can't understand is when this process(mask VFIO devices' =20
> > interrupt) =20
> > > occurs? =20
> > It is done in the VFIO interrupt handler:
> > vfio_intx_handler/disable_irq_nosync for VFIO PCI (vfio_pci_intrs.c) or
> > vfio_automasked_irq_handler (vfio_platform_irq.c) for VFIO PLATFORM .
> >
> > =20
> Thanks Eric,
>=20
> Got it.
> I just forget to look at the interrupt handler(vfio_intx_handler)!

Importantly, PCI INTx interrupts are exposed in
VFIO_DEVICE_GET_IRQ_INFO with the VFIO_IRQ_INFO_AUTOMASKED flag which
indicates that the interrupt is masked in the host kernel when it is
signaled via the eventfd and userspace is only required to perform an
unmask operation to receive the next interrupt.  Thanks,

Alex

