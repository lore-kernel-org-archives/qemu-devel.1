Received: from eggs.gnu.org ([2001:4830:134:3::10]:38546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2bP-0007tL-8G
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2bL-0007nK-7x
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:25:51 -0400
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7476e9c-d89e-9142-2d74-7a8235229b4a@redhat.com>
Date: Mon, 2 Oct 2017 10:25:44 -0500
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-2-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p5XtwMK0J3Wmcpl3LCGakcBu9kKFo7Ern"
Subject: Re: [Qemu-devel] [PATCH 1/8] qemu-options: Remove stray colons from
 output of --help
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p5XtwMK0J3Wmcpl3LCGakcBu9kKFo7Ern
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Message-ID: <a7476e9c-d89e-9142-2d74-7a8235229b4a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] qemu-options: Remove stray colons from
 output of --help
References: <20171002140307.5292-1-armbru@redhat.com>
 <20171002140307.5292-2-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:03 AM, Markus Armbruster wrote:
> Commit 43f187a broke --help: it put colons into blank lines.  It
> removed the colon from DEFHEADING(TITLE:) and added it back in the
> macro expansion of DEFHEADING(TITLE), so hxtool can emit "@subsection
> TITLE" more easily.  Trouble is it's added back even for the blank
> lines made with DEFHEADING().
>=20
> Put the colons back where they were before commit 43f187a, and strip
> them in hxtool instead.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> CC: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options-wrapper.h |  2 +-
>  qemu-options.hx        | 27 ++++++++++++++-------------
>  scripts/hxtool         |  3 ++-
>  3 files changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--p5XtwMK0J3Wmcpl3LCGakcBu9kKFo7Ern
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSWngACgkQp6FrSiUn
Q2opeAf9FI904LBW+XiuB/N9z2D+l9nO5ttCNbdGlBC1hZ3Upe4topOLx5A1gBsQ
shZ8d/RwjoxFmYuv2+15Km+H9RxwrAVuRJcj2ThzfcJp28ci4Pn1VoX0928XC6St
qLtwDcnM8JCE5c8UL9S40DG3OVO3pGlXZY2k5wjdimSrJ19Tou3bs1NMBG2/a/EF
dZFRQklFrEGsWDoExmkTEMI3fDGC4db/bcjqsHISFGzAbda6L9TEtFTYQgLmw6eu
ByYZnSrsfZF5z1AFCNpZljqkxdzEtvpzNXPCQLhHGuP5tXjWDJOTRMSiLBbHEjEP
S/tOUjyX5tGUFLZVPM2xQj7in9usiQ==
=3evP
-----END PGP SIGNATURE-----

--p5XtwMK0J3Wmcpl3LCGakcBu9kKFo7Ern--
