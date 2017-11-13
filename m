Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEEl2-0001Hq-6a
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEEkw-0004xj-9k
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:26:36 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:54845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEEkw-0004vx-3j
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:26:30 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r68so15224912wmr.3
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 05:26:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108153245.20740-2-alex.bennee@linaro.org>
References: <20171108153245.20740-1-alex.bennee@linaro.org>
	<20171108153245.20740-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 13:26:08 +0000
Message-ID: <CAFEAcA8OHOQ_8cG=fXyoqr6f9FiEyBx6zeRu=04cyojpEZVWcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] accel/tcg/translate-all: expand
 cpu_restore_state addr check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 8 November 2017 at 15:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> We are still seeing signals during translation time when we walk over
> a page protection boundary. This expands the check to ensure the host
> PC is inside the code generation buffer. The original suggestion was
> to check versus tcg_ctx.code_gen_ptr but as we now segment the
> translation buffer we have to settle for just a general check for
> being inside.
>
> I've also fixed up the declaration to make it clear it can deal with
> invalid addresses. A later patch will fix up the call sites.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>

Thanks; this fixes my test case. Patch 2 is just cleanup and looks
like it needs rework, so I'm taking patch 1 into target-arm
to put into master for rc1.

thanks
-- PMM
