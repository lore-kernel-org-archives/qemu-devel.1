Received: from eggs.gnu.org ([2001:4830:134:3::10]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NOH-0006wS-0W
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3NOD-0006uc-7V
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:58:29 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:33873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3NOD-0006uM-0u
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:58:25 -0400
Received: by mail-ot0-x229.google.com with SMTP id m7-v6so19731914otd.1
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 07:58:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522344417-60114-1-git-send-email-mjc@sifive.com>
References: <1522344417-60114-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Apr 2018 15:58:03 +0100
Message-ID: <CAFEAcA-+SHHZzbEUg7i7uiTOmhuTPX=QiHQkakGbj+SupJ0KQg@mail.gmail.com>
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
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

On 29 March 2018 at 18:26, Michael Clark <mjc@sifive.com> wrote:
> The following changes since commit 47d3b60858d90ac8a0cc3a72af7f95c96781125a:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-important-fixes' into staging (2018-03-28 22:13:38 +0100)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-critical-fixes
>
> for you to fetch changes up to b02403363f1056421d120c8e974fdf9c76a84f95:
>
>   RISC-V: Workaround for critical mstatus.FS bug (2018-03-29 10:22:26 -0700)
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

Applied, thanks.

-- PMM
