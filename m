Received: from eggs.gnu.org ([2001:4830:134:3::10]:37003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andy.shevchenko@gmail.com>) id 1ffXee-0004Mv-4s
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andy.shevchenko@gmail.com>) id 1ffXed-0006w3-8W
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:37:08 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:42374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andy.shevchenko@gmail.com>)
	id 1ffXed-0006vW-22
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:37:07 -0400
Received: by mail-ua0-x242.google.com with SMTP id w7-v6so1626202uan.9
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:37:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709151947.940759-1-arnd@arndb.de>
References: <20180709151947.940759-1-arnd@arndb.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 18 Jul 2018 00:37:05 +0300
Message-ID: <CAHp75VdHZ4jCMLZn3RwhQ3ZCabZVsPMMUUOeXLvKT1y=m_z+WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] headers: fix linux/mod_devicetable.h
 inclusions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Jean-Christophe Trotin <jean-christophe.trotin@st.com>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>

On Mon, Jul 9, 2018 at 6:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> A couple of drivers produced build errors after the mod_devicetable.h
> header was split out from the platform_device one, e.g.
>
> drivers/media/platform/davinci/vpbe_osd.c:42:40: error: array type has incomplete element type 'struct platform_device_id'
> drivers/media/platform/davinci/vpbe_venc.c:42:40: error: array type has incomplete element type 'struct platform_device_id'
>
> This adds the inclusion where needed.
>
> Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  drivers/platform/x86/intel_punit_ipc.c     | 1 +


> --- a/drivers/platform/x86/intel_punit_ipc.c
> +++ b/drivers/platform/x86/intel_punit_ipc.c
> @@ -12,6 +12,7 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/bitops.h>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for the above bits.

-- 
With Best Regards,
Andy Shevchenko
