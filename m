Received: from eggs.gnu.org ([2001:4830:134:3::10]:58733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrg8-0004fg-Lp
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrg4-0006zR-GY
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:11:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjrg4-0006z4-8C
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:11:40 -0500
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<20170303162128.GD13631@redhat.com> <20170303174353.676c1a7b@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a93b0903-cf60-d21b-2d68-cd182e06aed3@redhat.com>
Date: Fri, 3 Mar 2017 12:11:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170303174353.676c1a7b@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6Sw3N3rnlnHeEgPkiP1feKGILIjVCxl0V"
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: G 3 <programmingkidx@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Sw3N3rnlnHeEgPkiP1feKGILIjVCxl0V
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: G 3 <programmingkidx@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Message-ID: <a93b0903-cf60-d21b-2d68-cd182e06aed3@redhat.com>
Subject: Re: [Qemu-devel] git master build failure in 9pfs
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
 <8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
 <20170303164426.42472535@bahia.lan>
 <AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
 <20170303162128.GD13631@redhat.com> <20170303174353.676c1a7b@bahia.lan>
In-Reply-To: <20170303174353.676c1a7b@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 10:43 AM, Greg Kurz wrote:

>>> +#ifndef O_PATH
>>> +    #define O_PATH 0
>>> +#endif =20
>>
>> Isn't the use of O_PATH required in order to fix the recent
>> security vulnerability in 9p ?  If so, then defining it to
>> 0 means the QEMU is silently becoming vulnerable once again
>> which I don't think is a good idea.
>>
>=20
> O_PATH was supposed to be used as an optimization here, since fds retur=
ned by
> this function are only passed to openat()... but your comment makes me =
realize
> I inadvertently dropped O_NOFOLLOW between v1 and v2 of the patchset. A=
nd this
> IS an actual vulnerability issue :) And reading the openat() manpage, I=
 see
> that O_PATH | O_NOFOLLOW doesn't cause openat() to fail, but to return =
a fd
> pointing to the symlink which is certainly not what I want :)

Why not? It works, since openat(fd, ...) fails with EBADF if fd is a
symlink rather than a directory.  (Well, it SHOULD fail like that,
according to the man page; I need to write a test program and find out
for sure).  So you don't have to do any additional syscalls, as your
very next *at call will tell you if you actually got a directory or a
symlink.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6Sw3N3rnlnHeEgPkiP1feKGILIjVCxl0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubHYAAoJEKeha0olJ0NqBxAH/2XckeFzkqq8fV8/lhzHH1Eg
L54pPL6cuSjNVauVnbfbiqqg6qnr30Y3THDI9nqPFDkoFh4TvQ4qzNBFcQmkli+L
5fA+peCcNCROqkn7QOlleWgMFprtvns23B2EGCd5y6gRDoJl7GUNWetWmplhBB+g
OHdDsOK0itZIaImtvSjPkepHqj6ALldAJvlMtXwvzrSJtov3sDVq9Ncab0Khobse
+fw5jSTz7n79FlXEbG7jV80+zRUrM9fNF+TMmulWY8+dtNZ5QrOo8ivMSEt7noYb
BY+2TppMbow/WF7BsLAdho6SQCqIBJtUARsx1RFfLZg0v5YaMDCZwfDoi3EgEi4=
=xg1n
-----END PGP SIGNATURE-----

--6Sw3N3rnlnHeEgPkiP1feKGILIjVCxl0V--
