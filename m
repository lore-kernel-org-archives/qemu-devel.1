Received: from eggs.gnu.org ([2001:4830:134:3::10]:60549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gUd8d-0001xm-RT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 14:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gUd8c-00089K-TW
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 14:47:15 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:39088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gUd8c-000894-Ov
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 14:47:14 -0500
Received: by mail-qk1-x743.google.com with SMTP id q70so12621937qkh.6
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 11:47:14 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed,  5 Dec 2018 17:46:58 -0200
Message-Id: <20181205194701.17836-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 0/3] wakeup-from-suspend and system_wakeup
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, mst@redhat.com, imammedo@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

changes in v11:
- fixed typos, changed version to 4.0 in patches 1 and 3
- changed text in patch 2 to be less alarming
- patch 3: changed error handling
- previous version link:
http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg01774.html


Daniel Henrique Barboza (3):
  qmp: query-current-machine with wakeup-suspend-support
  qga: update guest-suspend-ram and guest-suspend-hybrid descriptions
  qmp hmp: Make system_wakeup check wake-up support and run state

 hmp.c                   |  5 ++++-
 hw/acpi/core.c          |  9 ++++++++-
 hw/char/serial.c        |  2 +-
 hw/i386/xen/xen-hvm.c   |  5 +++++
 hw/input/ps2.c          |  6 +++---
 hw/timer/mc146818rtc.c  |  2 +-
 include/sysemu/sysemu.h |  4 +++-
 migration/migration.c   |  4 ++--
 qapi/misc.json          | 32 +++++++++++++++++++++++++++++++-
 qga/qapi-schema.json    | 16 ++++++++++------
 qmp.c                   |  8 +++++++-
 vl.c                    | 23 ++++++++++++++++++++++-
 12 files changed, 97 insertions(+), 19 deletions(-)

-- 
2.19.2
