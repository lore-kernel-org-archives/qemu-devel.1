Received: from eggs.gnu.org ([2001:4830:134:3::10]:54728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAsq9-00047w-2E
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAsq5-0008KE-L1
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:30:32 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:38192)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAsq3-0008Fw-PL
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:30:28 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 12 Oct 2018 16:30:05 +0800
Message-Id: <20181012083008.29027-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v2 0/3] use object link instead of qdev property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

According to qdev-properties.h, properties of pointer type
should be avoid, so convert qdev property to link, Whilst we
are here, also update some hardcoded strings with already
defineded macros.

v2:
-removed the patch1
-removed the TYPE_name in VMStateDescription.name

Cc: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

Mao Zhongyi (3):
  audio: use TYPE_WM8750 instead of a hardcoded string
  audio: use object link instead of qdev property to pass wm8750
    reference
  audio: use TYPE_MV88W8618_AUDIO instead of hardcoded string

 hw/arm/musicpal.c          |  5 +++--
 hw/audio/marvell_88w8618.c | 14 ++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.17.1
