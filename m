Received: from eggs.gnu.org ([2001:4830:134:3::10]:54348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etsNf-0005nX-Jl
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etsNZ-0006qB-Vo
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:02:35 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etsNZ-0006pU-Pg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:02:29 -0500
Received: by mail-oi0-x242.google.com with SMTP id c83so3959334oib.1
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 02:02:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520365586-30384-1-git-send-email-mjc@sifive.com>
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 10:02:08 +0000
Message-ID: <CAFEAcA_G1tHrBZ=GxAy0b-SLbYU2-XOAUNL0D=8MQeL0Roz_cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 6 March 2018 at 19:46, Michael Clark <mjc@sifive.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit f32408f3b472a088467474ab152be3b6285b2d7b:
>
>   misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:30 +0000)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v8.2
>
> for you to fetch changes up to 7051b081bf6796e5e84406f6223a7c4900bf7298:
>
>   RISC-V - Remove support for adhoc non-standard X_COP local-interrupt (2018-03-07 08:36:03 +1300)


Hi -- I would have applied this, but some of the commits
have no signed-off-by lines.

This is important, and I've already asked for it once. We cannot
accept anything that doesn't have a clear record in the commit
message of everybody (person or company) who's contributed code
to it, indicating that they're happy for their copyrighted
contributions to be taken into QEMU under our license. Lists
of names without emails in the cover letter are not sufficient.

In fact a lot of the last part of this patchset looks like
unreviewed changes/fixes that if we were going to have them we
should have squashed into the correct patches and resent the
series for review. Please don't do this. Code review is an
important part of how the QEMU project works.

thanks
-- PMM
