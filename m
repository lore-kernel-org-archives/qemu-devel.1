Received: from eggs.gnu.org ([2001:4830:134:3::10]:46250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQwDI-0007bd-Ho
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQwDF-0001ut-S1
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:16 -0500
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:49506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eQwDF-0001tz-Ju
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:13 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id C35DBADA40
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 15:16:11 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 18 Dec 2017 15:16:09 +0100
Message-ID: <151360656934.21833.11316709584569537205.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/2] fsdev: improve error handling of backend
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

This series simply converts the parse_opts and init fsdev operations to
report errors using the QEMU Error API. Some error messages get reworded
on the way.

Note that we only care for the local and proxy backends. The synth backend
doesn't generate errors and the handle backend shall probably be deprecated
soon.

--
Greg

---

Greg Kurz (2):
      fsdev: improve error handling of backend opts parsing
      fsdev: improve error handling of backend init


 fsdev/file-op-9p.h  |    4 ++--
 fsdev/qemu-fsdev.c  |    4 +++-
 hw/9pfs/9p-handle.c |    5 +++--
 hw/9pfs/9p-local.c  |   37 ++++++++++++++++++++++---------------
 hw/9pfs/9p-proxy.c  |   31 +++++++++++++++++++++----------
 hw/9pfs/9p-synth.c  |    2 +-
 hw/9pfs/9p.c        |    6 +++---
 7 files changed, 55 insertions(+), 34 deletions(-)
