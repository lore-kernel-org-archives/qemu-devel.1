Received: from eggs.gnu.org ([209.51.188.92]:50182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1TS0-0001Y8-8R
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1TRx-0002XB-Gi
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:06:58 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1h1TRv-0002RZ-1y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:06:55 -0500
Received: by mail-wr1-x431.google.com with SMTP id n2so12683175wrw.8
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 02:06:49 -0800 (PST)
Date: Wed, 6 Mar 2019 10:06:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190306100646.GI22159@stefanha-x1.localdomain>
References: <40280F65B1B0B44E8089ED31C01616EBA3947B1A@dggeml529-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TA4f0niHM6tHt3xR"
Content-Disposition: inline
In-Reply-To: <40280F65B1B0B44E8089ED31C01616EBA3947B1A@dggeml529-mbx.china.huawei.com>
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


--TA4f0niHM6tHt3xR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 08:26:23AM +0000, Lilijun (Jerry, Cloud Networking)=
 wrote:
>       I am running my VM using vhost-user NIC with OVS-DPDK.  The steps o=
f my question is shown as follows:
>      1) In the VM, I add one route entry manually on the vNIC eth0 using =
the linux tool route.=20
>      2) When restarting openvswitch service for the crash of the ovs-vswi=
tchd, qemu's vhost-user reconnected successfully after 40s. =20
>      3) Here VM's vNIC will receive link down and up events, the interval=
 between the two events is about 40s.
>      3) But that route entry disappeared and that will cause user's netwo=
rk traffic interruption and the service failed.
>=20
>      Is there some work on this problem?  Can we keep the vNIC's link up =
status when do vhost-user's reconnecting work?

Can you add the custom route to the network management tool inside the
guest so that it will be reinstated when the link comes back up?

The details of how to do this depend on the guest's distro.

Stefan

--TA4f0niHM6tHt3xR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf5u2AAoJEJykq7OBq3PIT2gH+QHKQOrFgojQRLOfuMGkO9ws
NtpMlGFCMJJBqYrUpqR8joqkGBxQ+u275Na4/GkEsXEqyjFGVthz3/QpyVTpGGwE
xiSLD34s/lvv36EyD3lqNb5Wr68puKhEJ/5XhBv6GKSwjFEMbYBYx3CcWBUl8OvS
mtzYO2A2Mevu0/IgFWXfZrVXNhiBRg6zRfS6vXCvbYD2ua2kaZwvrMBQKrnySVvJ
4LKqH2PxMTuEkm/TF/4uKkdCagvBRFlV7PKa+yuyayg9P8mGAng9EvZ7G1lwcKnz
7w7UHFmgD/sX+f0NPlQS/8SLeux3DgB1YcrCk/JskQ4gc9SyWkLCeL2/mUf7X4Q=
=y2Kv
-----END PGP SIGNATURE-----

--TA4f0niHM6tHt3xR--
