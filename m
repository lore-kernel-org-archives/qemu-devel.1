Received: from eggs.gnu.org ([2001:4830:134:3::10]:37042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <er209@kent.ac.uk>) id 1cagza-0002KG-Oh
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <er209@kent.ac.uk>) id 1cagzX-0000gL-NC
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:57:54 -0500
Received: from mx4.kent.ac.uk ([129.12.21.35]:52503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <er209@kent.ac.uk>) id 1cagzX-0000g9-Hm
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:57:51 -0500
Date: Mon, 06 Feb 2017 10:57:42 +0000
In-Reply-To: <CAFEAcA_ePwJUVrEh=jXu9Mup=zRwH=CWTjJsKcT7p7tA41ndtw@mail.gmail.com>
References: <24f4e37d0c554e379d13a13026efb36f@ex13-live-mbn2.ad.kent.ac.uk>
	<20170203144615.GD642@stefanha-x1.localdomain>
	<40A49F91-60AF-4CDF-B2B6-B6DC2E93EF78@kent.ac.uk>
	<CAFEAcA_ePwJUVrEh=jXu9Mup=zRwH=CWTjJsKcT7p7tA41ndtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ed Robbins <er209@kent.ac.uk>
Message-ID: <A01BDA8C-E7A1-47CD-AFE8-3C863ECE3383@kent.ac.uk>
Subject: Re: [Qemu-devel] TCG semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 6 February 2017 10:39:11 GMT+00:00, Peter Maydell <peter=2Emaydell@lina=
ro=2Eorg> wrote:
>On 6 February 2017 at 10:14, Ed Robbins <er209@kent=2Eac=2Euk> wrote:
>> It seems pretty good=2E I was surprised that call instructions can
>> have arguments/return specified, and wonder if those are normally
>> just empty, so that emulation of the target stack/registers just
>> carries the args/return in the background=2E Otherwise TCG must be
>> detecting the target's arguments/return for each call which would
>> need a clever dataflow analysis, or to follow calling convention
>> and just hope, right?
>
>"target" is a tricky word here, because it's unclear whether it
>means the guest or the host CPU architecture=2E Note that tcg/README
>always means "TCG target" (ie host) when it says "target", as
>per section 2=2E
>
>The "call" instruction is a call to a host function, so the
>only calling convention in play is the host OS's ABI=2E (This
>is what we use for calling C helper functions to implement
>more complex bits of the guest emulation=2E) We don't know or
>care about the guest's calling convention, because TCG only
>sees things at the level of guest instructions and registers=2E
>

Makes sense, thanks for clearing that up=2E

>> I also am not clear about the precise operation of the byte
>> swap instruction, but guess it follows the x86 bswap semantics=2E
>
>Er, there's more than one definition of how to do byteswaps?
>These instructions just swap the bytes in the however-many-bytes
>wide lump of data they're defined to operate on=2E (If the
>value type is wider than that lump of data then the insns
>are allowed to assume the high bytes are zeroes, ie undefined
>result if they're not=2E) Happy to take patches for clarifying
>the docs, though=2E
>

Maybe there's only one way it's done, but it's good to be clear on the pre=
cise operation=2E

Thanks,
Ed
