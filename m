Received: from eggs.gnu.org ([2001:4830:134:3::10]:36593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfmNr-0000pG-He
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cfmNo-0006Pa-Bk
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cfmNo-0006P0-5s
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:43:56 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F18F3D94D
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 11:43:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Feb 2017 12:43:49 +0100
Message-Id: <1487591031-28991-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] input patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Here is the input patch queue, fixing a ps/2 bug and finally merging the
wctablet (2016 gsoc project).

please pull,
  Gerd

The following changes since commit ad584d37f2a86b392c25f3f00cc1f1532676c2d1:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-02-16 17:46:52 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-input-20170220-1

for you to fetch changes up to 378af96155d62d90c876ee5e7648803247f1d864:

  Add wctablet device (2017-02-20 11:26:28 +0100)

----------------------------------------------------------------
input: add wctablet, ps2 fix

----------------------------------------------------------------
Anatoli Huseu1 (1):
      Add wctablet device

Fabian Lesniak (1):
      ps2: fix mouse mappings for right/middle button

 Makefile.objs            |   1 +
 backends/Makefile.objs   |   2 +-
 backends/trace-events    |  10 ++
 backends/wctablet.c      | 369 +++++++++++++++++++++++++++++++++++++++++++++++
 chardev/char.c           |   1 +
 docs/qdev-device-use.txt |   2 +-
 include/hw/input/ps2.h   |   4 +-
 qapi-schema.json         |   3 +-
 8 files changed, 387 insertions(+), 5 deletions(-)
 create mode 100644 backends/trace-events
 create mode 100644 backends/wctablet.c
