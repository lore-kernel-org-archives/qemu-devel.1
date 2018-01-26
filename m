Received: from eggs.gnu.org ([2001:4830:134:3::10]:54795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ef0Mz-0000tP-VE
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ef0Mw-0002xG-RT
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:32:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ef0Mw-0002ww-MD
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:32:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DB4C3D0075
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 09:13:42 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 26 Jan 2018 10:13:31 +0100
Message-Id: <20180126091338.13708-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Input 20180126 patches
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

The following changes since commit 2077fef91d5eb8e3745a84fabd87a5ee7d2b53=
5d:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80125' into staging (2018-01-25 17:04:47 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/input-20180126-pull-request

for you to fetch changes up to d0b610a55b81bdc485c877ef0466895fd40e8d6f:

  hw: convert virtio-input-hid device to keycodemapdb (2018-01-26 07:15:0=
7 +0100)

----------------------------------------------------------------
input: switch devices to keycodemapdb, bugfixes.

----------------------------------------------------------------

Daniel P. Berrange (4):
  hw: convert ps2 device to keycodemapdb
  hw: convert the escc device to keycodemapdb
  ui: fix alphabetical ordering of keymaps
  hw: convert virtio-input-hid device to keycodemapdb

Miika S (2):
  input: add mouse side buttons to virtio input
  input: virtio: don't send mouse wheel event twice

Prasad J Pandit (1):
  ps2: check PS2Queue pointers in post_load routine

 Makefile                    |   6 +-
 include/ui/input.h          |  18 +-
 hw/char/escc.c              | 126 +------------
 hw/input/ps2.c              | 427 ++------------------------------------=
------
 hw/input/virtio-input-hid.c | 144 ++-------------
 ui/input-keymap.c           |   6 +-
 6 files changed, 61 insertions(+), 666 deletions(-)

--=20
2.9.3
