Received: from eggs.gnu.org ([2001:4830:134:3::10]:48048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1flNV7-0002XQ-MF
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 19:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1flNV2-0000nh-Rs
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 19:59:25 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:54723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1flNV2-0000nZ-KF
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 19:59:20 -0400
Received: by mail-it0-x244.google.com with SMTP id s7-v6so6090734itb.4
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 16:59:20 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mhng-7a78b931-d225-4006-bbc7-707c9d471ef0@palmer-si-x1c4>
Date: Thu, 2 Aug 2018 19:59:17 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CD3DD6C-8FE0-4D25-884C-E2CCFEC5E0B4@gmail.com>
References: <mhng-7a78b931-d225-4006-bbc7-707c9d471ef0@palmer-si-x1c4>
Subject: Re: [Qemu-devel] RISC-V platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: alistair23@gmail.com, alistair.francis@wdc.com, qemu-devel@nongnu.org


> On Aug 2, 2018, at 5:07 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>=20
> On Fri, 29 Jun 2018 14:20:34 PDT (-0700), alistair23@gmail.com wrote:
>> On Fri, Jun 29, 2018 at 2:05 PM, G 3 <programmingkidx@gmail.com> =
wrote:
>>> Hi, I noticed your RISC-V patches on the mailing list and had a =
question
>>> that I think you may be able to answer. Has anyone defined a RISC-V =
platform
>>> yet? What I mean is defining what devices would be found on a RISC-V
>>> motherboard. I do hope to see RISC-V based desktop systems one day. =
But
>>> before that day can come the platform for this chip would have to be
>>> established. Could the SiFive board be the basis for such a =
standard?
>>=20
>> It really depends what you mean by a standard platform. At the moment
>> the SiFive HiFive Unleased board is the only ASIC that can boot =
Linux.
>> So that really is the "standard" RISC-V board. It is a pretty basic
>> embedded board though, so it can't be considered a "standard" RISC-V
>> desktop. There is a virt board in QEMU (which is similar to the =
HiFive
>> Unleashed) that is a good go to for QEMU work.
>=20
> The HiFive Unleashed is the defacto standard RISC-V embedded Linux =
platform right now, but there will be a RISC-V platform specification =
that defines proper standard platforms of various types.  This effort =
hasn't been started yet, but it should be done sooner rather than later.

I definitely agree it should come soon. I realize the QEMU community =
could start this effort rather easily by developing a machine and then =
porting software to it. I'm thinking something easy we could do is take =
the IBM PC standard and apply it with a RISC-V CPU. Hardware vendors =
could then take that emulated machine and turn it into a real machine. =
Linux distros could then be made to run on this platform. The future =
looks exciting for this CPU.=
