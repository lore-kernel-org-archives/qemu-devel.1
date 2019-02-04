Received: from eggs.gnu.org ([209.51.188.92]:42557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqn9p-0005Zw-OP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqmy6-00029p-Ug
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gqmy6-00028p-FC
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:43:58 -0500
References: <20190204215627.2099-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9889ec82-f1ed-3636-e706-5c359c17e668@redhat.com>
Date: Mon, 4 Feb 2019 16:43:56 -0600
MIME-Version: 1.0
In-Reply-To: <20190204215627.2099-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NRoihj02Xyla4zvMRAfQTZkQa2ezLwC8T"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Flag suspicious attribution
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NRoihj02Xyla4zvMRAfQTZkQa2ezLwC8T
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <9889ec82-f1ed-3636-e706-5c359c17e668@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Flag suspicious attribution
 lines
References: <20190204215627.2099-1-eblake@redhat.com>
In-Reply-To: <20190204215627.2099-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/4/19 3:56 PM, Eric Blake wrote:
> Flag commit attribution tags that are unusual (often because they
> were a typo), but only as a warning (because sometimes a humorous
> or otherwise useful tag is intentionally supplied).
>=20
> This picks the 6-most popular tags, each with 700 or more uses (well,
> S-o-b was already checked for case-sensitivity and typos, leaving
> only 5 new tags being checked), as determined by:
> $ git log | sed -n 's/^ *\([A-Za-z-]*-by:\).*/\1/p' | \
>   sort | uniq -c | sort -k1,1n | tail
>=20
> Most of the rejected lines were obvious typos (among others, we've
> had 4 cases of someone being burnt, based on Singed-off-by; and 2
> cases of list-reading via an e-reader, based on eviewed-by; there
> are also lines forgetting a space after the ':') or otherwise
> tongue-in-check (3 Approximately-suggested-by). A few lines not
> whitelisted here may be legitimate, but as they are orders of
> magnitude rarer, it is therefore not worth worrying about
> (7 Requested-by, 3 Co-authored-by, 1 Inspired-by, etc.).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

>  			}
> +		} elsif($line =3D~ /^\s*([A-Za-z-])*-by:/ &&
> +			($1 !~ /(Suggest|Report|Test|Ack|Review)ed/ ||
> +			 $line !~ /^\s[a-z-]*-by:\S/i)) {

Oops, that last one is supposed to be =3D~, to flag lines that forget the=

space between *-by: and the email address.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NRoihj02Xyla4zvMRAfQTZkQa2ezLwC8T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxYwCwACgkQp6FrSiUn
Q2qeQQf9GVxK4bE5PxUFHW5wpaRUAwGJtc7w70ZGkeObnQ3IaWdzVwPV5tqid3Su
QinSl/yI0TRJhK2tDPgcpamttLP5rw3jBQJpFOnpTlol7jjxNynkEUSaTmlDc5Nb
yOuAt1eGzp7BL4XW/wV/fuLuVhN/DtegtIQPNMboHcJzCBUnisdEV3n0Mg19yBNu
IYjmcQZLP5gSGbrh6Qvf6hX0u0X7POa/igKRWWy+hZeVP97wCo05fnLtybPhN+5w
RctkpEW+RVF4rCB2LkBCfofBQ0lpSoCT2ubhzp3bnR7Xd3DhsL6aSD2XA4U8p1eI
7GuCv97xngzSE7BmToTRVTuyITjk3Q==
=cFkH
-----END PGP SIGNATURE-----

--NRoihj02Xyla4zvMRAfQTZkQa2ezLwC8T--
