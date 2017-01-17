Received: from eggs.gnu.org ([2001:4830:134:3::10]:33162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTQXu-0008DM-Cf
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTQXr-0006Ji-CD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:59:18 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cTQXr-0006Ja-4H
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:59:15 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so37187700wmr.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:59:14 -0800 (PST)
Date: Tue, 17 Jan 2017 09:59:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170117095910.GC4265@stefanha-x1.localdomain>
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
	<79bc9757-3ba0-87c3-3502-a25a30e304a3@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <79bc9757-3ba0-87c3-3502-a25a30e304a3@siemens.com>
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>, Wei Wang <wei.w.wang@intel.com>, Markus Armbruster <armbru@redhat.com>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 02:10:17PM +0100, Jan Kiszka wrote:
> On 2017-01-16 13:41, Marc-Andr=E9 Lureau wrote:
> > On Mon, Jan 16, 2017 at 12:37 PM Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> wrote:
> >     So, this is our proposal. Would be great to hear some opinions if y=
ou
> >     see value in adding support for such an "ivshmem 2.0" device to QEM=
U as
> >     well and expand its ecosystem towards Linux upstream, maybe also DP=
DK
> >     again. If you see problems in the new design /wrt what QEMU provide=
s so
> >     far with its ivshmem device, let's discuss how to resolve them. Loo=
king
> >     forward to any feedback!
> >=20
> >=20
> > My feeling is that ivshmem is not being actively developped in qemu, but
> > rather virtio-based solutions (vhost-pci for vm2vm).
>=20
> As pointed out, for us it's most important to keep the design simple -
> even at the price of "reinventing" some drivers for upstream (at least,
> we do not need two sets of drivers because our interface is fully
> symmetric). I don't see yet how vhost-pci could achieve the same, but
> I'm open to learn more!

The concept of symmetry is nice but only applies for communications
channels like networking and serial.

It doesn't apply for I/O that is fundamentally asymmetric like disk I/O.

I just wanted to point this out because lack symmetry has also bothered
me about virtio but it's actually impossible to achieve it for all
device types.

Stefan

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYferuAAoJEJykq7OBq3PICCIIALcqp6JNg5cBvhKVekNhYoPf
mADbiYgtdECzJ3IdSWDjaTsLnfBjJiwpS9NRYnaHD/W1+1v/Gf0IORKaSLajVapP
3G5O6su5Y0DeXax386dozZP63F6lrt8pJX9b/upvUTWkMm39ESNEkuSCBU1qCzCh
sjrMXBKegpCT/oA4674GPTTuVfr3eoNEVD2CJ8gQyuMIp0G2fpSH6fgKJplVvQ2q
FGhF4mQa6WGSfNlw3A5xpPnP0FIpSOJATU2zSz/hoV0pLxbdCfZDrC7W9aLopcDo
DFNiwIBbdH23Uja57isRQl2eEvGNBj/t/MZul1lL5mM7U/HTDMq2EOXjxnyEgIg=
=QpX6
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
