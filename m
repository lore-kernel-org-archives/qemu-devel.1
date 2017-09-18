Received: from eggs.gnu.org ([2001:4830:134:3::10]:51679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtx23-0007uI-FT
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtx1z-0000Uo-Hx
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:28:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dtx1z-0000Ud-8o
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:28:15 -0400
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-3-aik@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05940475-2563-87fc-bdc5-5acb1bba4932@redhat.com>
Date: Mon, 18 Sep 2017 09:28:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170918101709.30421-3-aik@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1lraGoX1WxNBbE9FAvdK51mPMBU11Jtvw"
Subject: Re: [Qemu-devel] [PATCH qemu v3 02/13] exec: Explicitely export
 target AS from address_space_translate_internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1lraGoX1WxNBbE9FAvdK51mPMBU11Jtvw
From: Eric Blake <eblake@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05940475-2563-87fc-bdc5-5acb1bba4932@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu v3 02/13] exec: Explicitely export
 target AS from address_space_translate_internal
References: <20170918101709.30421-1-aik@ozlabs.ru>
 <20170918101709.30421-3-aik@ozlabs.ru>
In-Reply-To: <20170918101709.30421-3-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 05:16 AM, Alexey Kardashevskiy wrote:

Subject line: s/Explicitely/Explicitly/

> This is not so mechanical change in order to move to shared FlatViews
> so make it a separate patch.

Hard to understand; it's unclear whether this is the mechanical addition
of a parameter before the next patch does shared FlatViews, or whether
the next patch is mechanical by virtue of this patch doing the
non-mechanical changes.  Maybe:

Mechanical change to add a parameter to make it easier for the next
patch to share FlatViews.

> The first argument of
> address_space_do_translate() will become a FlatView, however since
> address_space_get_iotlb_entry() still wants AS, hence this change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  exec.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1lraGoX1WxNBbE9FAvdK51mPMBU11Jtvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/1/wACgkQp6FrSiUn
Q2oN0Qf+IEzPbl4JNTbF2ep9PKpvY9Tj2CFvQn7gmVfgkO+8coQMwQafCgOSXpUs
9uE70Bl+qgx7xjiUg38QXp5yVczX/5GNgATJv65/ZWsGiEaYUQ1MMyyx0uvS7Uxy
ybXf/eSMhrK0JDzKIXEFRq1d6JzwbDV89ZSo0xF//t3LZoV1d6H6ppYkQDf9RjAI
k6OTygbmsHR55fSdc02gG+d3/dBNwcIedarjRYXBkn6mwyAVi1r437Xm3mzFOiT5
fGd2FQJ8zDaFhnKqgWZ8US8foWPzkIknrgO+BNTrSFGpdbPy8YyFBnEQG3k0X6ZR
FdAGR0keVDCD5FygU6Vu6EP9mC3/2Q==
=1E7R
-----END PGP SIGNATURE-----

--1lraGoX1WxNBbE9FAvdK51mPMBU11Jtvw--
