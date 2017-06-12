Received: from eggs.gnu.org ([2001:4830:134:3::10]:39804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKPkq-0001bx-4n
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKPkp-0000EV-D4
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:51:40 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKPkp-0000E9-6b
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:51:39 -0400
Received: by mail-wr0-x22d.google.com with SMTP id v104so97094318wrb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 06:51:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607180736.11011-1-stefanha@redhat.com>
References: <20170607180736.11011-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 14:51:16 +0100
Message-ID: <CAFEAcA_q-71+Ap4JPF6AMTPnjVWHRAnZ=U1rFBj4Ji9yKeLFpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-2.9 0/5] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 June 2017 at 19:07, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 0db1851becbefe3e50cfc03776fb1f75817376=
af:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-re=
quest' into staging (2017-06-07 11:56:00 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 11cde1c81093a33c46c7a4039bf750bb61551087:
>
>   configure: split c and cxx extra flags (2017-06-07 15:29:46 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Bruno Dominguez (1):
>   configure: split c and cxx extra flags
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   oslib: strip trailing '\n' from error_setg() string argument
>   coccinelle: fix typo in comment
>
> Roman Pen (1):
>   coroutine-lock: do not touch coroutine after another one has been
>     entered
>
> Stefan Hajnoczi (1):
>   .gdbinit: load QEMU sub-commands when gdb starts
>
>  configure                                | 75 ++++++++++++++++++--------=
------
>  disas/libvixl/Makefile.objs              |  4 +-
>  util/oslib-posix.c                       |  2 +-
>  util/qemu-coroutine-lock.c               | 19 +++++++-
>  util/qemu-coroutine.c                    |  5 +++
>  .gdbinit                                 |  8 ++++
>  rules.mak                                |  3 --
>  scripts/coccinelle/return_directly.cocci |  2 +-
>  8 files changed, 77 insertions(+), 41 deletions(-)
>  create mode 100644 .gdbinit

Applied, thanks.

-- PMM
