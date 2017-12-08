Received: from eggs.gnu.org ([2001:4830:134:3::10]:38931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eNQJY-0000wT-Eq
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 16:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eNQJX-0002r6-Lp
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 16:36:12 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eNQJX-0002qT-GS
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 16:36:11 -0500
Received: by mail-pg0-x241.google.com with SMTP id y6so7670782pgp.4
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 13:36:11 -0800 (PST)
References: <20171121212534.5177-1-richard.henderson@linaro.org>
	<20171121212534.5177-22-richard.henderson@linaro.org>
	<alpine.DEB.2.20.1712051427000.7159@bulbul.intra.ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a284d37f-2c5d-5dbb-ab0f-522891aea2eb@linaro.org>
Date: Fri, 8 Dec 2017 13:36:07 -0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1712051427000.7159@bulbul.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 21/26] tcg: Add generic vector ops for
 multiplication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: qemu-devel@nongnu.org

On 12/05/2017 03:33 AM, Kirill Batuzov wrote:
> On Tue, 21 Nov 2017, Richard Henderson wrote:
> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
>> +{
>> +    TCGTemp *rt = tcgv_vec_temp(r);
>> +    TCGTemp *at = tcgv_vec_temp(a);
>> +    TCGTemp *bt = tcgv_vec_temp(b);
>> +    TCGArg ri = temp_arg(rt);
>> +    TCGArg ai = temp_arg(at);
>> +    TCGArg bi = temp_arg(bt);
>> +    TCGType type = rt->base_type;
>> +    int can;
>> +
>> +    tcg_debug_assert(at->base_type == type);
>> +    tcg_debug_assert(bt->base_type == type);
>> +    can = tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece);
> 
> Should be INDEX_op_mul_vec in the line above.

Fixed, thanks.


r~
