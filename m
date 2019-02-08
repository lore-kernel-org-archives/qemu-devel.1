Received: from eggs.gnu.org ([209.51.188.92]:54334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gruSm-0000gb-7f
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 19:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gruSl-0008QZ-CO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 19:56:16 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:46511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gruSl-0008Ph-5W
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 19:56:15 -0500
Received: by mail-lj1-x22c.google.com with SMTP id v15-v6so1496929ljh.13
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 16:56:14 -0800 (PST)
MIME-Version: 1.0
References: <154955529480.22127.1382747582342462477.malonedeb@chaenomeles.canonical.com>
In-Reply-To: <154955529480.22127.1382747582342462477.malonedeb@chaenomeles.canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 Feb 2019 16:55:32 -0800
Message-ID: <CAKmqyKMkSYK99s0w_aGOSMGoqNyf0Qx5Q7XgzTrBXK2Fy0WZ7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1815078] [NEW] Qemu 3.1.0 risc-v mie.MEIE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1815078 <1815078@bugs.launchpad.net>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Feb 7, 2019 at 8:19 AM RTOS Pharos <1815078@bugs.launchpad.net> wrote:
>
> Public bug reported:
>
> Hello all,
>
> There is a bug in qemu for Risc-v, related to the mie register: when we
> try to set the MEIE bit (11) nothing is done, even when we are running
> at machine mode.
>
> Li   a0 , 1 << 11
> Csrs mie , a0
>
> And when we read mie it is as though nothing was done.
>
> Going through the qemu source code I was able to correct it: on file
> op_helper.c, line 94, the variable all_ints should be initialized with:
>
> uint64_t all_ints = delegable_ints | MIP_MSIP | MIP_MTIP | MIP_MEIP;
>
> That is, the MIP_MEIP was missing.
>
> I've successfully triggered uart interrupts with this patch (virt
> machine).

Would you like to send a patch?

Alistair

>
> All the best,
> Pharos team
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1815078
>
> Title:
>   Qemu 3.1.0 risc-v mie.MEIE
>
> Status in QEMU:
>   New
>
> Bug description:
>   Hello all,
>
>   There is a bug in qemu for Risc-v, related to the mie register: when
>   we try to set the MEIE bit (11) nothing is done, even when we are
>   running at machine mode.
>
>   Li   a0 , 1 << 11
>   Csrs mie , a0
>
>   And when we read mie it is as though nothing was done.
>
>   Going through the qemu source code I was able to correct it: on file
>   op_helper.c, line 94, the variable all_ints should be initialized
>   with:
>
>   uint64_t all_ints = delegable_ints | MIP_MSIP | MIP_MTIP | MIP_MEIP;
>
>   That is, the MIP_MEIP was missing.
>
>   I've successfully triggered uart interrupts with this patch (virt
>   machine).
>
>   All the best,
>   Pharos team
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1815078/+subscriptions
>
