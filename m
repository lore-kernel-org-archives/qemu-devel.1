Received: from eggs.gnu.org ([2001:4830:134:3::10]:57858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshm-0005SZ-1a
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshh-0002qh-SL
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:38 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshh-0002ps-LR
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:33 -0400
Received: by mail-wm0-x243.google.com with SMTP id s206so16178239wme.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:19 +0100
Message-Id: <20180313224719.4954-10-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/69] checkpatch: Exempt long URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Sometimes, we want to refer to really long URLs, but checkpatch
balks, and we have to manually bypass the check.  URL shorteners
may be nice at reducing long links, but it's hard to guarantee the
shortened link will live as long as the real target, and it is
also nice to see the original target without having to load the
shortened URL through a browser.  So exempt a line containing
only a URL from the long-line syntax check.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180222215838.18223-1-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d1fe79bcc4..57daae05ea 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1447,9 +1447,10 @@ sub process {
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /$SrcFile/);
 
-#90 column limit
+#90 column limit; exempt URLs, if no other words on line
 		if ($line =~ /^\+/ &&
 		    !($line =~ /^\+\s*"[^"]*"\s*(?:\s*|,|\)\s*;)\s*$/) &&
+		    !($rawline =~ /^[^[:alnum:]]*https?:\S*$/) &&
 		    $length > 80)
 		{
 			if ($length > 90) {
-- 
2.14.3
