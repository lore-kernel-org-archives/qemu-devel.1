Received: from eggs.gnu.org ([2001:4830:134:3::10]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJl-00033s-OT
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8pJk-0005B4-Iw
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d8pJk-0005A2-DH
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57825448D6F
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 14:43:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 11 May 2017 16:43:35 +0200
Message-Id: <20170511144339.13027-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] make display updates thread safe, batch #2
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

Here is the vga patch queue, with the second patch batch to make display
updates thread-safe.

please pull,
  Gerd

The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:

  Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-vga-20170511-1

for you to fetch changes up to bfc56535f793c557aa754c50213fc5f882e6482d:

  vga: fix display update region calculation (2017-05-11 09:50:32 +0200)

----------------------------------------------------------------
make display updates thread safe, batch #2

----------------------------------------------------------------
Gerd Hoffmann (2):
      sm501: make display updates thread safe
      vga: fix display update region calculation

Mark Cave-Ayland (2):
      cg3: make display updates thread safe
      tcx: make display updates thread safe

 hw/display/cg3.c   | 41 ++++++++++++++++----------------
 hw/display/sm501.c | 27 ++++++----------------
 hw/display/tcx.c   | 68 +++++++++++++++++++-----------------------------=
------
 hw/display/vga.c   |  2 +-
 4 files changed, 53 insertions(+), 85 deletions(-)
