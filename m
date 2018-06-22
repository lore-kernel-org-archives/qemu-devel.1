Received: from eggs.gnu.org ([2001:4830:134:3::10]:32870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWMNP-0001cO-DQ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWMNL-0005jB-Gw
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:45:23 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:44126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@mips.com>)
	id 1fWMNL-0005fi-BG
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:45:19 -0400
From: Aleksandar Markovic <Aleksandar.Markovic@mips.com>
Date: Fri, 22 Jun 2018 13:45:05 +0000
Message-ID: <459ac8395cf141369afb50ca48d78bfb@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>,
	<20180620120620.12806-2-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-2-yongbok.kim@mips.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/35] target/mips: Raise a RI when given
 fs is n/a from CTC1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <Yongbok.Kim@mips.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, James Hogan <James.Hogan@mips.com>, Paul Burton <Paul.Burton@mips.com>, Matthew Fortune <Matthew.Fortune@mips.com>, Stefan Markovic <Stefan.Markovic@mips.com>

> From: Yongbok Kim <yongbok.kim@imgtec.com>
>
> Fix to raise a Reserved Instruction exception when given fs is not
> available from CTC1.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>

Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

> ---
>  target/mips/op_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 9025f42..41d3634 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2627,6 +2627,9 @@ void helper_ctc1(CPUMIPSState *env, target_ulong ar=
g1, uint32_t fs, uint32_t rt)
>                 (env->active_fpu.fcr31 & ~(env->active_fpu.fcr31_rw_bitma=
sk));
>          break;
>      default:
> +        if (env->insn_flags & ISA_MIPS32R6) {
> +            do_raise_exception(env, EXCP_RI, GETPC());
> +        }
>          return;
>      }
>      restore_fp_status(env);
> --
> 1.9.1
