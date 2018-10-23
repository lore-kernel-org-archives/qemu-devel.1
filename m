Received: from eggs.gnu.org ([2001:4830:134:3::10]:46292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEwQT-0005Xc-3R
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEwQO-0008AU-4K
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:08:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEwQN-00089N-O2
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:08:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id q6-v6so1634423wrw.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 06:08:43 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-3-richard.henderson@linaro.org>
	<5e3ac38a-88df-c7dd-2f2e-72a17fa300e1@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a26b731-8a3d-5b3a-bad6-334501868894@linaro.org>
Date: Tue, 23 Oct 2018 14:08:37 +0100
MIME-Version: 1.0
In-Reply-To: <5e3ac38a-88df-c7dd-2f2e-72a17fa300e1@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/7] decodetree: Remove "insn" argument
 from trans_* expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 10/23/18 2:04 PM, Bastian Koppelmann wrote:
> On 10/23/18 2:04 PM, Richard Henderson wrote:
>> ??? Needs simultaneous corresponding changes to all
>> translators using decodetree.
>> ---
>>   scripts/decodetree.py | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
> 
> Was the only intend of the insn argument to be used for manual decoding in a
> trans_ function?

I didn't quite know what it might be used for, and thought I was planning
ahead.  Now I see that it's probably counter-productive.

In particular, think of how you were calling the trans_foo functions yourself,
passing along the uint16_t input to the uint32_t output.  Which would have
worked not at all had you actually been using it for decode within the insn32
code base.


r~
