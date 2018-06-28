Received: from eggs.gnu.org ([2001:4830:134:3::10]:37446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXd0-0006Fz-En
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXcv-0001Zy-M0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:10:30 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYXcv-0001Zm-Cp
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:10:25 -0400
Received: by mail-qk0-x243.google.com with SMTP id u21-v6so3033380qku.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:10:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
	<20180628030330.15615-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff0f60f7-a26d-a35b-5223-77a51a69d834@amsat.org>
Date: Thu, 28 Jun 2018 11:10:19 -0300
MIME-Version: 1.0
In-Reply-To: <20180628030330.15615-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 01/23] target/openrisc: Fix mtspr shadow
 gprs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shorne@gmail.com

On 06/28/2018 12:03 AM, Richard Henderson wrote:
> Missing break.

"when added in d89e71e873d"?

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/sys_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index b284064381..2f337363ec 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -98,6 +98,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
>      case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
>          idx = (spr - 1024);
>          env->shadow_gpr[idx / 32][idx % 32] = rb;
> +        break;
>  
>      case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
>          idx = spr - TO_SPR(1, 512);
> 
