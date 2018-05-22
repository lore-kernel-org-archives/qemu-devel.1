Received: from eggs.gnu.org ([2001:4830:134:3::10]:47750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLA8c-0005D2-5A
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLA8Y-0005pF-Tz
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:27:50 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:34827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fLA8Y-0005oy-Ng
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:27:46 -0400
Received: by mail-pg0-x234.google.com with SMTP id 11-v6so6464691pge.2
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:27:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA-aD98+wh=XfMkY1iUwHjDJZ6dH7Juv0_o_VbgkcV0etw@mail.gmail.com>
	<214c47f3-1583-6480-4837-8b8ced37f038@twiddle.net>
	<CAFEAcA9QN_EFbfwqps+5Bu7CKX4J7GLGjBMURmk-1Jk22iixKA@mail.gmail.com>
	<7af06713-7e42-6489-5945-85545bc02f26@twiddle.net>
	<CAFEAcA90PcQH1Y-md7=dPTziP06ozripM7yPjqKJDgbk93gSzQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a801fc3e-2dc1-06de-1ec1-0b911ea29450@twiddle.net>
Date: Tue, 22 May 2018 09:27:43 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90PcQH1Y-md7=dPTziP06ozripM7yPjqKJDgbk93gSzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] TCG helpers that return f16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/22/2018 09:19 AM, Peter Maydell wrote:
> But what we actually have is
> target/arm/helper.c:float16 HELPER(recpe_f16)(float16 input, void *fpstp)
> target/arm/helper.c:float16 HELPER(vfp_sltoh)(uint32_t x, uint32_t
> shift, void *fpst)
> 
> (and others that you can find by grepping for "float16 HELPER") --
> the helpers don't return a uint32_t, they return float16.
> In fact if you try to make them return uint32_t then you get
> a compile error, because the DEF_HELPER_* macros prototype them
> as returning float16 when you say the return type is 'f16'.

Grr.  That is definitely not what I thought we were wiring up.

So, do you think it is sufficiently less confusing for developers within
target/* to have "f16" expand to "float16" as opposed to uint32_t?

It would be significant surgery within tcg to allow such types to be passed
down.  Although I've been wondering for some time if we might be able to handle
int128_t as a native tcg type, and that would require similar changes.


r~
