Received: from eggs.gnu.org ([2001:4830:134:3::10]:38391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB5-0007md-Qg
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB2-00014U-M2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:03 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:51045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB2-00013d-CF
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:00 -0400
Received: by mail-wm0-x236.google.com with SMTP id e16-v6so10988311wmd.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:56 +0200
Message-Id: <1530216310-52873-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 46/60] doc: another fix to "info pic"
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

Something that commit 254316fa1f ("intc: make HMP 'info irq' and 'info
pic' commands available on all targets", 2016-10-04) forgot to touch up.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171229073104.3810-2-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands-info.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 59bdd8f..a482b6e 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -201,7 +201,7 @@ ETEXI
 STEXI
 @item info pic
 @findex info pic
-Show i8259 (PIC) state.
+Show PIC state.
 ETEXI
 
     {
-- 
1.8.3.1
