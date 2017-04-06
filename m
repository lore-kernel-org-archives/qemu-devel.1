Received: from eggs.gnu.org ([2001:4830:134:3::10]:57673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwA9p-00077b-Ss
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwA9p-0005yc-5w
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:21:13 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cwA9o-0005yD-VA
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:21:13 -0400
Received: by mail-wr0-x22a.google.com with SMTP id g19so26507512wrb.0
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 09:21:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91CYjU12gPL5QbUCK3_M73BHoKRU77f6FKtO3qO2trPFQ0g@mail.gmail.com>
References: <CAJy91CYjU12gPL5QbUCK3_M73BHoKRU77f6FKtO3qO2trPFQ0g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Apr 2017 17:20:51 +0100
Message-ID: <CAFEAcA_+vXAvHx6m=+s0Re+e-w=G_arQNGzyoL83gncBs2U_Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] is qemu able to run multiple system emulation
 simultaneously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 April 2017 at 16:47, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> I need multiple ARM-based hardware emulation runing simultaneously in one
> PC.
> I wander if QEMU is capble to run two system emulation at the same time.
> Or I have to use two QEMU for two system emulation

You need to run two copies of QEMU for this. It should work fine,
though.

thanks
-- PMM
