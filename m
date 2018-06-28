Received: from eggs.gnu.org ([2001:4830:134:3::10]:54166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYWsX-0002iv-Lk
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYWsW-0001Yi-Vr
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:22:29 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu, 28 Jun 2018 14:22:10 +0100
Message-Id: <20180628132211.8795-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v3] crypto: Implement TLS Pre-Shared Keys (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

v2 was here:

  https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg07404.html

v2 -> v3:

 - Offer ECDHE-PSK key exchange algorithm too.

 - Added a regression test to tests/test-crypto-tlssession.c

Rich.
