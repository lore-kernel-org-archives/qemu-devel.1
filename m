Received: from eggs.gnu.org ([209.51.188.92]:49703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4p-0005dS-91
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4n-00036r-Aw
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4m-00035z-Vm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:45 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 May 2019 16:52:00 +0200
Message-Id: <1556808723-226478-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 12/15] tests: add expected ACPI tables for
 arm/virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>, xuwei5@hisilicon.com, xuwei5@huawei.com, linuxarm@huawei.com

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
this patch is ahead fo "tests: acpi: add simple  arm/virt testcase"
to keep 'make check' working during bisection and not to pollute
code with binary blobs which are not reviewable.
---
 tests/data/acpi/virt/APIC | Bin 0 -> 168 bytes
 tests/data/acpi/virt/DSDT | Bin 0 -> 18476 bytes
 tests/data/acpi/virt/FACP | Bin 0 -> 268 bytes
 tests/data/acpi/virt/GTDT | Bin 0 -> 96 bytes
 tests/data/acpi/virt/MCFG | Bin 0 -> 60 bytes
 tests/data/acpi/virt/SPCR | Bin 0 -> 80 bytes
 6 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/acpi/virt/APIC
 create mode 100644 tests/data/acpi/virt/DSDT
 create mode 100644 tests/data/acpi/virt/FACP
 create mode 100644 tests/data/acpi/virt/GTDT
 create mode 100644 tests/data/acpi/virt/MCFG
 create mode 100644 tests/data/acpi/virt/SPCR

diff --git a/tests/data/acpi/virt/APIC b/tests/data/acpi/virt/APIC
new file mode 100644
index 0000000000000000000000000000000000000000..797dfde2841c51b7e72065602=
e99ce1714347f0d
GIT binary patch
literal 168
zcmZ<^@N{0mz`($~*~#D8BUr&HBEZ=3DZD8>jB1F=3DCg4Dd+6SPUF6788)c?E~X6Fu>G{
hBZPn~MyPrgD9sGlkD?67;f3451Xcqw&w(L;0RYV=3D2>}2A

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
new file mode 100644
index 0000000000000000000000000000000000000000..20e85c7f89f645c69935c615c=
07084e221419960
GIT binary patch
literal 18476
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

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/virt/FACP
new file mode 100644
index 0000000000000000000000000000000000000000..27de99f51bfe846b1f8796ace=
49d83f5b33a1aed
GIT binary patch
literal 268
ycmZ>BbPnKQWME+3?d0$55v<@85#a0w6axw|fY>0Kx<CNcIA#XwTY+i=3D(L4a*H3tCz

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/GTDT b/tests/data/acpi/virt/GTDT
new file mode 100644
index 0000000000000000000000000000000000000000..10107a65e958ff6495bb8c17d=
63d0539690f59f6
GIT binary patch
literal 96
zcmZ<{aS2IaU|?Xn>E!S15v<@85#a0&6k`O6f!H7#8OTC8azL5|h^3)?DJYFj0RVOU
B2mt^9

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/MCFG b/tests/data/acpi/virt/MCFG
new file mode 100644
index 0000000000000000000000000000000000000000..e8987e1af0ec3829770bf4fe1=
1fab02b06160dd2
GIT binary patch
literal 60
scmeZuc5}C3U|?YMck*}k2v%^42ypfViZKGkKx`0=3D1Oyx)oc|yS05YNo0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/virt/SPCR
new file mode 100644
index 0000000000000000000000000000000000000000..377271a0e7817cc21a28c0212=
3a89facad63604f
GIT binary patch
literal 80
zcmWFza1IJ!U|?VpcJg=3Dj2v%^42yhMtiZKGkKx`1r48#l^3?L>agsBLmm>C$E7#RKo
I0Z0r60QF4^0RR91

literal 0
HcmV?d00001

--=20
2.7.4
