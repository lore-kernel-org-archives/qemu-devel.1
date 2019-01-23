Received: from eggs.gnu.org ([209.51.188.92]:36403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmKcD-00045u-EQ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmKcC-00026R-EE
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:38:57 -0500
References: <154825524292.21.4589691216699401444@ebba9967afc0>
	<63fcc13e-6fce-126b-1a6d-3ad1ed7d9976@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9fa15de0-9741-26ef-c302-ec6725784200@redhat.com>
Date: Wed, 23 Jan 2019 09:38:51 -0600
MIME-Version: 1.0
In-Reply-To: <63fcc13e-6fce-126b-1a6d-3ad1ed7d9976@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZfRMduIie170ktCeuGAL8SbbI9xnZ0BuM"
Subject: Re: [Qemu-devel] [PATCH v3 0/9] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZfRMduIie170ktCeuGAL8SbbI9xnZ0BuM
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Message-ID: <9fa15de0-9741-26ef-c302-ec6725784200@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/9] qcow2: encryption threads
References: <154825524292.21.4589691216699401444@ebba9967afc0>
 <63fcc13e-6fce-126b-1a6d-3ad1ed7d9976@virtuozzo.com>
In-Reply-To: <63fcc13e-6fce-126b-1a6d-3ad1ed7d9976@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 9:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 23.01.2019 17:54, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20190108170655.29766-1-vsementso=
v@virtuozzo.com/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-mingw@fedora build test. Please find the=
 testing commands and
>> their output below. If you have Docker installed, you can probably rep=
roduce it
>> locally.
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> time make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D14
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>>    CC      qapi/qapi-commands-crypto.o
>>    CC      qapi/qapi-commands-introspect.o
>> /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
>> /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified=
 bound 256 equals destination size [-Werror=3Dstringop-truncation]
>>       strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>=20
> unrelated to my series.
>=20

Known false alarm; the patchew processing queue is backlogged, and is
testing patches against a version of qemu.git that does not yet have
patches for newer gcc compliance incorporated, while at the same time
having recently upgraded its testing environment to use the newer gcc
that warns.  Commit 97b583f4 will silence the noise, once patchew
catches up to using it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ZfRMduIie170ktCeuGAL8SbbI9xnZ0BuM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxIiosACgkQp6FrSiUn
Q2qwJQf9H3yVkVsAyeUi11DNOATQi/BWIisCalNUnaJUBODMEzgflAZWPVdkx4DQ
QfBsaE2aMi9MDSzQNRnVnnThT5Ypz4PpbmNn3vvaPfxW9cPVRWerzkGrQzuAr2on
ZlZA98F9wEkrix3UcZa2HErQOFHP4Q2v/oIfG5mTSzvOb745w+TJUrTPjm+q9K2U
g2MqnShUlXYycNnj87wkSrDRcHo9JGpLFSrJpdsFQdeJ4QVGyyKFBd7gO7sg7g8c
AF+CzL0qwABEDEjnJApZVysqqAjd6b8DA77osaNQXPjhMPL3bxii/BBgVRoak4Hg
ng5F5p33O2s5om6dePdQyLUzd1kU0g==
=fg08
-----END PGP SIGNATURE-----

--ZfRMduIie170ktCeuGAL8SbbI9xnZ0BuM--
