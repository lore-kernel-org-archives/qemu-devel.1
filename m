Received: from eggs.gnu.org ([2001:4830:134:3::10]:41955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1ea5LN-0000nH-0Y
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1ea5LI-0003yY-FL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:50:25 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1ea5LI-0003yG-8c
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 14:50:20 -0500
Received: by mail-pg0-x243.google.com with SMTP id q12so5215200pgt.7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 11:50:19 -0800 (PST)
Date: Fri, 12 Jan 2018 11:50:18 -0800 (PST)
In-Reply-To: <20180112080916.GA23324@lst.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-3ec1b94c-0c03-44b5-9223-a4ef67a957ef@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/21] RISC-V QEMU Port Submission v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Clark <mjc@sifive.com>, hch@lst.de, kbastian@mail.uni-paderborn.de, patches+subscribe@groups.riscv.org, qemu-devel@nongnu.org, sagark@eecs.berkeley.edu

On Fri, 12 Jan 2018 00:09:16 PST (-0800), hch@lst.de wrote:
> On Fri, Jan 12, 2018 at 07:24:54AM +1300, Michael Clark wrote:
>> I'm going to be restoring branches for bbl and riscv-linux that work again
>> priv 1.9.1. There are still other emulators and RTL that support priv1.9.1.
>> Folk will have silicon against different versions of spec going forward.
>> Likewise going forward we are still going to need to support v1.10 behavior
>> when v1.11 is published. i.e. priv v1.10 mode is going to have to hide any
>> additions made in priv v1.11. I use priv v1.9.1 during my QEMU testing.
>> Hopefully, future changes are additive vs breaking...
>
> That was the plan for 1.10+.  And I thought that was because 1.10
> is what people actually started implementing for real, but based on
> the comment from Palmer that is not actually true.  Sigh..
>
> I guess at least for Linux we'd then want to make sure 1.9.1 support
> is in mainline as well, probably based off a config option.

I suppose in theory yes, but as far as I know there's no 1.9.1 chips with MMUs

> And if someone has a a good contact to the RISC-V website admins
> it would be very helpful to restore a link to the specification as well
> so that things other than the direct link work.

I sent an email.
