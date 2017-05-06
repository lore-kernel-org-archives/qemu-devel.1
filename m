Received: from eggs.gnu.org ([2001:4830:134:3::10]:60305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d71He-0003W4-6q
	for qemu-devel@nongnu.org; Sat, 06 May 2017 11:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d71HZ-0006Ja-5x
	for qemu-devel@nongnu.org; Sat, 06 May 2017 11:06:10 -0400
Received: from mail-ve1eur01on0110.outbound.protection.outlook.com
	([104.47.1.110]:2593
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d71HY-0006JT-Sc
	for qemu-devel@nongnu.org; Sat, 06 May 2017 11:06:05 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sat, 6 May 2017 15:06:02 +0000
Message-ID: <VI1PR0601MB2479230A02CDB35C0753B1CF9CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
References: <20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247905FC4B3FEE03780CF1EE9C150@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430125703.pcp4ldw7oardptmn@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247996FB5818A956470FE8169CEB0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170505231433.ggp34jmzx4fad6jp@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479934DD8D5807C7A9DB0A39CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170506005600.6utgnirnrlm2g56i@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479B8C2F3EA375823AD6B6E9CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170506011720.x7proxrmpvakd4it@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479B2228D4C769486ECAEC39CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170506092316.im32h7vth5rmvqtg@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170506092316.im32h7vth5rmvqtg@var.youpi.perso.aquilenet.fr>
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
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

>So, in your /etc/nsswitch.conf, use
>hosts: files dns

This resolved the problem. I am now able to do DNS queries using nslookup.
Thanks for all your help!

Mark.
