Received: from eggs.gnu.org ([2001:4830:134:3::10]:46485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKSwv-0001y4-G2
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKSwr-0002p6-37
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:53:09 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:41788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKSwq-0002oa-MD
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:53:05 -0500
Received: by mail-pl1-x62a.google.com with SMTP id p16-v6so8265504plr.8
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 10:53:04 -0800 (PST)
Date: Wed, 07 Nov 2018 10:53:02 -0800 (PST)
In-Reply-To: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-7f896ae0-6a2e-4a51-a80c-f7e594224624@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, 06 Nov 2018 10:43:17 PST (-0800), Peter Maydell wrote:
> I had an idea for how to get a rough list of source files
> containing devices that haven't been QOMified. The theory
> is that a pre-QOM device generally has an "init" function
> which allocates memory for the device struct. So looking in
> hw/ for files which call g_new*() or g_malloc*() should get
> us all the non-QOM devices (as well as a pile of false
> positives, of course). The following link is the result of
> doing that and then eyeballing the results for false positives
> and throwing those out. It might have missed one or two
> files or included one or two by mistake. But I think it's
> pretty close, and it seems to have caught all the obvious
> ones I knew about. There are 61 files on this list.
>
> I am also suspicious about hw/bt/ but don't know enough
> about that subsystem to say if it could benefit from
> using QOM objects more.
>
> [...]
>
> hw/riscv/riscv_htif.c
> hw/riscv/sifive_uart.c

I poked around at it looks like both of these are valid targets for a QOM 
conversion, and I think the UART in particular would be meaningfully more 
useful with a conversion.  I'll add it to my TODO list, but I'm not sure how 
long it'll take to get around to it -- sorry!

Thanks for pointing this out!
