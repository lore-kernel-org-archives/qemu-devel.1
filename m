Received: from eggs.gnu.org ([2001:4830:134:3::10]:56432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1egXoG-0006GC-Bf
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1egXoF-0002dW-Cu
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:26:56 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1egXoF-0002af-6M
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:26:55 -0500
Received: by mail-wr0-x244.google.com with SMTP id 36so11589551wrh.1
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 07:26:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116151152.4040-1-marcandre.lureau@redhat.com>
References: <20180116151152.4040-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Jan 2018 16:26:52 +0100
Message-ID: <CAJ+F1CJK8VQpyR-GJnbjbfzQtCs7Ng1KO9ev2BVJizjrX=SpQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Sanitizers configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

ping

On Tue, Jan 16, 2018 at 4:11 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Hi,
>
> This is a few reworked patches from "[PATCH v3 00/18] Various
> build-sys and sanitizer related fixes" series.
>
> It enables sanitizers by default with --enable-debug. But sanitizers
> can be also enabled/disabled independently with a configure option.
>
> If ASAN is detected but coroutine annotations are not available, then
> a simple message is printed during configure.
>
> Marc-Andr=C3=A9 Lureau (3):
>   exynos4210: workaround UBSAN compilation error
>   build-sys: add --enable-sanitizers
>   ucontext: annotate coroutine stack for ASAN
>
>  include/qemu/compiler.h      |  4 +++
>  hw/display/exynos4210_fimd.c |  2 +-
>  util/coroutine-ucontext.c    | 48 ++++++++++++++++++++++++++++++++
>  .travis.yml                  |  3 +-
>  configure                    | 65 ++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 120 insertions(+), 2 deletions(-)
>
> --
> 2.16.0.rc1.1.gef27df75a1
>
>



--=20
Marc-Andr=C3=A9 Lureau
