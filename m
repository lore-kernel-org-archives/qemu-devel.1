Received: from eggs.gnu.org ([2001:4830:134:3::10]:57856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dSquA-0004VK-Nm
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 16:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dSqu9-0004tm-QO
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 16:28:10 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dSqu9-0004s1-KH
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 16:28:09 -0400
Date: Wed, 5 Jul 2017 22:27:57 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170705202757.rlwd2lw3qo2g6sow@aurel32.net>
References: <84bf1844-8d5c-2a71-c1cc-8f8c74511fca@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <84bf1844-8d5c-2a71-c1cc-8f8c74511fca@vivier.eu>
Subject: Re: [Qemu-devel] trigonometric functions in softfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Thomas Huth <huth@tuxfamily.org>

Hi,

On 2017-07-05 10:25, Laurent Vivier wrote:
> Hi,
>=20
> Thomas has pointed out that WinUAE[1] has an updated softfloat library
> implementing missing operations for 680x0.
>=20
> Do you think these changes can be merged in QEMU?

=46rom the licensing point of view, they seems to use the SoftFloat-2a
license, so that should be fine.

Personally I am fine adding general trigonometric functions to
softfloat, that might help other targets like x86 which uses  the math
functions from libm and thus have different behaviour/precision
depending on the host.

The question is more how m68k specific are those trigonometric
functions. If we can have a way to implement them as generic
trigonometric functions reusable by other targets, I am all for it. If
not that code would probably be better in target/m68k.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
