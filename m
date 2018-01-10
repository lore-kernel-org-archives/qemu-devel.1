Received: from eggs.gnu.org ([2001:4830:134:3::10]:33935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZMws-0001J2-KF
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZMwo-0001FW-0Q
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eZMwn-0001Ef-Qw
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 10 Jan 2018 20:25:50 +0000
Message-Id: <20180110202553.31889-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] tracetool: improve error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This series improves the tracetool error messages to make them more
user-friendly.

Stefan Hajnoczi (3):
  tracetool: prefix parse errors with line numbers
  tracetool: clarify that "formats" means "format strings"
  tracetool: report error on foo() instead of foo(void)

 scripts/tracetool/__init__.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.14.3
