Received: from eggs.gnu.org ([209.51.188.92]:56702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqckL-0007jD-8n
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqcWQ-0004gd-CT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:34:44 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqcWK-0004Zn-84
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:34:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so13933079wrt.13
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:34:35 -0800 (PST)
References: <20190204052712.30833-1-richard.henderson@linaro.org>
	<20190204052712.30833-4-richard.henderson@linaro.org>
	<CABoDooOYVShpc+OAXVCnZ0CF2P1xqk=vEzOMsoxOiCzDjnkQjw@mail.gmail.com>
	<b84d3114-d046-ab9b-bb20-4098f7a5070e@linaro.org>
	<CAFEAcA8+FJ1SL4mB=hMQ8mLS4vkJr885=+kxD0chAHS-nBh_Dg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c1177c37-e8b3-a20f-6b8c-877ede487b19@linaro.org>
Date: Mon, 4 Feb 2019 11:34:31 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+FJ1SL4mB=hMQ8mLS4vkJr885=+kxD0chAHS-nBh_Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2/4/19 11:21 AM, Peter Maydell wrote:
> On Mon, 4 Feb 2019 at 10:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 2/4/19 8:00 AM, Laurent Desnogues wrote:
>>> The pseudo code asks for NaN inputs to return 0 since FPUnpack returns
>>> a value of 0 for NaN.
>>>
>>> The rest looks correct.
>>
>> So it does.  I apparently copied the INT_MAX thing from softfloat.c without
>> double-checking.
> 
> I'm a little surprised risu didn't catch that -- it's usually
> quite keen on checking NaN behaviour...

I'm not sure either...  Because of other issues, I regenerated the .bin file
and the nan case does trigger now.  I'm not sure what happened before.


r~
