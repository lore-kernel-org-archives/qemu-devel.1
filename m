Received: from eggs.gnu.org ([2001:4830:134:3::10]:60479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcD3i-0000li-4w
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcD3h-0005WM-AB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:56:42 -0400
References: <20170726130337.24102-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac8960ca-5149-19d3-3853-bcd8c0445e8f@redhat.com>
Date: Mon, 31 Jul 2017 10:56:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170726130337.24102-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q64XIWst9s9oqWgftx0McdEWPu45RX0dP"
Subject: Re: [Qemu-devel] [PATCH v3] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, el13635@mail.ntua.gr

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q64XIWst9s9oqWgftx0McdEWPu45RX0dP
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, el13635@mail.ntua.gr
Message-ID: <ac8960ca-5149-19d3-3853-bcd8c0445e8f@redhat.com>
Subject: Re: [PATCH v3] docs: add qemu-block-drivers(7) man page
References: <20170726130337.24102-1-stefanha@redhat.com>
In-Reply-To: <20170726130337.24102-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 08:03 AM, Stefan Hajnoczi wrote:
> Block driver documentation is available in qemu-doc.html.  It would be
> convenient to have documentation for formats, protocols, and filter
> drivers in a man page.
>=20
> Extract the relevant part of qemu-doc.html into a new file called
> docs/qemu-block-drivers.texi.  This file can also be built as a
> stand-alone document (man, html, etc).
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
>  * Rebased due to LUKS documentation conflict [Kevin]

Building in-tree on Kevin's block branch now sees this in git status:

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	docs/qemu-block-drivers.html
	docs/qemu-block-drivers.txt

Can we get those added to .gitignore (either squashed in here, or as a
followup)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q64XIWst9s9oqWgftx0McdEWPu45RX0dP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/Uy8ACgkQp6FrSiUn
Q2qcXgf+MZiNzQoScMq5gQwr15f8ixYBW4G7jnrzQ0HGogedyJjCLwy6KyiMsBux
0sxUEJ9wO0u4vSdRPH9L+CX7f9G8aMH+kePDhE9iPB4c1nrhYmn6iJ4KbTV4LSNx
PjogH12+9bV7AiCgNP3ipfzd8TLHBtSiG/Tk7b+J2GKC95e8hTQhxxnBquW+Z7EV
O/jj6gspzd5eNRd/Ko5uBi3Hyjr9if2pRnwqovgrjVLDwyPv3TbGTlygF+mu5N0k
BajVHkL2cNNQrWxv4vTCFPJPM4+dpaYGMJICZSEcgNtirunTpOMKXY9hIvJL5m2P
12sn96meJv9ROt48CLD4FouOIqqvtg==
=+fKq
-----END PGP SIGNATURE-----

--Q64XIWst9s9oqWgftx0McdEWPu45RX0dP--
