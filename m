Received: from eggs.gnu.org ([2001:4830:134:3::10]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSmY6-0004Wl-1V
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSmY1-0002ay-43
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:25:54 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSmY0-0002aT-TV
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:25:49 -0500
Received: by mail-wm1-x343.google.com with SMTP id z18so6609182wmc.4
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:25:48 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-11-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123144558.5048-11-richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 17:25:46 +0000
Message-ID: <87r2f232at.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 10/37] tcg/aarch64: Add
 constraints for x0, x1, x2
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

> These are function call arguments that we will need soon.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.inc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 30091f6a69..148de0b7f2 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -125,6 +125,18 @@ static const char *target_parse_constraint(TCGArgCon=
straint *ct,
>                                             const char *ct_str, TCGType t=
ype)
>  {
>      switch (*ct_str++) {
> +    case 'a': /* x0 */
> +        ct->ct |=3D TCG_CT_REG;
> +        tcg_regset_set_reg(ct->u.regs, TCG_REG_X0);
> +        break;
> +    case 'b': /* x1 */
> +        ct->ct |=3D TCG_CT_REG;
> +        tcg_regset_set_reg(ct->u.regs, TCG_REG_X1);
> +        break;
> +    case 'c': /* x2 */
> +        ct->ct |=3D TCG_CT_REG;
> +        tcg_regset_set_reg(ct->u.regs, TCG_REG_X2);
> +        break;
>      case 'r': /* general registers */
>          ct->ct |=3D TCG_CT_REG;
>          ct->u.regs |=3D 0xffffffffu;


--
Alex Benn=C3=A9e
