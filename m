Received: from eggs.gnu.org ([2001:4830:134:3::10]:36317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSNoB-0002us-8Q
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSNo5-0007sN-Jp
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:00:51 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSNo4-0007pt-Rk
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:00:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id n133so2555444wmd.4
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 07:00:44 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-6-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123144558.5048-6-richard.henderson@linaro.org>
Date: Thu, 29 Nov 2018 15:00:41 +0000
Message-ID: <87y39c2ajq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 05/37] tcg/i386: Add constraints
 for r8 and r9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com


Richard Henderson <richard.henderson@linaro.org> writes:

> These are function call arguments for x86_64 we will need soon.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.inc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 4f66a0c5ae..8aef66e430 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -233,6 +233,14 @@ static const char *target_parse_constraint(TCGArgCon=
straint *ct,
>          ct->ct |=3D TCG_CT_REG;
>          tcg_regset_set_reg(ct->u.regs, TCG_REG_EDI);
>          break;
> +    case 'E': /* "Eight", r8 */
> +        ct->ct |=3D TCG_CT_REG;
> +        tcg_regset_set_reg(ct->u.regs, TCG_REG_R8);
> +        break;
> +    case 'N': /* "Nine", r9 */
> +        ct->ct |=3D TCG_CT_REG;
> +        tcg_regset_set_reg(ct->u.regs, TCG_REG_R9);
> +        break;

I would be nice to flesh out the missing comments in tcg.h:

#define TCG_CT_ALIAS  0x80
#define TCG_CT_IALIAS 0x40
#define TCG_CT_NEWREG 0x20 /* output requires a new register */
#define TCG_CT_REG    0x01
#define TCG_CT_CONST  0x02 /* any constant of register size */

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>      case 'q':
>          /* A register that can be used as a byte operand.  */
>          ct->ct |=3D TCG_CT_REG;


--
Alex Benn=C3=A9e
