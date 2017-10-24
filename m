Received: from eggs.gnu.org ([2001:4830:134:3::10]:42309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCd-0006Ix-1O
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCX-0006zN-FZ
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 24 Oct 2017 09:20:41 -0300
Message-Id: <20171024122045.30072-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] tpm: add stubs to fix compiling with
 --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

This fixes building with --disable-tpm as reported by Zoltan:
  http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg05369.html

Cc'ing Peter in case this enters as a build fix instead of via trivial.

v2:
- added Richard W.M. Jones Tested-by tag
- remove #ifdef CONFIG_TPM in tpm.c (Stefan Berger)

Regards,

Phil.

PD: I missed Amarnath Valluri in my first series, you might want to add yourself
    a R: tag in MAINTAINTERS.
    
Philippe Mathieu-Daudé (4):
  tpm: add missing include
  tpm: add stubs
  tpm: remove unnecessary #ifdef CONFIG_TPM
  vl: remove unnecessary #ifdef CONFIG_TPM

 Makefile.objs        |  2 +-
 include/sysemu/tpm.h |  1 +
 stubs/tpm.c          | 33 +++++++++++++++++++++++++++++++++
 tpm.c                |  4 ----
 vl.c                 |  2 --
 MAINTAINERS          |  1 +
 stubs/Makefile.objs  |  1 +
 7 files changed, 37 insertions(+), 7 deletions(-)
 create mode 100644 stubs/tpm.c

-- 
2.15.0.rc1
