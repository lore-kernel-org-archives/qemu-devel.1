Received: from eggs.gnu.org ([209.51.188.92]:53322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjOa4-0000uM-J7
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjOa2-00048Z-P3
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:16:36 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:37916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gjOa1-00043v-Uh
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 08:16:34 -0500
Received: by mail-ot1-x335.google.com with SMTP id e12so2412713otl.5
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 05:16:21 -0800 (PST)
MIME-Version: 1.0
References: <1547487921-605-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1547487921-605-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Jan 2019 13:16:09 +0000
Message-ID: <CAFEAcA-tPoQK+7GTesyqAVmoKm7g3SHoP2iz3R8k7WX=PW5q4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/27] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

On Mon, 14 Jan 2019 at 17:45, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b=
16:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-=
part2' into staging (2019-01-14 11:41:43 +0000)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-14v2
>
> for you to fetch changes up to 650db715681ad1a042705484776e1974f288f3d4:
>
>   tests/hexloader-test: Don't pass -nographic to the QEMU under test (201=
9-01-14 18:21:29 +0100)
>
> ----------------------------------------------------------------
> - Remove deprecated "ivshmem" legacy device
> - Bug fix for vhost-user-test
> - Use more CONFIG Makefile switches for qtests
> - Get rid of global_qtests in some more qtests
> - typedef cleanups
> - Fixes for compiling with Clang
> - Force C standard to gnu99
> ----------------------------------------------------------------

Hi; another compile failure on that ppc64 system, I'm afraid:

/home/pm215/qemu/qemu-seccomp.c:45:1: error: initializer element is not con=
stant
 };
 ^
/home/pm215/qemu/qemu-seccomp.c:45:1: error: (near initialization for
=E2=80=98sched_setscheduler_arg[0]=E2=80=99)

(I did a quick check with 'make -k' and it looks like there aren't
any more lurking after that one.)

The system libseccomp is libseccomp-2.3.1-3.el7.

thanks
-- PMM
