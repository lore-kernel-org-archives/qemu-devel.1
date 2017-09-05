Received: from eggs.gnu.org ([2001:4830:134:3::10]:46346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dpABp-0008SN-3u
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dpABk-0007uY-Fo
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:30:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dpABk-0007su-4a
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:30:32 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Tue, 5 Sep 2017 17:30:03 +0800
Message-ID: <1504603805-180240-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] Support over 64 vcpus for windows guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, vrozenfe@redhat.com, weidong.huang@huawei.com, Gonglei <arei.gonglei@huawei.com>

Pls see the detail of patches.

Gonglei (2):
  pc: add 2.11 machine type
  i386/cpu/hyperv: support over 64 vcpus for windows guests

 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 include/hw/i386/pc.h |  8 ++++++++
 target/i386/cpu.c    |  1 +
 target/i386/cpu.h    |  2 ++
 target/i386/kvm.c    | 18 +++++++++++++++++-
 6 files changed, 51 insertions(+), 6 deletions(-)

-- 
1.8.3.1
