Received: from eggs.gnu.org ([209.51.188.92]:60969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwU8w-0005EL-2l
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwU8s-00062m-1M
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:50:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gwU8q-0005vT-0H
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:50:37 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-6-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b48ecdfe-ab7c-9fde-89fd-0296863648eb@redhat.com>
Date: Wed, 20 Feb 2019 16:42:45 +0100
MIME-Version: 1.0
In-Reply-To: <1549562254-41157-6-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/51] kconfig: introduce kconfig files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, philmd@redhat.com

On 07/02/2019 18.56, Paolo Bonzini wrote:
> The Kconfig files were generated mostly with this script:
>=20
>   for i in `grep -ho CONFIG_[A-Z0-9_]* default-configs/* | sort -u`; do
>     set fnord `git grep -lw $i -- 'hw/*/Makefile.objs' `
>     shift
>     if test $# =3D 1; then
>       cat >> $(dirname $1)/Kconfig << EOF
> config ${i#CONFIG_}
>     bool
>=20
> EOF
>       git add $(dirname $1)/Kconfig
>     else
>       echo $i $*
>     fi
>   done
>   sed -i '$d' hw/*/Kconfig
>   for i in hw/*; do
>     if test -d $i && ! test -f $i/Kconfig; then
>       touch $i/Kconfig
>       git add $i/Kconfig
>     fi
>   done
>=20
> Whenever a symbol is referenced from multiple subdirectories, the
> script prints the list of directories that reference the symbol.
> These symbols have to be added manually to the Kconfig files.
>=20
> Kconfig.host and hw/Kconfig were created manually.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-27-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> new file mode 100644
> index 0000000..64cd698
> --- /dev/null
> +++ b/hw/arm/Kconfig
> @@ -0,0 +1,119 @@
> +config ARM_VIRT
> +    bool
> +
> +config DIGIC
> +    bool
> +
> +config EXYNOS4
> +    bool
> +
> +config HIGHBANK
> +    bool
> +
> +config INTEGRATOR
> +    bool
> +
> +config MAINSTONE
> +    bool
> +
> +config MUSICPAL
> +    bool
> +
> +config NETDUINO2
> +    bool
> +
> +config NSERIES
> +    bool
> +
> +config OMAP
> +    bool
> +
> +config PXA2XX
> +    bool
> +
> +config REALVIEW
> +    bool
> +
> +config STELLARIS
> +    bool
> +
> +config STRONGARM
> +    bool
> +
> +config VERSATILE
> +    bool
> +
> +config ZYNQ
> +    bool
> +
> +config ARM_V7M
> +    bool
> +
> +config EXYNOS4
> +    bool

I just noticed: EXYNOS4 is defined twice in this file (it's also the
third entry from the top). You can remove one of those.

> +config ALLWINNER_A10
> +    bool
> +
> +config RASPI
> +    bool
> +
> +config STM32F205_SOC
> +    bool
> +
> +config XLNX_ZYNQMP_ARM
> +    bool
> +
> +config XLNX_VERSAL
> +    bool
> +
> +config FSL_IMX25
> +    bool
> +
> +config FSL_IMX31
> +    bool
> +
> +config FSL_IMX6
> +    bool
> +
> +config ASPEED_SOC
> +    bool
> +
> +config MPS2
> +    bool
> +
> +config IOTKIT
> +    bool

Are we using IOTKIT anywhere?

 Thomas
