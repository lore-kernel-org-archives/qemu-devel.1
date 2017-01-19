Received: from eggs.gnu.org ([2001:4830:134:3::10]:35774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUEWG-0002N4-52
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUEWF-0000Ic-B8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:20:56 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:35889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUEWF-0000IH-7A
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:20:55 -0500
Received: by mail-ua0-x229.google.com with SMTP id 96so35817307uaq.3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 07:20:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8b867af9-a039-f0de-9072-77c2a260ec23@redhat.com>
References: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
	<8b867af9-a039-f0de-9072-77c2a260ec23@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 15:20:34 +0000
Message-ID: <CAFEAcA8581hwSXXUSqLgFiJaFrfTTsnFJ0hwjD5neR_MJ5AtmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH v0] softfloat: Add round-to-odd
 rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 19 January 2017 at 14:47, Eric Blake <eblake@redhat.com> wrote:
> On 01/18/2017 11:14 PM, Bharata B Rao wrote:
>> round-to-odd mode is explained as under:
>>
>> Let Z be the intermediate arithmetic result or the operand of a convert
>> operation. If Z can be represented exactly in the target format, the
>> result is Z. Otherwise the result is either Z1 or Z2 whichever is odd.
>> Here Z1 and Z2 are the next larger and smaller numbers representable
>> in the target format respectively.
>
> IEEE 854 and thus POSIX <float.h> specifies round-to-zero,
> round-to-pos-inf, round-to-neg-inf, and round-to-even. It sounds like
> round-to-odd is similar to round-to-even, only that the ties are broken
> in the opposite direction.

No, round-to-even does "round ties to even" -- the rounding is
to the closest representable number, and only if the two
surrounding numbers are both equally near do we pick the even
one. round-to-odd is "always round to the odd number, even
if that's much further from the infinitely-precise result
than the even number is". (This is also sometimes called
von Neumann rounding or sticky rounding -- the motivation is
that you can for instance do 64bit -> 32bit -> 16bit
conversions in two steps without double rounding errors if
you do the first conversion with round-to-odd.)

thanks
-- PMM
