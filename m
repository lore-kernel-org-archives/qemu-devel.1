Received: from eggs.gnu.org ([2001:4830:134:3::10]:39144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGfC-0000aW-7T
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGfA-0002cR-Po
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:19:54 -0500
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
	<1516279431-30424-5-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76f78388-fb2a-4e39-29a1-338da45b0c32@redhat.com>
Date: Thu, 18 Jan 2018 14:19:43 -0600
MIME-Version: 1.0
In-Reply-To: <1516279431-30424-5-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sfd4cvl87J9fnGltilb2ZaNeOkyECY0LY"
Subject: Re: [Qemu-devel] [PATCH 4/7] qed: make bdrv_qed_do_open a
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sfd4cvl87J9fnGltilb2ZaNeOkyECY0LY
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <76f78388-fb2a-4e39-29a1-338da45b0c32@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/7] qed: make bdrv_qed_do_open a
 coroutine_fn
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
 <1516279431-30424-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516279431-30424-5-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 06:43 AM, Paolo Bonzini wrote:
> It is called from qcow2_invalidate_cache in coroutine context (incoming=


Why is a qcow2 function calling qed code?  Definitely a copy-paste bug,
but I'm not sure of the right fix.

> migration runs in a coroutine), so it's cleaner if metadata is always
> loaded from a coroutine.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/qed.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sfd4cvl87J9fnGltilb2ZaNeOkyECY0LY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphAV8ACgkQp6FrSiUn
Q2pPvwgAlPdbX1bdJOnQAQ26rxwDfOZCJKzKM9f88dCZsafJlnCdwuENEOZCqsFL
5ZNzPqar04rnSI4taCIghKNtymxzy/dJMzPtEA/BtRHBiKYwqlhgjAkd4UYPf4Ag
kPioqtLNwuungcI3GrTQcRYeLS7wuu5N1mjwf11nqN0rNrlqQAzpT6E/YgmESYOm
ZpBEnvKDG96aiI9O2eM0xhSABwmPG7iBkaiG7OYTESiY8JZMP7uKgnq9rfKbn+57
8VrTF26ahevpG5HU0r3jIyUvVDFG8pTIO5vNrHP2rUbUbRRPWJbiGrbusDEP0Bm+
e9DtaFOlZFuwp1tVRapqaqwVKK65RQ==
=PYPq
-----END PGP SIGNATURE-----

--sfd4cvl87J9fnGltilb2ZaNeOkyECY0LY--
