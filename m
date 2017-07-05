Received: from eggs.gnu.org ([2001:4830:134:3::10]:49681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dSoH1-0000IR-K0
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dSoGy-00082m-Eo
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:39:35 -0400
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com
	([104.47.37.86]:54752
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dSoGy-00081J-10
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:39:32 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 5 Jul 2017 10:36:23 -0700
Message-ID: <cover.1499276048.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 0/3]  Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com

QEMU currently has a standard method to report errors with
error_repot(). This ensure a sane and standard format when printing
errors. This series is attempting to extend this functionality for
warnings and information as well.

At the moment only one error is being converted, I wanted to get the
implementation nailed down a little bit before I started converting
others.

This patch renames error_print_loc() function to be more clear, but I
didn't bother renaming the others. It seems silly to change
error_printf() to error_warning_printf() and printf is already taken so
I just left it as is.

I also didn't change the current error output as that would probably
break backwards compatibilty for anyone who is parsing logs.

RFCv3:
 - Use more detailed enum and function names
 - Add wrapper functions for the info and warning reporting
RFCv2:
 - Use enums for ERROR, WARN and INFO with a generic report() function
   instead of adding new functions

Alistair Francis (3):
  util/qemu-error: Rename error_print_loc() to be more generic
  qemu-error: Implement a more generic error reporting
  char-socket: Report TCP socket waiting as information

 chardev/char-socket.c       |  4 +--
 include/qemu/error-report.h | 16 +++++++++
 scripts/checkpatch.pl       |  8 ++++-
 util/qemu-error.c           | 84 +++++++++++++++++++++++++++++++++++++++++=
+---
 4 files changed, 104 insertions(+), 8 deletions(-)

--=20
2.11.0
