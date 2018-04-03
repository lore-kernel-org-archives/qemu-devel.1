Received: from eggs.gnu.org ([2001:4830:134:3::10]:56627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3Qw5-0004r0-AL
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3Qw2-0008Tj-74
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 14:45:37 -0400
References: <20180326184147.1565719-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cceeaa0f-946d-5c26-2fad-55cebbb73027@redhat.com>
Date: Tue, 3 Apr 2018 13:45:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180326184147.1565719-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fMrb6uERX3NjXmOY2DMtI2stMHhjjNb7B"
Subject: Re: [Qemu-devel] [PATCH for-2.12] maint: Add .mailmap entries for
 patches claiming list authorship
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fMrb6uERX3NjXmOY2DMtI2stMHhjjNb7B
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org
Message-ID: <cceeaa0f-946d-5c26-2fad-55cebbb73027@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] maint: Add .mailmap entries for
 patches claiming list authorship
References: <20180326184147.1565719-1-eblake@redhat.com>
In-Reply-To: <20180326184147.1565719-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/26/2018 01:41 PM, Eric Blake wrote:
> The list did not author any patches, but it does rewrite the
> 'From:' header of messages sent from any domain with restrictive
> SPF policies that would otherwise prevent the message from reaching
> all list recipients.  If a maintainer is not careful to undo the
> list header rewrite, and the author did not include a manual
> 'From:' line in the body to fix the munged header, then 'git am'
> happily attributes the patch to the list.  Add some mailmap
> entries to correct the few that have escaped our attention; while
> we also work on improving the tooling to catch the problem in
> the future before a merge is even made.
>=20
> Also improve the comments occurring in the file, including line
> length improvements.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Probably worth inclusion in 2.12-rc1, since it makes statistics
> about the release easier to follow.

I'll include this in my qapi+misc pull for 2.12-rc2

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fMrb6uERX3NjXmOY2DMtI2stMHhjjNb7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrDy8UACgkQp6FrSiUn
Q2pXSQf/dUqCBhdowFfbfUuHPinKrGtXQOU08oyO4I9MkIw2Ph74puutW/wEWOVg
2pxmOy0u1KXfmrjqmZopoHG7DnDyFugk0+NB6WyftcPAulfh3FIJWH/LkkyJJ7Ix
1RyhzK1l/Vt1fPQQ+RseICf7cFha3C5LmaKQXUpWp9E0zhnV//jCDm2qCM6e0qiQ
OK35f+9Tbbz/RtIPiAHBy4UfRG4WOWTIbJgJyeW8E/DU1XkUkJO2yUqqQUR+Ktrt
7l99YL01yZWmu6KCmBIsnP+ixhXP02w7aeNG3okSpx+D5nyKZ+izge2kutJ8WRyJ
+Fs5G9fOQq0muLqdVmE7613lAR5Glw==
=4yDl
-----END PGP SIGNATURE-----

--fMrb6uERX3NjXmOY2DMtI2stMHhjjNb7B--
