Received: from eggs.gnu.org ([208.118.235.92]:39467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gcLfF-0004S8-Pu
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gcLfC-00049G-Ig
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:44:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:35523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gcLfC-0003lu-58
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:44:46 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Thu, 27 Dec 2018 10:43:02 +0800
Message-Id: <20181227024304.12182-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH 0/2] Add MSR based features on Cascadelake CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, tao3.xu@intel.com, robert.hu@linux.intel.com, mark.kanda@oracle.com

These patches update the stepping and add some MSR based features 
enumerated by ARCH_CAPABILITIES on Cascadelake-Server CPU model.

Tao Xu (2):
  i386: Update stepping of Cascadelake-Server
  i386: Add some MSR based features on Cascadelake-Server CPU model

 include/hw/i386/pc.h | 20 ++++++++++++++++++++
 target/i386/cpu.c    |  8 ++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.17.1
