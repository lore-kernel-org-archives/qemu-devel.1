Received: from eggs.gnu.org ([2001:4830:134:3::10]:60769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVInv-0000vh-HE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVInr-0004vd-9e
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:39:51 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVInr-0004up-3f
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:39:47 -0400
Received: by mail-wr0-x232.google.com with SMTP id k67so36252124wrc.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:39:46 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-8-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-8-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 15:39:44 +0100
Message-ID: <87k23d90sv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/22] tcg/i386: constify
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
>  tcg/i386/tcg-target.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 01e3b4e..06df01a 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -2514,7 +2514,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>      return NULL;
>  }
>
> -static int tcg_target_callee_save_regs[] = {
> +static const int tcg_target_callee_save_regs[] = {
>  #if TCG_TARGET_REG_BITS == 64
>      TCG_REG_RBP,
>      TCG_REG_RBX,


--
Alex Bennée
