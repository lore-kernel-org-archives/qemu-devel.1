Received: from eggs.gnu.org ([2001:4830:134:3::10]:49702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fbAYK-0004CI-IB
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fbAYJ-0002WU-K1
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:08:32 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:43839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fbAYJ-0002Ts-Ez
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:08:31 -0400
Received: by mail-qt0-x241.google.com with SMTP id f18-v6so8185688qtp.10
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:08:31 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu,  5 Jul 2018 17:08:10 -0300
Message-Id: <20180705200813.2033-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v8 0/3] wakeup-from-suspend and system_wakeup
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
Cc: ehabkost@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb413@gmail.com>

changes in v8:
- created 'query-current-machine' API to hold the wakeup-suspend-support
  flag
- wake-up flag now considers the --no-acpi config option for PC archs
- fixes in patch 3 proposed by Markus.
Previous series link:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04234.html

Daniel Henrique Barboza (3):
  qmp: query-current-machine with wakeup-suspend-support
  qga: update guest-suspend-ram and guest-suspend-hybrid descriptions
  qmp hmp: Make system_wakeup check wake-up support and run state

 hmp.c                   |  5 ++++-
 include/sysemu/sysemu.h |  1 +
 qapi/misc.json          | 29 ++++++++++++++++++++++++++++-
 qga/qapi-schema.json    | 12 ++++++------
 qmp.c                   | 11 ++++++++++-
 vl.c                    | 30 ++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 9 deletions(-)

-- 
2.17.1
