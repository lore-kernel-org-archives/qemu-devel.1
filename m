Received: from eggs.gnu.org ([2001:4830:134:3::10]:60361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7jl-00016Z-UR
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH7jk-0004cH-2O
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:37:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 14:37:18 +0100
Message-Id: <20181029133722.12415-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Audio 20181029 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 285278ca785f5fa9a570927e1c0958a2ca2b21=
50:

  Merge remote-tracking branch 'remotes/famz/tags/testing-pull-request' i=
nto staging (2018-10-27 19:55:08 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20181029-pull-request

for you to fetch changes up to d436d4e7a50a7c4fddc0569c2107fe5eaf0e1fbc:

  audio: use TYPE_MV88W8618_AUDIO instead of hardcoded string (2018-10-29=
 13:50:15 +0100)

----------------------------------------------------------------
audio: qom cleanups.

----------------------------------------------------------------

Li Qiang (1):
  hw: AC97: make it more QOMconventional

Mao Zhongyi (3):
  audio: use TYPE_WM8750 instead of a hardcoded string
  audio: use object link instead of qdev property to pass wm8750
    reference
  audio: use TYPE_MV88W8618_AUDIO instead of hardcoded string

 include/hw/audio/wm8750.h  |  1 +
 hw/arm/musicpal.c          |  5 +++--
 hw/audio/ac97.c            | 12 ++++++++----
 hw/audio/marvell_88w8618.c | 14 ++++++--------
 4 files changed, 18 insertions(+), 14 deletions(-)

--=20
2.9.3
