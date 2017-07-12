Received: from eggs.gnu.org ([2001:4830:134:3::10]:53488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVMhL-0000jG-IA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVMhI-0002zo-HZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:49:19 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVMhI-0002yz-Bu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:49:16 -0400
Received: by mail-qt0-x244.google.com with SMTP id m54so3231960qtb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 11:49:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CGME20170712135227eucas1p1d5baf43182869329c6dd282e52143444@eucas1p1.samsung.com>
	<002201d2fb16$189c1460$49d43d20$@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <69582ade-1afa-d2e0-ec06-069676d43499@amsat.org>
Date: Wed, 12 Jul 2017 15:49:12 -0300
MIME-Version: 1.0
In-Reply-To: <002201d2fb16$189c1460$49d43d20$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] tcg/tci: Remove unnecessary TODO() for
 INDEX_op_bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jaroslaw Pelczar <j.pelczar@samsung.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>

Hi Jaroslaw,

Thank for reporting this, however this fix has been reviewed:
http://patchwork.ozlabs.org/patch/781982/

On 07/12/2017 10:52 AM, Jaroslaw Pelczar wrote:
> Running Ubuntu with systemd on AArch64 Cortex-A53 and qemu is compiled
> with
> 
> ./configure --target-list=aarch64-softmmu --enable-tcg-interpreter
> 
> System gives the following log:
> 
> Welcome to Ubuntu 16.04.1 LTS!
> 
> systemd[1]: Set hostname to <localhost.localdomain>.
> TODO (...)/qemu/tcg/tci.c:1049: tcg_qemu_tb_exec()
> (...)/qemu/tcg/tci.c:1049: tcg fatal error
> Aborted (core dumped)
> 
> After investigation it turns out that TCG generates bswap16_i64
> opcode, which looks fine in the implementation.

Indeed while correctly implemented, "that code part was simply never 
executed, and [Stefan] only removed the TODO() statements from tested 
code." as explained Stefan.

> Signed-off-by: Jaroslaw Pelczar <j.pelczar@samsung.com>

I can add your Signed-off-by there if you mind

> ---
>   tcg/tci.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tcg/tci.c b/tcg/tci.c
> index 4bdc645..f39bfb9 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -1046,7 +1046,6 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t
> *tb_ptr)
>               break;
>   #if TCG_TARGET_HAS_bswap16_i64
>           case INDEX_op_bswap16_i64:
> -            TODO();
>               t0 = *tb_ptr++;
>               t1 = tci_read_r16(&tb_ptr);
>               tci_write_reg64(t0, bswap16(t1));
> 

Regards,

Phil.
