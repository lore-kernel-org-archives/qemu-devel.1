Received: from eggs.gnu.org ([2001:4830:134:3::10]:59686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drUY1-0007wh-My
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drUXw-0006nM-Qn
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:39:09 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:53928
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1drUXw-0006m7-Jz
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:39:04 -0400
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <6a9c81f3-bbe3-e177-1ede-ad0cf40fe553@weilnetz.de>
Date: Mon, 11 Sep 2017 21:39:01 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Am 11.09.2017 um 20:24 schrieb Peter Maydell:
> On 11 September 2017 at 19:01, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 09/10/2017 07:28 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> changed in 659ef5cbb893, this fixes building with --enable-tcg-interp=
reter:
>>>
>>> /home/travis/build/qemu/qemu/tcg/tcg.c:116:14: error: =E2=80=98tcg_ou=
t_ldst_finalize=E2=80=99 used but never defined [-Werror]
>>>  static bool tcg_out_ldst_finalize(TCGContext *s);
>>>               ^
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Oops.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> Applied to master as a buildfix, thanks.

Thank you, Peter.

> I've also turned on a tci compile check on my pre-merge tests.
> (It doesn't pass "make check" for me, though...)

I just tested it myself. "make check" passed, but printed some
KVM related messages which could be suppressed by fixing the
test code:

[...]
  GTESTER tests/test-qht-par
Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
[...]
Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
make: Verzeichnis =E2=80=9E/qemu/bin/=E2=80=9C wird verlassen

What failures do you get?

Regards,
Stefan
