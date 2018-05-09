Received: from eggs.gnu.org ([2001:4830:134:3::10]:41616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGRLA-0001MD-DL
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGRL7-0007TW-9V
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:49:16 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  9 May 2018 17:49:08 +0200
Message-Id: <20180509154910.23578-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/2] vfio-ccw: exploit halt/clear
 subchannel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Hi,

this is the QEMU companion patchset to "vfio-ccw: support for {halt,clear}
subchannel", but is interface-wise independent of it.

With an old host kernel, things should work as before. With a new host
kernel, guest halt/clear requests should get passed through to the host.

I tested this with a hacked-up guest kernel to issue clears on demand.

Cornelia Huck (2):
  vfio-ccw: forward halt/clear to device if supported
  s390/css: add some tracing for pass-through handling

 hw/s390x/css.c         | 38 ++++++++++++++++++++++++++++++++++----
 hw/s390x/trace-events  |  4 ++++
 hw/vfio/ccw.c          | 11 +++++++++--
 include/hw/s390x/css.h | 10 +++++++---
 4 files changed, 54 insertions(+), 9 deletions(-)

-- 
2.14.3
