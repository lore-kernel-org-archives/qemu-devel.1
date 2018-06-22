Received: from eggs.gnu.org ([2001:4830:134:3::10]:38671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWAUf-0004Hc-Ot
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWAUe-0000sU-N3
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:04:05 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:34597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fWAUe-0000sM-IM
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:04:04 -0400
Received: by mail-yw0-x244.google.com with SMTP id b125-v6so1848741ywe.1
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 18:04:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621184116.910-1-alex.bennee@linaro.org>
References: <20180621184116.910-1-alex.bennee@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 21 Jun 2018 18:04:03 -0700
Message-ID: <CAMo8BfJ+Y9didgKKvrWJiuYOd+qUyxpjy75mBaOzspCt5eHZDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] blogposts: add post about the new
 check-tcg infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jun 21, 2018 at 11:41 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  _posts/2018-06-21-tcg-testing.md | 129 +++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 _posts/2018-06-21-tcg-testing.md
>
> diff --git a/_posts/2018-06-21-tcg-testing.md b/_posts/2018-06-21-tcg-tes=
ting.md

[...]

> +The `tests/tcg` directory still contains a number of source files we
> +don't build. Notably the cris, lm32, mips, openrisc and xtensa targets h=
ave
> +a set of tests that need a system emulator. Now we have the
> +infrastructure for compiling I hope we can get support for system
> +tests added fairly quickly. There will need to be some work to figure
> +out a nice common way to pass results back to the build-system. For
> +linux-user this is simple as all programs can simply return their exit
> +code however for system emulation this is a little more involved.

xtensa tests pass exit codes to the build system through semihosting calls.
If any of them fails make check fails as well.

--=20
Thanks.
-- Max
