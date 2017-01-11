Received: from eggs.gnu.org ([2001:4830:134:3::10]:44148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFI4-0004bc-NV
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFHz-0006Fg-W7
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRFHz-0006F4-PY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:51 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE25E81240
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 09:33:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 10:33:42 +0100
Message-Id: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] audio patch queue
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

Here comes the audio patch queue, with some fixes and cleanups.

please pull,
  Gerd

The following changes since commit b44486dfb9447c88e4b216e730adcc78019085=
2c:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170110-1' i=
nto staging (2017-01-10 14:52:34 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-audio-20170111-1

for you to fetch changes up to 11f547e58a08ea71a8a92d3ffe1e210b4b0b709c:

  es1370: wire up reset via DeviceClass (2017-01-11 09:19:03 +0100)

----------------------------------------------------------------
audio: qomify drivers, hotplug fixes.

----------------------------------------------------------------
Gerd Hoffmann (1):
      es1370: wire up reset via DeviceClass

Li Qiang (2):
      audio: es1370: add exit function
      audio: ac97: add exit function

xiaoqiang zhao (2):
      hw/audio: QOM'ify marvell_88w8618.c
      hw/audio: QOM'ify pl041.c

 hw/audio/ac97.c            | 11 +++++++++++
 hw/audio/es1370.c          | 20 +++++++++++++++++---
 hw/audio/marvell_88w8618.c | 18 +++++++++++-------
 hw/audio/pl041.c           | 25 ++++++++++++++-----------
 4 files changed, 53 insertions(+), 21 deletions(-)
