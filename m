Received: from eggs.gnu.org ([2001:4830:134:3::10]:54159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXaff-0005AA-Vb
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXafb-0005ph-BW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:08:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXafb-0005pA-1H
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:08:43 -0400
References: <1500151401-30863-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170717071835.GD22872@lemon>
	<1805860107.204084.1500320230836.JavaMail.zimbra@research.iiit.ac.in>
	<8e003313-8651-1f92-3a0b-d465ab1d1cf7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <799cd2c9-42cb-ed90-6e53-ce5fd7700b13@redhat.com>
Date: Tue, 18 Jul 2017 17:08:30 -0500
MIME-Version: 1.0
In-Reply-To: <8e003313-8651-1f92-3a0b-d465ab1d1cf7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XbGwV3f6oOFd3mDQrHILT5wQ5UanSx5iD"
Subject: Re: [Qemu-devel] [RFC] RFC on Backup tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Ishani <chugh.ishani@research.iiit.ac.in>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XbGwV3f6oOFd3mDQrHILT5wQ5UanSx5iD
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Ishani <chugh.ishani@research.iiit.ac.in>,
 Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha <stefanha@redhat.com>
Message-ID: <799cd2c9-42cb-ed90-6e53-ce5fd7700b13@redhat.com>
Subject: Re: [Qemu-devel] [RFC] RFC on Backup tool
References: <1500151401-30863-1-git-send-email-chugh.ishani@research.iiit.ac.in>
 <20170717071835.GD22872@lemon>
 <1805860107.204084.1500320230836.JavaMail.zimbra@research.iiit.ac.in>
 <8e003313-8651-1f92-3a0b-d465ab1d1cf7@redhat.com>
In-Reply-To: <8e003313-8651-1f92-3a0b-d465ab1d1cf7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 04:29 PM, John Snow wrote:
>>>
>>> You need a copyright header here (the default choice for QEMU is GPLv=
2 but there
>>> is no strict restrictions for scripts). See examples in other *.py fi=
les.
>>
>> Thanks. Will update in next revision.
>> =20
>=20
> Yes, up to you. Files without a copyright default to GPLv2 in the QEMU
> project, but if you feel strongly one way or another you can argue for
> that license in upstream review.

More precisely, the qemu binary is GPLv2 (only), as that is the only
license compatible as the sum of its parts.  But new files default to
GPLv2+ (upgradable to GPLv3, except when mixed with GPLv2-only code).

>=20
> (For instance, documentation and other non-code documents can sometimes=

> be better served by different licenses.)

Indeed, some people (not me) express concern whether a specification
documentation that is GPL would require all implementations of that
specification to also be GPL, and thus intentionally choose a more
permissive license for the documentation (BSD being a common example).
(Personally, I think that a GPL specification merely means that you
can't copy the docs without your copy being GPL, but that you can still
implement the specification using from-scratch non-GPL code - but I'm
not a lawyer, so listening to me may not be the best thing)

>=20
> We tend to avoid the implicit copyright when possible, so including an
> explicit GPLv2 license is preferable to declare intent.

Remember, an explicit GPLv2-only license needs strong justification,
since the implicit license is GPLv2+.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XbGwV3f6oOFd3mDQrHILT5wQ5UanSx5iD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluht4ACgkQp6FrSiUn
Q2qW+Qf/cwPhtayJTxZdvp0ROmw3AXSlPdUGC3iYxtHnvWn2tMpeD2JU5HuGXaOJ
31Vb4lDk+cxQOYcHF0dn3Wkfo4kbIJUVsbxoLoZxSVQBdDU/IjH0sQG3LWOTTM1L
Av52YbWmUogqL2QFtRz48jzjPLjOuITpHRNrYiEaNPdLib+qEJNZeLpAEWQQyMx6
KirrC/W4a8m86QPoCk9EgVA1JO8+k/5FrM9WpED/1cK0udEw5dOd9WsKBFF6XWLq
GSYur30ndLqlyBhIIwZKtMcmYD9BmgIyM/MWoDk4xisV1DNwiN1Nz3+FBRBsx3fa
dIrA3qedylzpzHiExx8wqhrqz/PeFA==
=oRIW
-----END PGP SIGNATURE-----

--XbGwV3f6oOFd3mDQrHILT5wQ5UanSx5iD--
