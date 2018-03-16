Received: from eggs.gnu.org ([2001:4830:134:3::10]:33337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewir7-0005cv-Rq
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewir7-0007to-6a
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:28:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ewir7-0007tU-2r
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:28:45 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 16 Mar 2018 14:28:20 +0800
Message-Id: <20180316062822.15425-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v3 0/2] slirp: Add query-usernet QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

v3: - Add Eric's rev-by to patch 2.
    - Address Eric's comments on patch 1:
      * Fix spell/grammar: "programmed", "awaiting".
      * Fix include "qapi/qapi-commands-net.h".
      * Underscores to dashes.
      * "Since 2.13" now.

v2: Fix compiler error. [patchew]

The command is a counterpart of HMP "info usernet" and is at least very useful
for the VM tests. So add it.

Fam Zheng (2):
  slirp: Add "query-usernet" QMP command
  tests: Use query-usernet instead of 'info usernet'

 net/slirp.c        |  26 +++++++
 qapi/net.json      | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/libslirp.h   |   2 +
 slirp/misc.c       | 156 +++++++++++++++++++++++++++++------------
 slirp/tcp.h        |  15 ----
 tests/vm/basevm.py |  14 ++--
 6 files changed, 347 insertions(+), 67 deletions(-)

-- 
2.14.3
