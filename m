Received: from eggs.gnu.org ([2001:4830:134:3::10]:60052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fEN9r-0001L0-Az
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fEN9q-0005sm-F3
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:57:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu,  3 May 2018 18:56:43 -0400
Message-Id: <20180503225648.13153-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] qemu-img: make subcommand usage docstrings
 consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>

I'm working on a project to attempt to autogenerate all of this, but
until then let's just do a bit of the usual kinds of tidying.

________________________________________________________________________________

For convenience, this branch is available at:
https://github.com/jnsnow/qemu.git branch trivial-qemu-img
https://github.com/jnsnow/qemu/tree/trivial-qemu-img

This version is tagged trivial-qemu-img-v1:
https://github.com/jnsnow/qemu/releases/tag/trivial-qemu-img-v1

John Snow (5):
  qemu-img-commands.hx: argument ordering fixups
  qemu-img.texi: fix command ordering
  qemu-img: remove references to GEN_DOCS
  qemu-img: Make documentation between .texi and .hx consistent
  qemu-img-cmds.hx: add passive-aggressive note

 qemu-img-cmds.hx       | 13 +++++----
 qemu-img.c             |  2 --
 qemu-img.texi          | 78 ++++++++++++++++++++++++++------------------------
 qemu-options-wrapper.h |  1 -
 4 files changed, 48 insertions(+), 46 deletions(-)

-- 
2.14.3
