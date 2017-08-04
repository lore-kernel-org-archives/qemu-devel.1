Received: from eggs.gnu.org ([2001:4830:134:3::10]:55139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddejq-0003ge-2T
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddejp-0003bI-7W
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:42:10 -0400
References: <20170804105059.11941-1-berrange@redhat.com>
	<20170804140210.GD4108@localhost.localdomain>
	<20170804140630.GC14504@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c9832bf-1e0e-6b3a-d962-5672cb96d323@redhat.com>
Date: Fri, 4 Aug 2017 10:41:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170804140630.GC14504@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ekXmh3XQRtoDUOJ3aaWdIllElR55kXT4P"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ekXmh3XQRtoDUOJ3aaWdIllElR55kXT4P
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <9c9832bf-1e0e-6b3a-d962-5672cb96d323@redhat.com>
Subject: Re: [Qemu-block] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
References: <20170804105059.11941-1-berrange@redhat.com>
 <20170804140210.GD4108@localhost.localdomain>
 <20170804140630.GC14504@redhat.com>
In-Reply-To: <20170804140630.GC14504@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 09:06 AM, Daniel P. Berrange wrote:
> On Fri, Aug 04, 2017 at 04:02:10PM +0200, Kevin Wolf wrote:
>> Am 04.08.2017 um 12:50 hat Daniel P. Berrange geschrieben:
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>> ---

>> Really? We are asserting that they match in bdrv_aligned_preadv():
>>
>>     assert(!qiov || bytes =3D=3D qiov->size);
>=20
> Hmm, why do we pass @bytes at all then ? If they're always the same,
> how about deleting it and just letting everyone read qiov->size
> directly.

Read the assertion again: qiov can be NULL (generally, when writing
zeroes).  So we can't rely on qiov->size in that scenario.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ekXmh3XQRtoDUOJ3aaWdIllElR55kXT4P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmElcIACgkQp6FrSiUn
Q2o1Cgf/TxBBcqZRqK2hdKHjxyLjwJb4NJo26zD3e5435JKveohes7nVWg1NJ9oP
hecB05MhRdwGtKUbYYVvmF78POFBMHsdlJ7RxCX2LUUU8I4rLa2q98rCyDL2G6Rk
6KwJS/0ihv+vzHD/rKeArxPgXCP36ZhkOhr4OPVemiYOqG7iRi+8SLIpp/Fm1C+u
wmDMNxRnVfe/+8tJDU84Q6txNLmxIc739AYnXU4o1SfV9l+bMzZrirJ9Xp4lWdPZ
VsN6ZUXA45FOVBs1zP5erxDp6EJ/YpP++NubTmJpv4h/8SEVQVjpuUGtknhN2m8k
EuoEkmj7eVCDogba6fxjWN8QA/P7OA==
=/fQF
-----END PGP SIGNATURE-----

--ekXmh3XQRtoDUOJ3aaWdIllElR55kXT4P--
