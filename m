Received: from eggs.gnu.org ([2001:4830:134:3::10]:44496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1xVq-0007Dw-Ho
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1xVp-0001Tq-Bi
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:08:26 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f1xVp-0001Ti-4l
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:08:25 -0400
Received: by mail-oi0-x243.google.com with SMTP id x9-v6so8254666oig.7
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 10:08:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522344417-60114-1-git-send-email-mjc@sifive.com>
References: <1522344417-60114-1-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 30 Mar 2018 10:08:23 -0700
Message-ID: <CAHNT7Nvtx85EfQ6g_E1bL5XRvwZYoo=YoarMA6r9V4dER-O3Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] RISC-V: Critical fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Michael Clark <mjc@sifive.com>

Hi Peter,

I had tested Richard's proper fix but we didn't have a PR or the required
Reviewed-by and Signed-off-by so I made the PR for the conservative fix,
assuming we can test Richard's more correct fix and include it in the QEMU
2.13 timeframe. I've tested Richard's fix with the simple scheduling test
case, so if he makes a PR, I'm happy for that to be included versus this
workaround. The workaround is, of course, the most conservative fix as it
will always cause FP state to be saved, assuming we missed a case in
Richard's patch.

I'll leave it up to you and Richard, but please include either this
workaround or Richard's slightly larger change in QEMU 2.12, if possible.
In any case, I believe vendors have patches they can include in their
packages... but it would be nice that upstream QEMU 2.12 has working FP for
RISC-V with SMP Linux.

Thanks,
Michael.



On Thu, Mar 29, 2018 at 10:26 AM, Michael Clark <mjc@sifive.com> wrote:

> The following changes since commit 47d3b60858d90ac8a0cc3a72af7f95
> c96781125a:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-important-fixes'
> into staging (2018-03-28 22:13:38 +0100)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-critical-
> fixes
>
> for you to fetch changes up to b02403363f1056421d120c8e974fdf9c76a84f95:
>
>   RISC-V: Workaround for critical mstatus.FS bug (2018-03-29 10:22:26
> -0700)
>
> ----------------------------------------------------------------
> RISC-V: Critical fixes for QEMU 2.12
>
> This series includes changes that are considered release critical,
> such as floating point register file corruption under SMP Linux
> due to incorrect handling of mstatus.FS.
>
> This workaround will be replaced with a more comprehensive fix
> for mstatus.FS handling in QEMU 2.13.
>
> ----------------------------------------------------------------
> Michael Clark (1):
>       RISC-V: Workaround for critical mstatus.FS bug
>
>  target/riscv/op_helper.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
