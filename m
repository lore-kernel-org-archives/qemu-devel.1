Received: from eggs.gnu.org ([2001:4830:134:3::10]:58488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJYB-0005Jb-2h
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJYA-0004y6-Bj
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:04:27 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  7 Dec 2018 18:03:54 +0100
Message-Id: <20181207170400.5129-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] fw_cfg: add HMP 'info fw_cfg' and
 add_file_from_host()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi, various fw_cfg easy patches:

- First patches are trivial cleanups (and add trace events),

- patch 5 add a 'info fw_cfg' HMP command to display comprehensive list o=
f
fw_cfg entries registered,

- patch 6 add fw_cfg_add_file_from_host(), a helper to map a file from th=
e
host (using g_file_get_contents). This will be used by later UEFI series.

Philippe Mathieu-Daud=C3=A9 (6):
  hw/arm/virt: Remove null-check in virt_build_smbios()
  hw/arm: Remove unused include
  hw/i386: Remove unused include
  hw/nvram/fw_cfg: Add trace events
  hw/nvram/fw_cfg: Add HMP 'info fw_cfg' command
  hw/nvram/fw_cfg: Add fw_cfg_add_file_from_host()

 hmp-commands-info.hx      |  14 ++++
 hw/acpi/piix4.c           |   1 -
 hw/arm/virt-acpi-build.c  |   1 -
 hw/arm/virt.c             |   4 --
 hw/i386/acpi-build.c      |   1 -
 hw/i386/pc.c              |   1 -
 hw/nvram/fw_cfg.c         | 142 ++++++++++++++++++++++++++++++++++++++
 hw/nvram/trace-events     |   5 ++
 include/hw/nvram/fw_cfg.h |  24 +++++++
 9 files changed, 185 insertions(+), 8 deletions(-)

--=20
2.17.2
