Received: from eggs.gnu.org ([2001:4830:134:3::10]:32956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVIp2-000286-IT
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVIoy-0005WY-S1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:41:00 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVIoy-0005W0-J4
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:40:56 -0400
Received: by mail-wr0-f177.google.com with SMTP id c11so36325269wrc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:40:56 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-9-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-9-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 15:39:53 +0100
Message-ID: <87inix90sm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/mips/tcg-target.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 8cff9a6..790b4fc 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -2323,7 +2323,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>      return NULL;
>  }
>
> -static int tcg_target_callee_save_regs[] = {
> +static const int tcg_target_callee_save_regs[] = {
>      TCG_REG_S0,       /* used for the global env (TCG_AREG0) */
>      TCG_REG_S1,
>      TCG_REG_S2,


--
Alex Bennée
