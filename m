Received: from eggs.gnu.org ([2001:4830:134:3::10]:37322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekCk-0004HH-Bw
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekCj-0007YI-Il
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:16:46 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:35222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eekCj-0007Xx-Dc
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:16:45 -0500
Received: by mail-ot0-x22c.google.com with SMTP id 53so7162756otj.2
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 08:16:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <F19A160D-99BC-4170-B544-8BAFFC23FE83@gmail.com>
References: <151274735709.11243.12332071284435970530.malonedeb@soybean.canonical.com>
	<151686682161.4861.8851702267220024380.malone@wampee.canonical.com>
	<F19A160D-99BC-4170-B544-8BAFFC23FE83@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 16:16:24 +0000
Message-ID: <CAFEAcA9vJ7A+J2OSPNsfyT575p+heE5o_++T-Jtp6S3dyG3NTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1737194] Re: Windows NT 4.0 fails to boot
 from qcow2 installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1737194 <1737194@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 January 2018 at 15:58, John Arbuckle <programmingkidx@gmail.com> wrote:
> I did try to build at commits 306ec6c3cece7004429c79c1ac93d49919f1f1cc
> and e689f7c668cbd9d08f330e17c3dd3a059c9553d3. Both failed to build on my
> Mac OS X system. Here is the error message I usually saw:
>
>   LINK  qemu-io
> Undefined symbols for architecture x86_64:
>   "_use_rt_clock", referenced from:
>       _bdrv_acct_start in block.o
>       _bdrv_acct_done in block.o
> Undefined symbols for architecture x86_64:
>       _qemu_clock_get_ns in qemu-timer.o
>   "_use_rt_clock", referenced from:
>       _bdrv_acct_start in block.o
>       _bdrv_acct_done in block.o
>       _qemu_clock_get_ns in qemu-timer.o

If you configure with --disable-tools does it manage to build,
or does it just go on to fail to link the main QEMU binary
with the same error? (We've had some issues in the past I think
where configure put libraries on the main binary link line but
not on the tools link lines, so maybe worth a try...)

thanks
-- PMM
