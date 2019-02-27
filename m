Received: from eggs.gnu.org ([209.51.188.92]:37905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz1y5-0001qY-I6
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz1xv-0002Nk-QA
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:21:53 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 27 Feb 2019 16:20:35 +0000
Message-Id: <20190227162035.18543-4-berrange@redhat.com>
In-Reply-To: <20190227162035.18543-1-berrange@redhat.com>
References: <20190227162035.18543-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 3/3] nbd: fix outdated qapi docs syntax for
 tls-creds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qapi/block.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/block.json b/qapi/block.json
index 79623088e7..145c268bb6 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -224,7 +224,7 @@
 # QEMU instance could refer to them as "nbd:HOST:PORT:exportname=3DNAME"=
.
 #
 # @addr: Address on which to listen.
-# @tls-creds: (optional) ID of the TLS credentials object. Since 2.6
+# @tls-creds: ID of the TLS credentials object (since 2.6).
 # @tls-authz: ID of the QAuthZ authorization object used to validate
 #             the client's x509 distinguished name. This object is
 #             is only resolved at time of use, so can be deleted and
--=20
2.20.1
