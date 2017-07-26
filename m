Received: from eggs.gnu.org ([2001:4830:134:3::10]:51112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1daKlY-0007tG-L3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1daKlV-0006gR-Dv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:46:12 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:54750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1daKlV-0006fi-2U
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:46:09 -0400
References: <e071dd23-8d19-93ba-7962-b2e2df69a6ee@mail.uni-paderborn.de>
	<CAMU+Ekyxu9rwJ4s8xCGb87cSexfGweTmQ_Q7smLVWxjmbVqu_Q@mail.gmail.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <deabb08a-ed8d-55e0-ebd7-51302bf5260c@mail.uni-paderborn.de>
Date: Wed, 26 Jul 2017 13:45:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAMU+Ekyxu9rwJ4s8xCGb87cSexfGweTmQ_Q7smLVWxjmbVqu_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [sw-dev] RFC: QEMU RISC-V modular ISA decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Hoult <bruce@hoult.org>
Cc: RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

On 07/25/2017 06:37 PM, Bruce Hoult wrote:
> Do you have any good estimates for how much of the execution time is
> typically spent in instruction decode?
> 
> RISC-V qemu is twice as fast as ARM or Aarch64 qemu, so it's doing
> something right!
> 
> (I suspect it's probably mostly the lack of needing to emulate condition
> codes)

And most likely du to no overflow calculations. I don't expect
performance to be too big of an issue (I don't have hard data on that),
this was just the first thing that came to mind. I was rather hoping to
get some feedback from the s390x maintainers/qemu devs on other problems
I'm not seeing.

The important question to me: Is it worth it to refactor the code to
allow easy extensibility or not?

Cheers,
Bastian
