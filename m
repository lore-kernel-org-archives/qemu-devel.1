Received: from eggs.gnu.org ([2001:4830:134:3::10]:55418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBO5S-00086I-3y
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBO5O-0001RM-T7
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:52:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBO5O-00017o-Fo
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 13:52:22 -0400
Received: by mail-pf1-x444.google.com with SMTP id 78-v6so5333220pfq.0
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 10:52:20 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-15-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b62f0701-8777-9c7d-1368-85b2bcc2176d@linaro.org>
Date: Sat, 13 Oct 2018 10:52:16 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-15-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/28] target/riscv: Convert RV priv insns
 to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
> +static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a,
> +                             uint32_t insn)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    gen_helper_tlb_flush(cpu_env);
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a, uint32_t insn)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    gen_helper_tlb_flush(cpu_env);
> +    return true;
> +#else
> +    return false;
> +#endif
> +}

Out of curiosity, are we missing a check for priv_ver in each of these?
If so it's missing in the original source, so definitely a different patch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
