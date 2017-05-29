Received: from eggs.gnu.org ([2001:4830:134:3::10]:56927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFN3z-00013y-Jv
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFN3y-0004ZT-Ti
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:58:35 -0400
References: <20170529152316.27647-1-mreitz@redhat.com>
	<20170529152316.27647-2-mreitz@redhat.com>
	<27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
	<a412a3b6-37ec-f321-c6d6-aa754153cfe0@redhat.com>
	<683fd2c8-e98e-90e6-bf63-2b0e41236220@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a06c191-35d0-b98d-1f17-1fc9184cbbd1@redhat.com>
Date: Mon, 29 May 2017 17:58:24 +0200
MIME-Version: 1.0
In-Reply-To: <683fd2c8-e98e-90e6-bf63-2b0e41236220@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0J8g7BKF3Cg9dQNDkeqEKEhuoX76q8Ibx"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0J8g7BKF3Cg9dQNDkeqEKEhuoX76q8Ibx
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3a06c191-35d0-b98d-1f17-1fc9184cbbd1@redhat.com>
Subject: Re: [PATCH v3 1/2] iotests: Use absolute paths for executables
References: <20170529152316.27647-1-mreitz@redhat.com>
 <20170529152316.27647-2-mreitz@redhat.com>
 <27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
 <a412a3b6-37ec-f321-c6d6-aa754153cfe0@redhat.com>
 <683fd2c8-e98e-90e6-bf63-2b0e41236220@redhat.com>
In-Reply-To: <683fd2c8-e98e-90e6-bf63-2b0e41236220@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-29 17:55, Eric Blake wrote:
> On 05/29/2017 10:46 AM, Max Reitz wrote:
>=20
>>> If you switch all of these to $(realpath -- "$(type -p "$QEMU_...")")=
,
>>> you can add:
>>
>> I'd love to, but this is what type -p outputs for me:
>>
>> $ type -p qemu-img
>> qemu-img is /usr/bin/qemu-img
>=20
> Huh? That's plain 'type' output.  Are you sure you're testing 'type -p'=
?
>=20
> $ PATH=3D$PATH    # to forcefully clear bash's cache
> $ type qemu-img
> qemu-img is /usr/bin/qemu-img
> $ type -p qemu-img
> /usr/bin/qemu-img
> $ qemu-img --help >/dev/null   # to repopulate qemu-img into the cache
> $ type qemu-img
> qemu-img is hashed (/usr/bin/qemu-img)
> $ type -p qemu-img
> /usr/bin/qemu-img
>=20
>>
>> So I would need to parse the result (and it depends on the locale). If=

>> that is indeed so, I'd rather stay with which, to be honest...
>=20
> Plain 'type' does have to be parsed, but 'type -p' is required to be
> machine-usable.

Oops. I tested it (both with -p and without) on zsh, then on bash, and I
forgot the -p on bash. Well, I'm going to trust you, then. O:-)

Max


--0J8g7BKF3Cg9dQNDkeqEKEhuoX76q8Ibx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLEUgEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMp+
B/4pnnTpqDUFmIEkdzCcXZ44VgYNWQg0Ute2FaojDX9E7FCWzHzLLCGK957P8VPo
h925smLPjOSZp1Vp9H4088LnnOB7YorTKrZWmWBf+IDb4gbGADwNQPILWfHG3qfS
oJSGfvQwdyG/qQgNi688EwHkUqcaqswp5iQzFgmLpPDx5vwcgsbfBDiESaeJ+jzD
pOkzMvReQIjd3V8jdYuS7Y263qWGjJTe5vlVKsuavJH/8wqXdnPo63UUfF3X26P9
GYWYJMeYSmUtcr66eY/lM8GzljusqdSwhmcCgIKzla92Nfxm/MuxrM9idWqFrqj5
HagbfWTwJZN+S53+70AyRTDo
=yNxv
-----END PGP SIGNATURE-----

--0J8g7BKF3Cg9dQNDkeqEKEhuoX76q8Ibx--
