Received: from eggs.gnu.org ([2001:4830:134:3::10]:53581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eWKZe-0001vw-Q5
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 06:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eWKZZ-0004xY-Ti
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 06:17:38 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:12839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eWKZZ-0004w1-Hy
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 06:17:33 -0500
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <77f0c119-236d-9d4e-0a99-3519ecc26b23@profihost.ag>
Date: Tue, 2 Jan 2018 12:17:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] dropped pkts with Qemu on tap interace (RX)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hello,

currently i'm trying to fix a problem where we have "random" missing
packets.

We're doing an ssh connect from machine a to machine b every 5 minutes
via rsync and ssh.

Sometimes it happens that we get this cron message:
"Connection to 192.168.0.2 closed by remote host.
rsync: connection unexpectedly closed (0 bytes received so far) [sender]
rsync error: unexplained error (code 255) at io.c(226) [sender=3.1.2]
ssh: connect to host 192.168.0.2 port 22: Connection refused"

The tap devices on the target vm shows dropped RX packages on BOTH tap
interfaces - strangely with the same amount of pkts?

# ifconfig tap317i0; ifconfig tap317i1
tap317i0  Link encap:Ethernet  HWaddr 6e:cb:65:94:bb:bf
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:2238445 errors:0 dropped:13159 overruns:0 frame:0
          TX packets:9655853 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:177991267 (169.7 MiB)  TX bytes:910412749 (868.2 MiB)

tap317i1  Link encap:Ethernet  HWaddr 96:f8:b5:d0:9a:07
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:1516085 errors:0 dropped:13159 overruns:0 frame:0
          TX packets:1446964 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1597564313 (1.4 GiB)  TX bytes:3517734365 (3.2 GiB)

Any ideas how to inspect this issue?

Greets,
Stefan
