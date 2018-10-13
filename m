Received: from eggs.gnu.org ([2001:4830:134:3::10]:49448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPg0-0001PY-QF
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPfu-0005Kn-7E
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:34:14 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBPft-0005J9-W9
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:34:10 -0400
Received: by mail-pl1-x641.google.com with SMTP id 30-v6so7409018plb.10
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 12:34:09 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-18-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2826c8b3-fcaf-d646-1153-801cc93eebc8@linaro.org>
Date: Sat, 13 Oct 2018 12:34:05 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-18-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/28] target/riscv: Convert quadrant 2 of
 RVXC insns to decodetree
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
> +@c_flwsp_ldsp   ... .  ..... ..... .. &c_flwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
> +    uimm_ldsp=%uimm_6bit_ld %rd
> +@c_fswsp_sdsp   ... .  ..... ..... .. &c_fswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
> +    uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5

I'm not especially keen about decoding the same bits twice.

I wonder if it's better to call the proper extract_foo function
within the trans_ function like you do elsewhere.  Written as

c_flwsp_ldsp	011 -  ----- ----- 10


r~
