Received: from eggs.gnu.org ([2001:4830:134:3::10]:56026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dYXGS-00076X-0P
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dYXGO-0002QB-Tr
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dYXGO-0002Od-Nb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:42:36 -0400
Message-ID: <1500640952.12926.9.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Jul 2017 14:42:32 +0200
In-Reply-To: <eeba9fcf-4b52-2c24-af03-d88333cd2dc6@redhat.com>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500533554.6553.1.camel@redhat.com>
	<3e0f92ea-58ce-abfb-1aed-4d56c1fa68b2@redhat.com>
	<1500631461.12926.5.camel@redhat.com>
	<eeba9fcf-4b52-2c24-af03-d88333cd2dc6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH 0/2] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>

On Fri, 2017-07-21 at 15:15 +0300, Marcel Apfelbaum wrote:
> On 21/07/2017 13:04, Gerd Hoffmann wrote:
> > =C2=A0=C2=A0=C2=A0Hi,
> >=20
> > > > What about window sizes?=C2=A0=C2=A0IIRC there was a plan to prov=
ide
> > > > allocation
> > > > hints for them too ...
> > >=20
> > > Yes, is in my TODO list, however not as part of Aleksandr's
> > > series
> > > which aims to provide PCIe-PCI bridge hotplug support.
> >=20
> > I'd prefer to have a single vendor capability for all resource
> > allocation hints provided by qemu.
> >=20
>=20
> [Adding Laszlo]
>=20
>=20
> Sure, the capability looking something like:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0[flags: reserve-buses|reserve-IO|reserve-MEM|..=
.]
> =C2=A0=C2=A0=C2=A0=C2=A0[extra-buses][IO-size][MEM-size]
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0if reserve-buses -> use 'extra-buses' value and=
 so on

Do we need the flags?  We can use "value =3D=3D 0 -> no hint for you".
Also what about prefetchable vs. non-prefetchable memory?  I guess we
want a size hint for both memory windows?

cheers,
  Gerd
