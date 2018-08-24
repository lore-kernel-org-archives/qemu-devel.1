Received: from eggs.gnu.org ([2001:4830:134:3::10]:36754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1ftEYW-0008ND-GW
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1ftEYO-0004ZP-Sk
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:03:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46167 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
	id 1ftEYO-0003Td-Au
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:03:16 -0400
in-reply-to: <CAFEAcA_QUNb8SYqQz5NMtLNzz-QUeHhvPnTjiR=9n6E699BD=Q@mail.gmail.com>
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
message-id: <670f-5b802c00-7-67bfcd8@224416105>
date: Fri, 24 Aug 2018 18:02:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?Pz09P3V0Zi04P3E/IFtQVUxMIHY1IDAwLzQ2XSBN?=
 =?utf-8?q?IPS_queue_August_2018_v5?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


> On 23 August 2018 at 15:18, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > The following changes since commit 3392fbee4e435658733bbe9aab233926=
60558b59:
> >
> > Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3=
.1-pull-request' into staging (2018-08-23 12:28:17 +0100)
> >
> > are available in the git repository at:
> >
> > https://github.com/AMarkovic/qemu tags/mips-queue-aug-2018
> >
> > for you to fetch changes up to e7133037c63d9d806f1a1f6c5a1906e65849=
6cfa:
> >
> > target/mips: Add definition of nanoMIPS I7200 CPU (2018-08-23 16:11=
:35 +0200)
> >
> > ----------------------------------------------------------------
> > MIPS queue August 2018 v5
> >
> > The patches in this queue add support for core functionality and
> > system mode for nanoMIPS platform.
> >
> > v5: Corrected repository
> > v4: Fixed clang build errors for user mode configurationos.
> > v3: Fixed initial ('since') commit.
> > v2: Added missing 'Reviewed-by' lines
> >
>
> Hi -- I'm afraid this fails to build on hosts with no C++ compiler.
> (The OpenBSD VM in the tests/vm/ setup is an example of this.)
>
> Linking fails with
> x86=5F64-unknown-openbsd6.1-gcc-4.9.4: error: ../disas/nanomips.o: No=

> such file or directory
>
> If you want to use a disassembler written in C++ you need
> sufficient checks in configure to ensure that it isn't
> configured in if there's no C++ compiler. Compare the
> handling of the AArch64 disassembler: in configure we do
> if test -n "${cxx}"; then
> disas=5Fconfig "ARM=5FA64"
> fi
>
> and then in disas/Makefile.objs the relevant object files
> are included via "common-obj-$(CONFIG=5FARM=5FA64=5FDIS)"
>
> You probably want a similar thing with a
> disas=5Fconfig "NANOMIPS"
>
> thanks
> -- PMM


Hi, Peter,

I just sent (only a cover letter of) v6 of the pull request. The disass=
embler patch is excluded from this request, so only 45 patches.

Hope this would be OK.

Thanks,
Aleksandar
