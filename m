Received: from eggs.gnu.org ([2001:4830:134:3::10]:47857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYbwA-0004Il-A4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYbw9-00016z-K4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:46:34 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu, 28 Jun 2018 19:46:23 +0100
Message-Id: <20180628184624.5867-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v5] crypto: Implement TLS Pre-Shared Keys (PSK).
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

v4 was here:

https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08464.html

v5:

 - Checks that username is not used when endpoint=server.
   (Note it is optional when endpoint=client, defaulting to "qemu")

Rich.
