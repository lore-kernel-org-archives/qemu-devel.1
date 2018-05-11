Received: from eggs.gnu.org ([2001:4830:134:3::10]:40242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGxcR-0004kl-IY
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGxcO-0002yt-Df
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:17:15 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:34614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGxcO-0002vM-84
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:17:12 -0400
Received: by mail-pg0-x235.google.com with SMTP id g20-v6so1772063pgv.1
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 19:17:12 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<87wowsk1ih.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8979b195-d1b0-de1f-7cad-864982108610@linaro.org>
Date: Thu, 10 May 2018 19:17:07 -0700
MIME-Version: 1.0
In-Reply-To: <87wowsk1ih.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/9] target/arm: Fixups for
 ARM_FEATURE_V8_FP16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 04/27/2018 10:22 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> When running the gcc testsuite with current aarch64-linux-user,
>> the testsuite detects the presence of the fp16 extension and
>> enables lots of extra tests for builtins.
>>
>> Quite a few of these new tests fail because we missed implementing
>> some instructions.  We really should go back and verify that nothing
>> else is missing from this (rather large) extension.
> 
> So this set of instructions is generated from any ASL description that
> contains "half":

This still isn't all of them.  At least the insns from fmov_float_gen.html are
missing.  The four insns could be handled with

FMOV_H_general  A64_V sf:1 00 11110 11 100 11 o:1 000000 Rn:5 Rd:5

Peter had pointed out that I didn't handle sf=1 in fmov during review.


r~
