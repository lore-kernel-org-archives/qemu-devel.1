Received: from eggs.gnu.org ([2001:4830:134:3::10]:54678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVL1u-0003j0-1J
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVL1q-0000jO-4R
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:02:26 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVL1p-0000jG-VW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:02:22 -0400
Received: by mail-qk0-f194.google.com with SMTP id 16so4793990qkg.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 10:02:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-9-git-send-email-cota@braap.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <61a98594-7fcb-04b6-e94b-2ceb30bd519f@amsat.org>
Date: Wed, 12 Jul 2017 14:01:17 -0300
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-9-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/22] tcg/mips: constify
 tcg_target_callee_save_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/09/2017 04:50 AM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tcg/mips/tcg-target.inc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 8cff9a6..790b4fc 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -2323,7 +2323,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>       return NULL;
>   }
>   
> -static int tcg_target_callee_save_regs[] = {
> +static const int tcg_target_callee_save_regs[] = {
>       TCG_REG_S0,       /* used for the global env (TCG_AREG0) */
>       TCG_REG_S1,
>       TCG_REG_S2,
> 
