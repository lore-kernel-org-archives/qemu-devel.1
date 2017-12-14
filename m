Received: from eggs.gnu.org ([2001:4830:134:3::10]:36328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePSw5-00055e-1G
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePSw0-0006EL-Hd
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:48:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePSw0-0006Cm-BJ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:48:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DC3F883AC
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 12:48:19 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-117-51.ams2.redhat.com
	[10.36.117.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B49A560C9F
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 12:48:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Dec 2017 12:48:15 +0000
Message-Id: <20171214124817.2567-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:

  Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20171214

for you to fetch changes up to 0eaf3b824745cacebfc321aef6787528d33d58fe:

  tests: test-hmp: print command execution result (2017-12-14 11:09:42 +0000)

----------------------------------------------------------------
HMP pull 2017-12-14

----------------------------------------------------------------
Thomas Huth (1):
      hmp-commands: Remove the deprecated usb_add and usb_del

Vadim Galitsyn (1):
      tests: test-hmp: print command execution result

 hmp-commands.hx         | 33 ---------------------------------
 hw/usb/bus.c            | 22 ----------------------
 include/hw/usb.h        |  1 -
 include/sysemu/sysemu.h |  2 --
 qemu-doc.texi           |  8 --------
 tests/test-hmp.c        |  7 +++++--
 vl.c                    | 44 --------------------------------------------
 7 files changed, 5 insertions(+), 112 deletions(-)
