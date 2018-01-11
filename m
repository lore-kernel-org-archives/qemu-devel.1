Received: from eggs.gnu.org ([2001:4830:134:3::10]:43271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZiW2-0000ei-Ta
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZiW2-0002Nf-3q
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:27:54 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:41215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZiW2-0002Mv-03
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:27:54 -0500
Received: by mail-ot0-x22b.google.com with SMTP id 44so2184987otk.8
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:27:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f82e02e3-40dd-8e74-6fe5-3205cdd42758@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<CAFEAcA9Qnj0G03x72BFLAYmodeBMDB=t3pz4JxUj0HvrbhkuGA@mail.gmail.com>
	<f82e02e3-40dd-8e74-6fe5-3205cdd42758@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 19:27:32 +0000
Message-ID: <CAFEAcA9eNzA9Yar4SC5UKWzMij0ypyXKATRqU1pVx8UTf33u7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 00/23] target/arm: decode generator and
 initial sve patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11 January 2018 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 01/11/2018 09:56 AM, Peter Maydell wrote:
>> On 18 December 2017 at 17:45, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> The most important part here, for review, is the first patch.
>>>
>>> I add a code generator, writen in python, which takes an input file
>>> that describes the opcode bits and field bits of the instructions,
>>> and outputs a function that does all of the decoding.
>>>
>>> The subsequent patches begin to add SVE support and also demonstrate
>>> how I envision how both the decoder and the tcg host vector support
>>> are to be used.  Thus, review of the direction would be appreciated
>>> before there are another 100 patches along the same style.
>>
>> This doesn't apply to master -- do you have an example of
>> what the generated code comes out like?
>
> That's why I gave you a link to a buildable branch on Tuesday.

tgt-arm-cplx ? I had a look at that but it seemed to be a different
set of patches to this lot.

thanks
-- PMM
