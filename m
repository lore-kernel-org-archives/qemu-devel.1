Received: from eggs.gnu.org ([2001:4830:134:3::10]:35619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZc6v-0008LZ-Bh
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZc6u-0002Kl-9b
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:05:17 -0400
References: <20170721183243.22706-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88fbee4a-0687-6402-cf9d-c6bf4b54b43b@redhat.com>
Date: Mon, 24 Jul 2017 07:05:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170721183243.22706-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="39qTmdkkrSFNUrJk1o0GA7dWh8OsH3Awq"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Bug fixes from byte-based
 block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--39qTmdkkrSFNUrJk1o0GA7dWh8OsH3Awq
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com
Message-ID: <88fbee4a-0687-6402-cf9d-c6bf4b54b43b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Bug fixes from byte-based block
 status
References: <20170721183243.22706-1-eblake@redhat.com>
In-Reply-To: <20170721183243.22706-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 01:32 PM, Eric Blake wrote:
> Series 2-4 of my byte-based conversion missed soft freeze, so they
> are now 2.11 material.  However, there are some bug fixes in those
> series that we should fix now in 2.10 (patch 1 from series two
> on dirty bitmaps, patch 2 extracted from "qcow2: Switch qcow2_measure()=

> to byte-based iteration" from series three on block status).
>=20
> I don't know if it is worth enhancing iotest 178 to probe the size
> of a 2T image.  The test is simple, and fast when patched:
>=20
> $ qemu-img create -f qcow2 -o cluster_size=3D2M huge 2T
> $ time ./qemu-img measure -O qcow2 -f qcow2 huge
> required size: 335806464
> fully allocated size: 2199359062016
>=20
> real	0m0.021s
> user	0m0.017s
> sys	0m0.004s
>=20
> but the inf-loop when unpatched is annoying; meanwhile, 'huge' only
> occupies 6 megabytes on disk, so it's not that invasive.
>=20
> Eric Blake (2):
>   dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
>   qcow2: Fix sector calculation in qcow2_measure()

Thanks; queued on my NBD branch:
git://repo.or.cz/qemu/ericb.git nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--39qTmdkkrSFNUrJk1o0GA7dWh8OsH3Awq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll14nMACgkQp6FrSiUn
Q2oD0wf9F6im+Hsv06BVdXVFhaX/r8CqCn4O8ke5aZkpcSS5NKwSupZ/FdyVQ/6U
uv5I+dTlriauLRdzQrApQ6ObnLHD0FJ18HYWFti9/gB5+yu73fm9QSS9x6SlDoY5
+vUV4zUn/oRRYK4qBroABuLwN3NN/bPSm7UbSVNJ6QPfFrEyWUWS449s1LnIcofk
ud09M/6+LLvxYrnGh7zQ7k76VQOuu0kLOZAKHwOgPR+SrMS9E7RduK879Wc54U1Z
cK56wvXq6UfQnXEZ2PlQLN/7HSOYzsPvIrMIv4I+VKmVvcFMkv/2oekHXXETJCCN
bmGtwnL9iQyGFCdolApvjgleO44e7A==
=X+5D
-----END PGP SIGNATURE-----

--39qTmdkkrSFNUrJk1o0GA7dWh8OsH3Awq--
