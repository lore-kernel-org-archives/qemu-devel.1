Received: from eggs.gnu.org ([2001:4830:134:3::10]:34688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX7C3-0001Fq-65
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX7By-0005sL-Bs
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:40:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX7By-0005rf-5x
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:40:10 -0400
Date: Mon, 17 Jul 2017 15:39:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170717143957.GS7163@stefanha-x1.localdomain>
References: <1500114070-181004-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wnBGVoaGQwxWUIo6"
Content-Disposition: inline
In-Reply-To: <1500114070-181004-1-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [RFC 0/3] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, weidong.huang@huawei.com, roy.fan.zhang@intel.com, xin.zeng@intel.com, linqiangmin@huawei.com, marcandre.lureau@redhat.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, jianjay.zhou@huawei.com


--wnBGVoaGQwxWUIo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 15, 2017 at 06:21:07PM +0800, Gonglei wrote:
> And the Intel guys are working on the DPDK vhost-crypto
> implementation. So let us push the cryptodev-vhost-user
> backend upstream so that the whole process can be
> accelerated.

I guess you want to use this?
http://dpdk.org/doc/guides/cryptodevs/qat.html

That makes sense.  I just wanted to share the link in case anyone else
is wondering how DPDK helps crypto.

Stefan

--wnBGVoaGQwxWUIo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbMw9AAoJEJykq7OBq3PIdNkH/itJ6AhX++WmV2irY2ciB0av
IZRUlcDFbxMW93Jq1vph/Be3rIzX8WGQ/k58yxUrMkluxCRiCe9Fgmi0GvPYaCNB
fOAd3FVV7V0tStRNsOG3GiaegeL9kwxB2BVPijLAkyLf0SK/tL42mKxKgKls9bJ0
i0SYTcFexm4vR+YFCuK2e6ylE13BYYTjDCbmntLBvDw4JBRfRTYCZFtZi7Ns9MUD
9j/deaYM9bhZG56nYVcK9qidT1zJywOcs1r6Jl61RBySQL7KudTdo0xzWYNYlYmG
xR528xwkrVAmXFRV+NzyGF3/EN+81c8HMBj7KKr88s97De2qVijqiCgfWTgEDqs=
=D60l
-----END PGP SIGNATURE-----

--wnBGVoaGQwxWUIo6--
