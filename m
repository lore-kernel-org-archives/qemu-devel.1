Received: from eggs.gnu.org ([2001:4830:134:3::10]:32955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYdk2-000893-Gh
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 16:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYdjz-000114-PO
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 16:14:25 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:45020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYdjz-0000ya-3A
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 16:14:23 -0500
Received: by mail-ot1-x334.google.com with SMTP id f18so10348074otl.11
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 13:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20181214031923.29527-1-richard.henderson@linaro.org>
	<CAFEAcA-7irqz__ZywybEORVtZiZgRGESFJaxdZShrKruuOACGw@mail.gmail.com>
	<6b3c561e-44d4-b15c-f6a9-e436ad47638f@linaro.org>
	<CAFEAcA9ruCb+aiUc2LSrSJ4wJSW5e4ui7xmzZGoPMwsELawW-A@mail.gmail.com>
	<66629a63-ad82-a7c6-6372-3266329e4945@linaro.org>
In-Reply-To: <66629a63-ad82-a7c6-6372-3266329e4945@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Dec 2018 21:14:09 +0000
Message-ID: <CAFEAcA9X8AxTZ-y1jz8xn2dJN+BDSfgZigGMwfHpc1+Ng5C7TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/32] tcg patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sun, 16 Dec 2018 at 20:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/16/18 4:43 AM, Peter Maydell wrote:
> > On Sun, 16 Dec 2018 at 07:03, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > You have access to the gcc compile farm, right? The sparc
> > tests run on gcc202.fsffrance.org.
>
> Ah.  I thought that machine had gone away.

Yeah, I think there were hardware issues, but they have
been resolved.

> That assertion turns out to be an existing bug.  I'm not sure what within this
> patch set triggers it, but my solution in the short term will be to revert
> ab20bdc1162.
>
> Would you like me to re-send the pull request with this fixed, or may I address
> this in the next patch set?

I need a fix before I can apply the pull request (as part of
the v2 pullreq is OK), because this is part of my standard test
set for merges and so I can't merge anything that makes it fail
tests.

thanks
-- PMM
