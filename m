Received: from eggs.gnu.org ([209.51.188.92]:36696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjX81-0005U9-UL
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjX80-0001AG-Rr
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:24:13 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:45044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjX80-00015D-GU
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:24:12 -0500
Received: by mail-pf1-x42f.google.com with SMTP id u6so1974644pfh.11
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 14:24:06 -0800 (PST)
References: <cover.1547510220.git.alistair.francis@wdc.com>
	<b17f45cb9053318f20ca2a5b2167afa96c1f933a.1547510220.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <62009a7b-877b-9c7d-7844-4eaa1930e9ff@linaro.org>
Date: Wed, 16 Jan 2019 09:23:59 +1100
MIME-Version: 1.0
In-Reply-To: <b17f45cb9053318f20ca2a5b2167afa96c1f933a.1547510220.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/8] RISC-V: Add priv_ver to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 1/15/19 10:58 AM, Alistair Francis wrote:
> -static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
> +static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)

Why change this?  I know there is variation in the naming, but my
preferred default mapping is CPUState *cs, RISCVCPU *cpu.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
