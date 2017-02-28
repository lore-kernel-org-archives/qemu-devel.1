Received: from eggs.gnu.org ([2001:4830:134:3::10]:51074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cipmo-00052Y-9E
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cipmj-0005d3-Jl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:58:22 -0500
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 28 Feb 2017 13:57:59 -0800
Message-ID: <20170228215801.10472-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] misc aarch64 fixes for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

Hi all,

I've been experimenting with running arm64 Windows on qemu's aarch64
virt target. There were a couple of fixes needed in the core ISA
emulation to enable this -- I'd appreciate feedback on whether this is
(a) the best way to implement these and (b) suitable for inclusion in
mainline. (I realise this is too late for 2.9, but would be happy to
have any feedback nevertheless.)

I've smoke-tested that these don't break Linux by following:
https://www.bennee.com/~alex/blog/2014/05/09/running-linux-in-qemus-aarch64-system-emulation-mode/
... however, that is fairly old; I'd also be happy to try a more
recent kernel if someone could point me to a bootable image.

Cheers,
Andrew

Andrew Baumann (2):
  target/arm: implement armv8 PMUSERENR (user-mode enable bits)
  target/arm: lie more convincingly about memory attributes in PAR_EL1

 target/arm/helper.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 9 deletions(-)

-- 
2.8.3
