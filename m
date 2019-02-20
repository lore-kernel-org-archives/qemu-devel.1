Received: from eggs.gnu.org ([209.51.188.92]:37191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwQUt-0007N1-0v
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwQUp-0002hK-9T
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:57:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gwQUp-0001OU-2r
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:57:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 922F23DE10
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 11:56:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Feb 2019 12:56:09 +0100
Message-Id: <20190220115611.3192-7-quintela@redhat.com>
In-Reply-To: <20190220115611.3192-1-quintela@redhat.com>
References: <20190220115611.3192-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/8] multifd: Change default packet size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

We moved from 64KB to 512KB, as it makes less locking contention
without any downside in testing.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 75a8fc21f8..d57db00ce4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -521,7 +521,7 @@ exit:
 #define MULTIFD_FLAG_SYNC (1 << 0)
=20
 /* This value needs to be a multiple of qemu_target_page_size() */
-#define MULTIFD_PACKET_SIZE (64 * 1024)
+#define MULTIFD_PACKET_SIZE (512 * 1024)
=20
 typedef struct {
     uint32_t magic;
--=20
2.20.1
