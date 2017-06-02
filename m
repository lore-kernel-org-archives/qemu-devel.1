Received: from eggs.gnu.org ([2001:4830:134:3::10]:52965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp39-0001Ev-Ao
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp35-0002Rs-Ou
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp35-0002RS-JO
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:39 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:03:29 +0200
Message-Id: <20170602160332.1939-1-lersek@redhat.com>
In-Reply-To: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
Subject: [Qemu-devel] [edk2 PATCH 0/3] OvmfPkg/AcpiPlatformDxe: NOACPI hint
 and 64-bit zone in fw_cfg blob alloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: SeaBIOS@seabios.org, qemu-devel@nongnu.org, edk2-devel@lists.01.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Jordan Justen <jordan.l.justen@intel.com>, Leif Lindholm <leif.lindholm@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>

Please see the parent blurb
<http://mid.mail-archive.com/c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
for a high level description.

Repo:   https://github.com/lersek/edk2.git
Branch: zone_hints

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Jordan Justen <jordan.l.justen@intel.com>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>

Thanks
Laszlo

Laszlo Ersek (3):
  OvmfPkg/AcpiPlatformDxe: rename BLOB.HostsOnlyTableData to
    BLOB.Releasable
  OvmfPkg/AcpiPlatformDxe: support NOACPI content hint in ALLOCATE
    command
  OvmfPkg/AcpiPlatformDxe: support 64-bit zone in ALLOCATE command

 OvmfPkg/AcpiPlatformDxe/QemuLoader.h    | 12 ++++-
 OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c | 53 +++++++++++++++-----
 2 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.9.3
