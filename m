Received: from eggs.gnu.org ([2001:4830:134:3::10]:40574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eosrJ-0004iS-BE
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eosrG-0000Zj-8h
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:32:33 -0500
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:41923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eosrG-0000ZK-1R
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:32:30 -0500
Received: by mail-pg0-x231.google.com with SMTP id q27so526171pgn.8
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:32:29 -0800 (PST)
References: <20180217164037.15727-1-richard.henderson@linaro.org>
	<20180217164037.15727-3-richard.henderson@linaro.org>
	<CAFEAcA8NvZeD_eXCvP8NyA8usVy+fPKkcVnqgvnDddcNhZCLHQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <af7f0c19-5c80-3124-e2ba-e454db06ad5a@linaro.org>
Date: Thu, 22 Feb 2018 07:32:25 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8NvZeD_eXCvP8NyA8usVy+fPKkcVnqgvnDddcNhZCLHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] tcg: Add missing tcg_can_emit_vec_op
 check in tcg_gen_gvec_2s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 02/22/2018 06:58 AM, Peter Maydell wrote:
> Incidentally, I notice that the condition checks
>      (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)
>       && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))
> 
>      (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)
>       && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))
> 
>      (TCG_TARGET_HAS_v64 && check_size_impl(oprsz, 8)
>       && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))
> 
> seem to be quite commonly used -- perhaps factoring these out
> into suitably named functions would make the code more readable?

That's a good idea.  I'll see what I can come up with there.


r~
