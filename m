Received: from eggs.gnu.org ([2001:4830:134:3::10]:40026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dktyd-0001oN-Qc
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dktyZ-0003mF-6m
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dktyY-0003lG-Sy
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:23:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF7D67EA93
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 15:23:15 +0000 (UTC)
References: <1503384739-17207-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da7c1a48-9c9e-c416-8b25-2f9a53a417b4@redhat.com>
Date: Thu, 24 Aug 2017 10:23:07 -0500
MIME-Version: 1.0
In-Reply-To: <1503384739-17207-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eHDA7S2KAQrTVEUdoOPgkwEsFPLKThEFT"
Subject: Re: [Qemu-devel] [PATCH] qobject: Explain how QNum works, and why
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eHDA7S2KAQrTVEUdoOPgkwEsFPLKThEFT
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mreitz@redhat.com
Message-ID: <da7c1a48-9c9e-c416-8b25-2f9a53a417b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qobject: Explain how QNum works, and why
References: <1503384739-17207-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1503384739-17207-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/22/2017 01:52 AM, Markus Armbruster wrote:
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qnum.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
> index 09d745c..9182129 100644
> --- a/include/qapi/qmp/qnum.h
> +++ b/include/qapi/qmp/qnum.h
> @@ -23,6 +23,27 @@ typedef enum {
>      QNUM_DOUBLE
>  } QNumKind;
> =20
> +/*
> + * QNum encapsulates how our dialect of JSON fills in the blanks left
> + * by the JSON specification (RFC 7159) regarding numbers.
> + *
> + * Conceptually, we treat number as an abstract type with three
> + * concrete subtypes: floating-point, signed integer, unsigned
> + * integer.  QNum implements this a discriminated union of double,

s/this/this as/

> + * int64_t, uint64_t.
> + *
> + * The JSON parser picks the subtype as follows.  If the number has a
> + * decimal point or an exponent, it is floating-point.  Else if it
> + * fits into int64_t, it's signed integer.  Else if it first into

s/first/fits/

> + * uint64_t, it's unsigned integer.  Else it's floating-point.
> + *
> + * Any number can serve as double: qnum_get_double() converts under
> + * the hood.
> + *
> + * An integer can serve as signed / unsigned integer as long as it is
> + * in range: qnum_get_try_int() / qnum_get_try_uint() check range and
> + * convert under the hood.
> + */
>  typedef struct QNum {
>      QObject base;
>      QNumKind kind;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eHDA7S2KAQrTVEUdoOPgkwEsFPLKThEFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlme71wACgkQp6FrSiUn
Q2rZ8wf/f2LKDKDxIQDY4ND/j24xXQzRNSfuxeWfq20Kb5Nxis2e0FjkVttbNHq/
cMrJFRVxWy+QquhGZGI2oU9p8bxzWQTb32fQ8sxV6Wu/3ijUcDrpH9Ds8JGljDSJ
a6a72xdoZKr3OjctDqI/eA6V1Ol0/BgL6sdif4vjbUBKGisLm1iiWdiDiMOo/XT+
RBoyMJYTBruEgXUj8T/5roz/PblIQlqYp9lXxcrqEUenjgMZudZ41p+pWe2itiHM
6GQdNx7t1YYew4QjgQieu0T8xMGwmkW3dpMmHcB9qR8SpShMh3rW+0OfhEff47Tl
kDZo3pZBH4hGKc+SxMTGu+QyLUcx4A==
=Edvc
-----END PGP SIGNATURE-----

--eHDA7S2KAQrTVEUdoOPgkwEsFPLKThEFT--
