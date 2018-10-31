Received: from eggs.gnu.org ([2001:4830:134:3::10]:50509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHmlN-0003hy-HZ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHmlA-0005q8-JS
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:26:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gHmlA-0005JJ-62
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:25:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 31 Oct 2018 08:43:07 +0000
Message-Id: <20181031084309.9227-3-stefanha@redhat.com>
In-Reply-To: <20181031084309.9227-1-stefanha@redhat.com>
References: <20181031084309.9227-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] get_maintainer: use 'https://' instead of
 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 43fb5f512f..fc7275b9e2 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1376,7 +1376,7 @@ sub vcs_exists {
 	warn("$P: No supported VCS found.  Add --nogit to options?\n");
 	warn("Using a git repository produces better results.\n");
 	warn("Try latest git repository using:\n");
-	warn("git clone git://git.qemu.org/qemu.git\n");
+	warn("git clone https//git.qemu.org/git/qemu.git\n");
 	$printed_novcs = 1;
     }
     return 0;
-- 
2.17.2
