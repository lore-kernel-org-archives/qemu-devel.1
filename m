Received: from eggs.gnu.org ([2001:4830:134:3::10]:39146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaFv-0004Wk-Fb
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaFu-0003an-Mg
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:21:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:21:19 -0300
Message-Id: <20180606152128.449-3-f4bug@amsat.org>
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/11] hw/digic: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Canon DIGIC" <qemu-arm@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/digic-uart.c   | 4 ++--
 hw/timer/digic-timer.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 6ebcb87a40..ccc75eaa4d 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -60,7 +60,7 @@ static uint64_t digic_uart_read(void *opaque, hwaddr addr,
     default:
         qemu_log_mask(LOG_UNIMP,
                       "digic-uart: read access to unknown register 0x"
-                      TARGET_FMT_plx, addr << 2);
+                      TARGET_FMT_plx "\n", addr << 2);
     }
 
     return ret;
@@ -98,7 +98,7 @@ static void digic_uart_write(void *opaque, hwaddr addr, uint64_t value,
     default:
         qemu_log_mask(LOG_UNIMP,
                       "digic-uart: write access to unknown register 0x"
-                      TARGET_FMT_plx, addr << 2);
+                      TARGET_FMT_plx "\n", addr << 2);
     }
 }
 
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index e1fcf73c3e..4d73077207 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -73,7 +73,7 @@ static uint64_t digic_timer_read(void *opaque, hwaddr offset, unsigned size)
     default:
         qemu_log_mask(LOG_UNIMP,
                       "digic-timer: read access to unknown register 0x"
-                      TARGET_FMT_plx, offset);
+                      TARGET_FMT_plx "\n", offset);
     }
 
     return ret;
@@ -109,7 +109,7 @@ static void digic_timer_write(void *opaque, hwaddr offset,
     default:
         qemu_log_mask(LOG_UNIMP,
                       "digic-timer: read access to unknown register 0x"
-                      TARGET_FMT_plx, offset);
+                      TARGET_FMT_plx "\n", offset);
     }
 }
 
-- 
2.17.1
