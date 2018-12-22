Received: from eggs.gnu.org ([2001:4830:134:3::10]:34882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gafQB-0006hH-4z
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 06:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gafQA-0004ED-HT
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 06:26:19 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:32975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gafQA-0004Dy-DA
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 06:26:18 -0500
Received: by mail-oi1-x231.google.com with SMTP id c206so6907331oib.0
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 03:26:18 -0800 (PST)
MIME-Version: 1.0
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
	<42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
In-Reply-To: <42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 22 Dec 2018 11:26:05 +0000
Message-ID: <CAFEAcA85Gi1u_x3fdXLtDgQpHcoik9KggidK2+AJL4xtP6U=aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/35] Misc patches for 2018-12-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sat, 22 Dec 2018 at 08:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 21/12/18 22:09, Peter Maydell wrote:
> > I don't really understand what's going on here, or why
> > it only happens with this one system (my main x86-64
> > Linux Ubuntu 16.04.5 box) and not the various others I'm
> > running test builds on. But it does seem to be 100%
> > reliable with any of these pullreqs with the new test
> > driver in them :-(
>
> I'm afraid something in your setup is causing make's stdout to have
> O_NONBLOCK set.  Make doesn't use O_NONBLOCK at all, so it must be
> something above it.  I also checked Perl with strace and, at least here,
> it doesn't set O_NONBLOCK.
>
> So here are some ideas... First, can you try applying something like
> this to reproduce?

OK, I'll give these a go, but it'll have to be in January now.

thanks
-- PMM
