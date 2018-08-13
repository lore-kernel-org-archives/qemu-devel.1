Received: from eggs.gnu.org ([2001:4830:134:3::10]:58776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fpAmF-00043H-S2
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fpAmC-0003qp-Jx
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:12:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fpAmC-0003qM-AE
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:12:44 -0400
MIME-Version: 1.0
Message-ID: <44df7d1d-bb51-4c1c-9356-c8318bd84845@default>
Date: Mon, 13 Aug 2018 04:12:40 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH 00/29]: vmsvga: Various fixes and
 enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: rth@twiddle.net, mtosatti@redhat.com, pbonzini@redhat.com, habkost@redhat.com, qemu-devel@nongnu.org


----- kraxel@redhat.com wrote:

> Hi,
>=20
> > > But gdm doesn't start, neither with X11 nor with wayland.  Which
> is a
> > > regression, because the xorg vmware driver manages to handle the
> current
> > > qemu emulation just fine so gnome @ X11 works.
> >=20
> > Interesting. Thanks for finding this out. Will have a look.
> > Can you give more exact details about how you reproduced this
> issue?
>=20
> xorg is easiest, because Fedora 28 uses that by default for vmware
> svga:
>=20
>   (1) download Fedora 28 workstation live iso.
>   (2) boot in qemu with -vga vmware.
>=20
> To try wayland you have to install fedora to disk (can be done using
> the
> workstation live iso).
>=20
> You can switch between xorg and wayland using /etc/gdm/custom.conf
> then,
> by commenting/uncommenting the WaylandEnable line ...
>=20
>    [daemon]
>    # Uncoment the line below to force the login screen to use Xorg
>    #WaylandEnable=3Dfalse
>=20
> ... and rebooting.
>=20
> > I prefer to have a similar setup to make sure we have fixed the
> > regression in this series.
>=20
> xorg regression needs fixing.
>=20
> Having wayland working too would be nice, but wayland doesn't work
> with
> the current emulation either.  So it isn't a regression and can be
> done
> as separate patch series later on.
>=20
> cheers,
>   Gerd

Thanks for the info.
We will reproduce and attempt to fix them both.
Stay tuned.

Regards,
-Liran
