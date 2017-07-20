Received: from eggs.gnu.org ([2001:4830:134:3::10]:42697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDv0-00026b-WA
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDv0-0000j5-0D
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:03:15 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-10-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00d382b3-2dfa-b213-37c9-957a89c6c9dd@redhat.com>
Date: Thu, 20 Jul 2017 11:03:06 -0500
MIME-Version: 1.0
In-Reply-To: <1500560441-5670-10-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gC7S7Ma4QtxSBhGH3kQ5NRcu9nkXm6sd3"
Subject: Re: [Qemu-devel] [PATCH V4 09/10] block/qcow2: add lzo compress
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gC7S7Ma4QtxSBhGH3kQ5NRcu9nkXm6sd3
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <00d382b3-2dfa-b213-37c9-957a89c6c9dd@redhat.com>
Subject: Re: [PATCH V4 09/10] block/qcow2: add lzo compress format
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
 <1500560441-5670-10-git-send-email-pl@kamp.de>
In-Reply-To: <1500560441-5670-10-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 09:20 AM, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2-cluster.c | 15 +++++++++++++++
>  block/qcow2.c         | 42 +++++++++++++++++++++++++++++++++++-------
>  configure             |  2 +-
>  qapi/block-core.json  | 14 ++++++++++++--
>  qemu-img.texi         |  1 +
>  5 files changed, 64 insertions(+), 10 deletions(-)

Where is the change to docs/ for updating the qcow2 spec to document the
new format?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gC7S7Ma4QtxSBhGH3kQ5NRcu9nkXm6sd3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw1DoACgkQp6FrSiUn
Q2qh+wf6AiWJXXXP7e+A4aNuMHQ3CPui7ERUzxABg315y2vY2dwj9XlGHMfI2sD1
WuVElXAF+18xGzVqkHysUGSEU9+hyI+fzm4vT7wjPHILB9wB7XFV1XxmxpnoM1Ss
0mD4E2OdhPUsDFw4i+INKK9a50PTAFvxo+WmcHmhfRnIs3Vi76d6I/glIb0eUCs3
O93lfLa91Zwl7XBhWMEg7pPtfpuF18xz4uLfJa245I1oLER66wT5ogyCqAsiBKoG
vljt+zbkAbjbTWAoOS7JqnlA+pGoj1nYU1mCOILKK9XXQJfDDhBUlzaJrb/0KyD+
pXHnDhyVD5hmnha1QeBZtie76Ve8cg==
=1j8J
-----END PGP SIGNATURE-----

--gC7S7Ma4QtxSBhGH3kQ5NRcu9nkXm6sd3--
