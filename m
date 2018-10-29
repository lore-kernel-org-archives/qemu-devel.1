Received: from eggs.gnu.org ([2001:4830:134:3::10]:40231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gH373-0001oR-R4
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 04:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gH36q-0003ga-Pc
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 04:41:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:29505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gH36n-0003bj-9S
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 04:41:13 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Mon, 29 Oct 2018 16:39:52 +0800
Message-Id: <cover.1540801392.git.tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/1] Add PKU on Skylake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com
Cc: pbonzini@redhat.com, rth@twiddle.net, jingqi.liu@intel.com, robert.hu@intel.com, qemu-devel@nongnu.org, Tao Xu <tao3.xu@intel.com>

This patch adds PKU on Skylake-Server CPU model.

Changelog:
v2
	Remove OSPKE which is not needed. Add 
	Skylake-Server-*-cpu.pku=off entries on
	PC_COMPAT_3_0 to keep PKU disabled on 
	pc-*-3.0 and older.

Tao Xu (1):
  i386: Add PKU on Skylake-Server CPU model

 include/hw/i386/pc.h | 10 +++++++++-
 target/i386/cpu.c    |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.17.1
