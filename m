Received: from eggs.gnu.org ([2001:4830:134:3::10]:50850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYGdO-0007zM-B5
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYGdL-0002ih-5r
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:01:46 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:38408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYGdL-0002iP-1P
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:01:43 -0400
Received: by mail-qt0-x236.google.com with SMTP id c5-v6so2769382qth.5
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:01:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627185248.GA19743@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
Date: Wed, 27 Jun 2018 17:01:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180627185248.GA19743@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="GKoJl1pe513oBNRhzBg9BGjgL9rk2IY2U"
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GKoJl1pe513oBNRhzBg9BGjgL9rk2IY2U
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Guenter Roeck <linux@roeck-us.net>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <96809884-2f46-ed63-48fd-9fd4c5050e20@amsat.org>
Subject: Re: [Qemu-devel] Linux kernel configurations for various Microblaze
 systems
References: <20180627185248.GA19743@roeck-us.net>
In-Reply-To: <20180627185248.GA19743@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On 06/27/2018 03:52 PM, Guenter Roeck wrote:
> Hi,
>=20
> I would like to add Microblaze "petalogix-ml605" and "xlnx-zynqmp-pmu"
> to my list of qemu boot tests of upstream and stable release kernels.

Do you mind sharing your tests on this thread?

"Who is running QEMU automated tests, and when?"
http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04695.html

> Unfortunately I have been unable to locate working kernel configuration=
s
> for the those systems, nor working qemu command lines. I found a few li=
nks,
> but they are all dead.

I got more lucky using the Xilinx downstream code from:
https://github.com/Xilinx

In particular using their downstream DeviceTree:

https://github.com/Xilinx/device-tree-xlnx

I also used those links:

http://www.wiki.xilinx.com/MicroBlaze
http://www.wiki.xilinx.com/Build%20kernel

Regards,

Phil.


--GKoJl1pe513oBNRhzBg9BGjgL9rk2IY2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsz7R4ACgkQ4+MsLN6t
wN4TvA//XsXWZlOt2Bkh1UMktwEyz0AxNojvVk4VCo8jJaPOiY6h1JmN2LbR9Bua
jYdFbtcxLtTVZJfG+hZbzz8hmUGJ20XrYRMjE9MEpJtae/0Jbeh1HQO5uBuSCRbH
5fcklq7MN2dw3bjdrsFxHxTLikJYWk0xWvo02tSyaK4IJKSlRc+NtGXoWywU19hh
eLK6ohpbgAM9hQjBGbaezf7fDi27vp3gucXYI3hoyiu3GCyq5CysLt+vPSTkW4JN
AwcTOe/sdj1ZSXWGC0Cd8RYpuEqAyxVB+ZDK7D7tA5ge21ROTfT2RK3Z8BEGMdXV
9SLxJeYxmiPYbICFF8AWF5Uac8IMKKyaOb15wh/RwwY8kZ2uy6iK8pW2wk0c+RX5
g7HFXyVyfb/CRLaEo4oD+al434WoBMt/JMzEFmK5vhak47QcD/E+UGoqD++eq69z
9/MTINg5ICxFQXFt3ZYdBhOSKLcflmAKAyOfF22ivT8ssS/UV+4bKNI+AnV5cpfY
avEsWJIm6z2mmyJbUAtzBw4gLjxVGJBSWqVfErt9AWlvmG7neh/iM9ulOKssF40o
CjA+Abn2lAbpvUajh9lzy5O2Fr4AdNFB+Lej5wxC94HexCA16NOTzFtpQ0uo4xxM
Ht+DcucvYiOmcbyzOlsbUOn0Zdf8/gbC7JsSyeA2gsxHgHDX42E=
=8/xw
-----END PGP SIGNATURE-----

--GKoJl1pe513oBNRhzBg9BGjgL9rk2IY2U--
