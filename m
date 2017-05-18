Received: from eggs.gnu.org ([2001:4830:134:3::10]:60493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMSE-0001ap-1A
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMSC-0005sS-UK
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:31:01 -0400
References: <20170515191136.24314-1-ndevos@redhat.com>
	<20170518095422.12555-1-ndevos@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a194304c-1327-ec67-3f64-c0124c6482dd@redhat.com>
Date: Thu, 18 May 2017 09:30:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170518095422.12555-1-ndevos@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0fURkKBHb76DfU2E0WuetFiRq1pLUOnsA"
Subject: Re: [Qemu-devel] [PATCH v2] gluster: add support for
 PREALLOC_MODE_FALLOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0fURkKBHb76DfU2E0WuetFiRq1pLUOnsA
From: Eric Blake <eblake@redhat.com>
To: Niels de Vos <ndevos@redhat.com>, Jeff Cody <jcody@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <a194304c-1327-ec67-3f64-c0124c6482dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] gluster: add support for
 PREALLOC_MODE_FALLOC
References: <20170515191136.24314-1-ndevos@redhat.com>
 <20170518095422.12555-1-ndevos@redhat.com>
In-Reply-To: <20170518095422.12555-1-ndevos@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/18/2017 04:54 AM, Niels de Vos wrote:
> Add missing support for "preallocation=3Dfalloc" to the Gluster block
> driver. This change bases its logic on that of block/file-posix.c and
> removed the gluster_supports_zerofill() and qemu_gluster_zerofill()
> functiond in favour of #ifdef checks in an easy to read

s/functiond/functions/

> switch-statement.
>=20
> Both glfs_zerofill() and glfs_fallocate() have been introduced with
> GlusterFS 3.5.0 (pkg-config glusterfs-api =3D 6). A #define for the
> availability of glfs_fallocate() has been added to ./configure.
>=20
> Reported-by: Satheesaran Sundaramoorthi <sasundar@redhat.com>
> URL: https://bugzilla.redhat.com/1450759
> Signed-off-by: Niels de Vos <ndevos@redhat.com>
> ---
> v2 changes requested by Jeff Cody:
> - add CONFIG_GLUSTERFS_FALLOCATE
> - remove unneeded wrapper qemu_gluster_zerofill()

The automated tools prefer that v2 patches are sent as a new top-level
thread, rather than buried in-reply-to the v1 thread.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0fURkKBHb76DfU2E0WuetFiRq1pLUOnsA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHbAdAAoJEKeha0olJ0NqCfgH/168SFlyaMYDMvfro5eOUANn
aQu6HgXM0A4x8k1TLjiSODi3rnTOGBrsuFxgnYDCmg8dHyQBfSymepVQ8AV2BdOO
oDnkgIhuBqrnZ47Hd5slZXj3o6LmD/jcz8H0oSb9cA0vGR5MWNHoKTs6xz9Y5mk3
1appVOyZNglOGHvfHA1wPWhslm1+Dxxy1LCZplks2zpmjLyLo9HZa0Jvli453yX/
AjJiy9TWo6ygIlFRIONVtryWJkD/0Br38ElMtYsClURdxJ4mRGP2tYQMdCznUHca
XqSdjZSyk4BYzn35jfzzAsJy0Uk3grDwbn4VSqlZ6ZA0YP17DMH4MbuoijoRXS4=
=4aOa
-----END PGP SIGNATURE-----

--0fURkKBHb76DfU2E0WuetFiRq1pLUOnsA--
