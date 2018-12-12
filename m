Received: from eggs.gnu.org ([2001:4830:134:3::10]:52146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MW-0000lG-Bw
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MU-0000C0-De
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:48 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MS-0008JB-GF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id a18so6412214wmj.1
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:24 +0100
Message-Id: <1544628195-37728-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/54] checkpatch: fix premature exit when no
 input or --mailback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In some cases, checkpatch's process subroutine is exiting the
whole process.  This is wrong, just return from the subroutine
instead.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 60f6f89..b9974f0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2820,19 +2820,19 @@ sub process {
 	# If we have no input at all, then there is nothing to report on
 	# so just keep quiet.
 	if ($#rawlines == -1) {
-		exit(0);
+		return 1;
 	}
 
 	# In mailback mode only produce a report in the negative, for
 	# things that appear to be patches.
 	if ($mailback && ($clean == 1 || !$is_patch)) {
-		exit(0);
+		return 1;
 	}
 
 	# This is not a patch, and we are are in 'no-patch' mode so
 	# just keep quiet.
 	if (!$chk_patch && !$is_patch) {
-		exit(0);
+		return 1;
 	}
 
 	if (!$is_patch) {
-- 
1.8.3.1
