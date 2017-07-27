Received: from eggs.gnu.org ([2001:4830:134:3::10]:46590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daXRk-00079f-EP
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daXRh-0007aT-8y
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:18:36 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daXRh-0007aC-4i
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:18:33 -0400
Received: by mail-qk0-x244.google.com with SMTP id q66so17024631qki.1
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 18:18:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170726235614.14687-1-aurelien@aurel32.net>
	<20170726235614.14687-3-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dee17306-22f3-c8ac-f314-c27efe07e665@amsat.org>
Date: Wed, 26 Jul 2017 22:18:29 -0300
MIME-Version: 1.0
In-Reply-To: <20170726235614.14687-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 2/2] Revert "elf-loader: warn
 about invalid endianness"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 07/26/2017 08:56 PM, Aurelien Jarno wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> This reverts c8e1158cf611 "elf-loader: warn about invalid endianness"
> as it produces a useless message every time an LE kernel image is
> passed via -kernel on a ppc64-pseries machine. The pseries machine
> already checks for ELF_LOAD_WRONG_ENDIAN and tries with big_endian=0.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/core/loader.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index c17ace0a2e..e5e8cbb638 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -480,7 +480,6 @@ int load_elf_ram(const char *filename,
>       }
>   
>       if (target_data_order != e_ident[EI_DATA]) {
> -        fprintf(stderr, "%s: wrong endianness\n", filename);
>           ret = ELF_LOAD_WRONG_ENDIAN;
>           goto fail;
>       }
> 
