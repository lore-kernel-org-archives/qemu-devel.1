Received: from eggs.gnu.org ([2001:4830:134:3::10]:43615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3LVE-0003Go-92
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3LVD-0005sf-Dd
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:57:32 -0400
References: <f7011b6ebc323b45b46a8f01310249e2e6d77617.1522730165.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9b947ec-a9ea-bcd3-efb9-c6d0bce1e150@redhat.com>
Date: Tue, 3 Apr 2018 07:57:14 -0500
MIME-Version: 1.0
In-Reply-To: <f7011b6ebc323b45b46a8f01310249e2e6d77617.1522730165.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3w5luOgqShfREAPI6NcXupyVFGrXm35Mr"
Subject: Re: [Qemu-devel] [PATCH for-2.12] block: handle invalid lseek
 returns gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3w5luOgqShfREAPI6NcXupyVFGrXm35Mr
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <c9b947ec-a9ea-bcd3-efb9-c6d0bce1e150@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] block: handle invalid lseek returns
 gracefully
References: <f7011b6ebc323b45b46a8f01310249e2e6d77617.1522730165.git.jcody@redhat.com>
In-Reply-To: <f7011b6ebc323b45b46a8f01310249e2e6d77617.1522730165.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2018 11:37 PM, Jeff Cody wrote:
> In commit 223a23c198787328ae75bc65d84edf5fde33c0b6, we implemented a
> workaround in the gluster driver to handle invalid values returned for
> SEEK_DATA or SEEK_HOLE.
>=20
> In some instances, these same invalid values can be seen in the posix
> file handler as well - for example, it has been reported on FUSE gluste=
r
> mounts.

Yuck - that should be reported to the FUSE and gluster folks, as it does
not scale to have everyone else work around their bug.  But in the
meantime, working around it here is acceptable.

>=20
> Calling assert() for these invalid values is overly harsh; we can safel=
y
> return -EIO and allow this case to be treated as a "learned nothing"
> case (e.g., D4 / H4, as commented in the code).
>=20
> This patch does the same thing that 223a23c198787 did for gluster.c,
> except in file-posix.c
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/file-posix.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3w5luOgqShfREAPI6NcXupyVFGrXm35Mr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrDei4ACgkQp6FrSiUn
Q2r71wf+JrF38pmOIctGPBKgY4o6Pp9qt5anqvajlf0XKep4VnJdpxI+O5iDq28g
Sea03q60lvqemSLko3i/gWjfqcWp3G87hsOpLbUzeexClSxEjyj810hbFaYaXpuT
WrDj3aOqq8YBAzRQboPhLw114gdw4bVaF1C7bw4xrY8NFWnMLmNBJOfQaBbz0DMe
RScpCb1McQebdzt9u8j4i66guUOVfYn4UUsA+FnhEXdVJ0Fogy35qVlI8AeQ+Kt2
/CcvWY+9V66ItEI3vDPo3jQnigA4mBMUH2PhvpppH1cFioVijrZ5jRiIOqp6unGp
gNuyWNffVS5aSIKdtAmMz6ZRNQMMgg==
=+qGk
-----END PGP SIGNATURE-----

--3w5luOgqShfREAPI6NcXupyVFGrXm35Mr--
