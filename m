Received: from eggs.gnu.org ([209.51.188.92]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY3-0003cW-1q
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY2-0004Nn-9L
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:41:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:33225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hCIY2-0004Lx-0H
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:41:58 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Fri,  5 Apr 2019 14:41:17 +0800
Message-Id: <20190405064121.23662-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] cleanup select_machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, armbru@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

Here is two simple change related to select_machine()

[1]: make find_default_machine() local since no one outside file use it
[2]: allocate TYPE_MACHINE list only once to select machine type
[3]: cleanup after previous commit
[4]: Simplify machine_parse()

---
v2:
  * adjust changelog in [1]
  * Markus provides [3-4]

Markus Armbruster (2):
  vl: Clean up after previous commit
  vl: Simplify machine_parse()

Wei Yang (2):
  vl.c: make find_default_machine() local
  vl.c: allocate TYPE_MACHINE list once during bootup

 include/hw/boards.h |  1 -
 vl.c                | 69 ++++++++++++++++++---------------------------
 2 files changed, 28 insertions(+), 42 deletions(-)

-- 
2.19.1
