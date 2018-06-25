Received: from eggs.gnu.org ([2001:4830:134:3::10]:44190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fXOn0-0005Zc-3a
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fXOmz-0005Ys-BU
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:32:06 -0400
Date: Mon, 25 Jun 2018 12:31:38 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180625103138.GJ16514@angien.pipo.sk>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622154042.GS23296@redhat.com>
	<CAFEAcA9ksxY+CkGFhD=cGK=zoAvtGAdd_hG1L91js_SKK0RCxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8SdtHY/0P4yzaavF"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ksxY+CkGFhD=cGK=zoAvtGAdd_hG1L91js_SKK0RCxQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 25/26] block: Remove deprecated -drive
 option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Jeff Cody <jcody@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>


--8SdtHY/0P4yzaavF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 11:01:46 +0100, Peter Maydell wrote:
> On 22 June 2018 at 16:40, Daniel P. Berrang=E9 <berrange@redhat.com> wrot=
e:
> >  - SD card - requires -drive with if=3Dsd, no -device support AFAICT
>=20
> Hmm? You can use -device if you want:
>   -drive if=3Dnone,id=3Dmydrive,... -device sd-card,...,drive=3Dmydrive
> (the sd-card device then plugs into the sd controller device
> via the sd-bus bus).
>=20
> Most command lines floating around on the web use if=3Dsd, though
> (which doesn't require explicit creation of the sd-card device.)

When I've spoke with Markus during the KVM forum he found out that some
machine types still don't support that, so that why libvirt didn't
bother converting it yet.

--8SdtHY/0P4yzaavF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlswxIoACgkQHGwCByjY
1GqVzRAApvARcLzAL+UID4dCHZwKjRhLd3JujUQb7ff/KlcgoF0ZkIFtA7wS7pV7
hr6cXfvfFs1Lf3FAY29M7Axh52KslZnDHT75tAYpO/HS1VwBR9qIL3ScDx9G/vRy
D2nykNcOWvgK4aFI9TidGVXbA2xJq4qkzr6nUhTmkIkokF0xPoPBsYMdMilpk185
JdbQRf4f0DD88hH5MIJ8kEbK5LdNLgQNk67VE3dj1MCmEPFwhLMyybC1eXxjsucl
AU9PJ7iHt92bhHN6cVkRXWubEu1/j9YdNofymrBmejzyjOrRP+eaAH59Xs0Zqz5m
NuhsNM3Q47HfFKVAwph53tiYjNenxhChpbpqSZ4MJGWqC1JpEsP1rNdGTcS724GV
YHB8yC44EnaHNzFnLL+ZDe55yhDlCL82PEkjZmksPGWXljmdrL7B5EzfNn0NGlWh
G9vW6NN5GpoeB0+vQIOO3niWZiyzvgGskSjc7+OnMZXC/V1hIgzXqCz3CikUWpGS
aW/1C1STmZcT5so1NSzx7NLUJ7/vPeaPxLq5e30ImPXSCxMzMj0aRRq3IGIoGeG6
eQgTiKNJVxtwZWZWtXn0Of0TuVeqPhEnc0LJzybwpTnlU2uz1VdY/0sRcFiA5bng
IlU0oHuJGbsB33R5HupWbGEG43XmHKumVDVwCqOzyLeGPkM+CyU=
=3mj2
-----END PGP SIGNATURE-----

--8SdtHY/0P4yzaavF--
