Received: from eggs.gnu.org ([2001:4830:134:3::10]:43306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEUqL-00075j-Ay
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 03:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEUq9-0004on-J2
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 03:41:35 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:50649)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEUq4-0004gk-Tc
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 03:41:26 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 22 Oct 2018 15:40:47 +0800
Message-Id: <20181022074050.19638-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/3] use object link instead of qdev property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

According to qdev-properties.h, properties of pointer type
should be avoid, so convert qdev property to link, Whilst we
are here, also update some hardcoded strings with already
defineded macros.

v4:
-fixed the "Broken pipe" error when "make check"

v3:
-removed incorrected "To: xxx" tags from commit message
-keep 'dc->user_creatable = false' in mv88w8618_audio_class_init()

v2:
-removed the patch1
-removed the TYPE_name in VMStateDescription.name

Cc: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>

Mao Zhongyi (3):
  audio: use TYPE_WM8750 instead of a hardcoded string
  audio: use object link instead of qdev property to pass wm8750
    reference
  audio: use TYPE_MV88W8618_AUDIO instead of hardcoded string

 hw/arm/musicpal.c          |  5 +++--
 hw/audio/marvell_88w8618.c | 14 ++++++--------
 include/hw/audio/wm8750.h  |  1 +
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.17.1
