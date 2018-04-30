Received: from eggs.gnu.org ([2001:4830:134:3::10]:52624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD8Cu-00047f-5G
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD8Cp-0001Sd-9v
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:47:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fD8Cp-0001S0-3P
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:46:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 30 Apr 2018 13:46:46 +0100
Message-Id: <20180430124651.10340-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] checkpatch: backport UTF-8 fixes and
 MAINTAINERS check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>

v2:
 * Resolve missing CHK() [Thomas]
 * Drop first argument to WARN() to match QEMU function arguments

This series cherry picks checkpatch UTF-8 fixes and the MAINTAINERS file check
from Linux.  Thomas Huth original did the backport in January 2017 but the
series was forgotten (<1485436265-12573-1-git-send-email-thuth@redhat.com>).  I
did the cherry pick again from scratch.

The MAINTAINERS file check prints a warning when new files are added without a
modification to ./MAINTAINERS.  It is easy to forget to update ./MAINTAINERS
and this check should help us stay on top of new source files.

Joe Perches (4):
  checkpatch: add a --strict check for utf-8 in commit logs
  checkpatch: ignore email headers better
  checkpatch: emit a warning on file add/move/delete
  checkpatch: reduce MAINTAINERS update message frequency

Pasi Savanainen (1):
  checkpatch: check utf-8 content from a commit log when it's missing
    from charset

 scripts/checkpatch.pl | 56 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

-- 
2.14.3
