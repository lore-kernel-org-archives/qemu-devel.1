Received: from eggs.gnu.org ([2001:4830:134:3::10]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gLAfE-0002M9-LG
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gLAfD-0007Ow-9Q
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:33:48 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gLAfB-0006g7-7C
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:33:46 -0500
Received: by mail-qk1-x742.google.com with SMTP id o125so2935532qkf.3
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 09:33:24 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Fri,  9 Nov 2018 15:33:06 -0200
Message-Id: <20181109173309.25212-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.2 v10 0/3] wakeup-from-suspend and
 system_wakeup changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, ehabkost@redhat.com, armbru@redhat.com, mst@redhat.com, imammedo@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

Changes in v10:
- added qemu_register_wakeup_support call in hw/i386/xen/xen-hvm.c
- explained the effects of not checking the query-current-machine
before issuing guest-suspend-ram/hybrid in QGA documentation
- changed qemu_system_wakeup_request to allow the runstate check
error to be propagated to callers
- previous series link:
https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02171.html


Daniel Henrique Barboza (3):
  qmp: query-current-machine with wakeup-suspend-support
  qga: update guest-suspend-ram and guest-suspend-hybrid descriptions
  qmp hmp: Make system_wakeup check wake-up support and run state

 hmp.c                   |  5 ++++-
 hw/acpi/core.c          | 10 +++++++++-
 hw/char/serial.c        |  3 ++-
 hw/i386/xen/xen-hvm.c   |  5 +++++
 hw/input/ps2.c          |  9 ++++++---
 hw/timer/mc146818rtc.c  |  3 ++-
 include/sysemu/sysemu.h |  4 +++-
 migration/migration.c   |  7 +++++--
 qapi/misc.json          | 32 +++++++++++++++++++++++++++++++-
 qga/qapi-schema.json    | 16 ++++++++++------
 qmp.c                   | 13 ++++++++++++-
 vl.c                    | 23 ++++++++++++++++++++++-
 12 files changed, 111 insertions(+), 19 deletions(-)

-- 
2.19.1
