Received: from eggs.gnu.org ([2001:4830:134:3::10]:38139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dg7nx-0006SV-O1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dg7nw-0007dE-Ld
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:08:37 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:44648
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dg7nw-0007cu-ER
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:08:36 -0400
References: <3710e9b8-4b16-1bcc-da17-80fb2cc2c644@adacore.com>
	<CAFEAcA-WJizoHGftAaHgNTmL5kTXM-yyFZBxVRBHU_K4BQ6edQ@mail.gmail.com>
	<ec720f9e-664f-cd08-3db7-b744a4e065d1@adacore.com>
	<CAFEAcA8KpZaKn=+GOhu6kWfz5s+aEW7wiKFsgt3f2Q-OC0hRPA@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <e17fcc4c-34f1-157c-3848-11feba521eb5@adacore.com>
Date: Fri, 11 Aug 2017 13:08:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8KpZaKn=+GOhu6kWfz5s+aEW7wiKFsgt3f2Q-OC0hRPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] big endian arm.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>



On 08/11/2017 01:05 PM, Peter Maydell wrote:
> On 11 August 2017 at 12:03, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>> On 08/11/2017 12:18 PM, Peter Maydell wrote:
>>> That said, if you specify a BE elf file then we do
>>> set the SCTLR.EE and CPSR.E bits on reset in do_cpu_reset()
>>> (a change added in the commit you quote), which is probably
>>> why we haven't noticed the arm_cpu_reset() bug.
>>
>>
>> Yes that was what I saw. But seems the bits are not reset anymore
>> in do_cpu_reset() we probably lost that change.
> 
> hw/arm/boot.c do_cpu_reset() still has that code as of
> current master...
> 

oops sorry you're right was on the wrong branch..

Thanks!
Fred

> thanks
> -- PMM
> 
