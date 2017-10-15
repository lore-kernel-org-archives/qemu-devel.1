Received: from eggs.gnu.org ([2001:4830:134:3::10]:38172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3m80-0003iM-Cv
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3m7z-0004IT-Po
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:51:04 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:48471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e3m7z-0004H9-JM
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:51:03 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i124so29308818wmf.3
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 09:51:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAF6HrYzSiw+NzKBP1QGK794+tcyZTK21XVsDXEpjF2-bD-9z3Q@mail.gmail.com>
References: <CAF6HrYzSiw+NzKBP1QGK794+tcyZTK21XVsDXEpjF2-bD-9z3Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 15 Oct 2017 17:50:41 +0100
Message-ID: <CAFEAcA-Um7zYLeSzFfSSL-nRsRKyRbKEwb2MEzcsGqoQDSuRqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Reading and writing functions for QEMU emulated
 peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ramy Sameh <ramysameh26@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mona Safar <Mona.Safar@eng.asu.edu.eg>, Ahmed Aly <ahmedaly50@gmail.com>, Watheq <watheq@gmail.com>

On 15 October 2017 at 17:47, Ramy Sameh <ramysameh26@gmail.com> wrote:
> I was tracking the calling of function pl011_read, and I noticed that it is
> called from function *memory_region_read_accessor *in memory.c
>
> I also noticed that all peripherals reading functions (e.g. pl050_read,
> pl190_read ... etc) in the emulated VersatilePB board, are called from the
> same location in *memory_region_read_accessor.*
>
> *My question is*: Is this calling procedure done for the emulated
> VersatilePB board *only*, or this is the case for the peripherals in all
> emulated systems ?

Broadly speaking, yes, all peripheral device read and write
functions are invoked via the memory subsystem code (which
is the part of QEMU that figures out what memory region
covers whatever the physical address that the guest wrote
to is).

thanks
-- PMM
