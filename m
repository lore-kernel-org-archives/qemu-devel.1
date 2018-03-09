Received: from eggs.gnu.org ([2001:4830:134:3::10]:56024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euP23-0007gB-5W
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euP22-0001PP-6I
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:54:27 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:40854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euP22-0001PH-14
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:54:26 -0500
Received: by mail-ot0-x236.google.com with SMTP id l12so9901329otj.7
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 12:54:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520627374-93719-1-git-send-email-mjc@sifive.com>
References: <1520627374-93719-1-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 10 Mar 2018 09:54:24 +1300
Message-ID: <CAHNT7NsbNYtRtug9=gv1tPg7_XLs4b=BwK+95_3zpvy5yTVriw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V: Fix riscv_isa_string g_new0 size
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, RISC-V Patches <patches@groups.riscv.org>

Apologies for jumping the gun again with a PR before a review. It was most
likely because I thought it was a critical bug fix.

I'm incorporating Eric Blake's feedback.

On Sat, Mar 10, 2018 at 9:29 AM, Michael Clark <mjc@sifive.com> wrote:

> The following changes since commit e4ae62b802cec437f877f2cadc4ef0
> 59cc0eca76:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'
> into staging (2018-03-09 17:28:16 +0000)
>
> are available in the git repository at:
>
>   https://github.com/michaeljclark/riscv-qemu.git fix-riscv-isa-string
>
> for you to fetch changes up to 32b3a5716062f805a42e1cae1df95f2f869a78c1:
>
>   RISC-V: Fix isa string logic bug, use popcount to count bits (2018-03-10
> 09:17:29 +1300)
>
> ----------------------------------------------------------------
> Michael Clark (1):
>       RISC-V: Fix isa string logic bug, use popcount to count bits
>
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
