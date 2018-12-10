Received: from eggs.gnu.org ([2001:4830:134:3::10]:45297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWR2v-00022m-Mw
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWR2p-0003z5-VA
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:16:48 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWR2o-0003xE-U2
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:16:43 -0500
Received: by mail-oi1-x243.google.com with SMTP id x23so9939507oix.3
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 11:16:41 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-4-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54550637-3a70-722f-a98f-6bd93958b644@linaro.org>
Date: Mon, 10 Dec 2018 13:16:37 -0600
MIME-Version: 1.0
In-Reply-To: <20181207085635.4291-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/6] target/ppc: introduce
 get_cpu_vsr{l, h}() and set_cpu_vsr{l, h}() helpers for VSR register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/7/18 2:56 AM, Mark Cave-Ayland wrote:
> +static inline void get_vsr(TCGv_i64 dst, int n)
> +{
> +    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[n]));
> +}
> +
> +static inline void set_vsr(int n, TCGv_i64 src)
> +{
> +    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n]));
> +}

Why isn't this helper still using cpu_vsr[n]?


r~
