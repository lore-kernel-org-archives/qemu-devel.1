Received: from eggs.gnu.org ([2001:4830:134:3::10]:59159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fvTHo-0003ko-Dj
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 16:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fvTHj-00088G-As
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 16:11:24 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fvTHj-000882-37
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 16:11:19 -0400
Received: by mail-pg1-x542.google.com with SMTP id r1-v6so4364614pgp.11
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 13:11:18 -0700 (PDT)
References: <20180828130041.26445-1-jancraig@amazon.com>
	<20180828130041.26445-5-jancraig@amazon.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <663ffd8f-f8b2-772f-006c-eca366bc333e@linaro.org>
Date: Thu, 30 Aug 2018 13:11:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180828130041.26445-5-jancraig@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/8] target/mips: Add MXU instruction
 S8LDD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com

On 08/28/2018 06:00 AM, Craig Janeczek via Qemu-devel wrote:
> +    case 6: /* XRa = {{8{sign of tmp8}}, tmp8, {8{sign of tmp8}}, tmp8} */
> +        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_SB);
> +        tcg_gen_mov_tl(t0, t1);
> +        tcg_gen_andi_tl(t0, t0, 0xFF00FFFF);
> +        tcg_gen_shli_tl(t1, t1, 16);
> +        tcg_gen_or_tl(t0, t0, t1);
> +        break;

 tcg_gen_deposit_tl(t0, t1, t1, 16, 16);


r~
