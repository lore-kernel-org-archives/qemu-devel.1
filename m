Received: from eggs.gnu.org ([209.51.188.92]:38470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmfdy-0006jM-UP
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmfdt-0000ms-2u
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:06:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmfds-0000m0-QZ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:06:05 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-27-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <50df8f61-e649-2fac-ab0b-72f9ef60bd39@redhat.com>
Date: Thu, 24 Jan 2019 15:06:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-27-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 26/44] kconfig: introduce kconfig
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com

On 2019-01-23 07:56, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> The Kconfig files were generated mostly with this script:
> 
>   for i in `grep -ho CONFIG_[A-Z0-9_]* default-configs/* | sort -u`; do
>     set fnord `git grep -lw $i -- 'hw/*/Makefile.objs' `
>     shift
>     if test $# = 1; then
>       cat >> $(dirname $1)/Kconfig << EOF
> config ${i#CONFIG_}
>     bool
> 
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
> 
> Whenever a symbol is referenced from multiple subdirectories, the
> script prints the list of directories that reference the symbol.
> These symbols have to be added manually to the Kconfig files.
> 
> Kconfig.host and hw/Kconfig were created manually.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
[...]
> diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
> new file mode 100644
> index 0000000000..c2c26e5150
> --- /dev/null
> +++ b/hw/cris/Kconfig
> @@ -0,0 +1,2 @@
> +config AXIS
> +    bool

Please also add here:

config ETRAXFS
    bool

> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> new file mode 100644
> index 0000000000..1a3e8b0e02
> --- /dev/null
> +++ b/hw/riscv/Kconfig
> @@ -0,0 +1,14 @@
> +config HTIF
> +    bool
> +
> +config HART
> +    bool
> +
> +config SIFIVE
> +    bool
> +
> +config SPIKE
> +    bool
> +
> +config RISCV_VIRTIO
> +    bool

Please rename the RISCV_VIRTIO to RISCV_VIRT.

We also additionally need these two here:

config SIFIVE_E
    bool

config SIFIVE_U
    bool

 Thanks,
  Thomas
