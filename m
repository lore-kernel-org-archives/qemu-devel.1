Received: from eggs.gnu.org ([2001:4830:134:3::10]:39824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gTEMC-0003h2-Gk
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 18:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gTEM9-0002Gk-FH
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 18:07:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gTEM9-0002Do-7v
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 18:07:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so8632247wrb.2
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 15:07:23 -0800 (PST)
References: <20181128195802.B6A6C7456B9@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <62a45983-1ea6-c3d5-37e5-12b43cf34d39@redhat.com>
Date: Sun, 2 Dec 2018 00:07:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181128195802.B6A6C7456B9@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] i2c: Move typedef of bitbang_i2c_interface
 to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Corey Minyard <minyard@acm.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Cc'ing Corey, the new I2C maintainer (since 4.0).

On 28/11/18 20:27, BALATON Zoltan wrote:
> Clang 3.4 considers duplicate typedef in ppc4xx_i2c.h and
> bitbang_i2c.h an error even if they are identical. Move it to a common
> place to allow building with this clang version.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/i2c/bitbang_i2c.h        | 2 --
>  include/hw/i2c/i2c.h        | 2 ++
>  include/hw/i2c/ppc4xx_i2c.h | 3 ---
>  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i2c/bitbang_i2c.h b/hw/i2c/bitbang_i2c.h
> index 3a7126d5de..9443021710 100644
> --- a/hw/i2c/bitbang_i2c.h
> +++ b/hw/i2c/bitbang_i2c.h
> @@ -3,8 +3,6 @@
>  
>  #include "hw/i2c/i2c.h"
>  
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> -
>  #define BITBANG_I2C_SDA 0
>  #define BITBANG_I2C_SCL 1
>  
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 5dc166158b..cf4c45a98f 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -82,6 +82,8 @@ int i2c_recv(I2CBus *bus);
>  
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
>  
> +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> +
>  /* lm832x.c */
>  void lm832x_key_event(DeviceState *dev, int key, int state);
>  
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index 0891a9c948..b3450bacf7 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -31,9 +31,6 @@
>  #include "hw/sysbus.h"
>  #include "hw/i2c/i2c.h"
>  
> -/* from hw/i2c/bitbang_i2c.h */
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> -
>  #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
>  #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_I2C)
>  
> 
