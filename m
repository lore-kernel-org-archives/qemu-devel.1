Received: from eggs.gnu.org ([2001:4830:134:3::10]:58270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZ39p-0004IM-0V
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 19:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZ39k-0003qv-Qm
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 19:22:44 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZ39k-0003qb-Ib
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 19:22:40 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so14080952wrt.13
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:22:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181217170000.4884-1-aleksandar.markovic@rt-rk.com>
	<20181217170000.4884-4-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <53ec4cc4-29b8-002c-5622-c5e48ee8cd02@amsat.org>
Date: Tue, 18 Dec 2018 01:22:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181217170000.4884-4-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] MAINTAINERS: target/mips: Reorder
 items alphabetically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

On 12/17/18 6:00 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Reorder items alphabetically for better visibility.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  MAINTAINERS | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3dda82d31e..0909a24e97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -207,18 +207,18 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Maintained
>  F: target/mips/
>  F: default-configs/*mips*
> +F: disas/mips.c
> +F: disas/nanomips.cpp
> +F: disas/nanomips.h

All match disas/*mips*

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +F: hw/intc/mips_gic.c
>  F: hw/mips/
>  F: hw/misc/mips_*
> -F: hw/intc/mips_gic.c
>  F: hw/timer/mips_gictimer.c
> +F: include/hw/intc/mips_gic.h
>  F: include/hw/mips/
>  F: include/hw/misc/mips_*
> -F: include/hw/intc/mips_gic.h
>  F: include/hw/timer/mips_gictimer.h
>  F: tests/tcg/mips/
> -F: disas/mips.c
> -F: disas/nanomips.h
> -F: disas/nanomips.cpp
>  K: ^Subject:.*(?i)mips?
>  
>  Moxie
> 
