Received: from eggs.gnu.org ([2001:4830:134:3::10]:46154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZicE-0005mc-T9
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZicB-00084h-Hb
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:34:18 -0500
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:38943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZicB-00084N-B7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:34:15 -0500
Received: by mail-pf0-x231.google.com with SMTP id e11so2427601pff.6
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:34:15 -0800 (PST)
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<CAFEAcA9Qnj0G03x72BFLAYmodeBMDB=t3pz4JxUj0HvrbhkuGA@mail.gmail.com>
	<f82e02e3-40dd-8e74-6fe5-3205cdd42758@linaro.org>
	<CAFEAcA9eNzA9Yar4SC5UKWzMij0ypyXKATRqU1pVx8UTf33u7Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <833c4229-7a78-849f-c17a-bfbef4506458@linaro.org>
Date: Thu, 11 Jan 2018 11:34:11 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9eNzA9Yar4SC5UKWzMij0ypyXKATRqU1pVx8UTf33u7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 01/11/2018 11:27 AM, Peter Maydell wrote:
> On 11 January 2018 at 19:23, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 01/11/2018 09:56 AM, Peter Maydell wrote:
>>> On 18 December 2017 at 17:45, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>> The most important part here, for review, is the first patch.
>>>>
>>>> I add a code generator, writen in python, which takes an input file
>>>> that describes the opcode bits and field bits of the instructions,
>>>> and outputs a function that does all of the decoding.
>>>>
>>>> The subsequent patches begin to add SVE support and also demonstrate
>>>> how I envision how both the decoder and the tcg host vector support
>>>> are to be used.  Thus, review of the direction would be appreciated
>>>> before there are another 100 patches along the same style.
>>>
>>> This doesn't apply to master -- do you have an example of
>>> what the generated code comes out like?
>>
>> That's why I gave you a link to a buildable branch on Tuesday.
> 
> tgt-arm-cplx ? I had a look at that but it seemed to be a different
> set of patches to this lot.

No, tgt-arm-sve-{1,2,3}.  All of them should build.

tgt-arm-cplx is the armv8.{1,3} stuff that's waiting on fp16 to go in.


r~
