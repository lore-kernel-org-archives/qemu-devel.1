Received: from eggs.gnu.org ([2001:4830:134:3::10]:55020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezJoh-0005vQ-Fy
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezJog-0000Ob-9L
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:20:59 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:44844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezJog-0000No-40
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:20:58 -0400
Received: by mail-ot0-x242.google.com with SMTP id x6-v6so11227253otg.11
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 03:20:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521584722-39133-1-git-send-email-mjc@sifive.com>
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 10:20:36 +0000
Message-ID: <CAFEAcA-oqg8UJD=i9swm8AiF=tvJ7GY6+CyStJNiZyoqUYfMqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 20 March 2018 at 22:25, Michael Clark <mjc@sifive.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4f135:
>
>   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-fixes
>
> for you to fetch changes up to e1a247183ac0816284dfda61423f7030b6686679:
>
>   RISC-V: Remove erroneous comment from translate.c (2018-03-20 14:34:13 -0700)

I know this pull request needs a respin, but I gave it a test build
run anyway to see if there were any issues thrown up by that (there
weren't, which is great).

I did notice that the tag name you quote here, "tags/riscv-qemu-2.12-fixes",
doesn't seem to be a tag pushed to your git repo. I tested with
"tags/riscv-qemu-2.12-fixes-v5" which I'm guessing is what you meant.
You probably want to have a look into the workflow which generates
these pullreq emails though to ensure it's creating them with the
tag names that you intend, though.

thanks
-- PMM
