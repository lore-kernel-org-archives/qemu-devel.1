Received: from eggs.gnu.org ([2001:4830:134:3::10]:42252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo.btrfs@gmx.com>) id 1fBH2t-0003fD-9I
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quwenruo.btrfs@gmx.com>) id 1fBH2q-0000Un-1f
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:49:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:58401)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <quwenruo.btrfs@gmx.com>)
	id 1fBH2p-0000U7-NL
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:48:59 -0400
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c0eaa5d5-7b1a-74f9-1d34-d8ac7cff3546@gmx.com>
Date: Wed, 25 Apr 2018 17:48:42 +0800
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hgvx0C9aY42QQ0JhcwaibquzkKs4AzNqq"
Subject: [Qemu-devel] ridiculously slow VM memory performance on Ryzen CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hgvx0C9aY42QQ0JhcwaibquzkKs4AzNqq
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <c0eaa5d5-7b1a-74f9-1d34-d8ac7cff3546@gmx.com>
Subject: ridiculously slow VM memory performance on Ryzen CPU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

When testing IO heavy work on my VM backed by Ryzen 1700 CPU, I turned
to brd modules, but surprisingly, the speed is even slower than some HDD:=


---
$ sudo modprobe brd rd_nr=3D1 rd_size=3D1048576
$ dd if=3D/dev/zero of=3D/dev/ram0 bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 9.9928 s, 107 MB/s
---
107MB is pretty lame...
Even some HDD could be faster than this.

On host, it's much better:
---
$ if=3D/dev/zero of=3D/dev/ram0 bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.754641 s, 1.4 GB/s
---

For host hardware:
CPU: Ryzen 1700 All cores @ 3.8G
Mem: DDR4 2400 dual channel (8G x 2)

For host software:
Kernel:       4.16.3-1-ARCH
Qemu:         2.11.1-2
Distribution: Archlinux

VM setup is mostly default setup done by libvirt.

I'm not sure if this is related to this bug:
https://www.redhat.com/archives/vfio-users/2017-April/msg00019.html

Thanks,
Qu


--hgvx0C9aY42QQ0JhcwaibquzkKs4AzNqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlrgTvoACgkQwj2R86El
/qhsqQgAlHEgMh4WOzZhYL464zlCGeiEJxoulYvJCPQ0MyVHcUQUXizevvAJUE95
62+mmJTHzGS6Leeh/alfDbrES8aevE3R0ewNrFGxcPBNwgjbVZoAaA5hRfAW+fsb
HzcjUmiS4dheLjk3LppCWcb7VQehY0L8lxZ93BwzCC9mXztEUnLhnG0p+hJ5dZX/
/000A22OvOcv04BRnjRo+OVjXTJrDY+5192Psd1u1ZEBQEG/tNPAJg4TG+CY9FIz
W5B3JD8h2UCS0GOnvA+z2yyIL+5cR06dGOhfaxc31WmSYmsASDNEqfnmjsvic1KO
dzRWBHFwHQmsKC8nR8ukzVlnawmSUQ==
=Osjm
-----END PGP SIGNATURE-----

--hgvx0C9aY42QQ0JhcwaibquzkKs4AzNqq--
