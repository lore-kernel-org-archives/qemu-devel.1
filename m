Received: from eggs.gnu.org ([209.51.188.92]:32809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1guR2l-0007gk-KS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1guR0Z-0006xK-D5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:05:37 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:32931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1guR0R-0006oN-IW
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:05:30 -0500
Received: by mail-lj1-x243.google.com with SMTP id f24-v6so6867098ljk.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 16:05:21 -0800 (PST)
MIME-Version: 1.0
References: <154955529480.22127.1382747582342462477.malonedeb@chaenomeles.canonical.com>
	<155012716149.28602.16690825449346178376.malone@chaenomeles.canonical.com>
In-Reply-To: <155012716149.28602.16690825449346178376.malone@chaenomeles.canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 14 Feb 2019 16:04:36 -0800
Message-ID: <CAKmqyKN0XXTCHOydx1B_SJn_xVcGpq8WO6Pw=K4bh751_6LWQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1815078] Re: Qemu 3.1.0 risc-v mie.MEIE
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

On Wed, Feb 13, 2019 at 11:02 PM RTOS Pharos <1815078@bugs.launchpad.net> wrote:
>
> So I tried it but got the error:
>
> ERROR: missing file ../qemu-3.1.0/ui/keycodemapdb/README
>
> This is not a GIT checkout but module content appears to
> be missing. Do not use 'git archive' or GitHub download links
> to acquire QEMU source archives. Non-GIT builds are only
> supported with source archives linked from:
>
>   https://www.qemu.org/download/
>
> Developers working with GIT can use scripts/archive-source.sh
> if they need to create valid source archives.
>
> Makefile.cross-compiler:259: recipe for target 'qemu-3.1' failed
> make: *** [qemu-3.1] Error 1
>
>
> Get this is standard error, but I don't have time now to see how to work
> around it. Maybe later I can

The error describes how to fix the error. Just git clone the QEMU
source directly instead of using the GitHub tarballs.

Alistair

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
>   Fix Committed
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
