Received: from eggs.gnu.org ([2001:4830:134:3::10]:50945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjBn8-0002R0-0N
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjBn3-0004mZ-U5
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:28:09 -0500
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:32815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjBn3-0004gI-OG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:28:05 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id F22F4B418C
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 22:27:56 +0100 (CET)
Date: Wed, 1 Mar 2017 22:27:48 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170301222748.2c7a3ead@bahia.lan>
In-Reply-To: <20170301115026.22621-1-stefanha@redhat.com>
References: <20170301115026.22621-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/McitOF.P4kcKZk0VvAcBZCH";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] throttle: improve command-line
 parameter documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Nini Gu <ngu@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org

--Sig_/McitOF.P4kcKZk0VvAcBZCH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  1 Mar 2017 11:50:23 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> v3:
>  * Added Patch 2 to fix invalid test parameters
>  * Switched to nicer max < avg check [Berto]
> v2:
>  * Fixed s/bps/iops/ copy-paste error in Patch 1 [Berto]
>  * Rephrased warning about guest hangs and errors [Berto]
>  * Added Patch 2 to hide the internal .max value from the monitor
>=20
> Patch 1 fleshes out the documentation for I/O throttling command-line
> parameters.
>=20
> Patch 2 hides an internal value that was being exposed to users via the
> monitor and caused confusion.
>=20
> I ended up not adding QMP-style throttling.* names to the command-line
> documentation because the names are very long and unlikely to be used.  I
> couldn't see a nice way of adding them while still keeping the documentat=
ion
> readable.
>=20

I only see this series now and it's a bit unfortunate... throttling options
are now also available for fsdev. Only QMP-style names were added though,
and they appear in the documentation. I agree the names are long, and the
result isn't pretty on 80 columns, but it is readable still.

I don't really want to add code, just to have shorter names and a prettier
output. But it would be a good thing for fsdev to benefit from this new
documentation... any suggestion how to do that ?

> Stefan Hajnoczi (3):
>   qemu-options: explain disk I/O throttling options
>   throttle: do not use invalid config in test
>   throttle: make throttle_config(throttle_get_config()) symmetric
>=20
>  tests/test-throttle.c |  8 ++++----
>  util/throttle.c       | 14 ++++++++++++++
>  qemu-options.hx       | 24 ++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 4 deletions(-)
>=20


--Sig_/McitOF.P4kcKZk0VvAcBZCH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli3PNUACgkQAvw66wEB28JDhgCghHZdcXM8iXxM2SWNG8vmXxU2
zGgAnitePU8tMBgVNJjFfwGgGGAQJItE
=I1LU
-----END PGP SIGNATURE-----

--Sig_/McitOF.P4kcKZk0VvAcBZCH--
