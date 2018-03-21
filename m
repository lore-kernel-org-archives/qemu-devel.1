Received: from eggs.gnu.org ([2001:4830:134:3::10]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyfiB-0007Lk-Ml
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyfiA-0007pa-RJ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:31:35 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 21 Mar 2018 15:31:24 +0000
Message-Id: <20180321153124.5357-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] block: drop moderated sheepdog mailing list
 from MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The sheepdog mailing list is setup to stop and queue messages from
non-subscribers, pending moderator approval. Unfortunately it seems
that the moderation queue is not actively dealt with. Even when messages
are approved, the sender is never added to the whitelist, so every
future mail the same sender continues to get stopped for moderation.

MAINTAINERS entries should be responsive and not uneccessarily block
mails from QEMU contributors, so drop the sheepdog mailing list.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 354a18ce49..7eea869dcd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1871,7 +1871,6 @@ M: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
 M: Liu Yuan <namei.unix@gmail.com>
 M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
-L: sheepdog@lists.wpkg.org
 S: Supported
 F: block/sheepdog.c
 T: git git://github.com/codyprime/qemu-kvm-jtc.git block
--=20
2.14.3
