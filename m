Received: from eggs.gnu.org ([2001:4830:134:3::10]:55789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8QWU-0001EE-79
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8QWO-0005Cx-Fl
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:52:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8QWO-00050N-52
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:52:00 -0400
Received: by mail-wm1-x344.google.com with SMTP id e187-v6so2038561wmf.0
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:51:47 -0700 (PDT)
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-3-crosa@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181004161852.11673-3-crosa@redhat.com>
Date: Fri, 05 Oct 2018 14:51:45 +0100
Message-ID: <87mursqz66.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] tests/tcg/README: fix location for
 lm32 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>


Cleber Rosa <crosa@redhat.com> writes:

> Point to the right and obvious location for lm32 tests.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/tcg/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/README b/tests/tcg/README
> index a5643d33e7..2a58f9a058 100644
> --- a/tests/tcg/README
> +++ b/tests/tcg/README
> @@ -10,6 +10,6 @@ with "make test-cris".
>
>  LM32
>  =3D=3D=3D=3D
> -The testsuite for LM32 is in tests/tcg/cris.  You can run it
> +The testsuite for LM32 is in tests/tcg/lm32.  You can run it
>  with "make test-lm32".

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

It's a correct fix, although I note running "make test-lm32" doesn't do
much either in the top of the build dir or in that directory. It's
probably best to drop the second line until I fix it.

--
Alex Benn=C3=A9e
