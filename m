Received: from eggs.gnu.org ([2001:4830:134:3::10]:56457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gWOIm-00050d-0c
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gWOIl-0004cS-0g
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:20:59 -0500
Date: Mon, 10 Dec 2018 17:20:48 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181210162048.zjio2dr7ffgntlfg@kamzik.brq.redhat.com>
References: <1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V12 0/5] add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Thu, Dec 06, 2018 at 07:25:55PM +0800, Peng Hao wrote:
> The first patches are simple cleanups:
>      - patch 1 move the pvpanic device with the 'ocmmon objects' so we =
compile
>                it once for the x86/arm/aarch64 archs,
>      - patch 2 simply renames ISA fields/definitions to generic ones.
>=20
>      Then instead of add/use the MMIO pvpanic device in the virt machin=
e in an
>      unique patch, I split it in two distinct patches:
>      - patch 3 uses Peng Hao's work, but add the MMIO interface to the =
existing
>         device (no logical change).
>      - patch 4 is Peng Hao's work in the virt machine (no logical chang=
e).
>      - patch 5 add pvpanic device in acpi table in virt machine
>      v2 from Peng Hao is:
>      https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03433.htm=
l
>=20
> v3 --> v4
>      patch 1,2 no modification.
>      patch 3, add TYPE_PANIC_MMIO for distinguishing different bus devi=
ce,
>               virt + isa_pvpanic will abnormally terminate virtual mach=
ine.
>      patch 4, "pvpanic,mmio" --> "qemu,pvpanic-mmio".
>      patch 5, newly added.
>=20
> v4 --> v5
>      patch 1,2 no modification.
>      patch 3 delete PvpanicCommonState structure.
>      patch 4 VIRT_PVPANIC_MMIO --> VIRT_PVPANIC
>              correct VIRT_PVPANIC's overlap start address
>      patch 5 no modification.
>=20
> v5 --> v6
>      add document.
>=20
> v6 --> v7
>      patch 5 modify device name from "PANC" to "PEVT".
>      patch 6 modify document description.
>=20
> v7 --> v8
>      add configure interface for pvpanic-mmio
>=20
> v8 --> v9
>      revert "moving structure definition to header file"
>      because of compile error in x86.
>=20
> v9 --> v10
>      Modify document.
>      Repair missing header files.
>=20
> v10 --> v11
>      change configure interface in virt machine configure parameters.
>=20
> v11 --> v12
>      realize pvpanic as a pci device and use the mmio of pci device.

Do you have a pointer to the kernel patches?

Thanks,
drew


>=20
> Philippe Mathieu-Daud=E9 (2):
>   hw/misc/pvpanic: Build the pvpanic device in $(common-obj)
>   hw/misc/pvpanic: Cosmetic renaming
>=20
> Peng Hao (3):
>   pvpanic : update pvpanic document
>   hw/arm/virt: Use the pvpanic device
>   pvpanic: add mmio interface as a pci device
>=20
> default-configs/arm-softmmu.mak |  1 +
> docs/specs/pvpanic.txt          | 13 +++++-
> hw/misc/Makefile.objs           |  2 +-
> hw/misc/pvpanic.c               | 91 +++++++++++++++++++++++++++++++++-=
-------
> include/hw/misc/pvpanic.h       |  1 +
> include/hw/pci/pci.h            |  1 +
> 6 files changed, 91 insertions(+), 18 deletions(-)
>=20
> --=20
> 1.8.3.1
>=20
>=20
