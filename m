Received: from eggs.gnu.org ([2001:4830:134:3::10]:33037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNaPp-0001Pn-Bd
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gNaPo-0004oS-BS
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:27:53 -0500
Date: Fri, 16 Nov 2018 10:27:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181116102735.7e506760@redhat.com>
In-Reply-To: <20181105014047.26447-19-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-19-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 18/24] hw: i386: Export the MADT build
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Mon,  5 Nov 2018 02:40:41 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> It is going to be used by the PC machine type as the MADT table builder
> method and thus needs to be exported outside of acpi-build.c
>=20
> Also, now that the generic build_madt() API is exported, we have to
> rename the ARM static one in order to avoid build time conflicts.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  include/hw/i386/acpi.h   | 28 ++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c |  4 ++--
>  hw/i386/acpi-build.c     |  4 ++--
>  3 files changed, 32 insertions(+), 4 deletions(-)
>  create mode 100644 include/hw/i386/acpi.h
>=20
> diff --git a/include/hw/i386/acpi.h b/include/hw/i386/acpi.h
> new file mode 100644
> index 0000000000..b7a887111d
> --- /dev/null
> +++ b/include/hw/i386/acpi.h
[...]

> +/* ACPI MADT (Multiple APIC Description Table) build method */
> +void build_madt(GArray *table_data, BIOSLinker *linker,
> +                MachineState *ms, AcpiConfiguration *conf);
> +
> +#endif
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index b5e165543a..b0354c5f03 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -564,7 +564,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
> =20
>  /* MADT */
>  static void
> -build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +virt_build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState=
 *vms)
>  {
You are moving build_madt() into x86 specific header i386/acpi.h
so question is why do you touch ARM variant at all?

[...]
