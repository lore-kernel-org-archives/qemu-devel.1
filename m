Received: from eggs.gnu.org ([2001:4830:134:3::10]:35818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0iUm-0007pK-Ho
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 03:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0iUi-0000Ir-CK
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 03:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1g0iUi-0000H7-4O
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 03:26:24 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 14 Sep 2018 15:26:14 +0800
Message-Id: <20180914072616.17771-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] slirp: Add support for RFC2132 TFTP
 server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

Post separatedly from the OpenBSD series for some more focus since the rest are
already queued.

Fam Zheng (2):
  slirp: Add sanity check for str option length
  slirp: Implement RFC2132 TFTP server name

 net/slirp.c      | 21 +++++++++++++++++++--
 qapi/net.json    |  5 ++++-
 qemu-options.hx  |  7 ++++++-
 slirp/bootp.c    | 45 +++++++++++++++++++++++++++++++++++----------
 slirp/bootp.h    |  1 +
 slirp/libslirp.h |  1 +
 slirp/slirp.c    |  2 ++
 slirp/slirp.h    |  1 +
 8 files changed, 69 insertions(+), 14 deletions(-)

-- 
2.17.1
