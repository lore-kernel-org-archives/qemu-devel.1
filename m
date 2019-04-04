Received: from eggs.gnu.org ([209.51.188.92]:54914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1hBxjB-0001xe-BA
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1hBxd8-0008Gu-Vl
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:21:52 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:39824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1hBxd3-00081O-5B
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:21:46 -0400
Received: by mail-it1-x142.google.com with SMTP id 139so2312673ita.4
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 01:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <201904041010.10367.randrianasulu@gmail.com>
	<CAOvqHj4JsRvm1vzu-VQ0GGGTLEPBT-wyRcRbUHTZGE6m8onjwg@mail.gmail.com>
	<201904041044.49806.randrianasulu@gmail.com>
In-Reply-To: <201904041044.49806.randrianasulu@gmail.com>
From: =?UTF-8?B?VGFvIFd1KOWQtOa2m0BFbmcp?= <lepton@google.com>
Date: Thu, 4 Apr 2019 01:21:27 -0700
Message-ID: <CAOvqHj4XcYypo3rJ1H1r7uQrn0ucMbrrfpBx_7M_iwKdwf32VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Proof of concept for GPU forwarding for Linux
 guest on Linux host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Thu, Apr 4, 2019 at 12:49 AM Andrew Randrianasulu <
randrianasulu@gmail.com> wrote:

> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Thursday 04 April 2019 10:33:55 Tao Wu(=E5=90=B4=E6=B6=9B@Eng) =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
> > On Thu, Apr 4, 2019 at 12:15 AM Andrew Randrianasulu <
> > randrianasulu@gmail.com> wrote:
> >
> > > Hi!
> > >
> > > I recall I saw something like this some time ago (but in connection
> with
> > > qemu-user + ALSA sycallls)
> > > So far I found this:
> > >
> > > https://marc.info/?l=3Dqemu-devel&m=3D154349285205915
> > >
> > > List:       qemu-devel
> > > Subject:    [Qemu-devel] Support for Intel GPU
> > > From:       Allan Sandfeld Jensen <kde () carewolf ! com>
> > > Date:       2018-11-29 11:54:19
> > >
> > > Ah, found alsa bits too:
> > > https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05334.html
> >
> > Thanks, I took a look, the previous patches are targeting qemu user mod=
e
> > while mine is targeting full system virtualization.
> > There is no plan to merge my code as it is now. I just want to get some
> > feedbacks first.
>
> I was thinking qemu's system mode was covered already by
>
>
> https://www.kraxel.org/blog/2018/04/vgpu-display-support-finally-merged-u=
pstream/
> (intel's vGPU)
>
> Personally I have never tested this.

>
> https://www.kraxel.org/blog/2016/09/using-virtio-gpu-with-libvirt-and-spi=
ce/
> (virtio-gpu
> <https://www.kraxel.org/blog/2016/09/using-virtio-gpu-with-libvirt-and-sp=
ice/(virtio-gpu>,
> via gallium framework)
>
In the long term, this should be the right direction. But for now, it is
lacking of something like vulkan support.
Also, performance is not as great as it could be. In some use case
(benchmark), GPU forwarding work much better
than virtio-gpu and can get close native performance.

>
> ?
>
> But thanks anyway, may be some of those ideas can be fused together (I
> only have nvidia/nouveau GPU,
> and at best can forward-port something simple)

Actually although I said GPU forwarding, the real code is doing "file
handler" forwarding (by supporting
mmap/ioctl/select...) etc. I am not sure if we should have a general frame
work for things like this so we can forward
any special device in host to guest with minimal efforts.

>






>
> >
> >
> > >
> > >
> > > None of this was merged, as far as I understand.
> > >
> >
>
>
>
