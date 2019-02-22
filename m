Received: from eggs.gnu.org ([209.51.188.92]:53709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxHIx-0005j8-7X
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxHIv-0005K9-Ay
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:20:18 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxHIu-0005DH-UZ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:20:17 -0500
Received: by mail-pg1-x543.google.com with SMTP id 196so1586787pgf.13
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 12:20:11 -0800 (PST)
References: <20190222055950.17403-1-richard.henderson@linaro.org>
	<a46631f2-fc78-2f06-09f0-25b2563af52d@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eab85d35-87c5-bf23-20cc-87e334b79049@linaro.org>
Date: Fri, 22 Feb 2019 12:20:06 -0800
MIME-Version: 1.0
In-Reply-To: <a46631f2-fc78-2f06-09f0-25b2563af52d@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: Add vector opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au

On 2/22/19 9:13 AM, Mark Cave-Ayland wrote:
> On 22/02/2019 05:59, Richard Henderson wrote:
> 
>> This requires VSX, not just Altivec, so Power7 or later.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> At present there are no tunables that can avoid the 64-bit element
>> load/store requirement.  As with requiring AVX1 for x86 hosts, I'm
>> not sure it's worth inventing such a tunable for pre-power7 hosts.
>>
>> Tested vs aarch64 risu test cases.  It's probably worth testing
>> this vs Mark's target/ppc conversion.
> 
> Oooh this looks really exciting! However... I only have a G4 Mac Mini around that I
> use for testing which is Altivec-only :(  Is it much work to support non-VSX hosts?

Hmm, dunno.  I'll think about it.

> This leads me to a related point that came up when Howard and I were testing the PPC
> vector patches - how do we know at runtime which optimisations were being used, e.g.
> what is the value of have_avx2 on a particular CPU running QEMU?

There is no way from within qemu itself.

> Under Linux this isn't too bad since you can just do "cat /proc/cpuinfo | grep avx2"
> but it becomes more tricky when getting bug reports from Windows users who aren't
> particularly technical...

Something like:
https://www.intel.com/content/www/us/en/support/articles/000005651/processors.html

or any one of several other utilities that can display cpuid information.


r~
