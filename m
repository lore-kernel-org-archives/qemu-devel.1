Received: from eggs.gnu.org ([209.51.188.92]:59570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMEcI-0001W8-Vy
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMEcI-0005jV-7j
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:31:26 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMEcI-0005j5-0K
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:31:26 -0400
Received: by mail-pl1-x641.google.com with SMTP id y3so1282466plp.0
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 09:31:25 -0700 (PDT)
References: <20190430181326.1314-1-driver1998@foxmail.com>
	<6e3335b8-a5ce-ef0a-bf24-08165d877a2a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <31bdbd72-32af-1fc9-be06-3f1998062161@linaro.org>
Date: Thu, 2 May 2019 09:31:21 -0700
MIME-Version: 1.0
In-Reply-To: <6e3335b8-a5ce-ef0a-bf24-08165d877a2a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] util/cacheinfo.c: Use uintptr_t
 instead of unsigned long in AArch64 arch_cache_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org

On 5/2/19 1:26 AM, Thomas Huth wrote:
>> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>>  static void arch_cache_info(int *isize, int *dsize)
>>  {
>>      if (*isize == 0 || *dsize == 0) {
>> -        unsigned long ctr;
>> +        uintptr_t ctr;
> 
> Looking at the whole function, is uintptr_t really the right type to use
> here? ctr does not seem to contain the value of a pointer variable, so
> this looks wrong to me...
> Do you get a compiler warning here? If so, how does it look like?
> Anyway, I think it would be better to use a uint64_t or uint32_t type
> here instead if possible?

uint64_t is the proper type to use with MRS.


r~
