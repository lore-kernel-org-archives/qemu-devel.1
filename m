Received: from eggs.gnu.org ([2001:4830:134:3::10]:47131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4S7e-0004ro-Pu
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4S7Z-0007xz-46
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:41:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4S7Y-0007xS-Ug
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:41:25 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 17 Oct 2017 15:41:18 +0200
Message-Id: <1508247680-98800-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] s390x: cpu cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

series includes remaining in my queue non cpu_model refactoring
patches that fix and cleanup cpu_init code

CC: Richard Henderson <rth@twiddle.net>
CC: Alexander Graf <agraf@suse.de>
CC: Cornelia Huck <cohuck@redhat.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>


Igor Mammedov (2):
  s390x: fix cpu object referrence leak in s390x_new_cpu()
  s390x: move s390x_new_cpu() into board code

 target/s390x/cpu.h         |  1 -
 hw/s390x/s390-virtio-ccw.c | 21 +++++++++++++++++++++
 target/s390x/helper.c      | 20 --------------------
 3 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.7.4
