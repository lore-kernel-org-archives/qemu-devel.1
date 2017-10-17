Received: from eggs.gnu.org ([2001:4830:134:3::10]:48816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4PgF-0007NS-Tf
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4Pg8-0002yA-Li
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:05:03 -0400
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-37-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e1e9d13-9b7f-ef72-757b-7b4262986a48@redhat.com>
Date: Tue, 17 Oct 2017 13:04:47 +0200
MIME-Version: 1.0
In-Reply-To: <20171017001209.32276-37-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 36/39] i386/pc: move pvpanic.c from
 hw/misc/ to hw/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 17/10/2017 02:12, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

pvpanic does not _have_ to be i386-specific, and losing the
configurability with default-configs/ is a bit of a pity (there are
people who change the configurations), so I think it's better to leave
out this change.

Paolo

> ---
>  default-configs/i386-softmmu.mak   | 1 -
>  default-configs/x86_64-softmmu.mak | 1 -
>  hw/{misc =3D> i386}/pvpanic.c        | 0
>  hw/i386/Makefile.objs              | 2 +-
>  hw/misc/Makefile.objs              | 1 -
>  5 files changed, 1 insertion(+), 4 deletions(-)
>  rename hw/{misc =3D> i386}/pvpanic.c (100%)
>=20
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-so=
ftmmu.mak
> index dbc4e65652..541ec8604d 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -46,7 +46,6 @@ CONFIG_LPC_ICH9=3Dy
>  CONFIG_PCI_Q35=3Dy
>  CONFIG_APIC=3Dy
>  CONFIG_IOAPIC=3Dy
> -CONFIG_PVPANIC=3Dy
>  CONFIG_MEM_HOTPLUG=3Dy
>  CONFIG_NVDIMM=3Dy
>  CONFIG_ACPI_NVDIMM=3Dy
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_6=
4-softmmu.mak
> index f1fe508ff4..23488d324f 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -46,7 +46,6 @@ CONFIG_LPC_ICH9=3Dy
>  CONFIG_PCI_Q35=3Dy
>  CONFIG_APIC=3Dy
>  CONFIG_IOAPIC=3Dy
> -CONFIG_PVPANIC=3Dy
>  CONFIG_MEM_HOTPLUG=3Dy
>  CONFIG_NVDIMM=3Dy
>  CONFIG_ACPI_NVDIMM=3Dy
> diff --git a/hw/misc/pvpanic.c b/hw/i386/pvpanic.c
> similarity index 100%
> rename from hw/misc/pvpanic.c
> rename to hw/i386/pvpanic.c
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index feff56a9b7..41574096f1 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -7,6 +7,6 @@ obj-y +=3D amd_iommu.o
>  obj-$(CONFIG_XEN) +=3D ../xenpv/ xen/
> =20
>  obj-y +=3D kvmvapic.o
> -obj-y +=3D acpi-build.o
> +obj-y +=3D acpi-build.o pvpanic.o
>  obj-y +=3D pci-assign-load-rom.o
>  obj-y +=3D vmport.o
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 03bc758592..182f9a7d54 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -53,7 +53,6 @@ obj-$(CONFIG_MIPS_CPS) +=3D mips_cpc.o
>  obj-$(CONFIG_MIPS_ITU) +=3D mips_itu.o
>  obj-$(CONFIG_MPS2_SCC) +=3D mps2-scc.o
> =20
> -obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
>  obj-$(CONFIG_HYPERV_TESTDEV) +=3D hyperv_testdev.o
>  obj-$(CONFIG_AUX) +=3D auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
>=20
