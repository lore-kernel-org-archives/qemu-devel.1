Received: from eggs.gnu.org ([2001:4830:134:3::10]:46295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7obM-0001dE-7f
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 17:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7obL-000101-Bd
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 17:22:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 Oct 2018 16:22:09 -0500
Message-Id: <20181003212211.812374-4-eblake@redhat.com>
In-Reply-To: <20181003212211.812374-1-eblake@redhat.com>
References: <20181003212211.812374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] qemu-nbd: Document --tls-creds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Commit 145614a1 introduced --tls-creds and documented it in
qemu-nbd.texi, but forgot to document it in 'qemu-nbd --help'.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181003180426.602765-1-eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 qemu-nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 51b9d38c727..66e023f7fa4 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -94,6 +94,7 @@ static void usage(const char *name)
 "General purpose options:\n"
 "  --object type,id=ID,...   define an object such as 'secret' for providing\n"
 "                            passwords and/or encryption keys\n"
+"  --tls-creds=ID            use id of an earlier --object to provide TLS\n"
 "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
 "                            specify tracing options\n"
 "  --fork                    fork off the server process and exit the parent\n"
-- 
2.17.1
