Received: from eggs.gnu.org ([2001:4830:134:3::10]:42805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJRFh-0001ey-3n
	for qemu-devel@nongnu.org; Thu, 17 May 2018 18:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJRFc-0007UF-1h
	for qemu-devel@nongnu.org; Thu, 17 May 2018 18:20:01 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJRFa-0007SE-W6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 18:19:55 -0400
Received: by mail-pl0-x243.google.com with SMTP id bi12-v6so3340268plb.12
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:19:54 -0700 (PDT)
References: <20180516155243.16937-1-richard.henderson@linaro.org>
	<20180516155243.16937-10-richard.henderson@linaro.org>
	<CAFEAcA-LJunrL8xeViCYujefSLxxx0kQXKM4zYHyw5xLka2vdw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <288813d7-acfa-a606-71c0-842f44d85259@linaro.org>
Date: Thu, 17 May 2018 15:19:50 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-LJunrL8xeViCYujefSLxxx0kQXKM4zYHyw5xLka2vdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 09/28] target/arm: convert conversion
 helpers to fpst/ahp_flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/17/2018 03:16 AM, Peter Maydell wrote:
> On 16 May 2018 at 16:52, Richard Henderson <richard.henderson@linaro.org> wrote:
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index 731cf327a1..613598d090 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
> 
> Just noticed, but in the 32-bit translator where the argument to
> get_fpstatus_ptr() is "is this neon?" (ie "do we use the standard
> FPSCR value"), shouldn't we be passing 'true' to get_fpstatus_ptr()
> for the halfprec conversions in disas_neon_data_insn() ?

Bah.  I went overboard with the aa64 fixups and forgot that aa32 hasn't had the
real fp16 extensions added.  I'll re-send.


r~
