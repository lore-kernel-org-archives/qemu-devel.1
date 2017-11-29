Received: from eggs.gnu.org ([2001:4830:134:3::10]:42406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJreN-0000Bw-Nb
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJreK-0005wC-MI
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJreK-0005vF-G3
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:58:56 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 09:58:51 +0800
Message-Id: <20171129015851.16429-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH qemu-web] Suggest qemu-web prefix in the
 introductory post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yu.ning@linux.intel.com, pbonzini@redhat.com

Chances are qemu-devel@nongnu.org patches only adding new files can be
picked up by patchew and treated like a qemu.git patch. Patchew already
ignores [qemu-web] patches, so suggest it in this article as well. (Are
there better places to document this?)

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 _posts/2017-02-04-the-new-qemu-website-is-up.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/_posts/2017-02-04-the-new-qemu-website-is-up.md b/_posts/2017-02-04-the-new-qemu-website-is-up.md
index 66d3181..c16053c 100644
--- a/_posts/2017-02-04-the-new-qemu-website-is-up.md
+++ b/_posts/2017-02-04-the-new-qemu-website-is-up.md
@@ -19,7 +19,8 @@ and the source code for the website can be cloned from the
 repository.  Just like for any other project hosted by QEMU, the best way
 to propose or contribute a new change is by sending a patch through the
 [qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-devel)
-mailing list.
+mailing list. (Add `[qemu-web PATCH]` to the subject so that CI will not be
+confused with qemu.git patches.)
 
 For example, if you would like to add a new screenshot to the homepage,
 you can clone the `qemu-web.git` repository, add a PNG file to the
-- 
2.14.3
