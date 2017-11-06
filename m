Received: from eggs.gnu.org ([2001:4830:134:3::10]:55193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eBgi4-0002r5-4M
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eBgi0-0005KP-6X
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:41:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eBghz-0005JJ-UR
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:40:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6CdL7P089773
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 07:40:49 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2nxbx7ek-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 07:40:48 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 07:40:47 -0500
References: <20171106115347.19873-1-marcandre.lureau@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 10:40:41 -0200
MIME-Version: 1.0
In-Reply-To: <20171106115347.19873-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <bf2bbd4b-b26f-cf44-6bb1-47c80e4e6a88@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: restrict vmcoreinfo to
 fw_cfg+dma capable targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com



On 11/06/2017 09:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> vmcoreinfo is built for all targets. However, it requires fw_cfg with
> DMA operations support (write operation). Restrict vmcoreinfo exposure
> to architectures that are supporting FW_CFG_DMA, that is arm-virt and
> x86 only atm.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

>   default-configs/arm-softmmu.mak    | 2 ++
>   default-configs/i386-softmmu.mak   | 1 +
>   default-configs/x86_64-softmmu.mak | 1 +
>   hw/misc/Makefile.objs              | 2 +-
>   4 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-soft=
mmu.mak
> index 5059d134c8..d37edc4312 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -130,3 +130,5 @@ CONFIG_SMBIOS=3Dy
>   CONFIG_ASPEED_SOC=3Dy
>   CONFIG_GPIO_KEY=3Dy
>   CONFIG_MSF2=3Dy
> +
> +CONFIG_FW_CFG_DMA=3Dy
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-so=
ftmmu.mak
> index a685c439e7..95ac4b464a 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -60,3 +60,4 @@ CONFIG_SMBIOS=3Dy
>   CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>   CONFIG_PXB=3Dy
>   CONFIG_ACPI_VMGENID=3Dy
> +CONFIG_FW_CFG_DMA=3Dy
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_6=
4-softmmu.mak
> index ea69e8289e..0221236825 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -60,3 +60,4 @@ CONFIG_SMBIOS=3Dy
>   CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>   CONFIG_PXB=3Dy
>   CONFIG_ACPI_VMGENID=3Dy
> +CONFIG_FW_CFG_DMA=3Dy
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 19202d90cf..10c88a84b4 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -9,7 +9,7 @@ common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
>   common-obj-$(CONFIG_EDU) +=3D edu.o
>  =20
>   common-obj-y +=3D unimp.o
> -common-obj-y +=3D vmcoreinfo.o
> +common-obj-$(CONFIG_FW_CFG_DMA) +=3D vmcoreinfo.o
>  =20
>   obj-$(CONFIG_VMPORT) +=3D vmport.o
>  =20
