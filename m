Received: from eggs.gnu.org ([2001:4830:134:3::10]:42374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgus-0005ni-KV
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgur-0005QZ-Lt
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:44:06 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:43:54 -0300
Message-Id: <20171215034356.4449-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 0/2] remove i386/pc dependency from non-PC
 world (part 1) fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org

Fix patch 42 from previous series (v4) so patchew can build, and if a maintainer
is willing to take the previous series with the last 2 patches, I don't need to
respam a v6.

Regards,

Phil.

Based-on: 20171215033015.738-42-f4bug@amsat.org
          (remove i386/pc dependency from non-PC world v4)

Philippe Mathieu-Daudé (2):
  hw/i386/vmport: replace fprintf() by trace events
  misc: drop old i386 dependency

 hw/char/debugcon.c      | 1 -
 hw/i386/vmport.c        | 8 +++-----
 hw/intc/lm32_pic.c      | 1 -
 hw/moxie/moxiesim.c     | 1 -
 hw/sparc/sun4m.c        | 1 -
 hw/watchdog/wdt_ib700.c | 1 -
 hw/i386/trace-events    | 4 ++++
 7 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.15.1
