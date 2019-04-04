Received: from eggs.gnu.org ([209.51.188.92]:47913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hC5TO-0007dn-CE
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 12:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hC5TN-0000ck-2H
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 12:44:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hC5TM-0000T4-9C
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 12:44:16 -0400
Date: Thu, 4 Apr 2019 17:44:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190404164400.GA2720@work-vm>
References: <201904041010.10367.randrianasulu@gmail.com>
	<CAOvqHj4JsRvm1vzu-VQ0GGGTLEPBT-wyRcRbUHTZGE6m8onjwg@mail.gmail.com>
	<201904041044.49806.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201904041044.49806.randrianasulu@gmail.com>
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
To: Andrew Randrianasulu <randrianasulu@gmail.com>, kraxel@redhat.com, marcandre.lureau@redhat.com
Cc: Tao =?utf-8?B?V3Uo5ZC05rabQEVuZyk=?= <lepton@google.com>, QEMU <qemu-devel@nongnu.org>

cc'ing in Gerd and Marc-Andr=C3=A9

* Andrew Randrianasulu (randrianasulu@gmail.com) wrote:
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Thursday 04 April 2019 10:33:55 Tao Wu(=E5=90=B4=E6=B6=9B@Eng) =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
> > On Thu, Apr 4, 2019 at 12:15 AM Andrew Randrianasulu <
> > randrianasulu@gmail.com> wrote:
> >=20
> > > Hi!
> > >
> > > I recall I saw something like this some time ago (but in connection=
 with
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
> >=20
> > Thanks, I took a look, the previous patches are targeting qemu user m=
ode
> > while mine is targeting full system virtualization.
> > There is no plan to merge my code as it is now. I just want to get so=
me
> > feedbacks first.
>=20
> I was thinking qemu's system mode was covered already by
>=20
> https://www.kraxel.org/blog/2018/04/vgpu-display-support-finally-merged=
-upstream/
> (intel's vGPU)
>=20
> https://www.kraxel.org/blog/2016/09/using-virtio-gpu-with-libvirt-and-s=
pice/
> (virtio-gpu, via gallium framework)
>=20
> ?
>=20
> But thanks anyway, may be some of those ideas can be fused together (I =
only have nvidia/nouveau GPU,=20
> and at best can forward-port something simple)
>=20
>=20
> >=20
> >=20
> > >
> > >
> > > None of this was merged, as far as I understand.
> > >
> >=20
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
