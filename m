Received: from eggs.gnu.org ([209.51.188.92]:45425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guCjN-0000W1-7r
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guCjF-0002aa-3G
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:50:48 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Thu, 14 Feb 2019 16:49:36 +0800
Message-Id: <20190214084939.20640-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [Patch v4 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, laurent@vivier.eu, imammedo@redhat.com, philmd@redhat.com, thuth@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

There are several functions/variable which are not used anymore.

This serials just remove those without functional change.

v4: fix reviewed-by tags
v3: add ack and repost in a new thread
v2: change commit log from "is now used in no place" to "in not used anymore"

Wei Yang (3):
  hw/i386/pc.c: remove unused function pc_acpi_init()
  hw/acpi: remove unused function acpi_table_add_builtin()
  hw/acpi: remove unnecessary variable acpi_table_builtin

 hw/acpi/core.c         | 10 +---------
 hw/i386/pc.c           | 27 ---------------------------
 include/hw/acpi/acpi.h |  1 -
 include/hw/i386/pc.h   |  1 -
 4 files changed, 1 insertion(+), 38 deletions(-)

-- 
2.19.1
