Received: from eggs.gnu.org ([2001:4830:134:3::10]:60878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn2F8-0001OO-4l
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn2F3-0000Pz-52
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:41:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fn2F2-0000Pl-Vh
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:41:41 -0400
Date: Tue, 7 Aug 2018 15:41:37 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180807134137.xepoakofn5e222nv@sirius.home.kraxel.org>
References: <20180803153235.4134-1-marcandre.lureau@redhat.com>
	<20180807125558.2g7nl5zhgrdblrwh@sirius.home.kraxel.org>
	<CAJ+F1C+cU-LKd_t-tn9jW86A8aV4CnQXUpA1NM+SPkB1rbrfoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+cU-LKd_t-tn9jW86A8aV4CnQXUpA1NM+SPkB1rbrfoQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix crashes upon warm reboot
 with vga mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Aug 07, 2018 at 03:02:49PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Aug 7, 2018 at 2:55 PM, Gerd Hoffmann <kraxel@redhat.com> wrote=
:
> > On Fri, Aug 03, 2018 at 05:32:35PM +0200, Marc-Andr=E9 Lureau wrote:
> >> With vga=3D775 on the Linux command line a first boot of the VM runn=
ing
> >> Linux works fine. After a warm reboot it crashes during Linux boot.
> >>
> >> Before that, valgrind points out bad memory write to console
> >> surface. The VGA code is not aware that virtio-gpu got a message
> >> surface scanout when the display is disabled. Let's reset VGA graphi=
c
> >> mode when it is the case, so that a new display surface is created
> >> when doing further VGA operations.
> >
> > I guess we should simply call vga_common_reset() in virtio_vga_reset(=
)
> > instead, can you try that?
> >
> Yes I tried, and it still fails. However I think the call is missing
> and I was planning to send it for 3.1 later, since I don't think it's
> RC material.
> The ordering of events is not completely obvious to me, but it's still
> crashing/corrupting memory after the reset occurs. The scanout get's
> disable after it iirc.

Ok, lets go with this patch for -rc4 and figure the reset issues later.
It is correct, even though I think there must be a simpler way to do it.
When we have a better fix we can revert it.

Peter, can you apply it directly?

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

thanks,
  Gerd
