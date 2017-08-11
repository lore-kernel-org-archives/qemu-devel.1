Received: from eggs.gnu.org ([2001:4830:134:3::10]:37364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dg7lN-0005EN-K0
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dg7lM-0006Jw-Lp
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:05:57 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dg7lM-0006Iz-E4
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:05:56 -0400
Received: by mail-wr0-x236.google.com with SMTP id y43so12234779wrd.3
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 04:05:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ec720f9e-664f-cd08-3db7-b744a4e065d1@adacore.com>
References: <3710e9b8-4b16-1bcc-da17-80fb2cc2c644@adacore.com>
	<CAFEAcA-WJizoHGftAaHgNTmL5kTXM-yyFZBxVRBHU_K4BQ6edQ@mail.gmail.com>
	<ec720f9e-664f-cd08-3db7-b744a4e065d1@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2017 12:05:34 +0100
Message-ID: <CAFEAcA8KpZaKn=+GOhu6kWfz5s+aEW7wiKFsgt3f2Q-OC0hRPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] big endian arm.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 11 August 2017 at 12:03, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
> On 08/11/2017 12:18 PM, Peter Maydell wrote:
>> That said, if you specify a BE elf file then we do
>> set the SCTLR.EE and CPSR.E bits on reset in do_cpu_reset()
>> (a change added in the commit you quote), which is probably
>> why we haven't noticed the arm_cpu_reset() bug.
>
>
> Yes that was what I saw. But seems the bits are not reset anymore
> in do_cpu_reset() we probably lost that change.

hw/arm/boot.c do_cpu_reset() still has that code as of
current master...

thanks
-- PMM
