Received: from eggs.gnu.org ([2001:4830:134:3::10]:56652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eWeBw-0001xx-MW
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eWeBs-00055e-4s
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:14:28 -0500
Received: from mailpro.odiso.net ([89.248.211.110]:55758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1eWeBr-0004ya-To
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:14:24 -0500
Date: Wed, 3 Jan 2018 09:14:10 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <826605310.756359.1514967250373.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <77f0c119-236d-9d4e-0a99-3519ecc26b23@profihost.ag>
References: <77f0c119-236d-9d4e-0a99-3519ecc26b23@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] dropped pkts with Qemu on tap interace (RX)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi Stefan,

>>The tap devices on the target vm shows dropped RX packages on BOTH tap=20
>>interfaces - strangely with the same amount of pkts?=20

that's strange indeed.=20
if you tcpdump tap interfaces, do you see incoming traffic only on 1 interf=
ace, or both random ?

(can you provide the network configuration in the guest for both interfaces=
 ?)


I'm seeing that you have enable multiqueue on 1 of the interfaces, do you h=
ave setup correctly the multiqueue part inside the guest.
do you have enough vcpu to handle all the queues ?


----- Mail original -----
De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
=C3=80: "qemu-devel" <qemu-devel@nongnu.org>
Envoy=C3=A9: Mardi 2 Janvier 2018 12:17:29
Objet: [Qemu-devel] dropped pkts with Qemu on tap interace (RX)

Hello,=20

currently i'm trying to fix a problem where we have "random" missing=20
packets.=20

We're doing an ssh connect from machine a to machine b every 5 minutes=20
via rsync and ssh.=20

Sometimes it happens that we get this cron message:=20
"Connection to 192.168.0.2 closed by remote host.=20
rsync: connection unexpectedly closed (0 bytes received so far) [sender]=20
rsync error: unexplained error (code 255) at io.c(226) [sender=3D3.1.2]=20
ssh: connect to host 192.168.0.2 port 22: Connection refused"=20

The tap devices on the target vm shows dropped RX packages on BOTH tap=20
interfaces - strangely with the same amount of pkts?=20

# ifconfig tap317i0; ifconfig tap317i1=20
tap317i0 Link encap:Ethernet HWaddr 6e:cb:65:94:bb:bf=20
UP BROADCAST RUNNING PROMISC MULTICAST MTU:1500 Metric:1=20
RX packets:2238445 errors:0 dropped:13159 overruns:0 frame:0=20
TX packets:9655853 errors:0 dropped:0 overruns:0 carrier:0=20
collisions:0 txqueuelen:1000=20
RX bytes:177991267 (169.7 MiB) TX bytes:910412749 (868.2 MiB)=20

tap317i1 Link encap:Ethernet HWaddr 96:f8:b5:d0:9a:07=20
UP BROADCAST RUNNING PROMISC MULTICAST MTU:1500 Metric:1=20
RX packets:1516085 errors:0 dropped:13159 overruns:0 frame:0=20
TX packets:1446964 errors:0 dropped:0 overruns:0 carrier:0=20
collisions:0 txqueuelen:1000=20
RX bytes:1597564313 (1.4 GiB) TX bytes:3517734365 (3.2 GiB)=20

Any ideas how to inspect this issue?=20

Greets,=20
Stefan=20
