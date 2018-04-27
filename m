Received: from eggs.gnu.org ([2001:4830:134:3::10]:57479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBar-0003w1-8D
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBam-0007M1-Fd
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:11:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fCBam-0007LR-AZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:11:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09B57FA466
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 22:11:43 +0000 (UTC)
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-8-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e47725ee-da93-5e15-4215-63d94389e87c@redhat.com>
Date: Fri, 27 Apr 2018 17:11:37 -0500
MIME-Version: 1.0
In-Reply-To: <1524841523-95513-8-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V6SqnrDtHdUcwDyIXjiGwTdASBX4XXywi"
Subject: Re: [Qemu-devel] [PATCH v6 07/11] tests: add
 allowed-in-preconfig-test for qapi-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V6SqnrDtHdUcwDyIXjiGwTdASBX4XXywi
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com
Message-ID: <e47725ee-da93-5e15-4215-63d94389e87c@redhat.com>
Subject: Re: [PATCH v6 07/11] tests: add allowed-in-preconfig-test for
 qapi-schema
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
 <1524841523-95513-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1524841523-95513-8-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 10:05 AM, Igor Mammedov wrote:
> make sure the QAPISchema can parse allowed-in-preconfig correctly
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/Makefile.include                           | 1 +
>  tests/qapi-schema/allowed-in-preconfig-test.err  | 1 +
>  tests/qapi-schema/allowed-in-preconfig-test.exit | 1 +
>  tests/qapi-schema/allowed-in-preconfig-test.json | 2 ++
>  tests/qapi-schema/allowed-in-preconfig-test.out  | 0
>  tests/qapi-schema/qapi-schema-test.json          | 3 +++
>  tests/qapi-schema/qapi-schema-test.out           | 2 ++
>  tests/test-qmp-cmds.c                            | 4 ++++

Aha. I'd squash this with patch 6, since it supplies the additional
tests I was asking about there.  (They were separate on the OOB series
more because of the time crunch of getting it in before rc0; but now
that we aren't under a crunch, I'd rather just have one patch for all
new tests).

>  8 files changed, 14 insertions(+)
>  create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.err
>  create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.exit
>  create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.json
>  create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.out
>=20

If you like my bikeshedding for a shorter 'allow-preconfig' name, don't
forget to rename the files as well as their contents.

> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -142,6 +142,9 @@
>  # Smoke test on Out-Of-Band
>  { 'command': 'an-oob-command', 'allow-oob': true }
> =20
> +# test allowed-in-preconfig flag
> +{ 'command': 'allowed-in-preconfig-test', 'allowed-in-preconfig': true=
 }

Why not just have a single command that sets both allow-oob and
allowed-in-preconfig on the same command?  Of course, rename it to
something other than 'an-oob-command', if you merge things into one comma=
nd.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--V6SqnrDtHdUcwDyIXjiGwTdASBX4XXywi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjoBkACgkQp6FrSiUn
Q2q1Egf+OCDFOoDeaBtcuz4URLwBZiY7GuR6BPW9/TRM+IIlA7W+zFJdVLlF6dGx
PyKFx20M6J/pLETu2JsReMaMyRrOlqQ3hVODEOKng/mta/3B3XpdVm/J/02xm0Xc
rxSErOjDXnH+OObnRF6qYAv6CSgSHTi1uR3fs5KA3O6m5THlQkwh4hL1DGMpIOUe
bEGQyfpewtMTeDe7Q96rCrDqfca3bBPPLVhD/2k8P5+zUDAr6vVLPbZtoXcxZo9e
zG6UL1JUe36cKedR3clFhCe6e1U/87g7qqEyI0FSzg/WRZEUxdQMsdG7b0RlSZmW
CixNBPKnth726mYafxFLjeE6UkrbWQ==
=b9T/
-----END PGP SIGNATURE-----

--V6SqnrDtHdUcwDyIXjiGwTdASBX4XXywi--
