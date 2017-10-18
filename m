Received: from eggs.gnu.org ([2001:4830:134:3::10]:35669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4j3F-000342-VE
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4j3C-0007g7-T6
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:46:05 -0400
Date: Wed, 18 Oct 2017 09:45:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171018094557.1473b323@nial.brq.redhat.com>
In-Reply-To: <20171017164426.25277-35-f4bug@amsat.org>
References: <20171017164426.25277-1-f4bug@amsat.org>
	<20171017164426.25277-35-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 34/42] hw/acpi/ich9: extract
 ACPI_PM_PROP_TCO_ENABLED from i386/pc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Tue, 17 Oct 2017 13:44:18 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> enable_tco is specific to i386/pc.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/ich9.h | 2 ++
>  include/hw/i386/pc.h   | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index a352c94fde..59aeb06393 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -63,6 +63,8 @@ typedef struct ICH9LPCPMRegs {
>      TCOIORegs tco_regs;
>  } ICH9LPCPMRegs;
> =20
> +#define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
> +
>  void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
>                    bool smm_enabled,
>                    qemu_irq sci_irq);
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 6335e2bf47..b1b4c918af 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -151,8 +151,6 @@ struct PCMachineClass {
>  #define PC_MACHINE_CLASS(klass) \
>      OBJECT_CLASS_CHECK(PCMachineClass, (klass), TYPE_PC_MACHINE)
> =20
> -#define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
> -
>  /* parallel.c */
> =20
>  void parallel_hds_isa_init(ISABus *bus, int n);
