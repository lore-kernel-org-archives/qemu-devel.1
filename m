Received: from eggs.gnu.org ([2001:4830:134:3::10]:34540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dPxPr-0002BK-Pc
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dPxPo-00036C-NT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:48:55 -0400
Received: from mail-dm3nam03on0066.outbound.protection.outlook.com
	([104.47.41.66]:18433
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dPxPo-00035Z-BJ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:48:52 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Jun 2017 13:45:41 -0700
Message-ID: <cover.1498596157.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 0/3]  Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

QEMU currently has a standard method to report errors with
error_repot(). This ensure a sane and standard format when printing
errors. This series is attempting to add the same functionality for
warnings.

At the moment only one error is being converted, I wanted to get the
implementation nailed down a little bit before I started converting
others.

This patch renames error_print_loc() function to be more clear, but I
didn't bother renaming the others. It seems silly to change
error_printf() to error_warning_printf() and printf is already taken so
I just left it as is.

I also didn't change the current error output as that would probably
break backwards compatibilty for anyone who is parsing logs.

Alistair Francis (3):
  util/qemu-error: Rename error_print_loc() to be more generic
  util/qemu-error: Add a warning_report() function
  char-socket: Report TCP socket waiting as a warning

 chardev/char-socket.c       |  2 +-
 include/qemu/error-report.h |  2 ++
 util/qemu-error.c           | 36 ++++++++++++++++++++++++++++++++++--
 3 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.11.0
