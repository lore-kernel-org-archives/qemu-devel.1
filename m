Received: from eggs.gnu.org ([2001:4830:134:3::10]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHs2A-0007mg-VC
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eHs26-0001WE-KH
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:59:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eHs26-0001V3-FH
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:59:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D8B87F7C2
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 13:59:13 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu, 23 Nov 2017 21:59:04 +0800
Message-Id: <20171123135906.12852-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] docs: Add documentation for image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com

Image locking feature was added in 2.10 but the documentation has been missing.
Users sometimes get confused and wonder how to configure it for their specific
needs. We should address common use cases in the man page and explain related
options.

Fam Zheng (2):
  docs: Add image locking subsection
  qemu-options: Mention locking option of file driver

 docs/qemu-block-drivers.texi | 36 ++++++++++++++++++++++++++++++++++++
 qemu-doc.texi                |  1 +
 qemu-options.hx              |  3 +++
 3 files changed, 40 insertions(+)

-- 
2.14.3
