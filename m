Received: from eggs.gnu.org ([2001:4830:134:3::10]:46782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1e6H52-0004a9-0U
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1e6H4x-0001NC-2Y
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:18:19 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:35436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1e6H4w-0001Mo-O3
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:18:15 -0400
References: <6968797c-f64c-69ff-2fa6-79c4fb3440c9@mail.uni-paderborn.de>
	<20171021064444.GJ30459@redhat.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <978b4e0a-8a9c-68e9-5c3d-a1cca51b947c@mail.uni-paderborn.de>
Date: Sun, 22 Oct 2017 15:22:49 +0200
MIME-Version: 1.0
In-Reply-To: <20171021064444.GJ30459@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [sw-dev] [RFC] RISC-V Decoder generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Richard,

On 10/21/2017 08:44 AM, Richard W.M. Jones wrote:
> On Fri, Oct 20, 2017 at 03:46:54PM +0200, Bastian Koppelmann wrote:
>> I asked you for feedback some while ago regarding a modular RISC-V QEMU
>> target (see discussion [1]). I tried getting it to work with the good
>> old C preprocessor and quickly realized that it is too limiting. Instead
>> I created a data-driven decoder generator written in python (see the
>> code on github [2]) using YAML as a description language.
>>
>> I'd like to get some feedback whether this is acceptable to be
>> upstreamed to QEMU or if you have any suggestions for improvements.
>> Right now only RV32I instruction are implemented in this scheme.
> 
> My suggestion would be to reimplement (part of) the s390x decoder
> using this scheme.  That would give us a direct comparison of how your
> scheme is better or worse than the existing macros.

Yeah that would be a great test. However I'm not sure if it's worth the
effort. AFAIK s390x will not be extended with new instructions, so there
is no need for a new scheme unless it helps making the code better
maintainable. But that's up to the s390x maintainers.

> 
> Will you be at the KVM Forum next week?

No, sorry. I'm at the verge of graduating from University, so my time is
very limited right now :(

Cheers,
Bastian
