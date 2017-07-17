Received: from eggs.gnu.org ([2001:4830:134:3::10]:52903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXAXd-0004E9-4z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXAXZ-0004oM-Q2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:14:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXAXZ-0004nm-H1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:14:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 761462F86EE
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 18:14:40 +0000 (UTC)
References: <20170717180926.14924-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <22df757f-6c8c-9ea9-ef3f-e60a301c6ff5@redhat.com>
Date: Mon, 17 Jul 2017 13:14:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170717180926.14924-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xp9TR7dVa4GALmnPDfHL128vfJ3Axx6kJ"
Subject: Re: [Qemu-devel] [PATCH v2] qapi: Fix error handling code on
 alternate conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xp9TR7dVa4GALmnPDfHL128vfJ3Axx6kJ
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <22df757f-6c8c-9ea9-ef3f-e60a301c6ff5@redhat.com>
Subject: Re: [PATCH v2] qapi: Fix error handling code on alternate conflict
References: <20170717180926.14924-1-ehabkost@redhat.com>
In-Reply-To: <20170717180926.14924-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 01:09 PM, Eduardo Habkost wrote:
> The conflict check added by commit c0644771 ("qapi: Reject
> alternates that can't work with keyval_parse()") doesn't work
> with the following declaration:
>=20
>   { 'alternate': 'Alt',
>     'data': { 'one': 'bool',
>               'two': 'str' } }
>=20
> It crashes with:
>=20
>   Traceback (most recent call last):
>     File "./scripts/qapi-types.py", line 295, in <module>
>       schema =3D QAPISchema(input_file)
>     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 1468,=
 in __init__
>       self.exprs =3D check_exprs(parser.exprs)
>     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 958, =
in check_exprs
>       check_alternate(expr, info)
>     File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 830, =
in check_alternate
>       % (name, key, types_seen[qtype]))
>   KeyError: 'QTYPE_QSTRING'
>=20
> This happens because the previously-seen conflicting member
> ('one') can't be found at types_seen[qtype], but at
> types_seen['QTYPE_BOOL'].
>=20
> Fix the bug by moving the error check to the same loop that adds
> new items to types_seen, raising an exception if types_seen[qt]
> is already set.
>=20
> Add two additional test cases that can detect the bug.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

If this misses tomorrow's freeze deadline, it's borderline for inclusion
in 2.10 (it does not change the qemu binary proper, but rather fixes a
build tool crash, where the crash is only provoked by bad input and we
won't have any bad input at the time of the freeze) - I'll leave it up
to Markus on whether to take now or defer to 2.11.  But either way:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xp9TR7dVa4GALmnPDfHL128vfJ3Axx6kJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlls/o0ACgkQp6FrSiUn
Q2pMvAf+I9XAB7pIBlzAxzMXxzyjufjKeHSGd7Ro228xVYde3DDQ/z2Xawmtq087
AEf3x5IagBXQE/0m2fwDDSzGZ9M9FDOUTOMv5kmABSkrznT8dHrGG3LKf9pK+Vjy
bhueH6OaeXRYlnAmueKEOzXje5kYs0R81uMIrlDIf4BlioEdkmjQDKMM+UAgbA5T
GS6GavbtksFPcByowxG91MsCVKAdNlL/PITwrbpyd6Rr1bvm+wzIr/Ez5Fp357ZG
VrLSCVbLFf6QC1LarfuxYhRLhskG3IUzo2c+xb6uigaPzqji6E/Z9eXqa6uurrPq
4ZFdm+Gt9H/wXZtx+swqwPw6Zbj0Rw==
=9lwK
-----END PGP SIGNATURE-----

--xp9TR7dVa4GALmnPDfHL128vfJ3Axx6kJ--
