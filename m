Received: from eggs.gnu.org ([2001:4830:134:3::10]:47248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDWrR-0003rs-Ne
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDWrM-00028w-Fv
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:38:49 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDWrM-0001oD-5q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:38:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id 23-v6so15917773pgc.8
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:38:33 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-17-kbastian@mail.uni-paderborn.de>
	<ed4c028f-12b8-d940-c4ce-49b59c36a06e@linaro.org>
	<86d7b325-80e1-1783-fb9b-b2071f1795cc@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <18e0d466-2f16-d85c-fa4a-50c85df1bddb@linaro.org>
Date: Fri, 19 Oct 2018 08:38:29 -0700
MIME-Version: 1.0
In-Reply-To: <86d7b325-80e1-1783-fb9b-b2071f1795cc@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/28] target/riscv: Convert quadrant 1 of
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

On 10/19/18 8:28 AM, Bastian Koppelmann wrote:
> 
> On 10/13/18 8:53 PM, Richard Henderson wrote:
>> On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
>>> +static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a, uint16_t insn)
>>> +{
>>> +    if (a->imm == 0) {
>>> +        return true;
>>> +    }
>> return false, I think.
> 
> 
> Those are HINTS, which means the instruction in valid, but does not affect
> state, so true is correct. If I do return false, then Linux does not boot
> anymore :)

Ah, this information is not present in the main body of the text, only in table
12.5.  It might be good to add comments to the code here.

Thanks.


r~
