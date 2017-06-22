Received: from eggs.gnu.org ([2001:4830:134:3::10]:50760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO1iJ-0005jf-3e
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO1iI-0003pl-E2
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:59:59 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dO1iI-0003pD-6q
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:59:58 -0400
Received: by mail-wr0-x22f.google.com with SMTP id r103so22620844wrb.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 05:59:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 13:59:36 +0100
Message-ID: <CAFEAcA9S3toNfOfGHuOk4Y8g_P6W5zQJaZYWC_dPddd2GVO9mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/31] Refactoring with clang-tidy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 June 2017 at 13:41, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om> wrote:
> Various refactring questions on previously sent series prompted me to
> look at coccinelle to automate some changes again. Alas, semantic
> patches are not so easy to express for me, cocci doesn't catch all
> cases, is quite slow, and it doesn't seem possible to evaluate
> expressions to check if E =3D=3D E-1 or if E is pow2 for example.
>
> I started looking at clang-tidy
> (http://clang.llvm.org/extra/clang-tidy/) as an alternative to do some
> refactoring.

Oh, very nice. I've had "investigate clang-tidy" in my todo list for
ages so it's nice that somebody has done it for me ;-)

I think it would be particularly interesting to look at whether
we can use this infrastructure to automatically detect some kinds
of bug, rather than merely stylistic issues. (As a random
example, could you detect calls to coroutine_fn functions from
normal functions?)

thanks
-- PMM
