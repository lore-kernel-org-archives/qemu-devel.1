Received: from eggs.gnu.org ([2001:4830:134:3::10]:35142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsuma-0000W9-Jf
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsumZ-00044s-HO
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:52:04 -0400
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d4209ba-6dd9-ded2-0675-adc336f95419@redhat.com>
Date: Fri, 15 Sep 2017 12:51:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170915101008.16646-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c99qErWRIgWu7jFnMFN1t2X98rW0Naj4f"
Subject: Re: [Qemu-devel] [PATCH 2/6] block: Add reopen_queue to
 bdrv_child_perm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c99qErWRIgWu7jFnMFN1t2X98rW0Naj4f
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <8d4209ba-6dd9-ded2-0675-adc336f95419@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] block: Add reopen_queue to
 bdrv_child_perm()
References: <20170915101008.16646-1-kwolf@redhat.com>
 <20170915101008.16646-3-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 05:10 AM, Kevin Wolf wrote:
> In the context of bdrv_reopen(), we'll have to look at the state of the=

> graph as it will be after the reopen. This interface addition is in
> preparation for the change.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int.h |  7 +++++++
>  block.c                   | 19 ++++++++++++-------
>  block/commit.c            |  1 +
>  block/mirror.c            |  1 +
>  block/replication.c       |  1 +
>  block/vvfat.c             |  1 +
>  6 files changed, 23 insertions(+), 7 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--c99qErWRIgWu7jFnMFN1t2X98rW0Naj4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8EzkACgkQp6FrSiUn
Q2oV+wf/W3lNkklhWTus8rTPygBjCTWoMMng3jEyeFGFnp92AqPAC2cbKyd2bTPU
oSsxfXI9DAs+XYw34vewor+irUMSTKAQ//kpl47yQ4S0mBnzZkEyMLhVpfFAyJ0T
6tsUiDnhttMS3p0xz+lzPuNimlXeIJwLxY2H3U5hOOCX9Wu1KNbx4bTX5D2s0hXL
peYElImEPWotEZ16SA3y/7VUDX56jThRtxmkkPUyqhnQC+N1UXVJWzB8dQ3mzood
d2GrTXvW6lx7KETx1PTrX7HzNRDTLWOysWtgn13EGhgGERjPKQ4ZL40AVDxSEvPg
S60qxnJIWLkEdX5DBxsmHWlm2PoXfw==
=ggm9
-----END PGP SIGNATURE-----

--c99qErWRIgWu7jFnMFN1t2X98rW0Naj4f--
