Received: from eggs.gnu.org ([209.51.188.92]:44927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjLkA-0006UO-Ij
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjLk8-0005qF-IN
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:14:50 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:34787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gjLk8-0005ou-B4
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:14:48 -0500
Received: by mail-ot1-x330.google.com with SMTP id t5so2019818otk.1
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 02:14:46 -0800 (PST)
MIME-Version: 1.0
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
	<30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
	<871s5fp54s.fsf@linaro.org>
	<e94b51d7-c90f-b599-fb68-ea8c2603989b@redhat.com>
	<87zhs3nk1m.fsf@linaro.org>
	<a0646a85-603d-99a8-c676-76e43a42e0fb@twiddle.net>
	<87y37monyr.fsf@linaro.org>
In-Reply-To: <87y37monyr.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Jan 2019 10:14:34 +0000
Message-ID: <CAFEAcA8u4AdhW-MF6uMP7=B4iYVO9ZEQCtcQKpN6KWALwAfLnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] include/fpu/softfloat: Fix compilation
 with Clang on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>

On Mon, 14 Jan 2019 at 22:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Richard Henderson <rth@twiddle.net> writes:
> > But perhaps
> >
> >     unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
> >     *r =3D n % d;
> >     return n / d;
> >
> > will allow the compiler to do what the assembly does for some 64-bit
> > hosts.
>
> I wonder how much cost is incurred by the jumping to the (libgcc?) div
> helper? Anyone got an s390x about so we can benchmark the two
> approaches?

The project has an s390x system available; however it's usually
running merge build tests so not so useful for benchmarking.
(I can set up accounts on it but that requires me to faff about
figuring out how to create new accounts :-))

thanks
-- PMM
