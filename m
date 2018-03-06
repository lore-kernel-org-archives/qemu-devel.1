Received: from eggs.gnu.org ([2001:4830:134:3::10]:48233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVe-0005IY-2X
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVd-0006Tx-6U
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:02 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVd-0006TH-0B
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:01 -0500
Received: by mail-wm0-x244.google.com with SMTP id a20so17994662wmd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:18 +0100
Message-Id: <1520342370-123606-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/34] checkpatch: add a warning for
 basename/dirname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Julia Suvorova <jusual@mail.ru>

From: Julia Suvorova <jusual@mail.ru>

g_path_get_* do the same as g_strdup(basename/dirname(...)) but
without modifying the argument.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Message-Id: <1519987399-19160-1-git-send-email-jusual@mail.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b4b812..a88af61 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2584,6 +2584,11 @@ sub process {
 			ERROR("__func__ should be used instead of gcc specific __FUNCTION__\n"  . $herecurr);
 		}
 
+# recommend g_path_get_* over g_strdup(basename/dirname(...))
+		if ($line =~ /\bg_strdup\s*\(\s*(basename|dirname)\s*\(/) {
+			WARN("consider using g_path_get_$1() in preference to g_strdup($1())\n" . $herecurr);
+		}
+
 # recommend qemu_strto* over strto* for numeric conversions
 		if ($line =~ /\b(strto[^kd].*?)\s*\(/) {
 			ERROR("consider using qemu_$1 in preference to $1\n" . $herecurr);
-- 
1.8.3.1
