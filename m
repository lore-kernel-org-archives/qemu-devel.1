Received: from eggs.gnu.org ([2001:4830:134:3::10]:46996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR25q-0003JV-DY
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR25m-0004pY-Sw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:32:58 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR25m-0004pA-Nb
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:32:54 -0500
Received: by mail-qt0-x243.google.com with SMTP id g10so21609886qtj.12
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 12:32:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
	<20171218171758.16964-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0d130927-7779-76ba-8c4e-4c7e7310fa7f@amsat.org>
Date: Mon, 18 Dec 2017 17:32:50 -0300
MIME-Version: 1.0
In-Reply-To: <20171218171758.16964-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 04/26] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 12/18/2017 02:17 PM, Richard Henderson wrote:
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 96316700dd..3ff4dea6b8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -492,7 +492,7 @@ typedef struct CPUARMState {
>           * the two execution states, and means we do not need to explicitly
>           * map these registers when changing states.
>           */
> -        float64 regs[64];
> +        float64 regs[64] QEMU_ALIGNED(16);
>  
>          uint32_t xregs[16];
>          /* We store these fpcsr fields separately for convenience.  */
> 
