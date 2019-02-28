Received: from eggs.gnu.org ([209.51.188.92]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzOdY-0004mR-Vi
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzOdY-0003OK-6S
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:34:20 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzOdX-0003Ni-Lq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:34:20 -0500
Received: by mail-oi1-x243.google.com with SMTP id x187so16966453oia.7
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 08:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20190228145624.24885-1-peter.maydell@linaro.org>
	<20190228145624.24885-2-peter.maydell@linaro.org>
	<5d0eca90-1316-25a3-42d4-35f7dc5566be@redhat.com>
In-Reply-To: <5d0eca90-1316-25a3-42d4-35f7dc5566be@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 16:34:06 +0000
Message-ID: <CAFEAcA8k_yUOMrs_-svyTjrfc2BR5=oe31H59mk0JUmmqL79=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/11] docs/cpu-hotplug.rst: Fix rST
 markup issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Thu, 28 Feb 2019 at 16:14, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Then I moved this file in a watched dir. I see warnings are not fatal,
> and from the manpage there is the '-W' option:
>
>   sphinx-build(1)
>
>   -W     Turn warnings into errors.
>          This means that the build stops at the first warning
>          and sphinx-build exits with exit status 1.
>
> Can we use this by default, as of C warnings?

I didn't know about this option and it sounds like a good
idea. But we probably want to only enable it on git builds
(the same as with -Werror).

I think I'd rather add -W after this lands (so we can see if
it's generating warnings on any of our build hosts that would
cause build failure that we need to fix before enabling it).

thanks
-- PMM
