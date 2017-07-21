Received: from eggs.gnu.org ([2001:4830:134:3::10]:47350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZU0-0008Sb-Ad
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZTw-0004p3-Aw
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYZTw-0004nu-1q
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:04:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CB1FC073D77
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 15:04:43 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-10-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7a634ae-bdd9-3690-c87e-349888736ffc@redhat.com>
Date: Fri, 21 Jul 2017 10:04:42 -0500
MIME-Version: 1.0
In-Reply-To: <1500645206-13559-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CGmaIv6e4aicTFB0dtuMP8wDnMf2Xujnk"
Subject: Re: [Qemu-devel] [PATCH 9/9] tests/libqtest: Enable compile-time
 format string checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CGmaIv6e4aicTFB0dtuMP8wDnMf2Xujnk
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c7a634ae-bdd9-3690-c87e-349888736ffc@redhat.com>
Subject: Re: [PATCH 9/9] tests/libqtest: Enable compile-time format string
 checking
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:53 AM, Markus Armbruster wrote:
> qtest_qmp() & friends pass their format string and variable arguments
> to qobject_from_jsonv().  Unlike qobject_from_jsonv(), they aren't
> decorated with GCC_FMT_ATTR().  Fix that to get compile-time format
> string checking.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/libqtest.h | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)

Don't know how much of this to merge with my fixed version of 2/9.  But
matches what I had locally after my version 1, before I ripped it all
back out again prior to posting my v2 when dealing with gcc fallout,
that you've now corrected.

> @@ -65,7 +66,8 @@ void qtest_qmp_discard_response(QTestState *s, const =
char *fmt, ...);
>   *
>   * Sends a QMP message to QEMU and returns the response.
>   */
> -QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
> +QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
> +    GCC_FMT_ATTR(2, 3);

This would fit on one line; any reason we need the line wrap?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CGmaIv6e4aicTFB0dtuMP8wDnMf2Xujnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyGAoACgkQp6FrSiUn
Q2qHIAgAmz8P5qZ2k8a88D0SpFXQXRz5Mm7r3Ws2mOL+DVUZMwaN2K4AEPhVg+L3
TcUMeIgTCOesi49hP2TYWbAsA8Ctxe+Zl8Jj+HyP55dmqyXTaOsaLeRjLIyO4ejJ
SAHr6uEavewbhCzA5Kr+OYljoYLRNQIPciH8i/oRq/gRzdW1ufDfpWfgLgNEfENx
sxBFNUABdwfsFeIHexESL0fzIKHtfhWb0DaZCgrL0vAHDXBVhVbW7pXRaksCXzN3
dsPfgTOVD6sZ0qIKrATqQ6djkRhArlMfSf8bcluDKgxzLod7siU2lCu+7+RR45UW
eOyD6GWXBGDoR8IiyRdvXsOU43TjmQ==
=w3UU
-----END PGP SIGNATURE-----

--CGmaIv6e4aicTFB0dtuMP8wDnMf2Xujnk--
