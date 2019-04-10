Received: from eggs.gnu.org ([209.51.188.92]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yP-0007Om-Gw
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yO-0001sC-H1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  9 Apr 2019 21:24:10 -0400
Message-Id: <20190410012413.31569-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/3] qemu-img: remove command documentation
 duplication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>

This might hopefully cut down on the doc duplication/mismatching
until I can devise something more comprehensive.

Ideally, I'd like to redo all of the documentation for qemu-img
nearly from scratch; with a parser generator that helps generate
the documentation as well so they'll never get out of date.

That's probably quite a ways off, and maybe there are other
structural changes we want to make with respect to sphinx and
other build tools, so I am sending something very minimal instead.

This ought to be functionally identical down to the last char.

(I've re-included patch one which I have sent to the list separately,
purely as a dependency if you want to apply these patches.)

John Snow (3):
  qemu-img: fix .hx and .texi disparity
  pxtool: Add new qemu-img command info generation tool
  qemu-img.texi: use macros for command summaries

 qemu-img.texi      |  28 ++++----
 Makefile           |   8 +--
 qemu-img-cmds.json | 165 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-img-cmds.hx   | 102 ----------------------------
 scripts/pxtool.py  |  53 +++++++++++++++
 5 files changed, 236 insertions(+), 120 deletions(-)
 create mode 100644 qemu-img-cmds.json
 delete mode 100644 qemu-img-cmds.hx
 create mode 100755 scripts/pxtool.py

-- 
2.17.2
