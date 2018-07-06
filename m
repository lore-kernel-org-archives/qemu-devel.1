Received: from eggs.gnu.org ([2001:4830:134:3::10]:33623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbT1R-0002bm-Sp
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbT1O-0000Y2-Pp
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:51:49 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Jul 2018 12:51:24 -0300
Message-Id: <20180706155127.7483-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.0 0/3] Sanitize linux-user stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org

Hi Laurent,

Here 3 trivial patches, the first one resolves this launchpad issue:
https://bugs.launchpad.net/qemu/+bug/1777226, then the following two
sanitize a bit further.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  linux-user: Do not report "Unsupported syscall" by default
  linux-user: Do not report "syscall not implemented" by default
  linux-user: Report error message on stderr, rather than stdout

 linux-user/alpha/cpu_loop.c      | 2 +-
 linux-user/cris/cpu_loop.c       | 2 +-
 linux-user/cris/signal.c         | 4 ++--
 linux-user/microblaze/cpu_loop.c | 6 +++---
 linux-user/microblaze/signal.c   | 4 ++--
 linux-user/nios2/signal.c        | 2 +-
 linux-user/sh4/cpu_loop.c        | 2 +-
 linux-user/sparc/cpu_loop.c      | 2 +-
 linux-user/sparc/signal.c        | 4 ++--
 linux-user/syscall.c             | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.18.0
