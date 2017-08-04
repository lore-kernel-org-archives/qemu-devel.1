Received: from eggs.gnu.org ([2001:4830:134:3::10]:57782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRju-0000m8-U3
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRjt-0000nj-TV
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:49:22 -0400
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-3-kwolf@redhat.com>
	<8dfbc0ca-9a02-3620-d9e5-41aadee69d52@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7a5e25c-fef4-d508-4a9c-ff2d57c1b2ee@redhat.com>
Date: Thu, 3 Aug 2017 20:49:11 -0500
MIME-Version: 1.0
In-Reply-To: <8dfbc0ca-9a02-3620-d9e5-41aadee69d52@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vIxR0tFdpo6sHLq1KqWM16i27oUs3SJj0"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] block: Allow reopen rw
 without BDRV_O_ALLOW_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vIxR0tFdpo6sHLq1KqWM16i27oUs3SJj0
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <a7a5e25c-fef4-d508-4a9c-ff2d57c1b2ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] block: Allow reopen rw without
 BDRV_O_ALLOW_RDWR
References: <20170803150301.10177-1-kwolf@redhat.com>
 <20170803150301.10177-3-kwolf@redhat.com>
 <8dfbc0ca-9a02-3620-d9e5-41aadee69d52@redhat.com>
In-Reply-To: <8dfbc0ca-9a02-3620-d9e5-41aadee69d52@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 10:21 AM, Eric Blake wrote:
> On 08/03/2017 10:02 AM, Kevin Wolf wrote:
>> BDRV_O_ALLOW_RDWR is a flag that tells whether qemu can internally
>> reopen a node read-write temporarily because the user requested
>> read-write for the top-level image, but qemu decided that read-only is=

>> enough for this node (a backing file).
>>
>> bdrv_reopen() is different, it is also used for cases where the user
>> changed their mind and wants to update the options. There is no reason=

>> to forbid making a node read-write in that case.
>=20
> Hmm, I wonder.  https://bugzilla.redhat.com/show_bug.cgi?id=3D1465320
> details a failure when starting qemu with a read-write NBD disk, then
> taking several snapshots (nbd <- snap1 <- snap2 <- snap3), then where
> intermediate commit (snap2 into nbd) works but live commit (snap3 into
> nbd) fails with a message that nbd does not support reopening.  I'm
> presuming that your series may help to address that; I'll give it a spi=
n
> and see what happens.

Nope, even with your patches, I'm still getting:

{'execute':'block-commit','arguments':{'device':'drive-image1','top':'bar=
2'}}
{"return": {}}
{"timestamp": {"seconds": 1501811285, "microseconds": 439748}, "event":
"BLOCK_JOB_COMPLETED", "data": {"device": "drive-image1", "len":
2097152, "offset": 2097152, "speed": 0, "type": "commit"}}

{'execute':'block-commit','arguments':{'device':'drive-image1','top':'bar=
3'}}
{"error": {"class": "GenericError", "desc": "Block format 'nbd' used by
node '#block048' does not support reopening files"}}

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vIxR0tFdpo6sHLq1KqWM16i27oUs3SJj0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmD0pcACgkQp6FrSiUn
Q2q++Af/eVzxd6ukJGfUmJsVtu6kCnf3D8Ug6Z+0gT+Ejvsf0LAG8J+a2YWYCDZP
ZKqbB86Rs+YoU744ZmGLSmo3Q/ubI42b9zWeoZ/gyz2h2BuU41b14lvB8xHdjKs5
ZObF+iJnk486HtP6p39EAuVaQr7aqMBfLt46s6SKOM2h+fMAIMutOyxWN6gIP19R
jQRmV9BA1/yovRrSOheboVSOYOYxOkPNgxp094AHZfhyvTsv8FDkFFGouM0q7G6f
+ZY7a/6795+PiBDSxyj/0gwIZYfeUr3AvLFlzr5I9utxEifZmJY5PPB7PenbZY4P
wOpngLuvRSAkQ2JQ5VJa3CL6mGcm/A==
=TmL5
-----END PGP SIGNATURE-----

--vIxR0tFdpo6sHLq1KqWM16i27oUs3SJj0--
