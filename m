Received: from eggs.gnu.org ([209.51.188.92]:58574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexa-000472-U2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexZ-00080P-QM
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:50:38 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 22 Apr 2019 21:50:13 +0200
Message-Id: <20190422195020.1494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/7] fw_cfg: Improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Trivial series to improve fw_cfg tracing.

Regards,

Phil.

Since v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.=
html
- Split arch-specific code (1 patch per arch) (requested by Laszlo)

Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.=
html
- Added arch-specific keys

Philippe Mathieu-Daud=C3=A9 (7):
  hw/nvram/fw_cfg: Add trace events
  hw/nvram/fw_cfg: Add fw_cfg_arch_key_name()
  hw/i386: Extract fw_cfg definitions to local "fw_cfg.h"
  hw/i386: Implement fw_cfg_arch_key_name()
  hw/ppc: Implement fw_cfg_arch_key_name()
  hw/sparc: Implement fw_cfg_arch_key_name()
  hw/sparc64: Implement fw_cfg_arch_key_name()

 MAINTAINERS               |  1 +
 hw/i386/Makefile.objs     |  2 +-
 hw/i386/fw_cfg.c          | 38 +++++++++++++++++++++++
 hw/i386/fw_cfg.h          | 20 +++++++++++++
 hw/i386/pc.c              |  7 +----
 hw/nvram/fw_cfg.c         | 63 ++++++++++++++++++++++++++++++++++++++-
 hw/nvram/trace-events     |  7 ++++-
 hw/ppc/Makefile.objs      |  2 +-
 hw/ppc/fw_cfg.c           | 45 ++++++++++++++++++++++++++++
 hw/sparc/sun4m.c          | 19 ++++++++++++
 hw/sparc64/sun4u.c        | 19 ++++++++++++
 include/hw/nvram/fw_cfg.h | 11 +++++++
 stubs/Makefile.objs       |  1 +
 stubs/fw_cfg.c            | 21 +++++++++++++
 14 files changed, 246 insertions(+), 10 deletions(-)
 create mode 100644 hw/i386/fw_cfg.c
 create mode 100644 hw/i386/fw_cfg.h
 create mode 100644 hw/ppc/fw_cfg.c
 create mode 100644 stubs/fw_cfg.c

--=20
2.20.1
