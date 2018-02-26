Received: from eggs.gnu.org ([2001:4830:134:3::10]:36116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqDga-0000vN-5V
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqDgV-0002TP-B7
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:59:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eqDgV-0002TJ-6H
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 02:58:55 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon, 26 Feb 2018 15:58:44 +0800
Message-Id: <20180226075846.20307-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] slirp: Add query-usernet QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

v2: Fix compiler error. [patchew]

The command is a counterpart of HMP "info usernet" and is at least very useful
for the VM tests. So add it.

Fam Zheng (2):
  slirp: Add "query-usernet" QMP command
  tests: Use query-usernet instead of 'info usernet'

 net/slirp.c        |  26 +++++++
 qapi/net.json      | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/libslirp.h   |   1 +
 slirp/misc.c       | 156 +++++++++++++++++++++++++++++------------
 slirp/tcp.h        |  15 ----
 tests/vm/basevm.py |  14 ++--
 6 files changed, 346 insertions(+), 67 deletions(-)

-- 
2.14.3
