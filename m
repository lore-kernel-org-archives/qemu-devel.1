Received: from eggs.gnu.org ([2001:4830:134:3::10]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZhX6-00033f-Ty
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZhX5-0005NK-G3
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:24:56 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZhX5-0005N7-99
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:24:55 -0500
Received: by mail-ot0-x241.google.com with SMTP id 53so2901154otj.2
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:24:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180111075812.GA32651@lst.de>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
	<20180111075812.GA32651@lst.de>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 12 Jan 2018 07:24:54 +1300
Message-ID: <CAHNT7Ns+ye2djyqKqr2VmHkjgTLxqkkr6=JKL2B7HvnQm3xRGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/21] RISC-V QEMU Port Submission v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

We've been asked to address the spec versioning problem in QEMU.

I'm going to be restoring branches for bbl and riscv-linux that work again
priv 1.9.1. There are still other emulators and RTL that support priv1.9.1.
Folk will have silicon against different versions of spec going forward.
Likewise going forward we are still going to need to support v1.10 behavior
when v1.11 is published. i.e. priv v1.10 mode is going to have to hide any
additions made in priv v1.11. I use priv v1.9.1 during my QEMU testing.
Hopefully, future changes are additive vs breaking...

We don't want a repeat of recent RISC-V history where the old version is
deprecated and the new version is not yet implemented so that it's nearly
impossible to get a working configuration unless one knows some magic
commit hashes for a "moving target". We want to add some more rigor to the
versioning problem. In fact, device-tree should be frozen and versioned too
as it is only implicitly specified by the code that implements it.

On Thu, Jan 11, 2018 at 8:58 PM, Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Jan 10, 2018 at 03:46:19PM -0800, Michael Clark wrote:
> > - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
> > - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
> > - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10
>
> Same question as for V2:  Why do you want to add code for an obsolete
> version of the privileged ISA spec? (which as far as I can tell
> can't even be found online).
>
