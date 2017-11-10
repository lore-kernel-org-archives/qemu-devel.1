Received: from eggs.gnu.org ([2001:4830:134:3::10]:50090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eDDCP-0002t7-Tb
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eDDCM-0001y8-PW
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:34:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eDDCM-0001vy-KF
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:34:34 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 10 Nov 2017 18:34:18 +0100
Message-Id: <20171110173421.17904-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] ivshmem: MSI bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: geoff@hostfission.com, pbonzini@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com

Fixes bugs in the ivshmem device implementation uncovered with the new
Windows ivshmem driver:
https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshmem

Ladi Prosek (3):
  ivshmem: Don't update non-existent MSI routes
  ivshmem: Always remove irqfd notifiers
  ivshmem: Improve MSI irqfd error handling

 hw/misc/ivshmem.c | 75 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 19 deletions(-)

-- 
2.13.5
