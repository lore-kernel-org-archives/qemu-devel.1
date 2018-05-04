Received: from eggs.gnu.org ([2001:4830:134:3::10]:41693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEVMR-0001dr-K9
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEVMM-0007q4-Lp
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fEVMM-0007l9-Hu
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  4 May 2018 15:42:03 +0800
Message-Id: <20180504074207.22634-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/4] slirp: Add query-usernet QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, berrange@redhat.com, Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

v6: Rename QAPI enum: TCPS -> UsernetTcpState. [Daniel]

v5: Fix QAPI example in comments. [Eric]
v4: vlan -> hub. [Samuel]
    Free 'info. [Samuel]

v3: - Add Eric's rev-by to patch 2.
    - Address Eric's comments on patch 1:
      * Fix spell/grammar: "programmed", "awaiting".
      * Fix include "qapi/qapi-commands-net.h".
      * Underscores to dashes.
      * "Since 2.13" now.

v2: Fix compiler error. [patchew]

The command is a counterpart of HMP "info usernet" and is at least very useful
for the VM tests. So add it.

Fam Zheng (4):
  qapi: Introduce UsernetTcpState
  slirp: Use QAPI enum to replace TCPS_* macros
  slirp: Add "query-usernet" QMP command
  tests: Use query-usernet instead of 'info usernet'

 net/slirp.c        |  26 +++++++
 qapi/net.json      | 214 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/libslirp.h   |   2 +
 slirp/misc.c       | 159 ++++++++++++++++++++++++++++-----------
 slirp/tcp.h        |  21 +-----
 slirp/tcp_input.c  | 103 +++++++++++++-------------
 slirp/tcp_subr.c   |  25 ++++---
 slirp/tcp_timer.c  |   7 +-
 tests/vm/basevm.py |  14 ++--
 9 files changed, 435 insertions(+), 136 deletions(-)

-- 
2.14.3
