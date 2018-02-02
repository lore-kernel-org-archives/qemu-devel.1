Received: from eggs.gnu.org ([2001:4830:134:3::10]:48415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehcje-0001QF-Dk
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehcjd-0000KE-EQ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:54:38 -0500
References: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
	<1b55edad-f820-6898-1630-ccc76e6c4845@redhat.com>
	<5858df64-9495-1332-3c53-fab0204f79a9@virtuozzo.com>
	<8b87f82d-2a90-d6cf-0fc4-aee0d704a403@redhat.com>
	<4919379e-ee86-5032-ec1e-fea39912783b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f76135f-6a96-6446-7f48-0683e7674c32@redhat.com>
Date: Fri, 2 Feb 2018 08:15:50 -0600
MIME-Version: 1.0
In-Reply-To: <4919379e-ee86-5032-ec1e-fea39912783b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="89DL7vZTxKvuuZ3CMQ7PXgKrjX2X6zeTL"
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: implement bdrv_get_info callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--89DL7vZTxKvuuZ3CMQ7PXgKrjX2X6zeTL
From: Eric Blake <eblake@redhat.com>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <5f76135f-6a96-6446-7f48-0683e7674c32@redhat.com>
Subject: Re: [PATCH 1/1] nbd: implement bdrv_get_info callback
References: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
 <1b55edad-f820-6898-1630-ccc76e6c4845@redhat.com>
 <5858df64-9495-1332-3c53-fab0204f79a9@virtuozzo.com>
 <8b87f82d-2a90-d6cf-0fc4-aee0d704a403@redhat.com>
 <4919379e-ee86-5032-ec1e-fea39912783b@virtuozzo.com>
In-Reply-To: <4919379e-ee86-5032-ec1e-fea39912783b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 08:06 AM, Edgar Kaziakhmedov wrote:

>>>> However, it would be nice to remove can_write_zeroes_with_unmap from=

>>>> BlockDriverInfo, and make bdrv_can_write_zeroes_with_unmap just retu=
rn
>>>> !!(bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP).=C2=A0 Kevin, what=
 do you
>>>> think?
>> Actually, I may even just give a shot at writing this alternative patc=
h,
>> to make Kevin's decision easier.
> But actually qcow2 performs some checks for version inside get_info
> callback before setting can_write_zeroes_with_unmap flag,
> so we can't take into account such checks in
> bdrv_can_write_zeroes_with_unmap subroutine. Therefore, I don't think i=
t
> is possible to do it like that.

Here's the patch I proposed (it looks like I forgot to CC you):

https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06471.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--89DL7vZTxKvuuZ3CMQ7PXgKrjX2X6zeTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0cpYACgkQp6FrSiUn
Q2pImgf/a50pLpygsp5IqLB+QPsKdC96Lv/wrQ7pZmrsFZQ6WKw6xfi9u+s1nT9D
IK4i2ROCPokwm1JWGfHyS6bzvscOZIeiLpM3zwxUO0loneq07jGeEC5AsMrdFOie
Fbj8BfTG5s8dBaBVLjirAhgZEohnLljyriKWfeOSp8hZTt6+v4/bQeOp7vqOOFRh
yhZYhVCbKpK0ETcSYbrvjtGjz9BlACEsHSytEKKOCO9B+xxIQv7pAnmndotKR3AK
IeunFPVajxIGROBKp9wSIN2E9hyjTGLZZ9YzW1/Z88CVXDhFjQgUupapHV33mWT8
a/U4tkdgt2Ljul8V/EcWFOss1d9JzA==
=jK85
-----END PGP SIGNATURE-----

--89DL7vZTxKvuuZ3CMQ7PXgKrjX2X6zeTL--
