Received: from eggs.gnu.org ([2001:4830:134:3::10]:50975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwgf-0006Yk-7r
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gEwgb-0002D1-87
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:25:33 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:44988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gEwga-00027y-WE
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:25:29 -0400
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-3-richard.henderson@linaro.org>
	<5e3ac38a-88df-c7dd-2f2e-72a17fa300e1@mail.uni-paderborn.de>
	<9a26b731-8a3d-5b3a-bad6-334501868894@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <2cf86fe8-8eff-5d7a-312d-f631aacfc5f0@mail.uni-paderborn.de>
Date: Tue, 23 Oct 2018 15:25:26 +0200
MIME-Version: 1.0
In-Reply-To: <9a26b731-8a3d-5b3a-bad6-334501868894@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com


On 10/23/18 3:08 PM, Richard Henderson wrote:
> On 10/23/18 2:04 PM, Bastian Koppelmann wrote:
>> On 10/23/18 2:04 PM, Richard Henderson wrote:
>>> ??? Needs simultaneous corresponding changes to all
>>> translators using decodetree.
>>> ---
>>>    scripts/decodetree.py | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>> Was the only intend of the insn argument to be used for manual decoding in a
>> trans_ function?
> I didn't quite know what it might be used for, and thought I was planning
> ahead.  Now I see that it's probably counter-productive.


Richard, can you pick up the first two patches together with the insn 
arg removal for openrisc and ARM, such that we don't break bisecting? I 
then squash the rest of the patches into my patch-set.

Cheers,

Bastian
