Received: from eggs.gnu.org ([2001:4830:134:3::10]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d40bv-0005hz-9l
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d40bs-0002sI-5g
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:46:39 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d40br-0002r9-VW
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:46:36 -0400
Received: by mail-wm0-x233.google.com with SMTP id u65so35062891wmu.1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 00:46:35 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-4-rth@twiddle.net>
	<874lx996hh.fsf@linaro.org>
	<30d66407-ad33-bc8c-55c6-0a5d7009bed4@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <30d66407-ad33-bc8c-55c6-0a5d7009bed4@twiddle.net>
Date: Fri, 28 Apr 2017 08:47:05 +0100
Message-ID: <871ssd7z46.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 03/19] qemu/atomic: Loosen restrictions
 for 64-bit ILP32 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> On 04/27/2017 06:10 PM, Alex Bennée wrote:
>>
>> Richard Henderson <rth@twiddle.net> writes:
>>
>>> We need to coordinate with the TCG_OVERSIZED_GUEST test in cputlb.c,
>>> and allow 64-bit atomics even though sizeof(void *) == 4.
>>
>> Hmm you say this here but we never actually do it. But the other changes
>> seem fine.
>
> I don't understand this comment.
>
>>> +#if defined(__x86_64__) || defined(__sparc__)
>>> +# define ATOMIC_REG_SIZE  8
>>> +#else
>>> +# define ATOMIC_REG_SIZE  sizeof(void *)
>>> +#endif
>
> How does this "never actually do it"?

I meant this is independent of the definition of TCG_OVERSIZED_GUEST:

#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
#define TCG_OVERSIZED_GUEST 1
#else
#define TCG_OVERSIZED_GUEST 0
#endif

So maybe the comment should be clearer for ATOMIC_REG_SIZE that it
should match TCG_TARGET_REG_BITS (and therefore sync with
TCG_OVERSIZED_GUEST) in the atomic.h comment.

--
Alex Bennée
