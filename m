Received: from eggs.gnu.org ([209.51.188.92]:55084)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ao2@ao2.it>)
	id 1hMTXu-0000yf-RZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ao2@ao2.it>) id 1hMTXt-0006vg-Lo
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:54 -0400
Received: from mail.ao2.it ([2001:4b98:dc0:41:216:3eff:fe7c:639b]:39645
	helo=ao2.it)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ao2@ao2.it>) id 1hMTXt-0006tx-BM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:53 -0400
From: Antonio Ospite <ao2@ao2.it>
Date: Fri,  3 May 2019 10:27:26 +0200
Message-Id: <20190503082728.16485-1-ao2@ao2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] configure: disallow spaces and colons
 in source path and build path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Antonio Ospite <antonio.ospite@collabora.com>, Antonio Ospite <ao2@ao2.it>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>

Hi,

Here is a v2 patch set to address
https://bugs.launchpad.net/qemu/+bug/1817345

The series follows up to:
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg05290.html
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg05573.html

Changes since v1:
  - Add a preparatory patch to set source_path only once and in a more
    robust way.

  - Move the checks in configure after the source_path definition to
    avoid using realpath which is not available everywhere.

  - Cover also the build path in Makefile. An extensive explanation of
    why I think this is needed is here:
    https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg05398.html

Thanks,
   Antonio

Antonio Ospite (2):
  configure: set source_path only once and make its definition more
    robust
  configure: disallow spaces and colons in source path and build path

 Makefile  |  4 ++++
 configure | 12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
