Received: from eggs.gnu.org ([2001:4830:134:3::10]:56615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e76iE-0006kc-4O
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 17:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e76iA-0006DK-1y
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 17:26:14 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:53475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e76i9-0006D0-QP
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 17:26:09 -0400
Received: by mail-wr0-x242.google.com with SMTP id u40so16165112wrf.10
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 14:26:09 -0700 (PDT)
References: <6968797c-f64c-69ff-2fa6-79c4fb3440c9@mail.uni-paderborn.de>
	<20171021064444.GJ30459@redhat.com>
	<978b4e0a-8a9c-68e9-5c3d-a1cca51b947c@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7e8f34bd-85a4-2c85-311b-52275c6b1719@linaro.org>
Date: Tue, 24 Oct 2017 23:25:58 +0200
MIME-Version: 1.0
In-Reply-To: <978b4e0a-8a9c-68e9-5c3d-a1cca51b947c@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [sw-dev] [RFC] RISC-V Decoder generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10/22/2017 03:22 PM, Bastian Koppelmann wrote:
> Hi Richard,
> 
> On 10/21/2017 08:44 AM, Richard W.M. Jones wrote:
>> On Fri, Oct 20, 2017 at 03:46:54PM +0200, Bastian Koppelmann wrote:
>>> I asked you for feedback some while ago regarding a modular RISC-V QEMU
>>> target (see discussion [1]). I tried getting it to work with the good
>>> old C preprocessor and quickly realized that it is too limiting. Instead
>>> I created a data-driven decoder generator written in python (see the
>>> code on github [2]) using YAML as a description language.
>>>
>>> I'd like to get some feedback whether this is acceptable to be
>>> upstreamed to QEMU or if you have any suggestions for improvements.
>>> Right now only RV32I instruction are implemented in this scheme.
>>
>> My suggestion would be to reimplement (part of) the s390x decoder
>> using this scheme.  That would give us a direct comparison of how your
>> scheme is better or worse than the existing macros.
> 
> Yeah that would be a great test. However I'm not sure if it's worth the
> effort. AFAIK s390x will not be extended with new instructions, so there
> is no need for a new scheme unless it helps making the code better
> maintainable. But that's up to the s390x maintainers.

s390x has been getting regular updates and new instructions.

However, s390x is much more regular in its opcode placement wrt the various
insn formats, so it's slightly easier to decode than riscv.

In addition, the s390x translator has more sophisticated handling of operands
and writeback than you have for riscv at present.  That is, where we indicate
that particular register or memory arguments should be loaded into TCG
temporaries; storing the result; computing the PSW flags; etc.  This is because
there are so many CISC instruction variants where arguments come from whereever.

So, really, I think it would be a large amount of work to extend this riscv
translator to handle s390x, and would largely be a waste.

It would perhaps more interesting to apply it to other risc targets.  But that
is surely out of scope for one patch set.


r~
