Received: from eggs.gnu.org ([2001:4830:134:3::10]:52571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIG9e-0000IL-SX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIG9c-0008Ou-9O
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:16:54 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIG9c-0008OW-1t
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:16:52 -0400
Received: by mail-pg0-x242.google.com with SMTP id n9-v6so5688250pgq.5
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:16:51 -0700 (PDT)
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-3-richard.henderson@linaro.org>
	<CAFEAcA-pD9cqs1M=_eYohkfBkWZ0CQENmJ24VCZgKihkMVUDYQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9d8e92cc-3a6a-dad3-834b-468061c0a108@linaro.org>
Date: Mon, 14 May 2018 09:16:47 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-pD9cqs1M=_eYohkfBkWZ0CQENmJ24VCZgKihkMVUDYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/27] fpu/softfloat: Don't set Invalid
 for float-to-int(MAXINT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 05/14/2018 03:19 AM, Peter Maydell wrote:
> On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> wrote:
>> From: Peter Maydell <peter.maydell@linaro.org>
>>
>> In float-to-integer conversion, if the floating point input
>> converts exactly to the largest or smallest integer that
>> fits in to the result type, this is not an overflow.
>> In this situation we were producing the correct result value,
>> but were incorrectly setting the Invalid flag.
>> For example for Arm A64, "FCVTAS w0, d0" on an input of
>> 0x41dfffffffc00000 should produce 0x7fffffff and set no flags.
>>
>> Fix the boundary case to take the right half of the if()
>> statements.
>>
>> This fixes a regression from 2.11 introduced by the softfloat
>> refactoring.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: ab52f973a50
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> This is missing your Signed-off-by: line (and a reviewed-by
> would be nice too :-))

Dang it.  I thought I had done so for all of the patches.
Clearly missed one though.  For your target-arm.next branch:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
