Received: from eggs.gnu.org ([209.51.188.92]:38696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gi57O-0002Hl-FD
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gi57I-0004Cf-VC
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:17:32 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gi577-000499-UZ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 17:17:21 -0500
Received: by mail-pf1-x443.google.com with SMTP id b7so7573168pfi.8
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 14:17:15 -0800 (PST)
References: <20190111220131.27153-1-jcmvbkbc@gmail.com>
	<2064503c-ed12-de29-59a9-46fa24d22f60@linaro.org>
	<CAMo8BfJaTbO0LSBWk7+WeFw7Oc6Sy2ykxaQcWTBeVGCdN9+aOg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cdaaa0bc-8282-6a92-886a-7dd5f2adfa46@linaro.org>
Date: Sat, 12 Jan 2019 09:17:08 +1100
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJaTbO0LSBWk7+WeFw7Oc6Sy2ykxaQcWTBeVGCdN9+aOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/xtensa: rework zero overhead
 loops implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 1/12/19 9:14 AM, Max Filippov wrote:
>>> +        /*
>>> +         * 0 in the csbase_lend field means that there may not be a loopback
>>> +         * for any instruction that starts inside this page. Any other value
>>> +         * means that an instruction that ends at this offset from the page
>>> +         * start may loop back.
>>
>> Nit: s/may/will/g
>>
>> Using "may" makes it seem like we may have missed a case that should have
>> looped back.
> 
> Using "will" makes it seem like it always loops back, but it doesn't do it
> when LCOUNT is 0.

Err, no, you covered that in the first sentence, where 0 means that it will not
loop back.


r~
