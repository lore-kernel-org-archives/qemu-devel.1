Received: from eggs.gnu.org ([2001:4830:134:3::10]:50994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEwgh-0006ZZ-Lv
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEwgd-0002KS-NM
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:25:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEwgd-0002F3-Gg
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:25:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so1698649wrw.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 06:25:31 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-3-richard.henderson@linaro.org>
	<5e3ac38a-88df-c7dd-2f2e-72a17fa300e1@mail.uni-paderborn.de>
	<9a26b731-8a3d-5b3a-bad6-334501868894@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <05807e1f-b196-d56e-62c1-8303754b7ade@redhat.com>
Date: Tue, 23 Oct 2018 15:25:00 +0200
MIME-Version: 1.0
In-Reply-To: <9a26b731-8a3d-5b3a-bad6-334501868894@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Richard Henderson <richard.henderson@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: peer.adelt@hni.uni-paderborn.de, mjc@sifive.com, palmer@sifive.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu

On 23/10/18 15:08, Richard Henderson wrote:
> On 10/23/18 2:04 PM, Bastian Koppelmann wrote:
>> On 10/23/18 2:04 PM, Richard Henderson wrote:
>>> ??? Needs simultaneous corresponding changes to all
>>> translators using decodetree.
>>> ---
>>>    scripts/decodetree.py | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>
>> Was the only intend of the insn argument to be used for manual decoding in a
>> trans_ function?
> 
> I didn't quite know what it might be used for, and thought I was planning
> ahead.  Now I see that it's probably counter-productive.

I agree.

> 
> In particular, think of how you were calling the trans_foo functions yourself,
> passing along the uint16_t input to the uint32_t output.  Which would have
> worked not at all had you actually been using it for decode within the insn32
> code base.
> 
> 
> r~
> 
