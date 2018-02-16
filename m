Received: from eggs.gnu.org ([2001:4830:134:3::10]:58057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1emj9i-0008LG-Hu
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1emj9h-0006mt-Fc
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:46:38 -0500
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:44353
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1emj9h-0006cO-An
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:46:37 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 1908E9843A
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:46:23 -0500 (EST)
Received: from humpty.home.comstyle.com (unknown
	[IPv6:2001:470:c454:100:30be:948d:d233:387b])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 5FF5898439
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:46:22 -0500 (EST)
Date: Fri, 16 Feb 2018 11:46:20 -0500
From: Brad Smith <brad@comstyle.com>
Message-ID: <20180216164620.GA53727@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] maintainers: Add myself as a OpenBSD maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add myself as an OpenBSD maintainer and add OpenBSD as maintained.

Signed-off-by: Brad Smith <brad@comstyle.com>


diff --git a/MAINTAINERS b/MAINTAINERS
index 57358a08e2..86329e274f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -386,6 +386,12 @@ M: Kamil Rytarowski <kamil@netbsd.org>
 S: Maintained
 K: ^Subject:.*(?i)NetBSD
 
+OPENBSD
+L: qemu-devel@nongnu.org
+M: Brad Smith <brad@comstyle.com>
+S: Maintained
+K: ^Subject:.*(?i)OpenBSD
+
 W32, W64
 L: qemu-devel@nongnu.org
 M: Stefan Weil <sw@weilnetz.de>
diff --git a/configure b/configure
index 913e14839d..850c46ebac 100755
--- a/configure
+++ b/configure
@@ -760,6 +760,7 @@ OpenBSD)
   audio_drv_list="sdl"
   audio_possible_drivers="sdl"
   HOST_VARIANT_DIR="openbsd"
+  supported_os="yes"
 ;;
 Darwin)
   bsd="yes"
