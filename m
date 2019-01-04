Received: from eggs.gnu.org ([208.118.235.92]:60816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPwd-0004ia-9j
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPwa-0002NQ-5o
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:55:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfPwZ-0002N8-TF
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:55:24 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-16-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <af2cbeac-607c-194a-e546-6a7995be3f52@redhat.com>
Date: Fri, 4 Jan 2019 14:55:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-16-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 15/25] isa: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
[...]
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 5e73277cc2..e0d7919a06 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -9,6 +9,9 @@ config ADS7846
> =20
>  config VGA_CIRRUS
>      bool
> +    default y
> +    depends on ISA_BUS && PCI
> +    select VGA

Please note that the cirrus-isa device has recently been split into a
separate file, see commit:

  ce3cf70edaaf1b8f9a566b36011350c642287879
  Move "isa-cirrus-vga" device into a separate file

I guess we need a dedicated VGA_CIRRUS_ISA switch for that file now?

> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 427bda3717..68a9064558 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -9,6 +9,7 @@ config I440FX
> =20
>  config ISAPC
>      bool
> +    select ISA_BUS
> =20
>  config Q35
>      bool

Can Q35 and I440FX work completely without ISA_BUS already, or should
they also select ISA_BUS here?

 Thomas
