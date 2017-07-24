Received: from eggs.gnu.org ([2001:4830:134:3::10]:36104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZffh-0004dx-7R
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZffg-0004kG-DL
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:53:25 -0400
References: <20170721183243.22706-1-eblake@redhat.com>
	<20170724092822.GC4630@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f771f7b-5e18-c5b1-2f18-78037fdb4cf6@redhat.com>
Date: Mon, 24 Jul 2017 10:53:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170724092822.GC4630@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7VfeDAgUpU6qxvrIg7T5jVFdDxN2vkQ37"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7VfeDAgUpU6qxvrIg7T5jVFdDxN2vkQ37
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org
Message-ID: <6f771f7b-5e18-c5b1-2f18-78037fdb4cf6@redhat.com>
Subject: Re: [PATCH for-2.10 0/2] Bug fixes from byte-based block status
References: <20170721183243.22706-1-eblake@redhat.com>
 <20170724092822.GC4630@noname.str.redhat.com>
In-Reply-To: <20170724092822.GC4630@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 04:28 AM, Kevin Wolf wrote:
> Am 21.07.2017 um 20:32 hat Eric Blake geschrieben:
>> Series 2-4 of my byte-based conversion missed soft freeze, so they
>> are now 2.11 material.  However, there are some bug fixes in those
>> series that we should fix now in 2.10 (patch 1 from series two
>> on dirty bitmaps, patch 2 extracted from "qcow2: Switch qcow2_measure(=
)
>> to byte-based iteration" from series three on block status).
>=20
> Thanks, applied to the block branch.
>=20
>> I don't know if it is worth enhancing iotest 178 to probe the size
>> of a 2T image.  The test is simple, and fast when patched:
>>
>> $ qemu-img create -f qcow2 -o cluster_size=3D2M huge 2T
>> $ time ./qemu-img measure -O qcow2 -f qcow2 huge
>> required size: 335806464
>> fully allocated size: 2199359062016
>>
>> real	0m0.021s
>> user	0m0.017s
>> sys	0m0.004s
>>
>> but the inf-loop when unpatched is annoying; meanwhile, 'huge' only
>> occupies 6 megabytes on disk, so it's not that invasive.
>=20
> Yes, please follow up with qemu-iotests cases for both bugs. We're only=

> adding the test after fixing the bug, so a hang in the buggy old code
> isn't a problem.

I've submitted as separate patches since you've already queued these;
but since you haven't done a pull request yet, we could also merge them
and submit the tests in the same patches as the fixes:
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07400.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7VfeDAgUpU6qxvrIg7T5jVFdDxN2vkQ37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2F+oACgkQp6FrSiUn
Q2pouwf+PAwkTNUfOFpgRkcnmkifSERLVvOylSVfPQEOQbYNi7MTECa6DDgFyf3U
GackYwrBYntJm/ssLPk58Wy7ogNMNA5WR4/Cg0xBU4LJq3aVTTfcSCCHacyio9+y
XGwrYNdxHz6yTWDSERffumBAaQL8cTu9MKICkN9lO7UGAopr8kORkNCwcdtCffkM
EAyThLaCvXPQPR2QB0vAgRlxg8+Aa8ktwjAsnyCHXa3C6eS64JB5RtMi8TBTkpIW
hKZlO1HV90+qELBC6fEJJLGNrs9iR4xF+3u53mXED5mMDdgEdl/9pCe3Y4NyWJFC
huq87DIAROtuaq2SNsFOEvZQTJ1rQQ==
=3pvs
-----END PGP SIGNATURE-----

--7VfeDAgUpU6qxvrIg7T5jVFdDxN2vkQ37--
