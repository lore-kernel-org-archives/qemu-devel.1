Received: from eggs.gnu.org ([2001:4830:134:3::10]:50089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwEZF-0005FJ-Bm
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwEZB-0006MS-FD
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:03:45 -0400
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
	<1488314205-16264-44-git-send-email-kwolf@redhat.com>
	<20170406205939.GA28584@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a010df05-e986-2142-3196-31f549558511@redhat.com>
Date: Thu, 6 Apr 2017 16:03:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170406205939.GA28584@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xd0VcI3pkaNegpJgc4xnKX8WtOmOTXpmg"
Subject: Re: [Qemu-devel] [PULL 43/46] block: Assertions for write
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xd0VcI3pkaNegpJgc4xnKX8WtOmOTXpmg
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <a010df05-e986-2142-3196-31f549558511@redhat.com>
Subject: Re: [Qemu-devel] [PULL 43/46] block: Assertions for write permissions
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
 <1488314205-16264-44-git-send-email-kwolf@redhat.com>
 <20170406205939.GA28584@redhat.com>
In-Reply-To: <20170406205939.GA28584@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 03:59 PM, Richard W.M. Jones wrote:
> On Tue, Feb 28, 2017 at 09:36:42PM +0100, Kevin Wolf wrote:
>> This adds assertions that ensure that the necessary write permissions
>> have been granted before someone attempts to write to a node.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> Acked-by: Fam Zheng <famz@redhat.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/io.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 2592ca1..4c79745 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -945,6 +945,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(B=
drvChild *child,
>>      size_t skip_bytes;
>>      int ret;
>> =20
>> +    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE))=
;
>=20
>=20
> This assertion is thrown in the libguestfs test suite.  I filed a bug
> about it against the Fedora package:
>=20
> https://lists.gnu.org/archive/html/qemu-block/2017-02/msg01305.html

Wrong URL?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Xd0VcI3pkaNegpJgc4xnKX8WtOmOTXpmg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5q0gAAoJEKeha0olJ0Nq5rEH/2f4jeloXnTh+wgrhKXxQ3s3
+ipDY6G9lBFxR3LQ8xDYS67QiYQWdOH3alADGU4wK2tAOVbz2DMn9Gl29f+9lj4w
iDQQsfT8EtfacDtn2HBmMMo78P3LFFMnimZkw+QZoTLeEVGZYYq1DigaH8p6Wp5A
xIib9IqdRPpqmq3sDBRSC3ih9qTyFyii6DnSc9ndGk9zE5N8kxToPDyIWCEls+wQ
6IhtTxohEtFKLay4G05/Yykb/xtBtzPPJJ7Z8X3Wl6B0Vgg61kpqreltCn5Cl0AL
YFugB5W7FeG9j/5pXJFH6m1b1vpXWxGzeVT9axuZxmJz52+AkHPs+BuScsn80Tg=
=6lkQ
-----END PGP SIGNATURE-----

--Xd0VcI3pkaNegpJgc4xnKX8WtOmOTXpmg--
