Received: from eggs.gnu.org ([2001:4830:134:3::10]:37699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4LQ-0005Ld-Jq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4LM-0001Vy-5B
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:26:16 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1db4LL-0001VG-UT
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:26:12 -0400
Received: by mail-wm0-x242.google.com with SMTP id x64so2917428wmg.1
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 05:26:11 -0700 (PDT)
Date: Fri, 28 Jul 2017 13:26:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728122608.GL12364@stefanha-x1.localdomain>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2OzUYMsT4j3Kc+NU"
Content-Disposition: inline
In-Reply-To: <20170725211523.3998-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/12] qtest: Document calling
 conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com


--2OzUYMsT4j3Kc+NU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 04:15:14PM -0500, Eric Blake wrote:
> We have two flavors of vararg usage in qtest; make it clear that
> qmp() has different semantics than hmp(), and let the compiler
> enforce that hmp() is used correctly. However, qmp() (and friends)
> only accept a subset of printf flags look-alikes (namely, those
> that our JSON parser understands), and what is worse, qmp("true")
> (the JSON keyword 'true') is different from qmp("%s", "true")
> (the JSON string '"true"'), and we have some intermediate cleanup
> patches to do before we can mark those as printf-like.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v3: restore lost attributes, add comments on va_list forms, tweak
> commit message to mention upcoming qmp cleanups
> v2: several comment tweaks, explain why qmp() can't be marked
> ---
>  tests/libqtest.h | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2OzUYMsT4j3Kc+NU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZey1gAAoJEJykq7OBq3PIAN4H/2enF8L+De4JwWaE9foPLzkb
BvkKrCnr3uu9LRVBCrBWxCQqFh17pIyYDzgPa43l2t3gr9weW88qD5hox65zO/z9
JWMLkM0651RU6eo2fbVO6XU9H4qfhqlgZrrylRGeM1aetbLGVlGeXPG8P7W0iUjL
UXl0VA1/DNgTqzhc/BpSq1IeRzeUE7DLyXZC+Tn8RR5hXLuGbu+iVkCVLd9TUIcl
jOCN4hpE0qPnzBJDPSGwNp403GDAgD94Hz34YgGs4Xx/if/e6WpoDBHlS2FBedJi
bF2zsMShK9i8zn8OysUqewYU/IPfO/2iFavnCkI5JqBlSnJvooXfj4zbjVKH5Og=
=oJs1
-----END PGP SIGNATURE-----

--2OzUYMsT4j3Kc+NU--
