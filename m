Received: from eggs.gnu.org ([2001:4830:134:3::10]:35882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1erfyu-0008Bn-Hw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1erfyq-0003rr-Jl
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:23:56 -0500
Received: from smtp55.i.mail.ru ([217.69.128.35]:54002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1erfyq-0003oq-3n
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 03:23:52 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Fri,  2 Mar 2018 11:22:45 +0300
Message-Id: <1519978965-16865-1-git-send-email-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] checkpatch: add a warning for basename/dirname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Julia Suvorova <jusual@mail.ru>

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b4b812..6c4fb42 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2584,6 +2584,11 @@ sub process {
 			ERROR("__func__ should be used instead of gcc specific __FUNCTION__\n"  . $herecurr);
 		}
 
+# recommend g_path_get_* over basename(3) and dirname(3)
+		if ($line =~ /\b(basename|dirname)\s*\(/) {
+			WARN("consider using g_path_get_$1 in preference to $1(3)\n" . $herecurr);
+		}
+
 # recommend qemu_strto* over strto* for numeric conversions
 		if ($line =~ /\b(strto[^kd].*?)\s*\(/) {
 			ERROR("consider using qemu_$1 in preference to $1\n" . $herecurr);
-- 
2.1.4
