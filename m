Received: from eggs.gnu.org ([2001:4830:134:3::10]:35646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHoo2-0004q2-OD
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHonw-0004MY-H0
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gHonw-0004Lr-89
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:36:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E05730832C9
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 11:36:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 31 Oct 2018 11:36:50 +0000
Message-Id: <20181031113651.32430-2-berrange@redhat.com>
In-Reply-To: <20181031113651.32430-1-berrange@redhat.com>
References: <20181031113651.32430-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] block: drop moderated sheepdog mailing list
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

The sheepdog mailing list is setup to stop and queue messages from
non-subscribers, pending moderator approval. Unfortunately it seems
that the moderation queue is not actively deadlt with. Even when messages
are approved, the sender is never added to the whitelist, so every
future mail the same sender continues to get stopped for moderation.

MAINTAINERS entries should be responsive and not uneccessarily block
mails from QEMU contributors, so drop the sheepdog mailing list.

Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d794bd7a66..39f00d058b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2028,7 +2028,6 @@ Sheepdog
 M: Liu Yuan <namei.unix@gmail.com>
 M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
-L: sheepdog@lists.wpkg.org
 S: Supported
 F: block/sheepdog.c
 T: git git://github.com/codyprime/qemu-kvm-jtc.git block
--=20
2.19.1
