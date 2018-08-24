Received: from eggs.gnu.org ([2001:4830:134:3::10]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftE3a-00057k-T9
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftE3Z-0007qx-JN
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:31:26 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftE3Z-0007pu-4C
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:31:25 -0400
Received: by mail-oi0-x242.google.com with SMTP id c190-v6so15993154oig.6
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 08:31:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 16:31:03 +0100
Message-ID: <CAFEAcA_QUNb8SYqQz5NMtLNzz-QUeHhvPnTjiR=9n6E699BD=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v5 00/46] MIPS queue August 2018 v5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 August 2018 at 15:18, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 3392fbee4e435658733bbe9aab23392660558b59:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-08-23 12:28:17 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-aug-2018
>
> for you to fetch changes up to e7133037c63d9d806f1a1f6c5a1906e658496cfa:
>
>   target/mips: Add definition of nanoMIPS I7200 CPU (2018-08-23 16:11:35 +0200)
>
> ----------------------------------------------------------------
> MIPS queue August 2018 v5
>
> The patches in this queue add support for core functionality and
> system mode for nanoMIPS platform.
>
> v5: Corrected repository
> v4: Fixed clang build errors for user mode configurationos.
> v3: Fixed initial ('since') commit.
> v2: Added missing 'Reviewed-by' lines
>

Hi -- I'm afraid this fails to build on hosts with no C++ compiler.
(The OpenBSD VM in the tests/vm/ setup is an example of this.)

Linking fails with
x86_64-unknown-openbsd6.1-gcc-4.9.4: error: ../disas/nanomips.o: No
such file or directory

If you want to use a disassembler written in C++ you need
sufficient checks in configure to ensure that it isn't
configured in if there's no C++ compiler. Compare the
handling of the AArch64 disassembler: in configure we do
    if test -n "${cxx}"; then
      disas_config "ARM_A64"
    fi

and then in disas/Makefile.objs the relevant object files
are included via "common-obj-$(CONFIG_ARM_A64_DIS)"

You probably want a similar thing with a
disas_config "NANOMIPS"

thanks
-- PMM
