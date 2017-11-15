Received: from eggs.gnu.org ([2001:4830:134:3::10]:36403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEvQn-0002EN-7q
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:00:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEvQj-0003RU-2l
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:00:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eEvQi-0003RG-ND
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:00:28 -0500
Date: Wed, 15 Nov 2017 11:00:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171115110019.GF8130@stefanha-x1.localdomain>
References: <8E78D212B8C25246BE4CE7EA0E645FE501B557EA@dggeml511-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <8E78D212B8C25246BE4CE7EA0E645FE501B557EA@dggeml511-mbs.china.huawei.com>
Subject: Re: [Qemu-devel] [Question] Qemu's Heap Becomes Very Large and
 Never Reduce Down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xulei (Stone)" <stone.xulei@huawei.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "yang.zhong" <yang.zhong@intel.com>, "anthony.xu" <anthony.xu@intel.com>, pbonzini <pbonzini@redhat.com>, berrange <berrange@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "liujunjie (A)" <liujunjie23@huawei.com>


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 03:14:52AM +0000, Xulei (Stone) wrote:
> Hi, guys
>=20
> I met a strange problem, with qemu 2.8.1:
> qemu consumes too many heap memory after several operations and can not r=
elease them anymore:
> hot pulg/unplug disk & net, vnc connect/disconnect, guestOS reboot, etc.
>=20
>=20
> 01a7a000-3b4efe000 rw-p 00000000 00:00 0                                 =
[heap]
>=20
> Size:           15520272 kB
>=20
> Rss:            14421836 kB
>=20
> Pss:            14421836 kB
>=20
> Shared_Clean:          0 kB
>=20
> Shared_Dirty:          0 kB
>=20
> Private_Clean:      1164 kB
>=20
> Private_Dirty:  14420672 kB
>=20
> Referenced:      7485624 kB
>=20
> Anonymous:      14421836 kB
>=20
> AnonHugePages:     34816 kB
>=20
> Swap:            1098140 kB
>=20
> KernelPageSize:        4 kB
>=20
> MMUPageSize:           4 kB
>=20
> Locked:                0 kB
>=20
> VmFlags: rd wr mr mw me ac sd
>=20
> My steps are:
> 1) start several VMs all equipped only 8G memory;
> 2) random combining those operations mentioned above;
> 3) after few hours, qemu's Virt memory and RSS both grow too large and ne=
ver fall down;
>=20
> After analysis via /proc/$pid/smaps, I found the VMA of pc.ram does not o=
ccupy much
> memory but only becauses of heap section.
>=20
> I guess that has some relations of glibc or qemu rcu_thread, but i can no=
t figure it out.
> Is there some patches can fix this problem or does somebody have any idea?

Please try qemu.git/master.

The malloc implementation (glibc, tcmalloc, jemalloc) probably makes a
difference since you are seeing heap growth.

The main question your report raises is that "random combining those
operations mentioned above" makes it hard to identify the operation that
leads to heap growth.  Can you run isolated tests that do only
hotplug/unplug *or* VNC connect/disconnect *or* guest OS reboot, not
everything together?

Thanks,
Stefan

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaDB5DAAoJEJykq7OBq3PICmYIALby3151fjma5xiMokBXZYVn
+zLoxm7jgHOPQWl5boqfOKEQkAP2TmajNUicOJ4EY3J45LN2aO3sD+R+yJPR/x3j
iswCyv13g8f0jQI0B91zCZF//p52mKBsHPTxAz3EDucLx5zqO460YCgzqJV9x003
Lav0fXgI0wdFNt3fzqy17X149eTlm+JX0mDEyv1dl4vgvuLmuHv9ukOzHaULReVX
PMer66l4lEWI71Xc4OPhpV6rSLWH8VGqRTlCg412c+XBjrDyO/lKtqdWfBoAqPgM
/vLXU5mabZYCic2pnCVM7ffuF6T6o4AseLEp5UTfh9iYtKL2qITlWUP5DAirLiA=
=9gZu
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
