Received: from eggs.gnu.org ([2001:4830:134:3::10]:54411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1e3nyg-0005K9-1z
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 14:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1e3nyf-0002up-7W
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 14:49:34 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ramysameh26@gmail.com>)
	id 1e3nyf-0002ud-0g
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 14:49:33 -0400
Received: by mail-oi0-x241.google.com with SMTP id 14so5838199oii.0
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 11:49:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Um7zYLeSzFfSSL-nRsRKyRbKEwb2MEzcsGqoQDSuRqg@mail.gmail.com>
References: <CAF6HrYzSiw+NzKBP1QGK794+tcyZTK21XVsDXEpjF2-bD-9z3Q@mail.gmail.com>
	<CAFEAcA-Um7zYLeSzFfSSL-nRsRKyRbKEwb2MEzcsGqoQDSuRqg@mail.gmail.com>
From: Ramy Sameh <ramysameh26@gmail.com>
Date: Sun, 15 Oct 2017 20:49:31 +0200
Message-ID: <CAF6HrYwPtrQU-wsTmSQcmoSC+7d7CHp-oVa6ksk+PG6_Q48WFQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mona Safar <Mona.Safar@eng.asu.edu.eg>, Ahmed Aly <ahmedaly50@gmail.com>, Watheq <watheq@gmail.com>

Many thanks Peter

On Sun, Oct 15, 2017 at 6:50 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 15 October 2017 at 17:47, Ramy Sameh <ramysameh26@gmail.com> wrote:
> > I was tracking the calling of function pl011_read, and I noticed that it
> is
> > called from function *memory_region_read_accessor *in memory.c
> >
> > I also noticed that all peripherals reading functions (e.g. pl050_read,
> > pl190_read ... etc) in the emulated VersatilePB board, are called from
> the
> > same location in *memory_region_read_accessor.*
> >
> > *My question is*: Is this calling procedure done for the emulated
> > VersatilePB board *only*, or this is the case for the peripherals in all
> > emulated systems ?
>
> Broadly speaking, yes, all peripheral device read and write
> functions are invoked via the memory subsystem code (which
> is the part of QEMU that figures out what memory region
> covers whatever the physical address that the guest wrote
> to is).
>
> thanks
> -- PMM
>



-- 
Best Regards,
Ramy Sameh
Embedded Software Engineer
+2-010-172-777-14
