Received: from eggs.gnu.org ([2001:4830:134:3::10]:46646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3OpP-0005TC-8x
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3OpN-0001sY-S6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:26:03 -0400
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-12-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58710b78-6db4-1991-4bd1-effc9035cfa8@redhat.com>
Date: Wed, 26 Apr 2017 10:25:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170425153858.25660-12-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7ti79NneU1Cv19mQSeRKELN4EDl0huQd8"
Subject: Re: [Qemu-devel] [PATCH v6 11/18] qcow2: convert QCow2 to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ti79NneU1Cv19mQSeRKELN4EDl0huQd8
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <58710b78-6db4-1991-4bd1-effc9035cfa8@redhat.com>
Subject: Re: [PATCH v6 11/18] qcow2: convert QCow2 to use QCryptoBlock for
 encryption
References: <20170425153858.25660-1-berrange@redhat.com>
 <20170425153858.25660-12-berrange@redhat.com>
In-Reply-To: <20170425153858.25660-12-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
> This converts the qcow2 driver to make use of the QCryptoBlock
> APIs for encrypting image content, using the legacyy QCow2 AES

s/legacyy/legacy/

> scheme.
>=20
> With this change it is now required to use the QCryptoSecret
> object for providing passwords, instead of the current block
> password APIs / interactive prompting.
>=20
>   $QEMU \
>     -object secret,id=3Dsec0,filename=3D/home/berrange/encrypted.pw \
>     -drive file=3D/home/berrange/encrypted.qcow2,encrypt.key-secret=3Ds=
ec0
>=20
> The test 087 could be simplified since there is no longer a
> difference in behaviour when using blockdev_add with encrypted
> images for the running vs stopped CPU state.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7ti79NneU1Cv19mQSeRKELN4EDl0huQd8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZALwBAAoJEKeha0olJ0NqIqIH/30pfGSuqCi/IZun+GmYpt5C
xY/sO2rN9HR1jLj7Sk3fwSHfI4UzjDJmKwnaDYOm1Otwpnz/5k7aNlN5CJKqaryn
Ek85Oih/r+WYTEFmWSCM8KLVifNbPvRJZN2TOeNUWr9FbFXSNV0NDKSFwFf09mnA
FsoGirKCDbIILljZW0f7izeKKZcK5rvmd26lmmkyBo3rkip0COhGzk6MLeSWOQXH
+d+xtvaWVOV9AjIzhtQwaVY9c7ODQGIVLRt52p0jR+i4zfxC930PKR/3jr05RwFw
fIelyk4I1+o2CoIAuOH8hAewmfzZdcHXnNS/KufHXbSOhtlvAGegNGsFwsyhGKY=
=NnIW
-----END PGP SIGNATURE-----

--7ti79NneU1Cv19mQSeRKELN4EDl0huQd8--
