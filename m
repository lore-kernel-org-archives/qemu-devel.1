Received: from eggs.gnu.org ([2001:4830:134:3::10]:38922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZutU-0006WE-HI
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZutO-00012L-UT
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:45:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZutN-0000wq-J2
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:45:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D35E8796E2
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 09:45:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A019868D27
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 09:45:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 20 Dec 2018 10:45:14 +0100
Message-Id: <20181220094514.3904-3-armbru@redhat.com>
In-Reply-To: <20181220094514.3904-1-armbru@redhat.com>
References: <20181220094514.3904-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] build: Remake config-host.mak when VERSION
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

configure gets the version number from VERSION, and writes it to
config-host.mak.  The make dependency for that is missing.  Because of
that, a rebuild after a VERSION change may not pick up the change.
Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181214084754.23854-1-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c8b9efdad4..038780c6d0 100644
--- a/Makefile
+++ b/Makefile
@@ -67,7 +67,7 @@ CONFIG_ALL=y
 -include config-all-devices.mak
 -include config-all-disas.mak
 
-config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios
+config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
 	@echo $@ is out-of-date, running configure
 	@# TODO: The next lines include code which supports a smooth
 	@# transition from old configurations without config.status.
-- 
2.17.2
