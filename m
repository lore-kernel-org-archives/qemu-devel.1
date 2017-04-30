Received: from eggs.gnu.org ([2001:4830:134:3::10]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4oPW-0003GR-HD
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 08:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4oPT-0005p0-BN
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 08:57:10 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:56703)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4oPT-0005ot-5j
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 08:57:07 -0400
Date: Sun, 30 Apr 2017 14:57:03 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170430125703.pcp4ldw7oardptmn@var.youpi.perso.aquilenet.fr>
References: <20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CBDA85F323A82C0CFBD99C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429171002.enxmz5dtuzhrxuc6@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479886B8955148FD8A2D06F9C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429191402.ebsdilnya67ispla@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479CA25619E1C66359EC3709C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170429220156.bb4hdlsaf6zzqmtw@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479F31C301B954294452CA49C120@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247905FC4B3FEE03780CF1EE9C150@VI1PR0601MB2479.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0601MB247905FC4B3FEE03780CF1EE9C150@VI1PR0601MB2479.eurprd06.prod.outlook.com>
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
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, MCDONALD Margaret <margaret.mcdonald@hexagon.com>

FONNEMANN Mark, on dim. 30 avril 2017 12:42:41 +0000, wrote:
> root@qemu:~# nslookup www.google.com
>                    *** Unknown host
> 
>                    nslookup: www.google.com: Unknown host

Could you run tcpdump inside the guest so we are sure what the nslookup
call emits?

Samuel
