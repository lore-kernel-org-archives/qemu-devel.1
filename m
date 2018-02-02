Received: from eggs.gnu.org ([2001:4830:134:3::10]:45664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehdAf-0000aU-D0
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehd8i-00063l-TA
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:22:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehd8i-00061f-0k
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:20:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D860765BB
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:12:38 +0000 (UTC)
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-3-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d0177d1-130b-6528-30ae-7f21e4bb56dd@redhat.com>
Date: Fri, 2 Feb 2018 09:12:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180202111022.19269-3-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OCYkNWIIXFAP5WUaKGErIIRLPC6b5ld0l"
Subject: Re: [Qemu-devel] [PATCH v3 02/12] vl: deprecate -alt-grab and
 -ctrl-grab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OCYkNWIIXFAP5WUaKGErIIRLPC6b5ld0l
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <3d0177d1-130b-6528-30ae-7f21e4bb56dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 02/12] vl: deprecate -alt-grab and
 -ctrl-grab
References: <20180202111022.19269-1-kraxel@redhat.com>
 <20180202111022.19269-3-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  vl.c          | 8 ++++++++
>  qemu-doc.texi | 6 ++++++
>  2 files changed, 14 insertions(+)
>=20

>              case QEMU_OPTION_ctrl_grab:
> +                g_printerr("The -ctrl-grab switch is deprecated, and w=
ill be\n"
> +                           "removed in a future release.\n");
>                  ctrl_grab =3D 1;
>                  break;
>              case QEMU_OPTION_no_quit:
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index aa7180a3d9..5961c7a211 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2756,6 +2756,12 @@ support for frameless windows, and the other use=
r interfaces never
>  implemented this in the first place.  So this will be removed together=

>  with SDL 1.2 support.
> =20
> +@subsection -alt-grab and -ctrl-grab (since 2.12.0)
> +
> +The ``-alt-grab'' and ``-ctrl-grab'' arguments are deprecated.  They
> +work with SDL only.  They will eventually replaced with a new way to
> +configure hotkeys which works consistently across all user interfaces.=


Should the error message printed to the user document the new interface
to be used instead? But that implies that we shouldn't deprecate this
until the new interface for configuring hotkeys has been finalized...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OCYkNWIIXFAP5WUaKGErIIRLPC6b5ld0l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0f80ACgkQp6FrSiUn
Q2o8OQf8DGWTG0HG+VYjD0b33Jk/5Fu9+OMXFmjhGrIbLM+9g1ZWFSAfKdTpAgJ7
VzEhWHrP0OMdxNlb7bF3aXzFReoS0cy7IaEPfIBBowgYOtSHbfh12Nwrvcmy8PqA
ntGxAsoGHZ0NO/EEHAzrDJZA6bNrCT9srb87u6kV/83kdIs36an+Jc9IfeBcuk2D
4ffPk9j6IJyem76Rz59t0HnGkxXbBBJqppixAwvj5u0ztqZrwIIepsoo+QWOecp1
uPL6RqZEhdIcWb1gcDOWGhz8f9KgKseB+7rkXRlVCMRB0SRngC5z3/EwKYwN26RX
6sG//snpRLvkvWGnM7fRqfaAGTwBqA==
=8LdJ
-----END PGP SIGNATURE-----

--OCYkNWIIXFAP5WUaKGErIIRLPC6b5ld0l--
