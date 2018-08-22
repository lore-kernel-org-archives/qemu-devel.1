Received: from eggs.gnu.org ([2001:4830:134:3::10]:33885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqV-0007YJ-V9
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqS-0004mY-J8
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsPqS-0004lZ-DT
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8466B4023476
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:54:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 11:54:12 +0200
Message-Id: <20180822095421.11765-2-quintela@redhat.com>
In-Reply-To: <20180822095421.11765-1-quintela@redhat.com>
References: <20180822095421.11765-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/10] configure: We don't want to clean
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
removing it on clean target.  Remove it instead on distclean.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Remove it instead on distclean.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b7c6e57de6..fe623e4634 100644
--- a/Makefile
+++ b/Makefile
@@ -752,7 +752,7 @@ clean:
 	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
 	rm -f $$d/qemu-options.def; \
         done
-	rm -f $(SUBDIR_DEVICES_MAK) config-all-devices.mak
+	rm -f config-all-devices.mak
 
 VERSION ?= $(shell cat VERSION)
 
@@ -764,6 +764,7 @@ qemu-%.tar.bz2:
 distclean: clean
 	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f config-all-devices.mak config-all-disas.mak config.status
+	rm -f $(SUBDIR_DEVICES_MAK)
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
-- 
2.17.1
