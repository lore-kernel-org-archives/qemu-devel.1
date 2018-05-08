Received: from eggs.gnu.org ([2001:4830:134:3::10]:33080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzNX-0004En-4T
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzNU-0003Y8-0H
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:57:51 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:46697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fFzNT-0003X7-P5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:57:47 -0400
Received: by mail-wr0-x22d.google.com with SMTP id a12-v6so748295wrn.13
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 02:57:47 -0700 (PDT)
Date: Tue, 8 May 2018 10:57:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508095745.GC19710@stefanha-x1.localdomain>
References: <1524894864-7492-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <1524894864-7492-1-git-send-email-jianjay.zhou@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] backends/cryptodev: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, weidong.huang@huawei.com, mst@redhat.com


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 28, 2018 at 01:54:24PM +0800, Jay Zhou wrote:
> This patch removes the dead code, which fixes Coverity (CID 1390600) issu=
e.
>=20
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
>  backends/cryptodev-vhost-user.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8XSZAAoJEJykq7OBq3PIEPgIAKvOZVai0dmnUxjUbLV3AQrH
hr0Elee1BHpwNJbbTwjJXqP0zQfZNuBZhdjZTy1htCpem9B5uVi6jDSIwxa5R4lT
UY/RdW6mSQTke+5mSsExxkkf7Gak8ZL01n+NDOsY5s28u26psdVzOFNBuF2k1RF/
YKXrol7N7J9OIfnh/Bt+PRP2k9uIjWPdeiR3gu0Gc83O6BtfihxH2QBaVB3Cr/6i
h6085+LbrW1dYHbfjqNwsHcBquSml12jYv6K+KPCzQzCzkt8PzWbDsaD2A10OeFV
zglsJiQXHc8i57qqNxun7VEBHIg2EPYwR2bpLaw0aeJb5XdWANPU4on5+JGdnF4=
=rLRv
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
