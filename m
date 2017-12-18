Received: from eggs.gnu.org ([2001:4830:134:3::10]:47767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQvsf-0007p4-Ch
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQvsc-00057W-5M
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:54:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eQvsb-00056p-V6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:54:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1105D21BA3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:54:53 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 13:54:16 +0000
Message-Id: <20171218135417.28301-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/1] Enable full IPv4/IPv6 dual stack
 support in chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Previously posted as part of a larger series:

  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02064.html

The common code has merged, so this is just the patch that needs to go via the
chardev maintainer's tree.

With this change, the chardev socket server honours multiple IP addresses
returned by getaddrinfo instead of only binding on the first. This makes dual
stack work fully, and also improves support with multi-homed hosts.

No changes in v1, except for rebasing.

Daniel P. Berrange (1):
  chardev: convert the socket server to QIONetListener

 chardev/char-socket.c | 72 +++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

-- 
2.14.3
