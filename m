Received: from eggs.gnu.org ([209.51.188.92]:35818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLU7M-0002at-Dy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLU7L-0005db-Hm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:52:24 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:34630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLU7L-0005dA-8T
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:52:23 -0400
Received: by mail-pg1-x52b.google.com with SMTP id c13so5983790pgt.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:52:23 -0700 (PDT)
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-8-richard.henderson@linaro.org>
	<CAFEAcA-_OG6DKJCVqYahNOo_oMoiWSq0Tb7+dQhOGh3jFg01=g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9ac3730c-930b-fdaf-6271-e16c1a0b50aa@linaro.org>
Date: Tue, 30 Apr 2019 07:52:14 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-_OG6DKJCVqYahNOo_oMoiWSq0Tb7+dQhOGh3jFg01=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/26] target/i386: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 4/30/19 4:49 AM, Peter Maydell wrote:
>> --- a/target/i386/mem_helper.c
>> +++ b/target/i386/mem_helper.c
>> @@ -191,24 +191,3 @@ void helper_boundl(CPUX86State *env, target_ulong a0, int v)
>>          raise_exception_ra(env, EXCP05_BOUND, GETPC());
>>      }
>>  }
>> -
>> -#if !defined(CONFIG_USER_ONLY)
>> -/* try to fill the TLB and return an exception if error. If retaddr is
>> - * NULL, it means that the function was called in C code (i.e. not
>> - * from generated code or from helper.c)
>> - */
>> -/* XXX: fix it to restore all registers */
> 
> Is this XXX comment definitely stale ?

This is a pre-TCG comment, from 61382a500a9 ("full softmmu support"), from
2003.  It has only been moved around since.  I can only imagine what problem
Fabrice might have been reminding himself.


r~
