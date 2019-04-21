Received: from eggs.gnu.org ([209.51.188.92]:59717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9iI-0004N9-Un
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9iI-0007Ea-36
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:28:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hI9iH-0007Dw-TC
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:28:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so11283779wmi.0
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 03:28:45 -0700 (PDT)
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-2-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <46a216be-0898-2d52-485d-fd07428c8b76@redhat.com>
Date: Sun, 21 Apr 2019 12:28:42 +0200
MIME-Version: 1.0
In-Reply-To: <20190420161446.2274-2-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] edu: mmio: set 'max_access_size' to
 8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, jslaby@suse.cz, pbonzini@redhat.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org

Hi Li,

The patch title is not very descriptive, maybe "allow 64-bit access"


On 4/20/19 6:14 PM, Li Qiang wrote:
> The edu spec said, the MMIO area can be accessed by 8 bytes.

or 64-bit...

> However currently the 'max_access_size' is not so the MMIO
> access dispatch can only access 4 bytes one time. This patch

32-bit

> fixes this to respect the spec.
> 
> Notice: here the 'min_access_size' is not a must, I set this
> for completement.

Which one? valid/impl? I think you can drop this comment from the commit
description.

> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/misc/edu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 91af452c9e..65fc32b928 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops = {
>      .read = edu_mmio_read,
>      .write = edu_mmio_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,

Per the spec, this is correct.

> +        .max_access_size = 8,

Correct.

> +    },
> +    .impl = {
> +        .min_access_size = 4,

OK.

> +        .max_access_size = 8,

Correct.

> +    },
> +
>  };
>  
>  /*
> 

With title/description updated:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
