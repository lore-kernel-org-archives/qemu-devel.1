Received: from eggs.gnu.org ([2001:4830:134:3::10]:51749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edZLd-0006jp-5V
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edZLZ-0002wQ-6R
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:29:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1edZLY-0002u0-T7
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:29:01 -0500
Date: Mon, 22 Jan 2018 10:28:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180122102851.GC31621@stefanha-x1.localdomain>
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801152229.53520.pisa@cmp.felk.cvut.cz>
	<04fbdf17-6431-5d67-6681-3cc0f375b32a@amsat.org>
	<201801190951.35681.pisa@cmp.felk.cvut.cz>
	<6a7d9a42-e0c3-9dbb-5436-57365e558800@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <6a7d9a42-e0c3-9dbb-5436-57365e558800@amsat.org>
Subject: Re: [Qemu-devel] [PATCH V4 2/7] CAN bus support to connect bust to
 Linux host SocketCAN interface.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 10:37:22AM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 01/19/2018 05:51 AM, Pavel Pisa wrote:
> > On Tuesday 16 of January 2018 01:12:09 Philippe Mathieu-Daud=E9 wrote:
> >> On 01/15/2018 06:29 PM, Pavel Pisa wrote:
> > But if the second format is preferred then I update the patch.
> >=20
> >>> Trace events seems as nice feature. But simple text printf
> >>> like output has been enough till now for CAN testing.
> >>> There is no debugging output in production build.
> >>> So I would add tracing infrastructure later if needed.
> >>
> >> They are as useful as console printf, but less invasive and more
> >> powerful: you can use a much precise timing, select which set of events
> >> to display without having to recompile.
> >> The default backend behaves as console printf.
> >>
> >> You should try them :)
> >=20
> > I have tried them on=20
> >=20
> >   pci_update_mappings_del
> >   pci_update_mappings_add
> >   pci_cfg_write
> >=20
> > and they work great. They would be nice for SJA1000
> > register accesses, PCI boards configuration etc.
> > I am not sure how to use them for CAN messages
> > which has a variable length data field.
>=20
> Yes, I hit this problem with variable length data in the SD Bus.
>=20
> Let's ask Stefan what is the best approach (he said "Tracing is not
> great for dumping large amounts of data")

Yes, tracing isn't pcap.  It's not designed for dumping payloads -
especially when the length is more than 64 bytes or so.

I suggest writing out a pcap file so wireshark or tcpdump can be used to
analyze it.  The code is pretty simple, see net/dump.c.

Stefan

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaZbzjAAoJEJykq7OBq3PIv/0H/RvlztNwD6KU+xZTbhnS2W/5
rd9eiMb1IAUlGV9afuZmdUGTHCfTjpdkw6/8QXc3ZR/1N/lx0WMRR1BkVpRge3CX
pT0Vr5C8eUFdzP19plXA17yKz6PydMFqxO/dKFkdYByxE39oui5txhfRXQ6eU8dF
Fz+llUVeGdT9i8yLAp8rMSMs73itC3uI9PZXBkZWSRIYENqlwGhN72sQojfUkBm6
8RbyKlRfXsPcM9VyLbwZp+37JW4ZBz16Ucf9CnrPoiv8ZS9siPbUxa4Ke335bR0f
nxFf7nX09XKvW74izTA54kKvcVFkX/13v2OO1YTgNWVqcXEaiuvRiNgm3YZ3L2Q=
=O7hr
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
