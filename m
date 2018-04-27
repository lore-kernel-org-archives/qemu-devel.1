Received: from eggs.gnu.org ([2001:4830:134:3::10]:56933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBXP-0002TJ-SQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBXL-0007Ij-Bg
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:08:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fCBXL-0007G0-5N
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:08:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBB45406E97F
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 22:08:14 +0000 (UTC)
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-7-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd942a4c-cd04-7acc-8249-96be0471af56@redhat.com>
Date: Fri, 27 Apr 2018 17:08:13 -0500
MIME-Version: 1.0
In-Reply-To: <1524841523-95513-7-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FKooGbRwtd3dZo5UegIAtS1Y0RLVkl149"
Subject: Re: [Qemu-devel] [PATCH v6 06/11] tests: let qapi-schema tests
 detect allowed-in-preconfig
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
--FKooGbRwtd3dZo5UegIAtS1Y0RLVkl149
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com
Message-ID: <cd942a4c-cd04-7acc-8249-96be0471af56@redhat.com>
Subject: Re: [PATCH v6 06/11] tests: let qapi-schema tests detect
 allowed-in-preconfig
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
 <1524841523-95513-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1524841523-95513-7-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 10:05 AM, Igor Mammedov wrote:
> use new allowed-in-preconfig parameter in tests.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/qapi-schema/doc-good.out          |  4 ++--
>  tests/qapi-schema/ident-with-escape.out |  2 +-
>  tests/qapi-schema/indented-expr.out     |  4 ++--
>  tests/qapi-schema/qapi-schema-test.out  | 20 ++++++++++----------
>  tests/qapi-schema/test-qapi.py          |  4 ++--
>  5 files changed, 17 insertions(+), 17 deletions(-)

Might also be worth adding a negative test, similar to oob-test.json, as
well as tweaking qapi-schema.json to have at least one command with the
property set to true...

> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -16,7 +16,7 @@ object Empty1
>  object Empty2
>      base Empty1
>  command user_def_cmd0 Empty2 -> Empty2
> -   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
> +   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
>  enum QEnumTwo ['value1', 'value2']
>      prefix QENUM_TWO
>  object UserDefOne

=2E..so that this file tests as much as possible independently from our
normal QMP schema.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FKooGbRwtd3dZo5UegIAtS1Y0RLVkl149
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjn00ACgkQp6FrSiUn
Q2rOnAf9GapPg9pcTHFj5WTcAI0indqSst9QKafiAZ4QrOMTxjNiLBLSK+WHmHm9
6n4ev+6aadSRnNCpDUNGPLamAcuZmW/aZqZSIhc+bvIBQWMniSdvhyLW6xLhJGa5
NFWZFNwFvf7lmdOEwKlqqQqkGtRpSwn4HhhbVho6zhkrQSAih5pNnTtm6uAjXoDi
/eEJ+KpGzRSQq2hNOPYlTzKqcACMAq9jOkpN4xrUCqdvRxdaUadp2EnU09xt0qk1
QfJvPnp+tyVG3Dt4w1bMv0BtP/vSwZrqrLFfkqk4bM+i+/1pDh8J8EJRfrU+hPpd
ZyNd3hZHFzIpud9kctmSNDZqZmuv3A==
=gdT3
-----END PGP SIGNATURE-----

--FKooGbRwtd3dZo5UegIAtS1Y0RLVkl149--
