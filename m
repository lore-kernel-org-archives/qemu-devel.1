Received: from eggs.gnu.org ([2001:4830:134:3::10]:47927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gRcSx-0000uw-FD
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gRcSs-0006nb-Ge
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:27:47 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:39753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gRcSs-0006mF-5N
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:27:42 -0500
References: <1540498768-8736-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540498768-8736-4-git-send-email-aleksandar.markovic@rt-rk.com>
	<03cea7f3-cbb7-6e4d-3104-01aba47cde09@weilnetz.de>
	<CAFEAcA_==cEJ0JTXdHZw3OVTywF0cJn_i62achSTLvSKA1OFoQ@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <81e0d483-f446-fbf1-e113-8fd845bcbbdd@weilnetz.de>
Date: Tue, 27 Nov 2018 13:27:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_==cEJ0JTXdHZw3OVTywF0cJn_i62achSTLvSKA1OFoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PULL 3/3] target/mips: Add disassembler support
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

Am 27.11.2018 um 12:24 schrieb Peter Maydell:
> On Thu, 8 Nov 2018 at 08:00, Stefan Weil <sw@weilnetz.de> wrote:
>> On 25.10.18 22:19, Aleksandar Markovic wrote:
>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>
>>> Add disassembler support for nanoMIPS.
>>>
>>> Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
>>> Signed-off-by: Matthew Fortune <matthew.fortune@mips.com>
>>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> ---
>>>  MAINTAINERS           |     2 +
>>>  configure             |     3 +
>>>  disas/Makefile.objs   |     1 +
>>>  disas/nanomips.cpp    | 22242 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  disas/nanomips.h      |  1099 +++
>>>  include/disas/bfd.h   |     1 +
>>>  include/exec/poison.h |     1 +
>>>  target/mips/cpu.c     |    13 +-
>>>  8 files changed, 23360 insertions(+), 2 deletions(-)
>>>  create mode 100644 disas/nanomips.cpp
>>>  create mode 100644 disas/nanomips.h
>>
>> Hi,
>>
>> the disassembler needs more work for the next QEMU release: it uses lots
>> of wrong format strings which will result in wrong output at least on
>> big endian hosts.
> Hi Stefan; by "for the next QEMU release" do you mean:
> (a) this is a release-critical bug which we need to fix for 3.1
> (b) this is not critical for this release, but we should
> fix it in the next release (4.0)
>
> ?
>
> thanks
> -- PMM


Hi Peter,

the fix is rather trivial. That's why I now have sent a patch series.

I'm not sure whether it should be handled as "release-critical". Big
endian Linux distributions would have a problem if users use nanomips
with the disassembler: I expect that numbers in the disassembler output
would be completely wrong.

There would be no crash, and I don't think that use case is very common,
so maybe a fix which avoids using 64 bit data types as suggested by
Aleksandar could be postponed until 4.0.

If you think that a fix for 3.1 would be better, you can use my fix. It
is also used in my builds for Windows.

Regards
Stefan
