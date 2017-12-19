Received: from eggs.gnu.org ([2001:4830:134:3::10]:36623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRJpH-0001cq-TL
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRJpE-0007jz-Ca
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:29:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eRJpE-0007jV-5t
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:29:00 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Dec 2017 16:28:53 +0100
Message-Id: <1513697336-2863-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] net: Remove "-net channel" and update
 "-net nic" docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, peter.maydell@linaro.org

Remove the deprecated (and even undocumented) "-net channel" parameter,
and update our docs with regards to the possibility to use "netdev=..."
together with the "-net nic" option for embedded NICs.

Thomas Huth (3):
  net: Remove the legacy "-net channel" parameter
  qemu-doc: The "-net nic" option can be used with "netdev=...", too
  qemu-doc: Update the deprecation information of -tftp, -bootp, -redir
    and -smb

 include/net/slirp.h |  2 --
 net/net.c           |  7 -------
 net/slirp.c         | 34 ----------------------------------
 qemu-doc.texi       | 38 +++++++++++++++++++++-----------------
 qemu-options.hx     | 14 ++++++++------
 5 files changed, 29 insertions(+), 66 deletions(-)

-- 
1.8.3.1
