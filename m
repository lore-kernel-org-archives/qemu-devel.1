Received: from eggs.gnu.org ([2001:4830:134:3::10]:52846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1ceeUm-0004jO-LN
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1ceeUj-00046N-Em
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:06:28 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <whitebox@nefkom.net>) id 1ceeUj-00046E-8u
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:06:25 -0500
From: Andreas Schwab <schwab@linux-m68k.org>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-16-laurent@vivier.eu>
	<ca2f9cdf-c18c-bc8a-05a7-05b1d9748a48@twiddle.net>
	<87poiiv3oz.fsf@linux-m68k.org>
	<93272090-e43c-d877-bd2b-49bc19d7175b@twiddle.net>
Date: Fri, 17 Feb 2017 10:06:20 +0100
In-Reply-To: <93272090-e43c-d877-bd2b-49bc19d7175b@twiddle.net> (Richard
	Henderson's message of "Fri, 17 Feb 2017 08:01:10 +1100")
Message-ID: <87zihl425v.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 15/16] target-m68k: add more FPU
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On Feb 17 2017, Richard Henderson <rth@twiddle.net> wrote:

> On 02/16/2017 09:18 PM, Andreas Schwab wrote:
>> There is no guarantee that the host long double has the same range and
>> precision as floatx80.
>
> Indeed not.  However, do you have another plan for implementing the
> trancendentals?  I'm quite happy using the host long double libm as an
> estimate.  Which is better than at least BasiliskII, which uses the host
> double.

In ARAnyM, I implemented a software emulation using mpfr (but it is
still incomplete in many ways).  I don't know if something like this
would be an option for qemu.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
