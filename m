Received: from eggs.gnu.org ([2001:4830:134:3::10]:56713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cF5Tt-0001e6-D4
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cF5Tq-0008AX-B3
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:39:53 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cF5Tq-0008AG-4H
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:39:50 -0500
Received: by mail-wm0-f52.google.com with SMTP id t79so44200266wmt.0
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 12:39:49 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-24-git-send-email-rth@twiddle.net>
	<8760muz6bu.fsf@linaro.org>
	<121c5948-5cab-f4b7-d88b-0fe4d689c474@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <121c5948-5cab-f4b7-d88b-0fe4d689c474@twiddle.net>
Date: Thu, 08 Dec 2016 20:38:47 +0000
Message-ID: <87zik6xijs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 23/64] tcg: Allow an operand to be
 matching or a constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 12/08/2016 09:19 AM, Alex Bennée wrote:
>>
>> Richard Henderson <rth@twiddle.net> writes:
>>
>>> This allows an output operand to match an input operand
>>> only when the input operand needs a register.
>>>
>>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>>
>> It's hard to offer anything more than a mechanical review for this as
>> the constraints aren't intuitive to me (I guess not as a gcc hacker!).
>
> It's even more confusing for a gcc hacker, as we don't have a concept of
> alternatives.  You get one set of constraints.
>
>> Could we either expand the documentation of constraints in tcg/README
>> with a summary of the global ones?
>
> There's only one global constraint: 'i'.  So... sure, but I don't know how much
> that will help.

So what do 0..9 and & mean? Or do you mean they are only constraints
applied by the backend?

--
Alex Bennée
