Received: from eggs.gnu.org ([2001:4830:134:3::10]:42563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dvUmn-0006jj-HY
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dvUmm-00066O-G7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:42:57 -0400
References: <20170922144353.4220-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8bc85930-8593-d35a-318a-7cff11e5e6ab@redhat.com>
Date: Fri, 22 Sep 2017 15:42:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170922144353.4220-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ISwUnh9ht6D3tPNLwodLBpaSGBMiF7M6f"
Subject: Re: [Qemu-devel] [PATCH] block/qcow2-bitmap: fix use of
 uninitialized pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ISwUnh9ht6D3tPNLwodLBpaSGBMiF7M6f
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 kwolf@redhat.com, mreitz@redhat.com
Cc: den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <8bc85930-8593-d35a-318a-7cff11e5e6ab@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/qcow2-bitmap: fix use of uninitialized
 pointer
References: <20170922144353.4220-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170922144353.4220-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/22/2017 09:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> Without initialization to zero dirty_bitmap field may be not zero
> for a bitmap which should not be stored and
> qcow2_store_persistent_dirty_bitmaps will erroneously call
> store_bitmap for it which leads to SYGSEGV on bdrv_dirty_bitmap_name.

s/SYG/SIG/

Introduced in commit 5f72826e, therefore it impacts 2.10, so:

CC: qemu-stable@nongnu.org

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ISwUnh9ht6D3tPNLwodLBpaSGBMiF7M6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnFdcgACgkQp6FrSiUn
Q2opXAf/W81pdqi5KcO76cvbmXkBQIbnHN4OQUOjsWNu/S/d+XNcSGy0hGISRWYB
nG/T4jUCsSz0VhzKQVlTbviqf+dQSp6pTVNSQBnfSVFbd1sNSzV96Li8OMvq+L2u
f3Qe2rW+612NQjRTKujaTO75t2LS5fbjaTLVUBNjk1I/vHFq+h0X+GphRX+K2kJG
ofXQvc2WnmACvtJH+xldRkmpB/dvziULJY+Fkr07b9DQU2+Msj8fLFANjy8Tf9jg
sw7KThBgp6OOXI5JN2fhUt0+0pQGG1YGEa29MxLMzS40D8ZRTDUWQmGx2zmmRtBC
q6ThJpkFzyNAEobDd0neaGCNtJeMjg==
=oSVt
-----END PGP SIGNATURE-----

--ISwUnh9ht6D3tPNLwodLBpaSGBMiF7M6f--
