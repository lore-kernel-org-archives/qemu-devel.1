Received: from eggs.gnu.org ([2001:4830:134:3::10]:48718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d400I-00075f-CF
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d400F-0000Af-6a
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:07:46 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d400E-00009V-W5
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:07:43 -0400
Received: by mail-wm0-x22f.google.com with SMTP id u65so34344170wmu.1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 00:07:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-4-rth@twiddle.net> <874lx996hh.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <30d66407-ad33-bc8c-55c6-0a5d7009bed4@twiddle.net>
Date: Fri, 28 Apr 2017 09:07:38 +0200
MIME-Version: 1.0
In-Reply-To: <874lx996hh.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org

On 04/27/2017 06:10 PM, Alex Bennée wrote:
> 
> Richard Henderson <rth@twiddle.net> writes:
> 
>> We need to coordinate with the TCG_OVERSIZED_GUEST test in cputlb.c,
>> and allow 64-bit atomics even though sizeof(void *) == 4.
> 
> Hmm you say this here but we never actually do it. But the other changes
> seem fine.

I don't understand this comment.

>> +#if defined(__x86_64__) || defined(__sparc__)
>> +# define ATOMIC_REG_SIZE  8
>> +#else
>> +# define ATOMIC_REG_SIZE  sizeof(void *)
>> +#endif

How does this "never actually do it"?


r~
