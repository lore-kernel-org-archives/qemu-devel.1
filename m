Received: from eggs.gnu.org ([2001:4830:134:3::10]:47534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eProP-0008Dh-Ji
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eProO-0004fk-O4
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:22:09 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:41252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eProO-0004dY-HE
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:22:08 -0500
Received: by mail-wr0-x231.google.com with SMTP id z18so8349656wrb.8
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 07:22:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-1-marcandre.lureau@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Dec 2017 16:22:06 +0100
Message-ID: <CAJ+F1C+PVtZ+a1+3TFuogUkR5Tf+7Rk-qA2XKJviCEubNMASEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/13] Various build-sys and ASAN
 related fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi

On Fri, Dec 15, 2017 at 4:06 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> work. Finally, the last patch should help ASAN and remove some
> false-positive, unfortunately it crashes ASAN and may be
> incorrect. Help welcome!
>

I forgot to update the cover letter: this is no longer true!

thanks

> v2:
> - simplify "build-sys: silence make by default or V=3D0": make it a
>   oneliner MAKEFLAGS, use --quiet.
> - document print-VAR rule in docs/devel/build-system.txt
> - fix ASAN coroutine instrumentation failure
> - should fix builds on gcc 4.4.7 (centos 6)
> - new coroutine test leak fix
> - add some r-b tags
>
> Marc-Andr=C3=A9 Lureau (13):
>   build-sys: fix qemu-ga -pthread linking
>   build-sys: silence make by default or V=3D0
>   build-sys: add a rule to print a variable
>   build-sys: add AddressSanitizer when --enable-debug if possible
>   tests: fix check-qobject leak:
>   vl: fix direct firmware directories leak
>   readline: add a free function
>   tests: fix migration-test leak
>   crypto: fix stack-buffer-overflow error
>   qemu-config: fix leak in query-command-line-options
>   tests: fix qmp-test leak
>   ucontext: annotate coroutine stack for ASAN
>   tests: fix coroutine leak in /basic/entered
>
>  include/qemu/compiler.h     |  4 ++++
>  include/qemu/readline.h     |  1 +
>  crypto/ivgen-essiv.c        |  2 +-
>  monitor.c                   |  2 +-
>  tests/check-qobject.c       |  2 ++
>  tests/migration-test.c      |  3 ++-
>  tests/qmp-test.c            |  3 ++-
>  tests/test-coroutine.c      |  1 -
>  util/coroutine-ucontext.c   | 46 +++++++++++++++++++++++++++++++++++++++=
++++++
>  util/qemu-config.c          |  3 ++-
>  util/readline.c             | 18 +++++++++++++++++-
>  vl.c                        |  9 ++++++---
>  Makefile                    |  7 +++++--
>  configure                   |  6 ++++++
>  docs/devel/build-system.txt | 13 +++++++++++++
>  rules.mak                   |  2 ++
>  16 files changed, 110 insertions(+), 12 deletions(-)
>
> --
> 2.15.1.355.g36791d7216
>
>



--=20
Marc-Andr=C3=A9 Lureau
