Received: from eggs.gnu.org ([2001:4830:134:3::10]:43818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEGSo-0007Rg-80
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEGSk-00059x-5g
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:11:22 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEGSj-00059T-OO
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:11:18 -0500
Received: by mail-vk0-f43.google.com with SMTP id p9so196027802vkd.3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 06:11:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Uc_g0NP78oEwg3u1cCmGPCxruMptt_OOAhhLiGfd4QQ@mail.gmail.com>
References: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
	<CAFEAcA-Uc_g0NP78oEwg3u1cCmGPCxruMptt_OOAhhLiGfd4QQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Dec 2016 14:09:56 +0000
Message-ID: <CAFEAcA8027hz-9qCva5gLTAJ1f22pdqcGetJ9fNfLdDzGXq80A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1647683] [NEW] Bad interaction between tb
 flushing & gdb stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1647683 <1647683@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <bonzini@gnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 6 December 2016 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> I saw something similar the other day as well, not involving valgrind,
> just a simple gdb connected to the gdbstub.

http://people.linaro.org/~peter.maydell/gdbstub-bug.tgz
is a repro case for this (with an aarch64 kernel guest).
Segfaults every time when the guest hits the breakpoint.

thanks
-- PMM
