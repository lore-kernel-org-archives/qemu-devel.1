Received: from eggs.gnu.org ([209.51.188.92]:43445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hJdL7-0004Il-By
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hJdL3-0005xV-CK
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:18:57 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:49046
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hJdKz-0005oJ-Oy
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:18:51 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu, 25 Apr 2019 14:18:32 +0200
Message-Id: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] Leon3 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, philmd@redhat.com, chouteau@adacore.com, frederic.konrad@adacore.com

Hi all,

Those are some little fixes for the leon3 machine:
  * The first part initializes the uart and the timer when no bios are
    provided.
  * The second part adds AHB and APB plug and play devices to allow to bo=
ot
    linux.
  * The third part adds myself to the MAINTAINERS for this board.

The test images are available here: https://www.gaisler.com/anonftp/linux=
/lin
ux-2.6/images/leon-linux-4.9/leon-linux-4.9-1.0/up/

Tested with:
  qemu-system-sparc -M leon3_generic --nographic --kernel image.ram

V1 -> V2:
  * minor fixes in the first patch suggested by Philippe.

Regards,
Fred

KONRAD Frederic (3):
  leon3: add a little bootloader
  leon3: introduce the plug and play mecanism
  MAINTAINERS: add myself for leon3

 MAINTAINERS                         |   1 +
 hw/misc/Makefile.objs               |   2 +
 hw/misc/grlib_ahb_apb_pnp.c         | 269 ++++++++++++++++++++++++++++++=
++++++
 hw/sparc/leon3.c                    | 114 +++++++++++++--
 include/hw/misc/grlib_ahb_apb_pnp.h |  60 ++++++++
 include/hw/sparc/grlib.h            |  35 +++--
 6 files changed, 455 insertions(+), 26 deletions(-)
 create mode 100644 hw/misc/grlib_ahb_apb_pnp.c
 create mode 100644 include/hw/misc/grlib_ahb_apb_pnp.h

--=20
1.8.3.1
