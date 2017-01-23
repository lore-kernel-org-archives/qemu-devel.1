Received: from eggs.gnu.org ([2001:4830:134:3::10]:35151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVgxu-0002xw-00
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVgxp-0005Tl-5u
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:55:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cVgxo-0005Te-TE
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:55:25 -0500
References: <1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1485186641-12220-3-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5655a23-8995-fa0a-6bb1-48852a17ccd9@redhat.com>
Date: Mon, 23 Jan 2017 09:55:15 -0600
MIME-Version: 1.0
In-Reply-To: <1485186641-12220-3-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cWcPXD91dalmBdMLBpOiSlg9829q4uefA"
Subject: Re: [Qemu-devel] [PATCH 2/2 V13] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cWcPXD91dalmBdMLBpOiSlg9829q4uefA
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org
Message-ID: <c5655a23-8995-fa0a-6bb1-48852a17ccd9@redhat.com>
Subject: Re: [PATCH 2/2 V13] throttle: factor out duplicate code
References: <1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1485186641-12220-3-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1485186641-12220-3-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2017 09:50 AM, Pradeep Jagadeesh wrote:
> This patch removes the redundant throttle code that was present in
> block and fsdev device files. Now the common code is moved
> to a single file.
>=20
> ---

You forgot your S-o-b designation.  Also, this is the second thread
you've sent with a title of v13; please remember to bump the version
each time you send a new version.  'git send-email -v14' will put in the
version string automatically (but with lower-case 'v').

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--cWcPXD91dalmBdMLBpOiSlg9829q4uefA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYhidjAAoJEKeha0olJ0NqenYH/RZcDMPX4w7seS6lD8BfLByp
FdcJpEORafZ1rXEHrxiShng2pk4NA5ga2TM3Gmmryv1ZCCp6hE2oLGkH0UoYYiTU
q9JGFfTWCWw9jRG6HYC4fyM/tunH7Ma31uKsYfu5UMWdQNFslqYD1vCemiyCGGsA
dyCyV1vj8P19Bez53FAKyd742Y2jdAnmV8far4hP4kXlly9s2wFt68k6q5iZT5f1
wTxhCct6mM0Ex0mtsh1q9QPHrOwJieczOO4Jjm4cVT0C/I4/mMcXAwyV1ui6oyyZ
T6Y+ooNsi9xKKbKG524VJPcwu/nH7SLBYWQuuycIjFC9gtHNHIDoCdnloUUgmm8=
=z52q
-----END PGP SIGNATURE-----

--cWcPXD91dalmBdMLBpOiSlg9829q4uefA--
