Received: from eggs.gnu.org ([2001:4830:134:3::10]:57753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfnho-0005ke-Py
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:08:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfnhl-0002XM-Jn
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:08:40 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cfnhl-0002WK-8g
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:08:37 -0500
References: <20170219200231.30672-1-laurent@vivier.eu>
	<CAFEAcA-wewMTE0qP1VB1VSTk=mNhZKxpQfrC79twv7iFk+Nedg@mail.gmail.com>
	<cbf02100-fe02-d7cd-e3a7-05149399198e@vivier.eu>
	<CAFEAcA9z_KLEKouw18wwrxm9DCAUz62K1SpADEgoYyWFzVQDgQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <40fc984e-d9b2-5040-967d-af5bd9f9d032@vivier.eu>
Date: Mon, 20 Feb 2017 14:08:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9z_KLEKouw18wwrxm9DCAUz62K1SpADEgoYyWFzVQDgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] risu-m68k: update fpregs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Le 20/02/2017 à 13:49, Peter Maydell a écrit :
> On 20 February 2017 at 12:41, Laurent Vivier <laurent@vivier.eu> wrote:
>> I have some problems with risugen since some functions have been moved
>> to common:
>>
>> $ ./risugen --numinsns 10000 --pattern ABCD m68k.risu ABCD.out
>> Generating code using patterns: ABCD M68000...
>> Syntax error detected evaluating ABCD M68000 constraints string:
>>     ]
>> {                         write_movb_di($Dx, rand(10) | (rand(10) <<
>> 4));                         write_movb_di($Dy, rand(10) | (rand(10) <<
>> 4));                         1;                      }
>> Undefined subroutine &risugen_common::write_movb_di called at (eval 5)
>> line 1.
>>
>> If I add "risugen_m68k::" to the function name, it works. But is there
>> better solution to fix that instead of updating all the calls in
>> m68k.risu for functions found in risugen_m68k.pm?
> 
> Oops, that was unintended. We definitely don't want to require
> decorating all the function calls in the .risu files. Reverting
> commit 6a3647ae8918 should fix this, but I'll see if there's
> a way to avoid the code duplication without the problem with
> evaluation happening in the "wrong" module scope.

Reverting 6a3647ae8918 actually fixes the problem.

Thanks,
Laurent
