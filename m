Received: from eggs.gnu.org ([2001:4830:134:3::10]:47825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pvl-0007fG-35
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pvh-0005vW-V9
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:06:49 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
	<2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <444b4d0c-d97a-2b66-a10a-595d22bca9b2@redhat.com>
Date: Wed, 18 Oct 2017 10:06:24 -0500
MIME-Version: 1.0
In-Reply-To: <2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DRodGGxkEN3Okgt9IBTXWT63TdAHWtmnF"
Subject: Re: [Qemu-devel] [PATCH v5 03/10] qemu-iotests: automatically clean
 up bash protocol servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DRodGGxkEN3Okgt9IBTXWT63TdAHWtmnF
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 stefanha@redhat.com
Message-ID: <444b4d0c-d97a-2b66-a10a-595d22bca9b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 03/10] qemu-iotests: automatically clean
 up bash protocol servers
References: <cover.1508257445.git.jcody@redhat.com>
 <503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
 <2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
In-Reply-To: <2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/18/2017 09:46 AM, Paolo Bonzini wrote:
> On 17/10/2017 18:31, Jeff Cody wrote:
>>              )
>>          else
>> +            # Do this in a sub-shell, so we are operating on the righ=
t
>> +            # TEST_DIR / QEMU_TEST_DIR
>>              (
>>              export TEST_DIR=3D$TEST_DIR_SEQ
>>              cd "$source_iotests";
>=20
> Where is the missing ")"?

This hunk is just adding comments, not '(', so it is already well-paired.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DRodGGxkEN3Okgt9IBTXWT63TdAHWtmnF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnnbfAACgkQp6FrSiUn
Q2oFkAf9EkOmi3WukGn++k9M+POFeHmkl18je/v/iaUt4QzLSAnUCotKFgZyEUMQ
AlXOFdbSx3YEFJvNrc3ygWVnuti9RIELPJsTghQliT14dcFXi5qH5jxZSsyRNkEA
qKSI+etsYtsVOZgYf6Ydly4SDOpot17/HAeEt6/OoRXiw0tu1EQ55MWTKP/AO533
7hXDoOfBeGLZRztkNZMlbveRdkthEpBRajPtSBMNOMd8KOGSasu88KnEOO3UR3BY
WdyXhp3H/WVRutERA8MtsS0ICrFAGsLAXDz7P6RjepVaG6CzDJIceGiqd4+AUMan
QT1F6U4SVbxmZnh/oWV1lR/KzsvbKw==
=E0eC
-----END PGP SIGNATURE-----

--DRodGGxkEN3Okgt9IBTXWT63TdAHWtmnF--
