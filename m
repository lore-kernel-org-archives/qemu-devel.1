Received: from eggs.gnu.org ([2001:4830:134:3::10]:34871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fZ0pH-0004d2-VQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fZ0pH-0003iQ-30
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:21:07 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:43942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fZ0pG-0003h3-R3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:21:07 -0400
Received: by mail-lj1-x241.google.com with SMTP id h2-v6so5092867ljb.10
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 14:21:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DB74515-B3DF-41FD-AB1A-1364CE376FB2@gmail.com>
References: <4DB74515-B3DF-41FD-AB1A-1364CE376FB2@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 Jun 2018 14:20:34 -0700
Message-ID: <CAKmqyKNmBeY0BZNuQ3o+XTzdtN6QCm8qPhi1VHz4XTNg=Q3=Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] RISC-V platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Jun 29, 2018 at 2:05 PM, G 3 <programmingkidx@gmail.com> wrote:
> Hi, I noticed your RISC-V patches on the mailing list and had a question
> that I think you may be able to answer. Has anyone defined a RISC-V platform
> yet? What I mean is defining what devices would be found on a RISC-V
> motherboard. I do hope to see RISC-V based desktop systems one day. But
> before that day can come the platform for this chip would have to be
> established. Could the SiFive board be the basis for such a standard?

It really depends what you mean by a standard platform. At the moment
the SiFive HiFive Unleased board is the only ASIC that can boot Linux.
So that really is the "standard" RISC-V board. It is a pretty basic
embedded board though, so it can't be considered a "standard" RISC-V
desktop. There is a virt board in QEMU (which is similar to the HiFive
Unleashed) that is a good go to for QEMU work.

Alistair
