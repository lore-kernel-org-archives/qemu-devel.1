Received: from eggs.gnu.org ([2001:4830:134:3::10]:50811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL8j3-0004QX-O3
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL8iy-0006Oa-6c
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:57:21 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:33913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL8iy-0006OR-1L
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:57:16 -0400
Received: by mail-oi0-x236.google.com with SMTP id l1-v6so16490102oii.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 07:57:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <214c47f3-1583-6480-4837-8b8ced37f038@twiddle.net>
References: <CAFEAcA-aD98+wh=XfMkY1iUwHjDJZ6dH7Juv0_o_VbgkcV0etw@mail.gmail.com>
	<214c47f3-1583-6480-4837-8b8ced37f038@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 15:56:54 +0100
Message-ID: <CAFEAcA9QN_EFbfwqps+5Bu7CKX4J7GLGjBMURmk-1Jk22iixKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] TCG helpers that return f16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 22 May 2018 at 15:55, Richard Henderson <rth@twiddle.net> wrote:
> On 05/22/2018 07:50 AM, Peter Maydell wrote:
>> Hi; I was reading about the x86-64 calling convention and I found
>> out that apparently for returns of smaller-than-register types the
>> high parts may contain garbage:
>> https://stackoverflow.com/questions/36706721/is-a-sign-or-zero-extension-required-when-adding-a-32bit-offset-to-a-pointer-for/36760539#36760539
>
> Yes, that's one reason I didn't want to get involved in returning a "real"
> 16-bit quantity.
>
>> However, for TCG helper functions, although we allow the helper
>> macro to say that the return type is 'f16', in helper-head.h we
>> seem to just alias f16 as i32, and in dh_sizemask() we only record
>> "is this 64 bits" and "is this signed". Am I missing the place
>> where we zero-extend the value we get back from the helper so
>> that it's the right thing in TCG's i32 ?
>
> It happens in C, implicit in "typedef uint16_t float16".

...but uint16_t is only 16 bits, so we are returning
a "real" 16 bit quantity?

thanks
-- PMM
