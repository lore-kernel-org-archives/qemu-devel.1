Received: from eggs.gnu.org ([209.51.188.92]:34416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLsvP-0002XU-Cv
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLsvL-00054B-MX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hLsvJ-0004ox-NI
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so4298110pfa.3
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:21:32 -0700 (PDT)
Date: Wed, 01 May 2019 10:21:29 -0700 (PDT)
In-Reply-To: <03ac8b9b-20ae-e6ec-5647-f679471f4d3b@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-c095a304-dace-4b99-8dc6-7a179a3f80bb@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/riscv: Add checks for several
 RVC reserved operands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org

On Thu, 25 Apr 2019 10:32:43 PDT (-0700), richard.henderson@linaro.org wrote:
> On 4/25/19 10:26 AM, Richard Henderson wrote:
>>  {
>> +  illegal         011 0  -----  00000 01 # c.addi16sp, RES nzimm=0
>>    addi            011 .  00010  ..... 01 @c_addi16sp
>>    lui             011 .  .....  ..... 01 @c_lui
>>  }
>
> Bah.  I just realized the comment should be more like
>
>   # c.addi16sp and c.lui, RES nzimm=0
>
> Otherwise one is led to believe that rd=2 is missing
> from the illegal pattern.

OK, I went ahead and squashed in that fix as well.
