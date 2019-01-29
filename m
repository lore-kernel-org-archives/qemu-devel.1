Received: from eggs.gnu.org ([209.51.188.92]:52007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1goIGj-0006eZ-Pe
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 20:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1goI4t-0002vz-30
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 20:20:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:32422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1goI4n-0002s6-13
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 20:20:36 -0500
Date: Tue, 29 Jan 2019 02:20:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1901290213290.42676@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] macOS build error after ddac19f534 (virtio: split
 virtio 9p bits from virtio-pci)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Hello,

I'm getting error building on macOS after commit ddac19f534:

   CC      aarch64-softmmu/hw/virtio/virtio-blk-pci.o
In file included from qemu/hw/virtio/virtio-9p-pci.c:19:
In file included from qemu/hw/9pfs/virtio-9p.h:6:
In file included from qemu/hw/9pfs/9p.h:7:
qemu/fsdev/file-op-9p.h:19:10: fatal error: 'sys/vfs.h' file not found
#include <sys/vfs.h>
          ^~~~~~~~~~~

Am I missing something? (Apart from the include file which is not present 
on OS X... Maybe this needs the #ifdefs it had before the split?)

Regards,
BALATON Zoltan
