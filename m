Received: from eggs.gnu.org ([2001:4830:134:3::10]:43045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1faGHW-0007fm-3t
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1faGHP-0003hz-GN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:03:26 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Tue,  3 Jul 2018 09:03:02 +0100
Message-Id: <20180703080303.17355-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v6] crypto: Implement TLS Pre-Shared Keys (PSK).
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

v5 was here:

https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08491.html
https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg00077.html

v6:

 - Make ECDHE-PSK dependent on GnuTLS >= 3.

 - Retested against nbdkit.

 - Retested with internal unit tests.

Rich.
