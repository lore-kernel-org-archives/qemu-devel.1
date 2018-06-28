Received: from eggs.gnu.org ([2001:4830:134:3::10]:37945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAb-0007C9-1i
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAX-0000Lr-Jr
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:30 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAX-0000KF-7h
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:29 -0400
Received: by mail-wm0-x22c.google.com with SMTP id 69-v6so10225700wmf.3
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:24 +0200
Message-Id: <1530216310-52873-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/60] configure: enable debug-mutex if debug
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180425025459.5258-5-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 3f53aa7..ca7de4f 100755
--- a/configure
+++ b/configure
@@ -1042,6 +1042,7 @@ for opt do
   --enable-debug)
       # Enable debugging options that aren't excessively noisy
       debug_tcg="yes"
+      debug_mutex="yes"
       debug="yes"
       strip_opt="no"
       fortify_source="no"
-- 
1.8.3.1
