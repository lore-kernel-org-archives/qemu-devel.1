Received: from eggs.gnu.org ([2001:4830:134:3::10]:54352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdBpR-0004vZ-EQ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdBpN-0004bC-1b
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cdBpM-0004ZJ-RO
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:17:40 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 183654D69C
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 08:17:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Feb 2017 09:17:25 +0100
Message-Id: <1486973851-21645-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] vga patch queue
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

Here comes the vga patch queue, bringing bugfixes
for cirrus and virtio-gpu.

please pull,
  Gerd

The following changes since commit 33d076ebd05491d9f7cace682b4ed70c33263f=
12:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-10022017=
-1' into staging (2017-02-10 15:05:37 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-vga-20170213-1

for you to fetch changes up to 12e97ec39931e5321645fd483ab761319d48bf16:

  Revert "cirrus: allow zero source pitch in pattern fill rops" (2017-02-=
10 16:49:45 +0100)

----------------------------------------------------------------
vga: bugfixes for cirrus and virtio-gpu

----------------------------------------------------------------
Gerd Hoffmann (5):
      virtio-gpu: fix resource leak in virgl_cmd_resource_unref
      vga: replace debug printf with trace points
      cirrus: replace debug printf with trace points
      cirrus: fix patterncopy checks
      Revert "cirrus: allow zero source pitch in pattern fill rops"

Li Qiang (1):
      virtio-gpu: fix memory leak in set scanout

 hw/display/cirrus_vga.c    | 71 +++++++++++++++++++++++++++-------------=
------
 hw/display/trace-events    | 12 ++++++++
 hw/display/vga.c           | 27 +++---------------
 hw/display/virtio-gpu-3d.c |  8 ++++++
 hw/display/virtio-gpu.c    |  1 +
 5 files changed, 67 insertions(+), 52 deletions(-)
