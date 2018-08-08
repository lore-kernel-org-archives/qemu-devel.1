Received: from eggs.gnu.org ([2001:4830:134:3::10]:48309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxG-0000ZW-Lp
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxC-00083O-J9
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnMxC-00082u-DB
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E69E640241C3
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 11:48:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  8 Aug 2018 13:48:09 +0200
Message-Id: <20180808114830.7169-2-quintela@redhat.com>
In-Reply-To: <20180808114830.7169-1-quintela@redhat.com>
References: <20180808114830.7169-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/22] configure: We don't want to clean
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
index 2da686be33..5059e53eb3 100644
--- a/Makefile
+++ b/Makefile
@@ -751,7 +751,7 @@ clean:
 	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
 	rm -f $$d/qemu-options.def; \
         done
-	rm -f $(SUBDIR_DEVICES_MAK) config-all-devices.mak
+	rm -f config-all-devices.mak
 
 VERSION ?= $(shell cat VERSION)
 
@@ -763,6 +763,7 @@ qemu-%.tar.bz2:
 distclean: clean
 	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f config-all-devices.mak config-all-disas.mak config.status
+	rm -f $(SUBDIR_DEVICES_MAK)
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
-- 
2.17.1
