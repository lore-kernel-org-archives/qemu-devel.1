Received: from eggs.gnu.org ([2001:4830:134:3::10]:41158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfAlF-0001pM-Cf
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfAlE-0006hQ-9U
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:05:53 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b7d69526-e675-7edd-dc26-0e2050225804@redhat.com>
Date: Tue, 8 Aug 2017 15:05:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170808183306.27474-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dmEe1gV1uVToHlUlDotwIPUoehkXxwQmI"
Subject: Re: [Qemu-devel] [PATCH 2/9] IDE: Add register hints to tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dmEe1gV1uVToHlUlDotwIPUoehkXxwQmI
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <b7d69526-e675-7edd-dc26-0e2050225804@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] IDE: Add register hints to tracing
References: <20170808183306.27474-1-jsnow@redhat.com>
 <20170808183306.27474-3-jsnow@redhat.com>
In-Reply-To: <20170808183306.27474-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 01:32 PM, John Snow wrote:
> Name the registers for tracing purposes.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/core.c       | 88 +++++++++++++++++++++++++++++++++++++++++----=
--------
>  hw/ide/trace-events |  4 +--
>  2 files changed, 70 insertions(+), 22 deletions(-)

> -    case 1:
> -	ide_clear_hob(bus);
> +    case ATA_IOPORT_WR_FEATURES:
> +        ide_clear_hob(bus);

Cool, fixing tab damage in the process.

I did a similar improvement to NBD traces, and it's definitely worth it
to have traces include names in addition to numbers.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dmEe1gV1uVToHlUlDotwIPUoehkXxwQmI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKGZMACgkQp6FrSiUn
Q2qWIAf+OlrSXmr9b3mN5QYrv86YHB6tHNS7/uOBZmpP1paOcYNJbLfqDtgTb9Xc
QIkPVip07WQ4Jlhfyeh5m86eih/CUOFj3hfn+GVm2nVrb1CFCTkgJ+Uy9T29RutW
2IqYJgxGnMsInPP5QmHwApG5pNc13u6tPfyVBvxjLw1yMEY+fC2yGMipe8kFfIgE
g4VLrFBBirK248P5v/zJzgIXGbppeDlJHJgYfuZ5KFE9OE4Kb4dO3OVa5bNnjrBt
euF9uE57MrhQe5R6ni8z3PFOHWdHXPY8c3oFdk0JPfIEzQs/fa20RnJP7HXUOJaR
eErsGDyPi0jfoPCyBaT/EcUtHxeLaw==
=xelR
-----END PGP SIGNATURE-----

--dmEe1gV1uVToHlUlDotwIPUoehkXxwQmI--
