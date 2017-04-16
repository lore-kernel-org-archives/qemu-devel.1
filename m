Received: from eggs.gnu.org ([2001:4830:134:3::10]:57889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1czscN-00059O-Mc
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 18:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1czscK-00036i-J1
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 18:26:03 -0400
Received: from mail-db5eur01on0109.outbound.protection.outlook.com
	([104.47.2.109]:27280
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1czscK-00035O-8h
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 18:26:00 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sun, 16 Apr 2017 22:10:51 +0000
Message-ID: <VI1PR0601MB2479E581256475D80164322A9C070@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <VI1PR0601MB2479DE114384C023CA45C41E9C040@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170416080930.luq2l4p3e36vovkj@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170416080930.luq2l4p3e36vovkj@var.youpi.perso.aquilenet.fr>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This issue still exists for me in 2.9 rc4. =20

-----Original Message-----
From: Samuel Thibault [mailto:samuel.thibault@gnu.org]=20
Sent: Sunday, April 16, 2017 04:10
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode net=
working (SLIRP)

Hello,

I hadn't seen the original report on the list, sorry. There is too much tra=
ffic on qemu-devel for me to manage to catch these :/

This problem was fixed by
e42f869b ("slirp: Make RA build more flexible") and a2f80fdf ("slirp: Send =
RDNSS in RA only if host has an IPv6 DNS server") which will be included in=
 qemu 2.9.

Samuel
