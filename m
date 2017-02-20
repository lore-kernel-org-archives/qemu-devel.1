Received: from eggs.gnu.org ([2001:4830:134:3::10]:49972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfnHO-0000Kp-Dt
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfnHL-0008EZ-70
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:41:22 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:57504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cfnHK-0008E6-Sp
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:41:19 -0500
References: <20170219200231.30672-1-laurent@vivier.eu>
	<CAFEAcA-wewMTE0qP1VB1VSTk=mNhZKxpQfrC79twv7iFk+Nedg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <cbf02100-fe02-d7cd-e3a7-05149399198e@vivier.eu>
Date: Mon, 20 Feb 2017 13:41:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wewMTE0qP1VB1VSTk=mNhZKxpQfrC79twv7iFk+Nedg@mail.gmail.com>
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

Le 20/02/2017 à 13:14, Peter Maydell a écrit :
> On 19 February 2017 at 20:02, Laurent Vivier <laurent@vivier.eu> wrote:
>> f_fpregs is a 2d array, not 1d:
>>
>>  typedef struct fpregset
>>  {
>>    int f_pcr;
>>    int f_psr;
>>    int f_fpiaddr;
>>  #ifdef __mcoldfire__
>>    int f_fpregs[8][2];
>>  #else
>>    int f_fpregs[8][3];
>>  #endif
>>  } fpregset_t;
>>
>> For the moment, we don't manage ColdFire case, only 680x0.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> Thanks; applied to target-arm.next.
> 
> I've also pushed out support for building risu into a separate
> build directory, and a 'build-all-archs' script that will
> build every target CPU arch that you have a cross compiler
> installed for (Debian and Ubuntu package cross compilers for
> everything, helpfully).

Thank you.

I have some problems with risugen since some functions have been moved
to common:

$ ./risugen --numinsns 10000 --pattern ABCD m68k.risu ABCD.out
Generating code using patterns: ABCD M68000...
Syntax error detected evaluating ABCD M68000 constraints string:
    ]
{                         write_movb_di($Dx, rand(10) | (rand(10) <<
4));                         write_movb_di($Dy, rand(10) | (rand(10) <<
4));                         1;                      }
Undefined subroutine &risugen_common::write_movb_di called at (eval 5)
line 1.

If I add "risugen_m68k::" to the function name, it works. But is there
better solution to fix that instead of updating all the calls in
m68k.risu for functions found in risugen_m68k.pm?

Thanks,
Laurent
