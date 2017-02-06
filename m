Received: from eggs.gnu.org ([2001:4830:134:3::10]:52612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <er209@kent.ac.uk>) id 1cagKM-00078h-Jt
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <er209@kent.ac.uk>) id 1cagKJ-0004Cl-Uf
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:15:18 -0500
Received: from mx4.kent.ac.uk ([129.12.21.35]:35905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <er209@kent.ac.uk>) id 1cagKJ-0004Cd-PO
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:15:15 -0500
Date: Mon, 06 Feb 2017 10:14:48 +0000
In-Reply-To: <20170203144615.GD642@stefanha-x1.localdomain>
References: <24f4e37d0c554e379d13a13026efb36f@ex13-live-mbn2.ad.kent.ac.uk>
	<20170203144615.GD642@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ed Robbins <er209@kent.ac.uk>
Message-ID: <40A49F91-60AF-4CDF-B2B6-B6DC2E93EF78@kent.ac.uk>
Subject: Re: [Qemu-devel] TCG semantics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 3 February 2017 14:46:15 GMT+00:00, Stefan Hajnoczi <stefanha@gmail=2Ec=
om> wrote:
>On Thu, Feb 02, 2017 at 12:09:02PM +0000, E=2ERobbins wrote:
>> I having been looking for prior work on a formalised semantics for
>the TCG language=2E I have seen passing references, and wondered if
>anyone can provide any pointers?
>>=20
>> If this is the wrong list for this question, apologies, please direct
>me elsewhere=2E
>
>This is the right list=2E  Welcome!
>

Thanks!

>Have you seen tcg/README?  It describes the TCG ops=2E
>

Yes, but was hoping for something a bit more precise, with a memory model =
etc=2E However, it isn't too much work to build one from the readme=2E

>If it's out of date or missing information, then improving the document
>seems worthwhile=2E

It seems pretty good=2E I was surprised that call instructions can have ar=
guments/return specified, and wonder if those are normally just empty, so t=
hat emulation of the target stack/registers just carries the args/return in=
 the background=2E Otherwise TCG must be detecting the target's arguments/r=
eturn for each call which would need a clever dataflow analysis, or to foll=
ow calling convention and just hope, right?

I also am not clear about the precise operation of the byte swap instructi=
on, but guess it follows the x86 bswap semantics=2E

I expect I can answer these questions by looking at some TCG output or che=
cking the code, though (I don't want to waste anyone's time with that)=2E

Thanks,
Ed
