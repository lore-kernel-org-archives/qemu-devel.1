Received: from eggs.gnu.org ([209.51.188.92]:56912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJhaA-0004qQ-UT
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJha9-0003dv-Uf
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:50:46 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJha9-0003bc-KI
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:50:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id f36so79550plb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:50:45 -0700 (PDT)
References: <mhng-f65ff93d-20e5-4c4a-919a-c311ae97649d@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <357d260b-4baf-aea8-c332-f77ce2a3e9b2@linaro.org>
Date: Thu, 25 Apr 2019 09:50:41 -0700
MIME-Version: 1.0
In-Reply-To: <mhng-f65ff93d-20e5-4c4a-919a-c311ae97649d@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 4/8] target/riscv: Merge argument
 decode for RVC shifti
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
>>  # *** RV64C Standard Extension (Quadrant 2) ***
>> -c_slli            000 .  .....  ..... 10 @c_shift2
>> +slli              000 .  .....  ..... 10 @c_shift2
> 
> This is another one where rd=0 is illegal in the compressed ISA, but again we
> don't appear to handle these correctly before the cleanups.

I see "HINT, rd=0" in the 2.2 documentation for this case.


r~
