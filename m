Received: from eggs.gnu.org ([2001:4830:134:3::10]:41266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7X51-0005By-Pw
	for qemu-devel@nongnu.org; Sun, 07 May 2017 21:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7X4y-0007Il-NF
	for qemu-devel@nongnu.org; Sun, 07 May 2017 21:03:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d7X4y-0007IU-Hg
	for qemu-devel@nongnu.org; Sun, 07 May 2017 21:03:12 -0400
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
	<20170430125703.pcp4ldw7oardptmn@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247996FB5818A956470FE8169CEB0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <45bda408-e14a-ab39-a2fe-898fe96f5b40@redhat.com>
Date: Mon, 8 May 2017 03:03:05 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR0601MB247996FB5818A956470FE8169CEB0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>, Samuel Thibault <samuel.thibault@gnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, MCDONALD Margaret <margaret.mcdonald@hexagon.com>

On 06.05.2017 00:38, FONNEMANN Mark wrote:
>> Could you run tcpdump inside the guest so we are sure what the nslookup call emits?
> 
> Is there another way to determine this info? My guest OS is an embedded system with BusyBox 1.25 and not much else.

FWIW, QEMU also has a built-in packet-dump functionality. You can use it
like this:

qemu-system-xxx ... -netdev user,id=netuser \
   -object filter-dump,id=dump,netdev=netuser,file=/tmp/dump.dat \
   -device e1000,netdev=netuser,mac=00:11:22:33:44:55

Then run "wireshark -r /tmp/dump.dat" afterwards to have a look at the
packets.

 Thomas
