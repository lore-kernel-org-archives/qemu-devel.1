Received: from eggs.gnu.org ([2001:4830:134:3::10]:40602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBnUb-0002HL-3g
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBnUX-0006VR-4Y
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:55:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eBnUW-0006V2-K2
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:55:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59E6852779
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:55:27 +0000 (UTC)
References: <20171106185411.19551-1-marcandre.lureau@redhat.com>
	<ae73f31f-749a-e02e-d04b-1090e350619e@redhat.com>
	<1152775610.36873329.1509996656951.JavaMail.zimbra@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32f2f284-251d-6285-6824-18554f693a28@redhat.com>
Date: Mon, 6 Nov 2017 13:55:22 -0600
MIME-Version: 1.0
In-Reply-To: <1152775610.36873329.1509996656951.JavaMail.zimbra@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vIdiiNkemESaJG48al1J2LtS4s5Oni8KG"
Subject: Re: [Qemu-devel] [PATCH] .gitignore: remove vscclient
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vIdiiNkemESaJG48al1J2LtS4s5Oni8KG
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <32f2f284-251d-6285-6824-18554f693a28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] .gitignore: remove vscclient
References: <20171106185411.19551-1-marcandre.lureau@redhat.com>
 <ae73f31f-749a-e02e-d04b-1090e350619e@redhat.com>
 <1152775610.36873329.1509996656951.JavaMail.zimbra@redhat.com>
In-Reply-To: <1152775610.36873329.1509996656951.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 01:30 PM, Marc-Andr=C3=A9 Lureau wrote:
>=20
>=20
> ----- Original Message -----
>> On 11/06/2017 12:54 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> It was removed with libcacard.
>>
>> which was back in which commit?  I'm trying to get an idea of how long=

>> this entry has been stale.
>=20
> Since:
>=20
> commit 7b02f5447c64d1854468f758398c9f6fe9e5721f
> Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Date:   Sun Aug 30 11:48:40 2015 +0200
>=20
>     libcacard: use the standalone project
>=20
>>
>> I'm not opposed to this patch, but I personally like to leave .gitigno=
re
>> entries in place for several releases after they are last useful, to
>> make incremental builds easier when jumping around between old and new=

>> branches across the point where the file was removed (as long as the n=
ew
>> branch still ignores the file, then building the file in the old branc=
h
>> doesn't hurt the new branch).  Of course, if I'm that involved in
>> backporting madness across branches, I'm also fine updating my own
>> .git/info/exclude for cruft that is built in only one of two branches,=

>> rather than relying on per-branch .gitignore to do it for me.

Then this particular cleanup is definitely beyond the realm of any
backporting efforts I care about, and makes sense to me; but I'm still
leaving it weak enough that I won't add R-b (especially not without a
more verbose commit body), but I'm also okay if someone else wants to
add R-b to the patch as presented rather than waiting for a respin.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vIdiiNkemESaJG48al1J2LtS4s5Oni8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloAvisACgkQp6FrSiUn
Q2qRYgf+NBv3tf3/VAPeIIRYM1RcH595v303uorapbjAoYpGalMTFg/gFFzTyGHI
ER2YcS6qsgZV2GT1k2UGs+bQu/0UGyx660jeL/LO3LwzLynllkgjVjngplEk2tyK
oXBeNLsmXGyykYefVgpXYe+RAojCoHBVPha5OlubbyDd3hQqacFA7U5HtHkJB56A
7mQL0qdLcmy9PSszhpj9PgK5q4vmK/zNixvM1yPrDFYZt/36dS3ffSjCdzPlly8b
k2nz8aM8vIoWkZV5XxxiweIj7ZsDpvRH2UwdjHNZSpdi4dRfu5JoVxJrq1joTlZi
6sP13C/NJlu7CUxnhYM6PkdFjh+cYw==
=4i+3
-----END PGP SIGNATURE-----

--vIdiiNkemESaJG48al1J2LtS4s5Oni8KG--
