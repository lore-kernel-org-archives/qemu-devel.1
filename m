Received: from eggs.gnu.org ([209.51.188.92]:35044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmc8E-0002nj-Ua
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmbz5-0007sC-SE
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:11:44 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmbz5-0007k9-6m
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:11:43 -0500
Received: by mail-ot1-x342.google.com with SMTP id 32so4701404ota.12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 02:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20190124013625.27239-1-philmd@redhat.com>
	<777d8a79-39b8-d287-f09d-d0e2e1769536@comstyle.com>
In-Reply-To: <777d8a79-39b8-d287-f09d-d0e2e1769536@comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 10:11:28 +0000
Message-ID: <CAFEAcA8P5eo-VEfvQ+hJTUqWVDhqV4rH91seJUM3RBOHQfj32A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] ui/egl: Silent '__HAIKU__ undefined'
 warnings on OpenBSD 6.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On Thu, 24 Jan 2019 at 02:03, Brad Smith <brad@comstyle.com> wrote:
>
> https://cgit.freedesktop.org/mesa/mesa/commit/include/EGL/eglplatform.h?id=f744c6c1e28fe363474550b94af42a8b7fc1c755
>
> Unfortunately that issue has only been fixed very recently.
>
> There is a possibility of us updating from Mesa 17.3.9 to 18.3.x which
> would bring in this header fix, but I don't know how long that will be
> and it's currently held up on us switching i386 from bfd ld to lld.
>
> So this header exists as is from 6.0 to the latest, most likely next release
> (6.5) too.
>
> Honestly I think it would be better to just ignore this particular
> issue. It's
> an issue with a header outside of QEMU and it will go away in time when
> Mesa is eventually updated.

Yes; I have been ignoring this warning for a while now
in my scripts that handle looking for warnings in build logs:

https://git.linaro.org/people/peter.maydell/misc-scripts.git/commit/greplogs?id=951983351baa2f27da4f4fe432fb55bf911d17e5

thanks
-- PMM
