Received: from eggs.gnu.org ([2001:4830:134:3::10]:33861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e5uPh-0002LF-05
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 10:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e5uPd-0005R5-QJ
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 10:06:08 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:42483)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1e5uPd-0005QP-Fm
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 10:06:05 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <87shf5zlty.fsf@frigg.lan>
	<20170929175943.GA25038@flamenco> <87vak1w53a.fsf@frigg.lan>
	<20170930180941.GA22048@flamenco> <8760bu333n.fsf@frigg.lan>
	<20171005005043.GA20425@flamenco> <87vajsl3h7.fsf@frigg.lan>
	<20171006175929.GA28281@flamenco> <87tvz08jc3.fsf@frigg.lan>
	<CAFEAcA8drKvtqmLNKx4oQs+zGUNBgnh3g9Q1X=TbPzoqT2iC2g@mail.gmail.com>
Date: Sat, 21 Oct 2017 17:05:46 +0300
In-Reply-To: <CAFEAcA8drKvtqmLNKx4oQs+zGUNBgnh3g9Q1X=TbPzoqT2iC2g@mail.gmail.com>
	(Peter Maydell's message of "Sun, 15 Oct 2017 17:47:21 +0100")
Message-ID: <877evo8ukl.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

Peter Maydell writes:

> On 15 October 2017 at 17:30, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wr=
ote:
>> Thinking about it, shouldn't this always be the same given QEMU's TLB/pa=
ge table
>> consistency assurances?

> What TLB/page table consistency assurances? For ARM at least
> we will only update (ie flush) the TLB when the guest next
> executes a relevant TLB maintenance instruction. So a
> misbehaving guest can set things up so the page table
> is completely different from what's in QEMU's TLB if it
> wants. This all falls in the realms of architecturally
> unpredictable behaviour for the guest -- whether you
> want the instrumentation to be confused as well is a
> different question...

I meant that if the contents of a virtual memory page change while QEMU is
translating an instruction, it must be able to detect that and act accordin=
gly
for correctness.

Having that in mind, the same should hold true when an instrumentor reads a
page's contents during translation (e.g., to gather information on opcodes).


Cheers,
  Lluis
