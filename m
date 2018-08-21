Received: from eggs.gnu.org ([2001:4830:134:3::10]:33452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4Y-0001vi-30
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4V-0006lj-6i
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4U-0006fU-2T
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id j26-v6so647338wre.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:20 +0200
Message-Id: <1534870966-9287-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 48/74] qemu-guest-agent: freeze-hook to ignore
 dpkg files as well
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

From: Christian Ehrhardt <christian.ehrhardt@canonical.com>

The hook already skips a set of rpm upgrade artifacts.
Do the same with such files that might be created by dpkg.

Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1484990

Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Message-Id: <1513160272-15921-1-git-send-email-christian.ehrhardt@canonical.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
