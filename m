Received: from eggs.gnu.org ([2001:4830:134:3::10]:54871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dkavc-00017D-3M
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dkavY-0004jL-7L
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:03:00 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:37887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dkavY-0004i9-0Z
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:02:56 -0400
Received: by mail-pg0-x234.google.com with SMTP id y129so3667199pgy.4
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 12:02:54 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-9-richard.henderson@linaro.org>
	<87valf4ub7.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <afa5cbde-a5e9-0ae3-5532-2073c3a90a57@linaro.org>
Date: Wed, 23 Aug 2017 12:02:47 -0700
MIME-Version: 1.0
In-Reply-To: <87valf4ub7.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 8/8] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 08/22/2017 06:15 AM, Alex Bennée wrote:
>> +#ifndef have_avx2
>> +        /* There are a number of things we must check before we can be
>> +           sure of not hitting invalid opcode.  */
>> +        if (c & bit_OSXSAVE) {
>> +            unsigned xcrl, xcrh;
>> +            asm ("xgetbv" : "=a" (xcrl), "=d" (xcrh) : "c" (0));
>> +            if (xcrl & 6 == 6) {
> 
> My picky compiler complains:
> 
> /home/alex/lsrc/qemu/qemu.git/tcg/i386/tcg-target.inc.c: In function ‘tcg_target_init’:
> /home/alex/lsrc/qemu/qemu.git/tcg/i386/tcg-target.inc.c:3053:22: error: suggest parentheses around comparison in operand of ‘&’ [-Werror=parentheses]
>              if (xcrl & 6 == 6) {


Bah.  I forgot that my default build uses -march=native, and my laptop has
AVX2, so this bit wouldn't have been compile tested at all.

Fixed on the branch.


r~
