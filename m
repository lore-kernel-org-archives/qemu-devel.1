Received: from eggs.gnu.org ([2001:4830:134:3::10]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6kMX-0008LY-SQ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6kMU-000060-Oz
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:34:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 23 Oct 2017 18:33:56 -0300
Message-Id: <20171023213359.23025-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] tpm: add stubs to fix compiling with
 --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>

This fixes building with --disable-tpm as reported by Zoltan:
  http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg05369.html

Cc'ing Peter in case this enters as build fix instead of via trivial.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  tpm: add missing include
  tpm: add stubs
  vl: remove unnecessary #ifdef CONFIG_TPM

 Makefile.objs        |  2 +-
 include/sysemu/tpm.h |  1 +
 stubs/tpm.c          | 33 +++++++++++++++++++++++++++++++++
 vl.c                 |  2 --
 MAINTAINERS          |  1 +
 stubs/Makefile.objs  |  1 +
 6 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 stubs/tpm.c

-- 
2.15.0.rc1
