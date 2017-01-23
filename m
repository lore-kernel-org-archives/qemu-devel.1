Received: from eggs.gnu.org ([2001:4830:134:3::10]:57451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVcpv-0000Iy-TS
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVcps-0005wu-Pz
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:30:59 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cVcps-0005we-Iy
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:30:56 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so25756823wmd.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 03:30:56 -0800 (PST)
Date: Mon, 23 Jan 2017 11:30:36 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170123113036.GJ29186@stefanha-x1.localdomain>
References: <1485163195-17547-1-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DesjdUuHQDwS2t4N"
Content-Disposition: inline
In-Reply-To: <1485163195-17547-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: Re: [Qemu-devel] [PATCH V1] throttle:Removed duplicate throtlle
 code from block and 9p files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: Greg Kurz <groug@kaod.org>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org


--DesjdUuHQDwS2t4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2017 at 04:19:55AM -0500, Pradeep Jagadeesh wrote:
> This will allow other subsystems (i.e. fsdev) to implement throttling
> without duplicating the command line options.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---
>  blockdev.c                      | 80 ++---------------------------------
>  fsdev/qemu-fsdev-opts.c         | 80 ++---------------------------------
>  include/qemu/throttle-options.h | 93 +++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 101 insertions(+), 152 deletions(-)
>  create mode 100644 include/qemu/throttle-options.h
>=20
> There is some code duplication around the command line options. This patch
> is a first proposal to reduce the duplication.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DesjdUuHQDwS2t4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYhelcAAoJEJykq7OBq3PIOsIH+wdYA2+hoqAocrwB8jGbF+pM
J84PEWbYAq8x5kUgMFyfaPraCJbePmzsMY8PQ5kZ8O6mIEXCBCHpdnv3/quJh9Hj
6DCVBf2PyFzzt0Y4a1Aua5L7YRXNFQvH1ljbAMNtQEqZa/2mb9S2b4fQGfuiNZzI
Gq5WThaIRPh6PPVlH45Hs4LKjByEw3OBd/JeaPHvATSDJ9hrCYm+8ff0CBly1YDA
Pr493/apcClKJB8URYcYbhqaWIyWLhDV47C4NXF7x6YaowMHd2v2zUJ6nSEGCPqv
RPucFh4KrCeHoQKaaWb73LpL/4GoLyp6t9JAZ+0ka+Vk1IQ9GcHX8oAl0KEtNIM=
=Wi/G
-----END PGP SIGNATURE-----

--DesjdUuHQDwS2t4N--
