Received: from eggs.gnu.org ([2001:4830:134:3::10]:34873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb8za-0005Jb-MD
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb8zW-0003cM-M2
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:51:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cb8zW-0003bs-Fr
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:51:42 -0500
References: <20170207155956.21573-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b7fc7007-1663-b41d-422a-9600e44d7b38@redhat.com>
Date: Tue, 7 Feb 2017 10:51:39 -0600
MIME-Version: 1.0
In-Reply-To: <20170207155956.21573-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wGvt5Lhdg1s3Hvks3S1TORXFTD1Nurav7"
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wGvt5Lhdg1s3Hvks3S1TORXFTD1Nurav7
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com
Message-ID: <b7fc7007-1663-b41d-422a-9600e44d7b38@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
References: <20170207155956.21573-1-pbonzini@redhat.com>
In-Reply-To: <20170207155956.21573-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/07/2017 09:59 AM, Paolo Bonzini wrote:
> I have converted all .gz and .bz2 files to .xz on download.qemu.org
> and this patch would change the links in the website.  This would save
> about 5 GB of bandwidth every day (about 20% savings).
>=20
> xz should be available for all platforms.  Besides providing better
> compression ratios, decompression of .xz files is about twice as fast
> compared to bzip2.  Compression instead is about 5.5 times slower.

I agree that bzip2 is pointless these days; .gz is a bit more important
when targetting older platforms but I think that does not describe
qemu's target audience.  Do we want to even enter the xz vs. lzma
controversy, or are we okay with being xz-only?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wGvt5Lhdg1s3Hvks3S1TORXFTD1Nurav7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmfsbAAoJEKeha0olJ0Nq/yMH/3MG31kSLjLITFI4xljytKJ8
Z9jgtDS5MQPpDVwPiD2sh24hpvtkt8RfzdrSkdXnlTJ2WkZVmkFhhzxjr2UoiaeF
dpG6pgElkcuIiPO55HBXP3GQ5XCrOMiotQoGdnyWe1wAS4MrtTDVh2TTdvcyozcD
dBFrmSPdVr3eITa0POKFizbSPMmZ2btHMKUsod1iYmHI07nj/O91PGiezXO375A6
fy9YdFRHSfoRyzF6L9AJfliyo0W2ftMOzz1W0bPpm192ykZyjEQNPHGAWc0eh9hR
2/RMViWg7dodZ4m1lZ4Os65DRFQfs5siwVco0Fk8Yu9HSOClOR4jbEetiTs3kPI=
=nSZR
-----END PGP SIGNATURE-----

--wGvt5Lhdg1s3Hvks3S1TORXFTD1Nurav7--
