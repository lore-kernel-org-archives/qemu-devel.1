Received: from eggs.gnu.org ([2001:4830:134:3::10]:58454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=27685eb1a=Paul.Durrant@citrix.com>)
	id 1d173X-0007RK-CZ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=27685eb1a=Paul.Durrant@citrix.com>)
	id 1d173N-0007rP-JG
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:03:11 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:46331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=27685eb1a=Paul.Durrant@citrix.com>)
	id 1d173N-0007qe-6C
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:03:01 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 20 Apr 2017 08:02:45 +0000
Message-ID: <6738c7d96a1c476187f69616f25b28d1@AMSPEX02CL03.citrite.net>
References: <alpine.DEB.2.10.1704141429110.23677@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704141734161.23677@sstabellini-ThinkPad-X260>
	<03cfd81856554ecd91c0c317353e819b@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704181038360.31486@sstabellini-ThinkPad-X260>
	<51ac3ff38f464abfb98928e6fb959bf7@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704191552450.31486@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1704191552450.31486@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] QEMU build breakage on ARM against Xen 4.9 caused
 by libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Wei Liu <wei.liu2@citrix.com>, "jgross@suse.com" <jgross@suse.com>, "julien.grall@arm.com" <julien.grall@arm.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 20 April 2017 00:02
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: 'Stefano Stabellini' <sstabellini@kernel.org>; qemu-devel@nongnu.org;
> Anthony Perard <anthony.perard@citrix.com>; Wei Liu
> <wei.liu2@citrix.com>; jgross@suse.com; julien.grall@arm.com; xen-
> devel@lists.xenproject.org
> Subject: RE: QEMU build breakage on ARM against Xen 4.9 caused by
> libxendevicemodel
>=20
> On Wed, 19 Apr 2017, Paul Durrant wrote:
> > > -----Original Message-----
> > > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > > Sent: 18 April 2017 18:41
> > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > Cc: 'Stefano Stabellini' <sstabellini@kernel.org>; qemu-
> devel@nongnu.org;
> > > Anthony Perard <anthony.perard@citrix.com>; Wei Liu
> > > <wei.liu2@citrix.com>; jgross@suse.com; julien.grall@arm.com; xen-
> > > devel@lists.xenproject.org
> > > Subject: RE: QEMU build breakage on ARM against Xen 4.9 caused by
> > > libxendevicemodel
> > >
> > > On Tue, 18 Apr 2017, Paul Durrant wrote:
> > > > > -----Original Message-----
> > > > > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > > > > Sent: 15 April 2017 01:40
> > > > > To: Stefano Stabellini <sstabellini@kernel.org>
> > > > > Cc: Paul Durrant <Paul.Durrant@citrix.com>; qemu-
> devel@nongnu.org;
> > > > > Anthony Perard <anthony.perard@citrix.com>; Wei Liu
> > > > > <wei.liu2@citrix.com>; jgross@suse.com; julien.grall@arm.com; xen=
-
> > > > > devel@lists.xenproject.org
> > > > > Subject: Re: QEMU build breakage on ARM against Xen 4.9 caused by
> > > > > libxendevicemodel
> > > > >
> > > > > On Fri, 14 Apr 2017, Stefano Stabellini wrote:
> > > > > > Hi Paul,
> > > > > >
> > > > > > The following commit in my qemu "next" branch breaks the build =
on
> > > arm
> > > > > > and arm64:
> > > > > >
> > > > > > commit 670271647ad15e9d937ced7a72c892349c709216
> > > > > > Author: Paul Durrant <paul.durrant@citrix.com>
> > > > > > Date:   Tue Mar 7 10:55:34 2017 +0000
> > > > > >
> > > > > >     xen: use libxendevicemodel when available
> > > > > >
> > > > > > See the appended build log. Sorry for not realizing it sooner.
> > > > >
> > > > > As I imagined, this bug is easy to solve. It is reproducible on x=
86 too,
> > > > > if you pass -DXC_WANT_COMPAT_DEVICEMODEL_API=3D1 to configure
> > > and
> > > > > forcefully disable Xen 4.9 detection in the configure script.
> > > > >
> > > > > If QEMU detects xen_ctrl_version =3D 480, the build will fail aga=
inst Xen
> > > > > 4.9, even when -DXC_WANT_COMPAT_DEVICEMODEL_API=3D1 is
> > > specified.
> > > > >
> > > > > The appended patch solves the problem. However, Xen 4.9 detection
> > > and
> > > > > compilation remain broken.
> > > >
> > > > Ok, that fix looks fine to me.
> > >
> > > I merged this change into "use libxendevicemodel when available" in m=
y
> > > next branch.
> > >
> > > Are you going to take care of getting the QEMU build on ARM to work
> > > against Xen 4.9 (properly detecting 4.9, without
> > > -DXC_WANT_COMPAT_DEVICEMODEL_API=3D1)?
> > >
> >
> > I can take a look once I get access to some h/w. Since the 4.9 detectio=
n
> should merely be based upon the presence of libxendevicemodel, I can't
> really imagine why ARM should behave any differently to x86.
>=20
> I managed to find the time to do some debugging. You are right that is
> not anything major. The bug is due to a missing -lxencall in the QEMU
> configure script, I wonder why it works on x86.

Yes, that's weird. libxendevicemodel does depend on libxencall for the case=
 when the privcmd driver in dom0 does not support the new DM_OP ioctl, but =
that dependency should be there regardless of architecture.

>=20
> diff --git a/configure b/configure
> index 99d6cbc..363a126 100755
> --- a/configure
> +++ b/configure
> @@ -2027,9 +2027,9 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
> +        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel -
> lxencall"
>        then
> -      xen_stable_libs=3D"$xen_stable_libs -lxendevicemodel"
> +      xen_stable_libs=3D"$xen_stable_libs -lxendevicemodel -lxencall"
>        xen_ctrl_version=3D40900
>        xen=3Dyes
>      elif

I think xencall should be part of the base xen_stable_libs anyway.

Cheers,

   Paul
