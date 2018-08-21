Received: from eggs.gnu.org ([2001:4830:134:3::10]:46360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs4mn-00044g-1X
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs4mh-0000kH-H4
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs4mh-0000jU-C5
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:25:15 -0400
Date: Tue, 21 Aug 2018 13:25:11 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821112511.dx7yftb6waafip6l@sirius.home.kraxel.org>
References: <20180821111313.27792-1-kraxel@redhat.com>
	<20180821111313.27792-2-kraxel@redhat.com>
	<CAJ+F1CJcBOauL_U1APo+BNVYcBiyAXfQ2TVV7U-VfjU6etq3dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJcBOauL_U1APo+BNVYcBiyAXfQ2TVV7U-VfjU6etq3dw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-vga: fix reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

> > @@ -179,8 +179,12 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >  static void virtio_vga_reset(DeviceState *dev)
> >  {
> >      VirtIOVGA *vvga = VIRTIO_VGA(dev);
> > -    vvga->vdev.enable = 0;
> >
> > +    /* reset virtio-gpu */
> > +    virtio_gpu_reset(VIRTIO_DEVICE(&vvga->vdev));
> > +
> > +    /* reset vga */
> > +    vga_common_reset(&vvga->vga);
> 
> Ah, I only tested with vga_common_reset(). I was missing the
> virtio_gpu_reset() part.

/me too (at least back then when discussing -rc4), took me some
debugging to figure ...

> I assume you tested it?

Sure.

cheers,
  Gerd
