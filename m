Received: from eggs.gnu.org ([2001:4830:134:3::10]:59490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eI9kH-0005bc-CK
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eI9kE-0001ZQ-SO
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:54:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eI9kE-0001Yg-Nj
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:53:58 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Nov 2017 16:53:49 +0800
Message-Id: <20171124085351.26386-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] docs: Add documentation for image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Philipp Hahn <hahn@univention.de>, famz@redhat.com, mreitz@redhat.com

v2: Grammar and spelling fixes pointed out by Kevin and Philipp.

Image locking feature was added in 2.10 but the documentation has been missing.
Users sometimes get confused and wonder how to configure it for their specific
needs. We should address common use cases in the man page and explain related
options.

Fam Zheng (2):
  docs: Add image locking subsection
  qemu-options: Mention locking option of file driver

 docs/qemu-block-drivers.texi | 36 ++++++++++++++++++++++++++++++++++++
 qemu-doc.texi                |  1 +
 qemu-options.hx              |  4 ++++
 3 files changed, 41 insertions(+)

-- 
2.14.3
