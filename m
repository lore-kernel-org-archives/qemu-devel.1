Received: from eggs.gnu.org ([2001:4830:134:3::10]:57785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCo38-0006TF-Ko
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCo37-0003Fl-Gu
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:43:22 -0500
References: <20171108215703.9295-1-eblake@redhat.com>
	<20171108215703.9295-2-eblake@redhat.com>
	<f00244d8-93c9-7434-884d-318ba8f67b4f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d6248e02-6233-85b0-7534-476370e7a1bd@redhat.com>
Date: Thu, 9 Nov 2017 08:43:11 -0600
MIME-Version: 1.0
In-Reply-To: <f00244d8-93c9-7434-884d-318ba8f67b4f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8dQ409BxkOj4QlsAcC1hN3Lghbrhm8Ad3"
Subject: Re: [Qemu-devel] [PATCH v2 1/7] nbd-client: Fix error message typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8dQ409BxkOj4QlsAcC1hN3Lghbrhm8Ad3
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com,
 Max Reitz <mreitz@redhat.com>
Message-ID: <d6248e02-6233-85b0-7534-476370e7a1bd@redhat.com>
Subject: Re: [PATCH v2 1/7] nbd-client: Fix error message typos
References: <20171108215703.9295-1-eblake@redhat.com>
 <20171108215703.9295-2-eblake@redhat.com>
 <f00244d8-93c9-7434-884d-318ba8f67b4f@virtuozzo.com>
In-Reply-To: <f00244d8-93c9-7434-884d-318ba8f67b4f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 02:58 AM, Vladimir Sementsov-Ogievskiy wrote:
> 09.11.2017 00:56, Eric Blake wrote:
>> Provide missing spaces that are required when using string
>> concatenation to break error messages across source lines.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

>> @@ -408,7 +408,7 @@ static coroutine_fn int nbd_co_do_receive_one_chun=
k(
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (chunk->type =3D=3D NBD_REPLY_TYPE_N=
ONE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(chunk->fl=
ags & NBD_REPLY_FLAG_DONE)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE
>> chunk without"
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "NBD_REPLY_FLAG_DONE flag set");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " NBD_REP=
LY_FLAG_DONE flag set");
>=20
> I think it's better not to change indentation here, as it is done so in=

> other places.
> You don't like this way of indenting splitted strings?

s/splitted/split/ (one of those weird irregular English verbs)

I just did what emacs recommended when I hit TAB.  Your indentation
style also works in isolation, even if it isn't the default that emacs
tries to give me.  I could avoid the churn on this patch, but then my
addition in 6/7 looks inconsistent compared to this one, so I'll
probably just leave the indentation change in place.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8dQ409BxkOj4QlsAcC1hN3Lghbrhm8Ad3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEaX8ACgkQp6FrSiUn
Q2pIBAf/ZBjaoUzrG0lfxbX2npV9zhBW1n3XOVqcaPRNMiYhsY4Xm/OirGsb3nQP
0jr+wTNiFmHguVN3Uy+CrPEdkDPi2JsSvRMn58qCQrFv6YBah/QCue5LtkdXgu/c
xKbmZW49GpHXWCdGGc4kjw/qjJPFb/1LKo4V/FjRM9N0xL2/05091AjVGx3MZr7L
IiYLViPWwxr9CGUSsWBJxLJ2f6uTz6uPNAi2KJi4ueQ42Ae92fl0UDE0WZ/XakeC
fveoR0yZjke8j4gQCZb6HnGreBbTIPRqM5gT2OMQjr0NE+cswLqJsyv8NzWZ0XQY
Y0QPmgjmNGb3k4kbly7wKH37jmm8gQ==
=0BqL
-----END PGP SIGNATURE-----

--8dQ409BxkOj4QlsAcC1hN3Lghbrhm8Ad3--
