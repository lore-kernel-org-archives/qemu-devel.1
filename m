Received: from eggs.gnu.org ([2001:4830:134:3::10]:33346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEVtE-0003H1-06
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEVt9-0008C0-3E
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:48:43 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:41226)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEVt8-00084J-97
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:48:38 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 22 Oct 2018 16:48:22 +0800
Message-Id: <20181022084824.555-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Modern shell scripting (use $() instead
 of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, philmd@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, sw@weilnetz.de, famz@redhat.com, eblake@redhat.com

Various shell files contain a mix between obsolete `` and
modern $(); It would be nice to convert to using $()
everywhere.

On https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02920.html

I just replaced `` in scripts dir,  so this series is a 
thorough cleanup of all obsolete `` in the source tree. 

v3:
-removed the patch1 from this series.  [Eric Blake]

v2:
-doubling "$" avoid it "escape" in a Makefile.  [Thomas Huth]

Cc: philmd@redhat.com
Cc: peter.maydell@linaro.org
Cc: thuth@redhat.com
Cc: sw@weilnetz.de
Cc: famz@redhat.com
Cc: eblake@redhat.com

Mao Zhongyi (2):
  debian-bootstrap.pre: Modern shell scripting (use $() instead of ``)
  po/Makefile: Modern shell scripting (use $() instead of ``)

 po/Makefile                                   | 2 +-
 tests/docker/dockerfiles/debian-bootstrap.pre | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1
