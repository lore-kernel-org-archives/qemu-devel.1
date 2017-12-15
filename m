Received: from eggs.gnu.org ([2001:4830:134:3::10]:39384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePukr-0008Rp-0P
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePukm-0001Tw-Vc
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:30:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePukm-0001TJ-Mi
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:30:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D671C2CE95C
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 18:30:35 +0000 (UTC)
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-7-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <47ee2c11-188a-f1ed-d59a-57b53276ca5c@redhat.com>
Date: Fri, 15 Dec 2017 12:30:32 -0600
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-7-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DqvND6aHHEb2AWOMLci50jgCwKhOoIIRm"
Subject: Re: [Qemu-devel] [PATCH v2 06/13] vl: fix direct firmware
 directories leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DqvND6aHHEb2AWOMLci50jgCwKhOoIIRm
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47ee2c11-188a-f1ed-d59a-57b53276ca5c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/13] vl: fix direct firmware directories
 leak
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
 <20171215150659.1811-7-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 09:06 AM, Marc-Andr=C3=A9 Lureau wrote:
> Note that data_dir[] will now point to allocated strings.
>=20
> Fixes:
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x7f1448181850 in malloc (/lib64/libasan.so.4+0xde850)
>     #1 0x7f1446ed8f0c in g_malloc ../glib/gmem.c:94
>     #2 0x7f1446ed91cf in g_malloc_n ../glib/gmem.c:331
>     #3 0x7f1446ef739a in g_strsplit ../glib/gstrfuncs.c:2364
>     #4 0x55cf276439d7 in main /home/elmarco/src/qq/vl.c:4311
>     #5 0x7f143dfad039 in __libc_start_main (/lib64/libc.so.6+0x21039)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  vl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DqvND6aHHEb2AWOMLci50jgCwKhOoIIRm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlo0FMgACgkQp6FrSiUn
Q2oECQf+KeJo5H0KKGP+YROZOAVLK9OI89ZchVz+RBVLoBxzuJcq5WIP5/svPDxI
ygZ8UJxjTSzJxsY21qs+xP8iRayGqPY/9hNrPP40QZT6iMTjbNyKI7xn9rHSMoCE
Xy7k27S5c9IbMbXcIXx7LAYr+r8SDVXGiH39OgTtOdbKaxOBSmWMz+1iZAh2Ch/l
yZgQ60iflqtFsUz8a/rbyexZULd8ds7BPMtoETvF+G7ulSCBBY4rs5tc/h8DnUeU
3MJn1JIgHAlj0bhVbUh7SlJpvV5yOaTkAQ6d1/UOD+JcJCrZNfmefYsvaXmcsx3j
zxlxQERHeYzvnmxYx7OA5LMuTJzmGQ==
=Qrp9
-----END PGP SIGNATURE-----

--DqvND6aHHEb2AWOMLci50jgCwKhOoIIRm--
