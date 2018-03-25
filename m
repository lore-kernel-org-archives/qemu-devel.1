Received: from eggs.gnu.org ([2001:4830:134:3::10]:35501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1f0AwL-0002J3-8s
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 15:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1f0AwI-0002n5-1i
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 15:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1f0AwH-0002mf-Sz
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 15:04:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75C42804EB
	for <qemu-devel@nongnu.org>; Sun, 25 Mar 2018 19:04:20 +0000 (UTC)
From: Cole Robinson <crobinso@redhat.com>
Date: Sun, 25 Mar 2018 15:03:28 -0400
Message-Id: <489fd750574cf761c1f083eaa7d2306e41035004.1522004432.git.crobinso@redhat.com>
Subject: [Qemu-devel] [PATCH sgabios] Makefile: Add HOSTCC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 970b0ff..c8cb92b 100644
--- a/Makefile
+++ b/Makefile
@@ -30,6 +30,7 @@ ASFLAGS += -DBUILD_USER="$(BUILD_USER)"
 LDSCRIPT := rom16.ld
 LDFLAGS := -T $(LDSCRIPT) -nostdlib
 OBJCOPY := objcopy
+HOSTCC := $(CC)
 
 ASRCS = sgabios.S
 
@@ -55,7 +56,7 @@ sgabios.elf: .depend $(OBJS) $(LDSCRIPT) csum8
 	$(LD) $(LDFLAGS) $(OBJS) -o $@
 
 csum8: csum8.c
-	$(CC) -Wall -O2 -o $@ $<
+	$(HOSTCC) -Wall -O2 -o $@ $<
 
 sgabios.o: buildinfo
 
-- 
2.16.2
