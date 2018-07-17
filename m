Received: from eggs.gnu.org ([2001:4830:134:3::10]:45223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFF-0006zV-87
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFA-0003QG-CZ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOFA-0003Pl-8X
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9F16401EF05
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:38 +0200
Message-Id: <20180717113402.5510-2-quintela@redhat.com>
In-Reply-To: <20180717113402.5510-1-quintela@redhat.com>
References: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 01/25] configure: We don't want to clean
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

If you don't want to compile everything, you configure
config-devices.mak.  And then make clean remove it, and make will
create a default one without your configuration.  Fix it by not
removing it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2da686be33..2ffbcde323 100644
--- a/Makefile
+++ b/Makefile
@@ -751,7 +751,7 @@ clean:
 	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
 	rm -f $$d/qemu-options.def; \
         done
-	rm -f $(SUBDIR_DEVICES_MAK) config-all-devices.mak
+	rm -f config-all-devices.mak
 
 VERSION ?= $(shell cat VERSION)
 
-- 
2.17.1
