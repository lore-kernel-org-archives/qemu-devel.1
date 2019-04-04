Received: from eggs.gnu.org ([209.51.188.92]:46908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hBx7y-0001tp-Mq
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hBx7x-0001kq-95
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:49:38 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hBx7w-0001iB-To
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:49:37 -0400
Received: by mail-lj1-x232.google.com with SMTP id f23so1226900ljc.0
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 00:49:36 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Thu, 4 Apr 2019 10:44:49 +0300
References: <201904041010.10367.randrianasulu@gmail.com>
	<CAOvqHj4JsRvm1vzu-VQ0GGGTLEPBT-wyRcRbUHTZGE6m8onjwg@mail.gmail.com>
In-Reply-To: <CAOvqHj4JsRvm1vzu-VQ0GGGTLEPBT-wyRcRbUHTZGE6m8onjwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201904041044.49806.randrianasulu@gmail.com>
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
To: "Tao Wu(=?utf-8?q?=E5=90=B4=E6=B6=9B?=@Eng)" <lepton@google.com>
Cc: QEMU <qemu-devel@nongnu.org>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Thursday 04 April 2019 10:33:55 Tao Wu(=E5=90=B4=E6=B6=9B@Eng) =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
> On Thu, Apr 4, 2019 at 12:15 AM Andrew Randrianasulu <
> randrianasulu@gmail.com> wrote:
>=20
> > Hi!
> >
> > I recall I saw something like this some time ago (but in connection with
> > qemu-user + ALSA sycallls)
> > So far I found this:
> >
> > https://marc.info/?l=3Dqemu-devel&m=3D154349285205915
> >
> > List:       qemu-devel
> > Subject:    [Qemu-devel] Support for Intel GPU
> > From:       Allan Sandfeld Jensen <kde () carewolf ! com>
> > Date:       2018-11-29 11:54:19
> >
> > Ah, found alsa bits too:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05334.html
>=20
> Thanks, I took a look, the previous patches are targeting qemu user mode
> while mine is targeting full system virtualization.
> There is no plan to merge my code as it is now. I just want to get some
> feedbacks first.

I was thinking qemu's system mode was covered already by

https://www.kraxel.org/blog/2018/04/vgpu-display-support-finally-merged-ups=
tream/
(intel's vGPU)

https://www.kraxel.org/blog/2016/09/using-virtio-gpu-with-libvirt-and-spice/
(virtio-gpu, via gallium framework)

?

But thanks anyway, may be some of those ideas can be fused together (I only=
 have nvidia/nouveau GPU,=20
and at best can forward-port something simple)


>=20
>=20
> >
> >
> > None of this was merged, as far as I understand.
> >
>=20
