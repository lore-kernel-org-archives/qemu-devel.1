Received: from eggs.gnu.org ([2001:4830:134:3::10]:60450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJtXr-000184-BC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJtXo-0001Vj-5p
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:00:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJtXn-0001Uz-Vt
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:00:20 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 12:00:13 +0800
Message-Id: <20171129040013.11804-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH qemu-web v2] Suggest qemu-web prefix in the
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
Cc: yu.ning@linux.intel.com, pbonzini@redhat.com, eblake@redhat.com

Chances are qemu-devel@nongnu.org patches only adding new files can be
picked up by patchew and treated like a qemu.git patch. Patchew already
ignores [qemu-web] patches, so suggest it in this article as well. (Are
there better places to document this?)

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 _posts/2017-02-04-the-new-qemu-website-is-up.md | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/_posts/2017-02-04-the-new-qemu-website-is-up.md b/_posts/2017-02-04-the-new-qemu-website-is-up.md
index 66d3181..1758436 100644
--- a/_posts/2017-02-04-the-new-qemu-website-is-up.md
+++ b/_posts/2017-02-04-the-new-qemu-website-is-up.md
@@ -19,7 +19,9 @@ and the source code for the website can be cloned from the
 repository.  Just like for any other project hosted by QEMU, the best way
 to propose or contribute a new change is by sending a patch through the
 [qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-devel)
-mailing list.
+mailing list. (Add `[qemu-web PATCH]` to the subject so that CI will not be
+confused with qemu.git patches. You can run `git config format.subjectprefix
+'qemu-web PATCH'`, so that `git-send-email` command will do it for you.)
 
 For example, if you would like to add a new screenshot to the homepage,
 you can clone the `qemu-web.git` repository, add a PNG file to the
-- 
2.14.3
