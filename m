Received: from eggs.gnu.org ([209.51.188.92]:53550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCI75-000517-46
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCI74-0001TD-10
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:14:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hCI73-0001RV-C0
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:14:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id x188so3932003oia.13
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 23:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190405003924.1906-1-palmer@sifive.com>
In-Reply-To: <20190405003924.1906-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2019 13:13:53 +0700
Message-ID: <CAFEAcA82u1SNuO-2AvCR8dx6XyyeZnrdWFbhmOvHun7hmxNFZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for 4.0-rc3, v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 5 Apr 2019 at 07:39, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The following changes since commit 061b51e9195670e9d190cdec46fabcb3c77763fb:
>
>   Update version for v4.0.0-rc2 release (2019-04-02 17:01:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.0-rc3-v2
>
> for you to fetch changes up to 79bcac250f96ba1d4fdecfdc6e3363c9024703a4:
>
>   riscv: plic: Log guest errors (2019-04-04 16:36:21 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for 4.0-rc3, v2
>
> This patch set contains a pair of tightly coupled PLIC bug fixes:
>
> * We were calculating the PLIC addresses incorrectly.
> * We were installing the wrong number of PLIC interrupts.
>
> The two bugs togther resulted in a mostly-working system, but they're
> impossible to seperate because fixing one bug would result in
> significant breakage.  As a result they're in the same patch.
>
> There is also a cleanup to use qemu_log_mask(LOG_GUEST_ERROR,...) for
> error reporting.
>
> As far as I know these are the last outstanding RISC-V patches for 4.0.
>
> v2 no longer fails "make check" for me... sorry!
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
