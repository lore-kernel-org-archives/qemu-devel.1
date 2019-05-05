Received: from eggs.gnu.org ([209.51.188.92]:43912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNItE-0003OB-NN
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNItD-0002es-SO
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:17:20 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNItD-0002dX-KL
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:17:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id z28so5385199pfk.0
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:17:19 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-15-mark.cave-ayland@ilande.co.uk>
	<3c05b552-a692-e439-fc28-90ad69767cf2@linaro.org>
	<e8968236-5ab2-568f-fd32-e9208c0f2ebe@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0e80eda-9f10-f39f-708a-1dc08575bd9b@linaro.org>
Date: Sun, 5 May 2019 08:17:15 -0700
MIME-Version: 1.0
In-Reply-To: <e8968236-5ab2-568f-fd32-e9208c0f2ebe@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/14] target/ppc: improve VSX_FMADD with
 new GEN_VSX_HELPER_VSX_MADD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 5/5/19 3:20 AM, Mark Cave-Ayland wrote:
>> The afrm argument is no longer used.
>> This also means that e.g.
>>
>> VSX_MADD(xsmaddadp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 0)
>> VSX_MADD(xsmaddmdp, 1, float64, VsrD(0), MADD_FLGS, 0, 1, 0)
>>
>> are redundant.  Similarly with all of the other pairs.
> 
> Agreed. What do you think is the best solution here - maybe a double macro that looks
> something like this?
> 
> #define VSX_MADD(op, prec, nels, tp, fld, maddflgs, sfprf, r2sp)
> _VSX_MADD(op##aprec, nels, tp, fld, maddflgs, sfprf, r2sp)
> _VSX_MADD(op##mprec, nels, tp, fld, maddflgs, sfprf, r2sp)
> 
> VSX_MADD(xsmadd, dp, 1, float64, VsrD(0), MADD_FLGS, 1, 0)

I have no idea what you're suggesting.

I am suggesting one function, xsmadddp, replacing xsmaddadp + xsmaddmdp, that
is used by both instructions.


r~
