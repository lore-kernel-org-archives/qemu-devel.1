Received: from eggs.gnu.org ([209.51.188.92]:56355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hApRn-0006yX-Cy
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hApRm-0002KZ-EN
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:25:27 -0400
Received: from mail-eopbgr770111.outbound.protection.outlook.com
	([40.107.77.111]:2374
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tjin@wavecomp.com>) id 1hApRm-0002Hz-0P
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:25:26 -0400
From: Tommy Jin <tjin@wavecomp.com>
Date: Mon, 1 Apr 2019 05:25:21 +0000
Message-ID: <1554096222-29539-1-git-send-email-tjin@wavecomp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Adds virtio_net as the default netcard for boston board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

This is a patch for Mips Boston board.
Currently, Boston didn't bring up any netcard by default, this is not so co=
nvenient for users who are verifying network related functionalities on thi=
s board.
As the linux kernel has already supported virtio_net, now add a virtio netc=
ard for boston, to make virtio work properly, please:
1. set virtio net options in linux kernel, saying CONFIG_VIRTIO && CONFIG_V=
IRTIO_PCI && CONFIG_VIRTIO_NET
2. specify model=3Dvirtio when you start boston in qemu.

Best regards,
Tommy
