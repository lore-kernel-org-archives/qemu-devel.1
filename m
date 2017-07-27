Received: from eggs.gnu.org ([2001:4830:134:3::10]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dadHt-0008BQ-23
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dadHq-0007zt-Fl
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:32:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dadHq-0007yY-8y
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:32:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
	<CAMU+Ekyxu9rwJ4s8xCGb87cSexfGweTmQ_Q7smLVWxjmbVqu_Q@mail.gmail.com>
	<deabb08a-ed8d-55e0-ebd7-51302bf5260c@mail.uni-paderborn.de>
Date: Thu, 27 Jul 2017 09:32:35 +0200
In-Reply-To: <deabb08a-ed8d-55e0-ebd7-51302bf5260c@mail.uni-paderborn.de>
	(Bastian Koppelmann's message of "Wed, 26 Jul 2017 13:45:10 +0200")
Message-ID: <87h8xygwrw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [sw-dev] RFC: QEMU RISC-V modular ISA decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Bruce Hoult <bruce@hoult.org>, RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> On 07/25/2017 06:37 PM, Bruce Hoult wrote:
>> Do you have any good estimates for how much of the execution time is
>> typically spent in instruction decode?
>> 
>> RISC-V qemu is twice as fast as ARM or Aarch64 qemu, so it's doing
>> something right!
>> 
>> (I suspect it's probably mostly the lack of needing to emulate condition
>> codes)
>
> And most likely du to no overflow calculations. I don't expect
> performance to be too big of an issue (I don't have hard data on that),
> this was just the first thing that came to mind. I was rather hoping to
> get some feedback from the s390x maintainers/qemu devs on other problems
> I'm not seeing.
>
> The important question to me: Is it worth it to refactor the code to
> allow easy extensibility or not?

A common answer to "is it worth it?" is "someone showing up with the
work is a pretty strong indicator it is to him".
