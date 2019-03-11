Received: from eggs.gnu.org ([209.51.188.92]:36905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3EI2-0003rE-4H
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3E7L-0005MV-1N
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:08:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h3E7K-0005Lp-Oy
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:08:54 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon, 11 Mar 2019 14:08:21 +0800
Message-Id: <20190311060823.18360-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] cleanup select_machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

Here is two simple change related to select_machine()

[1]: make find_default_machine() local since no one outside file use it
[2]: allocate TYPE_MACHINE list only once to select machine type

Wei Yang (2):
  vl.c: make find_default_machine() local
  vl.c: allocate TYPE_MACHINE list once during bootup

 include/hw/boards.h |  1 -
 vl.c                | 24 +++++++++++-------------
 2 files changed, 11 insertions(+), 14 deletions(-)

-- 
2.19.1
