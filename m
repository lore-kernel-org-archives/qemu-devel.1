Received: from eggs.gnu.org ([209.51.188.92]:42684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi0yu-00047R-3l
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi0ys-0001NC-1L
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:52:32 -0500
References: <20181221093529.23855-1-jsnow@redhat.com>
	<20181221093529.23855-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ab25a23-c717-2ef0-7cac-7ee6db63c364@redhat.com>
Date: Fri, 11 Jan 2019 11:52:17 -0600
MIME-Version: 1.0
In-Reply-To: <20181221093529.23855-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w5UheCaG8rr9zkJgqqyfFCGZj5XkHNaWB"
Subject: Re: [Qemu-devel] [PATCH v6 01/11] blockdev: abort transactions in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w5UheCaG8rr9zkJgqqyfFCGZj5XkHNaWB
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <6ab25a23-c717-2ef0-7cac-7ee6db63c364@redhat.com>
Subject: Re: [PATCH v6 01/11] blockdev: abort transactions in reverse order
References: <20181221093529.23855-1-jsnow@redhat.com>
 <20181221093529.23855-2-jsnow@redhat.com>
In-Reply-To: <20181221093529.23855-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/21/18 3:35 AM, John Snow wrote:
> Presently, we abort transactions in the same order they were processed =
in.
> Bitmap commands, though, attempt to restore backup data structures on a=
bort.
>=20
> That's not valid, they need to be aborted in reverse chronological orde=
r.
>=20
> Replace the QSIMPLEQ data structure with a QTAILQ one, so we can iterat=
e
> in reverse for the abort phase of the transaction.

This patch conflicts with Paolo's improvements to QTAILQ that just
landed; the resolution should be obvious, but at this point, you'll want
to post a v7.

Or did you want me to try and fix the conflict, and take the series
through my NBD tree since I have patches based on top of it?

>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  blockdev.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--w5UheCaG8rr9zkJgqqyfFCGZj5XkHNaWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw419EACgkQp6FrSiUn
Q2ozvgf8CAR3clr94clrPMkYIPeRbQZW0+OCmsawUr5koRkol/PfSJE3RUs+HXoD
C6ZqtrCE+i+fyujufQmYqWTSSLmQJAS3l4CiLY8P1Iy1ECkydJGkc69QOLNL3ngN
mBBzO6oQWbcfDKQxPp5hXs9ZFak+zpYIcn0kAd1H6N7uQLOF/HENxfpynREGvMKo
5woxoxtporqRNTNoOf0LdMQV4oTtXS2+LPwIo2AiNJ544zpQ8Y4vKohJzgAjaAeA
qJI4u7jStncM0LNANDF8/4u+6D7OkcrCombKo2uLhlVDYmPyT9k1d5I80l2jnBJf
bCD6HWihxzhYlcQLDcMOsQxWDZfW5g==
=XKZ/
-----END PGP SIGNATURE-----

--w5UheCaG8rr9zkJgqqyfFCGZj5XkHNaWB--
