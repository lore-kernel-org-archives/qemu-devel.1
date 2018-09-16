Received: from eggs.gnu.org ([2001:4830:134:3::10]:39868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1g1X8K-0005C7-95
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 09:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1g1X8H-0007cz-3C
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 09:30:40 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:48478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1g1X8G-0007cb-Op
	for qemu-devel@nongnu.org; Sun, 16 Sep 2018 09:30:37 -0400
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Mime-Version: 1.0 (1.0)
Message-Id: <8CB09556-E484-44D1-92C4-AC92DE2638B1@profihost.ag>
Date: Sun, 16 Sep 2018 15:30:34 +0200
Subject: [Qemu-devel] Overcommiting cpu results in all vms offline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

while overcommiting cpu I had several situations where all vms gone offline w=
hile two vms saturated all cores.

I believed all vms would stay online but would just not be able to use all t=
heir cores?

My original idea was to automate live migration on high host load to move vm=
s to another node but that makes only sense if all vms stay online.

Is this expected? Anything special needed to archive this?

Greets,
Stefan=
