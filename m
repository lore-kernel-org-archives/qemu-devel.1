Received: from eggs.gnu.org ([209.51.188.92]:36302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h3QgL-0000BV-Ie
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h3QgK-0006DQ-GF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:33:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:15317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h3QgJ-0005d5-RW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:33:52 -0400
Date: Mon, 11 Mar 2019 20:33:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903112027050.69539@zero.eik.bme.hu>
References: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] ssh session with qemu-arm using busybox
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>, kernelnewbies@kernelnewbies.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, qemu-devel@nongnu.org, =?EUC-KR?B?wPzB+L+1?= <jy0.jeon@gmail.com>

On Mon, 11 Mar 2019, Pintu Agarwal wrote:
> I am sure, many of you people would have explored already "how to use
> ssh over qemu" and found a easy method.
> So, if anybody have easy setup please share with me.
>
> I could see that after adding "ip=dhcp" I get the eth0 interface like this:
> / # ifconfig
> eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
>          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:2 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:1180 (1.1 KiB)  TX bytes:1180 (1.1 KiB)
>          Interrupt:22
>
> lo        Link encap:Local Loopback
>          inet addr:127.0.0.1  Mask:255.0.0.0
>          UP LOOPBACK RUNNING  MTU:65536  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>
> But I could not ping it from ubuntu PC.

This should already be documented here:
https://wiki.qemu.org/Documentation/Networking

The default QEMU network is -net user slirp based networking that provides 
outbound connectivity from the virtual machine but no ping or inbound 
connections. I.e. you can ssh from your guest to your host (so you could 
use scp in your guest to copy files from your host) or use some other 
networking (such as tap) that allows the host to connect to guest (but 
then you'll need to arrange routing and dhcp if you want that on your 
host otherwise your guest will only see your host). Hope this helps.

Regards,
BALATON Zoltan
