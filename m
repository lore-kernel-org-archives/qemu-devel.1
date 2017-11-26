Received: from eggs.gnu.org ([2001:4830:134:3::10]:48805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eJ4Fm-0005yF-O0
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eJ4Fi-0001bj-8W
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:14:18 -0500
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:22335
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1eJ4Fi-0001Xq-21
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:14:14 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id DD09F9843A
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 16:13:58 -0500 (EST)
Received: from humpty.home.comstyle.com (unknown
	[IPv6:2607:fea8:12c0:f00:90cf:984e:6c25:8021])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested) (Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id A6E0F98439
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 16:13:58 -0500 (EST)
Date: Sun, 26 Nov 2017 16:13:57 -0500
From: Brad Smith <brad@comstyle.com>
Message-ID: <20171126211356.GA46174@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] configure: Fix curses probe for older ncurses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix the curses probe with older ncurses (.e.g. 5.7, as used by OpenBSD).

ncurses 5.7 requires _XOPEN_SOURCE_EXTENDED to be defined for WACS_* constants.

Signed-off-by: Brad Smith <brad@comstyle.com>


diff --git a/configure b/configure
index 0c6e7572db..9715b9c2cc 100755
--- a/configure
+++ b/configure
@@ -3186,7 +3186,7 @@ EOF
   IFS=:
   for curses_inc in $curses_inc_list; do
     # Make sure we get the wide character prototypes
-    curses_inc="-DNCURSES_WIDECHAR $curses_inc"
+    curses_inc="-DNCURSES_WIDECHAR -D_XOPEN_SOURCE_EXTENDED $curses_inc"
     IFS=:
     for curses_lib in $curses_lib_list; do
       unset IFS
