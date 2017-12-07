Received: from eggs.gnu.org ([2001:4830:134:3::10]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eN0VN-0000dS-J8
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eN0VK-0007fm-QS
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:02:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eN0VK-0007eQ-Kv
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:02:38 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Dec 2017 19:02:33 +0100
Message-Id: <1512669755-8409-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 0/2] Remove deprecated net parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

These parameters have been marked as deprecated since QEMU v2.6.0.
And since QEMU 2.10, we've documented the policy that deprecated
interfaces can be removed after two public releases in case nobody
came up with real good reasons to keep them. As far as I know,
nobody complained, so it's time to remove these legacy options now.

Thomas Huth (2):
  net: Remove the legacy "-net channel" parameter
  net: Remove the deprecated -tftp, -bootp, -redir and -smb options

 include/net/net.h   |  3 --
 include/net/slirp.h |  6 ----
 net/net.c           |  7 ----
 net/slirp.c         | 92 -----------------------------------------------------
 os-posix.c          |  8 -----
 qemu-doc.texi       | 29 -----------------
 qemu-options.hx     | 15 ---------
 vl.c                | 18 -----------
 8 files changed, 178 deletions(-)

-- 
1.8.3.1
