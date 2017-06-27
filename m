Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPtkm-000719-Kk
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPtTo-0008MR-2C
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:36:47 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPtTn-0008MA-UU
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:36:43 -0400
Received: by mail-qt0-x241.google.com with SMTP id c20so4421313qte.0
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:36:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-8-rth@twiddle.net> <87wp7xx1et.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6225c2e2-d3a6-403e-fd99-cd053a859c1b@twiddle.net>
Date: Tue, 27 Jun 2017 09:36:40 -0700
MIME-Version: 1.0
In-Reply-To: <87wp7xx1et.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/16] tcg: Return NULL temp for
 TCG_CALL_DUMMY_ARG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net

On 06/27/2017 01:47 AM, Alex Bennée wrote:
> 
> Richard Henderson <rth@twiddle.net> writes:
> 
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   tcg/tcg.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tcg/tcg.h b/tcg/tcg.h
>> index 3b35344..6c357e7 100644
>> --- a/tcg/tcg.h
>> +++ b/tcg/tcg.h
>> @@ -730,7 +730,7 @@ extern bool parallel_cpus;
>>
>>   static inline TCGTemp *arg_temp(TCGArg a)
>>   {
>> -    return &tcg_ctx.temps[a];
>> +    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
>>   }
> 
> It doesn't look like a lot of calls to arg_temp are able to deal with a
> NULL return and may well immediately deref the value. Are we sure the
> cases the TCG_CALL_DUMMY arg is involved are narrowly defined?

They only appear as arguments to a call opcode.


r~
