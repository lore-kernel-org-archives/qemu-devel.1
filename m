Received: from eggs.gnu.org ([2001:4830:134:3::10]:42391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1g0Apd-0003fs-AT
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1g0Aix-0004r5-Nc
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:22:52 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1g0Aix-0004qo-IS
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:22:51 -0400
Received: by mail-io1-xd44.google.com with SMTP id y10-v6so1144570ioa.10
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 12:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180912160118.21158-1-liq3ea@163.com>
	<20180912160118.21158-8-liq3ea@163.com>
In-Reply-To: <20180912160118.21158-8-liq3ea@163.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 12 Sep 2018 21:22:34 +0200
Message-ID: <CACXAS8CwxjB1YGHrs8uUarw4VxvNcXPBra+P_91YYkhGYzDccQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 7/8] hw: sun4c: add read memory region
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liq3ea@163.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, lersek@redhat.com, marcandre.lureau@gmail.com, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, ppandit@redhat.com, liq3ea@gmail.com, qemu-devel <qemu-devel@nongnu.org>

Please correct the typo in the subject. I was scared that someone dug
out the sun4c zombie emulation.

In the particular case of sun4u, I think the proper way is not to have
the read callback, but throw an 'Unassigned memory access' exception

Regards,
Artyom
On Wed, Sep 12, 2018 at 6:09 PM Li Qiang <liq3ea@163.com> wrote:
>
> From: Li Qiang <liq3ea@gmail.com>
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/sparc64/sun4u.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index d16843b30e..74c55a82f4 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -212,6 +212,11 @@ typedef struct PowerDevice {
>      MemoryRegion power_mmio;
>  } PowerDevice;
>
> +static uint64_t power_mem_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0;
> +}
> +
>  /* Power */
>  static void power_mem_write(void *opaque, hwaddr addr,
>                              uint64_t val, unsigned size)
> @@ -223,6 +228,7 @@ static void power_mem_write(void *opaque, hwaddr addr,
>  }
>
>  static const MemoryRegionOps power_mem_ops = {
> +    .read = power_mem_read,
>      .write = power_mem_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
> --
> 2.17.1
>
>
>


-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
