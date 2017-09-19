Received: from eggs.gnu.org ([2001:4830:134:3::10]:60486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfn-0004cW-Rc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfi-0005l6-Bl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:43 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfi-0005kJ-51
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:38 -0400
Received: by mail-wm0-x244.google.com with SMTP id m127so3758048wmm.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:36 +0200
Message-Id: <1505824179-21541-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 47/50] checkpatch: add hwaddr to @typeList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

The script doesn't know about all possible types and learn them as
it parses the code. If it reaches a line with a type cast but the
type isn't known yet, it is misinterpreted as an identifier.

For example the following line:

    foo = (hwaddr) -1;

results in the following false-positive to be reported:

ERROR: spaces required around that '-' (ctx:VxV)

Let's add this standard QEMU type to the list of pre-known types.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <150538015789.8149.10902725348939486674.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 28d71b3..3c0a28e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -263,6 +263,7 @@ our @typeList = (
 	qr{${Ident}_handler},
 	qr{${Ident}_handler_fn},
 	qr{target_(?:u)?long},
+	qr{hwaddr},
 );
 
 # This can be modified by sub possible.  Since it can be empty, be careful
-- 
1.8.3.1
