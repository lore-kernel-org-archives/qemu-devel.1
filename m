Received: from eggs.gnu.org ([2001:4830:134:3::10]:34847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8XyO-00059y-3N
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8XyK-0000dH-Qn
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:12:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8XyK-0000d5-He
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:12:32 -0400
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-2-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5f5a368-0784-ca00-173d-b921a748ff12@redhat.com>
Date: Wed, 10 May 2017 15:12:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170510200535.13268-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lcdxbXFQu6rM950EX1ugDofaKixsM3tl3"
Subject: Re: [Qemu-devel] [PATCH 1/8] coccinelle: add a script to optimize
 tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lcdxbXFQu6rM950EX1ugDofaKixsM3tl3
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5f5a368-0784-ca00-173d-b921a748ff12@redhat.com>
Subject: Re: [PATCH 1/8] coccinelle: add a script to optimize tcg op using
 tcg_gen_extract()
References: <20170510200535.13268-1-f4bug@amsat.org>
 <20170510200535.13268-2-f4bug@amsat.org>
In-Reply-To: <20170510200535.13268-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/10/2017 03:05 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/coccinelle/tcg_gen_extract.cocci | 26 ++++++++++++++++++++++++=
++
>  1 file changed, 26 insertions(+)
>  create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci
>=20
> diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccine=
lle/tcg_gen_extract.cocci
> new file mode 100644
> index 0000000000..4080f97cc7
> --- /dev/null
> +++ b/scripts/coccinelle/tcg_gen_extract.cocci
> @@ -0,0 +1,26 @@
> +// optimize TCG using extract op
> +//
> +// Copyright: (C) 2017 Philippe Mathieu-Daud=C3=A9. GPLv2.

Unless you provide a strong reason to the contrary, new files should be
GPLv2+ rather than GPLv2-only.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lcdxbXFQu6rM950EX1ugDofaKixsM3tl3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE3QqAAoJEKeha0olJ0Nq1G0H/AgAyanimbgVQcYu1RFOj4Lp
mGusTY2LXe9DNUxEKRf+L93zzTKDppOw8v74d3lvOLyMn3v3+SJOoux+lzoUjv4q
ejC5czSSDUfzHHn3lv9JO5TaMI+HGoBGEw7IbmWgg+fmDzQxXlynMW8qa16hwKxw
8Aat1l7766NDA6/L7BmJ3hFiArspqUkjmTnlSFpjahwYjMM5erRFFz+SmRuGtHgm
Dpw36we7sPBm106eBY0A7X7c12/uIvGS5VfL9Ch77IE0WGcpOage3vZPgT3r3r5i
phOE/XEdZy88VTAOdoR0ikVvOsdIb4XYrzCQsvXZPwoA2DoffBDztELNMkYQfKs=
=YdKr
-----END PGP SIGNATURE-----

--lcdxbXFQu6rM950EX1ugDofaKixsM3tl3--
