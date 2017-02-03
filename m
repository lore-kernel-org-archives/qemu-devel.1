Received: from eggs.gnu.org ([2001:4830:134:3::10]:50248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY8d-0006jE-0m
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY8Z-00075d-OJ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cZY8Z-00075L-IK
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:18:27 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  3 Feb 2017 15:18:15 +0800
Message-Id: <1486106298-3699-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] kvm/ioapic: some tiny tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>

This series fixes the issue pointed out by PMM in thread:

  https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg06323.html

Along with other two patches to make the version more accurate. Thanks,

Peter Xu (3):
  kvm/ioapic: dump real object instead of a fake one
  ioapic: fix error report value of def version
  kvm/ioapic: correct kvm ioapic version

 hw/i386/kvm/ioapic.c | 13 +++++++++----
 hw/intc/ioapic.c     |  6 ++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.7.4
