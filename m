Received: from eggs.gnu.org ([2001:4830:134:3::10]:40514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2gu-0004LF-Sp
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2gq-0002it-9r
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:31:32 -0400
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <438af632-8b33-011b-7651-e1172207e6da@redhat.com>
Date: Mon, 2 Oct 2017 10:31:20 -0500
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-4-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BVTq2jOQQUdNGJJR0MLuAD3D2hj87vmwG"
Subject: Re: [Qemu-devel] [PATCH 3/8] qemu-options qemu-doc: Move "Device
 URL Syntax" to qemu-doc
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BVTq2jOQQUdNGJJR0MLuAD3D2hj87vmwG
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <438af632-8b33-011b-7651-e1172207e6da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] qemu-options qemu-doc: Move "Device URL
 Syntax" to qemu-doc
References: <20171002140307.5292-1-armbru@redhat.com>
 <20171002140307.5292-4-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:03 AM, Markus Armbruster wrote:
> Commit 0f5314a (v1.0) added section "Device URL Syntax" to
> qemu-options.hx.  It's enclosed in STEXI..ETEXI, thus affects only
> qemu-options.texi, not --help.  It appears as a subsection under
> section "Invocation".  Similarly, qemu.1 has it as a subsection under
> "OPTIONS".
>=20
> Commit f9dadc9 (v1.1.0) dropped new option -iscsi into the middle of
> this section.  No effect on qemu-options.texi.  It appears in --help
> run together with the "Bluetooth(R) options:" header.
>=20
> Commit c70a01e (v1.5.0) gives it is own heading in --help by moving
> commit 0f5314a's DEFHEADING(Device URL Syntax:) outside STEXI..ETEXI.
> Trouble is the heading makes no sense for -iscsi.
>=20
> Move all of the "Device URL Syntax" Texinfo to qemu-doc.texi.  Mark it
> for inclusion in qemu.1 with '@c man begin NOTES'.  This turns it into
> a separate section outside the list of options both in qemu-doc and in
> qemu.1.
>=20
> There's substantial overlap with the existing qemu-doc section "Disk
> Images".  Mark with a TODO comment.
>=20
> Output of --help will be fixed next.
>=20
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BVTq2jOQQUdNGJJR0MLuAD3D2hj87vmwG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSW8gACgkQp6FrSiUn
Q2rf4wgArhs2KZx7cj8sDB8kEOhOKOSKW0augHlGZZ/zCCebQWNkvoNXGhWYCsKF
4L+Ik7Lt0LDjfbt6TJRNZkQPHbguvUqOndC3TUAUXNm/rwWsXfAG76p6J3S7GOV6
H5oCYY/LcQiYjosqR0ITy2dspPt6LyA1//Uq0MG92F8fgO8tjD8XXns97imZ0ggT
4XYURn2t87wbsca+WjRD4KW4/fpEauvD4AA8ZoXz4nYtvU+QnoFtyJ/VYQf6UxwZ
zSnAkIqKcLxgaHB99bnSWlZ0F4TMFx9iBEI4TEnqqJ94pJwcEbbRVuD5AY6zZseQ
67YURHonsB4uYPJEwJ1pKa2rlxCD/w==
=No/q
-----END PGP SIGNATURE-----

--BVTq2jOQQUdNGJJR0MLuAD3D2hj87vmwG--
