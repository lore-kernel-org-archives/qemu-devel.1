Received: from eggs.gnu.org ([2001:4830:134:3::10]:47350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXVcI-0001oe-C3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXVcG-0006c6-Sk
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:21:46 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXVcG-0006b4-F5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:21:44 -0500
Received: by mail-ot1-x342.google.com with SMTP id i20so2863389otl.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 10:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20181213175552.14857-1-wainersm@redhat.com>
	<CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
	<cccf3c43-0e51-bbbc-3676-17286b11ec99@redhat.com>
In-Reply-To: <cccf3c43-0e51-bbbc-3676-17286b11ec99@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 18:21:29 +0000
Message-ID: <CAFEAcA9CpR=JGt74=xaUddYhf5SCOoeHH_v+O1L+rrTygZ7quQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 13 Dec 2018 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 13/12/18 19:01, Peter Maydell wrote:
> > I sent a patch to do this a little while back:
> >  https://patchwork.kernel.org/patch/10561557/
> >
> > It didn't get applied because Paolo disagreed with having
> > our tools enforcing what our style guide says.
>
> I didn't disagree with that---I disagreed with having a single style in
> the style guide, because unlike most other blatant violations of the
> coding style (eg. braces), this one is pervasive in maintained code and
> I don't want code that I maintain to mix two comment styles.
>
> So I proposed two alternatives:
>
> - someone fixes all the comment blocks which are "starred" but don't
> have a lone "/*" at the beginning, and then we can commit that patch;
>
> - we allow "/* foo" on the first line, except for doc comments and for
> the first line of the file (author/license block), and fix the style
> guide accordingly.

We came to a consensus on the comment style when we discussed
the patch which updated CODING_STYLE. I'm not personally
a fan of the result (I used to use "/* foo"), but what we have in the
doc is what we achieved consensus for. I'm not going to reopen
the "what should block comments look like" style debate.

We have always had older code which isn't following the new style,
and our general approach is that we don't do mass-style-fix patches
across the whole codebase. If you as a maintainer of a particular
sub-area want to do a style update you're free to do that.

thanks
-- PMM
