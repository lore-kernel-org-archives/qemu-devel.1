Received: from eggs.gnu.org ([2001:4830:134:3::10]:47883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1gJvdf-0000g2-3t
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1gJvdb-0007Ay-U4
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:19:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:41913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1gJvdb-00070M-Jh
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:18:59 -0500
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Tue,  6 Nov 2018 15:13:25 +0800
Message-Id: <1541488407-17045-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/2] x86/cpu: Enable direct stores cpu
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Cc: qemu-devel@nongnu.org, tao3.xu@intel.com, Liu Jingqi <jingqi.liu@intel.com>

Enable direct stores cpu features including MOVDIRI and MOVDIR64B.

MOVDIRI moves doubleword or quadword from register to memory through
direct store.
MOVDIR64B moves 64-bytes as direct-store with 64-bytes write atomicity.

Changelog:
v2:
	Separated from the series http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg02330.html
	since umonitor/umwait/tpause cpu features are not ready yet.
v1:
	Sent out with umonitor/umwait/tpause cpu features.

Liu Jingqi (2):
  x86/cpu: Enable MOVDIRI cpu feature
  x86/cpu: Enable MOVDIR64B cpu feature

 target/i386/cpu.c | 4 ++--
 target/i386/cpu.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4
