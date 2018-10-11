Received: from eggs.gnu.org ([2001:4830:134:3::10]:57311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gAVsQ-00082e-Rk
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gAVsM-0006SC-OK
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gAVsM-0006JI-CV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:59:18 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <20180927212438.32024-1-lersek@redhat.com>
Message-ID: <785e1781-398c-725f-4ded-b81b4aabe220@redhat.com>
Date: Thu, 11 Oct 2018 09:59:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180927212438.32024-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] hw/pci-host/x86: extend the 64-bit
 PCI hole relative to the fw-assigned base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Marcel Apfelbaum (GMail address)" <marcel.apfelbaum@gmail.com>

Michael,

On 09/27/18 23:24, Laszlo Ersek wrote:
> This is v2 of the series previously posted at
> <http://mid.mail-archive.com/20180924221346.16733-1-lersek@redhat.com>.
> 
> Changes are noted on every patch.

can you please merge this series?

Please note that it depends on v2 of the following patch, from Gerd:

> The bios-tables-test case depends on Gerd's "[PATCH] pci-testdev: add
> optional memory bar" at
> <https://patchew.org/QEMU/20180927121055.28361-1-kraxel@redhat.com/>.

[Qemu-devel] [PATCH v2] pci-testdev: add optional memory bar
message-id: <20180928064419.2106-1-kraxel@redhat.com>

so please include that as well (first).

Thanks!
Laszlo

> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> 
> Thanks
> Laszlo
> 
> Laszlo Ersek (4):
>   MAINTAINERS: list "tests/acpi-test-data" files in ACPI/SMBIOS section
>   tests/bios-tables-test: add 64-bit PCI MMIO aperture round-up test on
>     Q35
>   hw/pci-host/x86: extract get_pci_hole64_start_value() helpers
>   hw/pci-host/x86: extend the 64-bit PCI hole relative to the
>     fw-assigned base
> 
>  hw/pci-host/piix.c                   |  17 ++++++++++++-----
>  hw/pci-host/q35.c                    |  17 ++++++++++++-----
>  tests/bios-tables-test.c             |  16 ++++++++++++++++
>  MAINTAINERS                          |   2 ++
>  tests/acpi-test-data/q35/DSDT.mmio64 | Bin 0 -> 8947 bytes
>  tests/acpi-test-data/q35/SRAT.mmio64 | Bin 0 -> 224 bytes
>  6 files changed, 42 insertions(+), 10 deletions(-)
>  create mode 100644 tests/acpi-test-data/q35/DSDT.mmio64
>  create mode 100644 tests/acpi-test-data/q35/SRAT.mmio64
> 
