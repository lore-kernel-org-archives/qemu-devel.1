Received: from eggs.gnu.org ([2001:4830:134:3::10]:56977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZdCo-0000lX-V0
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 10:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZdCl-0002rF-QT
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 10:19:58 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZdCl-0002qn-Hn
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 10:19:55 -0400
Received: by mail-pl0-x244.google.com with SMTP id 31-v6so6700890plc.4
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 07:19:55 -0700 (PDT)
References: <20180701081245.14357-1-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d336819e-ab5c-2c36-e1c2-9ac1b306c8ae@linaro.org>
Date: Sun, 1 Jul 2018 07:19:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180701081245.14357-1-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/openrisc: Fix writes to interrupt
 mask register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: davidsondfgl@gmail.com, Richard Henderson <rth@twiddle.net>

On 07/01/2018 01:12 AM, Stafford Horne wrote:
> The interrupt controller mask register (PICMR) allows writing any value
> to any of the 32 interrupt mask bits.  Writing a 0 masks the interrupt
> writing a 1 unmasks (enables) the the interrupt.
> 
> For some reason the old code was or'ing the write values to the PICMR
> meaning it was not possible to ever mask a interrupt once it was
> enabled.
> 
> I have tested this by running linux 4.18 and my regular checks, I don't
> see any issues.
> 
> Reported-by: Davidson Francis <davidsondfgl@gmail.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  target/openrisc/sys_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
