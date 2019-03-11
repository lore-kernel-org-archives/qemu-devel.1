Received: from eggs.gnu.org ([209.51.188.92]:55903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h3HW8-0003dK-JS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h3HW7-0004lC-VH
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:46:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1h3HW7-0004k7-N1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:46:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id o7so4254305wrp.12
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 02:46:43 -0700 (PDT)
Date: Mon, 11 Mar 2019 09:46:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190311094639.GA5991@stefanha-x1.localdomain>
References: <40280F65B1B0B44E8089ED31C01616EBA3947B1A@dggeml529-mbx.china.huawei.com>
	<20190306100646.GI22159@stefanha-x1.localdomain>
	<40280F65B1B0B44E8089ED31C01616EBA394CD10@dggeml529-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <40280F65B1B0B44E8089ED31C01616EBA394CD10@dggeml529-mbx.china.huawei.com>
Subject: Re: [Qemu-devel] Question about VM inner route entry's lost when
 vhost-user reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Lilijun (Jerry, Cloud Networking)" <jerry.lilijun@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, wangyunjian <wangyunjian@huawei.com>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2019 at 02:31:12AM +0000, Lilijun (Jerry, Cloud Networking) wrote:
> This problem is related with backend vhost-user socket abnormal cases, we shouldn't ask customers to configure it manually for backend's issues or depends on guest OS's network configuration.

In Step 1 you said:

> > >      1) In the VM, I add one route entry manually on the vNIC eth0 using the
> > linux tool route.

You configured the route manually inside the guest.  Seems like a guest
problem to me.

If this was a physical machine that lost connectivity due to a link
event, what would happen?

Stefan

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJchi5/AAoJEJykq7OBq3PILrIIAMC5rNU9zohL8QLbao8LxRow
O7ltceN9XWoqcoYu+CH4ckdN37uXNkCDPSyaG7Mn6q0vucVUo2vpwu1SJM7lueeY
qVHD0+9f4edUCTN5PED2/GfHJhOQOXs8gTH4GmNRy7UwLkWo160JFmIchQ+i4LnC
Y5ewT2syIqahEL1kN9Y9jJSduMGD5scvTeFriugTUYumSE6qgMqmc3kr8+0BeOyu
G/ooEz5Tb2i5kCvcX3pLMU46DSWKIVxrdXPnjHu5U1SAWzsO1fUsiSGU0aZpDVTz
4/gedRLRdLCHTsJUKLFD+JeR9cSR5JH07o6I/gfXuUZI2vw0zBiDmT70OXFvAx8=
=XroA
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
