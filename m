Received: from eggs.gnu.org ([208.118.235.92]:58179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRQJ-0005AH-VA
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRQG-00027H-Si
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:30:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfRQG-00026n-Kg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:30:08 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-18-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ac00d820-95b3-5e36-f971-0f0d5f305209@redhat.com>
Date: Fri, 4 Jan 2019 16:30:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-18-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 17/25] i2c: express dependencies with
 Kconfig
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
> index 8ce968bfff..8ddce09ead 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -24,9 +24,11 @@ config PL110
> =20
>  config SII9022
>      bool
> +    depends on I2C
> =20
>  config SSD0303
>      bool
> +    depends on I2C
> =20
>  config SSD0323
>      bool
> @@ -70,6 +72,7 @@ config MILKYMIST_TMU2
> =20
>  config SM501
>      bool
> +    depends on I2C
> =20
>  config TCX
>      bool

I think XLNX_ZYNQMP_ARM likely needs "depends on I2C" nowadays, too ?

 Thomas
