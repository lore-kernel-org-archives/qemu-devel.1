Received: from eggs.gnu.org ([2001:4830:134:3::10]:49066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4Pge-0007b4-Ou
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4Pga-0003Q9-UQ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:05:28 -0400
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-36-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f0f4197-8787-a277-a46c-558f16fae2b8@redhat.com>
Date: Tue, 17 Oct 2017 13:05:17 +0200
MIME-Version: 1.0
In-Reply-To: <20171017001209.32276-36-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 35/39] i386/pc: move vmport.c from
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

Keeping the configurability is desirable here too, but moving to hw/i386
makes a lot of sense in this case.

Paolo

> ---
>  default-configs/i386-softmmu.mak   | 1 -
>  default-configs/x86_64-softmmu.mak | 1 -
>  hw/{misc =3D> i386}/vmport.c         | 0
>  hw/i386/Makefile.objs              | 1 +
>  hw/misc/Makefile.objs              | 2 --
>  5 files changed, 1 insertion(+), 4 deletions(-)
>  rename hw/{misc =3D> i386}/vmport.c (100%)
>=20
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-so=
ftmmu.mak
> index d2ab2f6655..dbc4e65652 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -41,7 +41,6 @@ CONFIG_PCI_PIIX=3Dy
>  CONFIG_WDT_IB700=3Dy
>  CONFIG_ISA_DEBUG=3Dy
>  CONFIG_ISA_TESTDEV=3Dy
> -CONFIG_VMPORT=3Dy
>  CONFIG_SGA=3Dy
>  CONFIG_LPC_ICH9=3Dy
>  CONFIG_PCI_Q35=3Dy
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_6=
4-softmmu.mak
> index 9bde2f1c4b..f1fe508ff4 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -41,7 +41,6 @@ CONFIG_PCI_PIIX=3Dy
>  CONFIG_WDT_IB700=3Dy
>  CONFIG_ISA_DEBUG=3Dy
>  CONFIG_ISA_TESTDEV=3Dy
> -CONFIG_VMPORT=3Dy
>  CONFIG_SGA=3Dy
>  CONFIG_LPC_ICH9=3Dy
>  CONFIG_PCI_Q35=3Dy
> diff --git a/hw/misc/vmport.c b/hw/i386/vmport.c
> similarity index 100%
> rename from hw/misc/vmport.c
> rename to hw/i386/vmport.c
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 909ead6a77..feff56a9b7 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -9,3 +9,4 @@ obj-$(CONFIG_XEN) +=3D ../xenpv/ xen/
>  obj-y +=3D kvmvapic.o
>  obj-y +=3D acpi-build.o
>  obj-y +=3D pci-assign-load-rom.o
> +obj-y +=3D vmport.o
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 19202d90cf..03bc758592 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -11,8 +11,6 @@ common-obj-$(CONFIG_EDU) +=3D edu.o
>  common-obj-y +=3D unimp.o
>  common-obj-y +=3D vmcoreinfo.o
> =20
> -obj-$(CONFIG_VMPORT) +=3D vmport.o
> -
>  # ARM devices
>  common-obj-$(CONFIG_PL310) +=3D arm_l2x0.o
>  common-obj-$(CONFIG_INTEGRATOR_DEBUG) +=3D arm_integrator_debug.o
>=20
