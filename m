Received: from eggs.gnu.org ([2001:4830:134:3::10]:49677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaY-0000Ds-AV
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaX-0008PB-DS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxaX-0008Ov-9K
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:22 +0100
Message-Id: <20180629175330.19391-4-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/11] sdcard: Reduce sdcard_set_blocklen()
 trace digits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Per the Physical Layer Simplified Spec. "5.3 CSD Register":

  "The maximum block length might therefore be in the range 512...2048 by=
tes"

Therefore 3 hexdigits are enough to report the block length.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/sd/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index bfd1d62efc..d7880bcea5 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -37,7 +37,7 @@ sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
 sdcard_set_enable(bool current_state, bool new_state) "%u -> %u"
 sdcard_reset(void) ""
-sdcard_set_blocklen(uint16_t length) "0x%04x"
+sdcard_set_blocklen(uint16_t length) "0x%03x"
 sdcard_inserted(bool readonly) "read_only: %u"
 sdcard_ejected(void) ""
 sdcard_erase(void) ""
--=20
2.17.1
