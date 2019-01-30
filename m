Received: from eggs.gnu.org ([209.51.188.92]:57985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gor0w-0006s6-DP
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gor0v-0001JP-Pj
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:38:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gor0v-0001I8-Fy
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:38:53 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed, 30 Jan 2019 14:37:00 +0000
Message-Id: <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH 0/2] USB static analysis patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, Darren.Kenny@oracle.com, Mark.Kanda@oracle.com, ameya.more@oracle.com

These two patches are a result of running the Parfait static analysis
tool on QEMU.  The first patch is an optimisation to move an assignment
after a test and the second patch handles a number of potential NULL
pointer dereferences if usb_ep_get() returns NULL.

Liam Merwick (2):
  usb: rearrange usb_ep_get()
  usb: deal with potential Null pointer returned by usb_ep_get()

 hw/usb/core.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

-- 
1.8.3.1
