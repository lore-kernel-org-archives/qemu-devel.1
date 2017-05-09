Received: from eggs.gnu.org ([2001:4830:134:3::10]:40141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8AEP-0005X2-1F
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8AEK-0000Fv-FQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37767)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8AEK-0000Fp-6I
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:51:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD42680F9E
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 18:51:26 +0000 (UTC)
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <99e29bb5-2f6f-68a6-4ec8-4e9c445a72bd@redhat.com>
Date: Tue, 9 May 2017 13:51:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170509173559.31598-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="79EJjTsHLgo2JeTOjT87eUf45u9nXLvbH"
Subject: Re: [Qemu-devel] [PATCH 03/17] tests: remove alt num-int cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--79EJjTsHLgo2JeTOjT87eUf45u9nXLvbH
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <99e29bb5-2f6f-68a6-4ec8-4e9c445a72bd@redhat.com>
Subject: Re: [PATCH 03/17] tests: remove alt num-int cases
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
 <20170509173559.31598-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 12:35 PM, Marc-Andr=C3=A9 Lureau wrote:
> There are no real users of this case, and it's going to be invalid afte=
r
> merging of QFloat and QInt use the same QNum type in the following patc=
h.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-keyval.c                     |  3 ---
>  tests/test-qobject-input-visitor.c      | 26 -------------------------=
-
>  tests/qapi-schema/qapi-schema-test.json |  2 --
>  tests/qapi-schema/qapi-schema-test.out  |  8 --------
>  4 files changed, 39 deletions(-)

Is it worth adding tests/qapi-schema/alternate-num-int.json that
attempts to create an alternate on 'int' and 'number' to (eventually)
show that we give a decent error message at QAPI generation time that
such a type is invalid?  Such a test would (eventually be) a negative
replacement test for the (currently positive) test that you are deleting
here, and make it easier to see the point in the series where we flip
the concept from supported to rejected.

That said, it doesn't have to necessarily be done at this point in the
series (since I haven't even yet seen how QNum will look), so it doesn't
hold up review of this particular patch.

Also, this may interact with Eduardo's current attempt (or at least
start of an attempt) to tighten the QAPI parser to reject alternates
that would otherwise be ambiguous when passed through the string input
visitor (for example, forbidding the combination of an enum starting
with a digit in an alternate that also accepts integers).  So be aware
that we may have some integration things to think about down the road.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--79EJjTsHLgo2JeTOjT87eUf45u9nXLvbH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEg+mAAoJEKeha0olJ0NqcJAIAK55xSLFXpG+Z+/k3cybr5rN
xQOSjDFqGwhIa/ucp4IRLXFUeQ0fcBHU2cVlgTRd8B+bsY6OeS62BuX+0WJhFIvS
RnM9FwD0+DICyJru925it/gWu7e83a6OtNAAfZ8AbkksXfql8C/hiPeJ0w+T2i0M
gFxSurza5e5Up6MnboAB85f4+eVHbb3m521eKrgyvpeeExLtOtDFI8L0RwRvMgwc
bpFi4ATKbw7zXaEodMcilgSwxueedsL9jaghvaVAxWRfLKfyBArnPSjrUrqOc8CA
KMFtWXj2mL0jEwlS1rQyXqDfDka3UHAFvGJrin41N9tlpoBSP8pcXq1h4epcbgo=
=NZKg
-----END PGP SIGNATURE-----

--79EJjTsHLgo2JeTOjT87eUf45u9nXLvbH--
