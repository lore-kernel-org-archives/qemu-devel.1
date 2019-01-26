Received: from eggs.gnu.org ([209.51.188.92]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gnHjz-0003Ho-QD
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 01:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gnHjx-0004SM-3y
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 01:46:55 -0500
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Date: Sat, 26 Jan 2019 08:46:30 +0200
Message-ID: <2184988.RNmFpAbUkI@basile.remlab.net>
In-Reply-To: <1738864.GFcTaivyIR@basile.remlab.net>
References: <1648289.tQCHxfjYn9@basile.remlab.net>
	<02a680e1-c20c-2ecb-2926-6250fddf9e76@linaro.org>
	<1738864.GFcTaivyIR@basile.remlab.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] target/arm: fix AArch64
 virtual address space size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Le lauantaina 26. tammikuuta 2019, 8.36.00 EET R=C3=A9mi Denis-Courmont a =
=C3=A9crit :
> I believe that TARGET_PHYS_ADDR_SPACE_BITS could be reduced to 56 bits.
> Anything less would presumably break handling of the address "sign" bit 5=
5.

Err, sorry. That is already 48 bits and that is the correct value of course=
=2E=20
There is no sign bit in physical address space.

=2D-=20
=E3=83=AC=E3=83=9F=E3=83=BB=E3=83=87=E3=83=8B-=E3=82=AF=E3=83=BC=E3=83=AB=
=E3=83=A2=E3=83=B3
http://www.remlab.net/
