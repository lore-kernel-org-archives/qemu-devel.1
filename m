Received: from eggs.gnu.org ([2001:4830:134:3::10]:33319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1eP49b-0003OM-GI
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1eP49W-0000eW-Qo
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:20:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1eP49W-0000dX-Ks
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:20:38 -0500
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 13 Dec 2017 11:17:52 +0100
Message-Id: <1513160272-15921-1-git-send-email-christian.ehrhardt@canonical.com>
Subject: [Qemu-devel] [PATCH] qemu-guest-agent: freeze-hook to ignore dpkg
 files as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>

The hook already skips a set of rpm upgrade artifacts.
Do the same with such files that might be created by dpkg.

Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1484990

Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
---
 scripts/qemu-guest-agent/fsfreeze-hook | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index c27b29f..13aafd4 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -13,7 +13,7 @@ FSFREEZE_D=$(dirname -- "$0")/fsfreeze-hook.d
 # Check whether file $1 is a backup or rpm-generated file and should be ignored
 is_ignored_file() {
     case "$1" in
-        *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave | *.sample)
+        *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave | *.sample | *.dpkg-old | *.dpkg-new | *.dpkg-tmp | *.dpkg-dist | *.dpkg-bak | *.dpkg-backup | *.dpkg-remove)
             return 0 ;;
     esac
     return 1
-- 
2.7.4
