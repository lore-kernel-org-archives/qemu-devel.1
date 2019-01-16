Received: from eggs.gnu.org ([209.51.188.92]:41615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhE1-00077e-Of
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhE0-0002in-Pp
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjhE0-0002Vv-8H
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:11:04 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-11-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e7e489da-5457-ba6c-d9bf-297cb34b4502@redhat.com>
Date: Wed, 16 Jan 2019 10:10:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-11-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 10/37] hw/lm32/Makefile.objs:
 Conditionally build lm32 and milkmyst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com, Michael Walle <michael@walle.cc>

On 2019-01-15 15:10, Yang Zhong wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> CONFIG_LM32 and CONFIG_MILKYMIST added for lm32 and milkmyst build.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/lm32/Makefile.objs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/lm32/Makefile.objs b/hw/lm32/Makefile.objs
> index ea6418ae59..c3941866c7 100644
> --- a/hw/lm32/Makefile.objs
> +++ b/hw/lm32/Makefile.objs
> @@ -1,3 +1,3 @@
>  # LM32 boards
> -obj-y +=3D lm32_boards.o
> -obj-y +=3D milkymist.o
> +obj-$(CONFIG_LM32) +=3D lm32_boards.o
> +obj-$(CONFIG_MILKYMIST) +=3D milkymist.o

Reviewed-by: Thomas Huth <thuth@redhat.com>
