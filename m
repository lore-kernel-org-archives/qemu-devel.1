Received: from eggs.gnu.org ([2001:4830:134:3::10]:33724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cboLq-0008RO-Rb
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cboLp-00021G-In
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cboLp-000218-DH
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:29 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 851863A7696
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 13:01:29 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Feb 2017 14:01:07 +0100
Message-Id: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 00/10] vnc: add support for multiple listening
 sockets.
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

Here comes the UI patch queue, carrying only vnc updates this time.  Big
chunk is the multiple sockets support patch series, but there are also
some smaller fixes and cleanups.

please pull,
  Gerd

The following changes since commit d0dff238a87fa81393ed72754d4dc8b09e50b08b:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170206' into staging (2017-02-07 15:29:26 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-ui-20170209-1

for you to fetch changes up to 7448e761356799d4e445e6ea3891a8067233465d:

  ui: add ability to specify multiple VNC listen addresses (2017-02-08 14:59:40 +0100)

----------------------------------------------------------------
vnc: add support for multiple listening sockets.
vnc: misc fixes and cleanups.

----------------------------------------------------------------
Daniel P. Berrange (8):
      ui: fix regression handling bare 'websocket' option to -vnc
      ui: fix reporting of VNC auth in query-vnc-servers
      ui: refactor VncDisplay to allow multiple listening sockets
      ui: refactor code for populating SocketAddress from vnc_display_open
      ui: extract code to connect/listen from vnc_display_open
      ui: let VNC server listen on all resolved IP addresses
      util: add iterators for QemuOpts values
      ui: add ability to specify multiple VNC listen addresses

Michael Tokarev (1):
      vnc: do not disconnect on EAGAIN

Peter Maydell (1):
      ui/vnc: Drop unused vnc_has_job() and vnc_jobs_clear()

 include/qemu/option.h |   9 +
 qapi-schema.json      |  28 ++-
 qemu-options.hx       |  12 +-
 ui/vnc-jobs.c         |  23 --
 ui/vnc-jobs.h         |   2 -
 ui/vnc.c              | 658 +++++++++++++++++++++++++++++++++++---------------
 ui/vnc.h              |  10 +-
 util/qemu-option.c    |  19 ++
 8 files changed, 533 insertions(+), 228 deletions(-)
