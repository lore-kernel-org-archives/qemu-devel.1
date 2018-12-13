Received: from eggs.gnu.org ([2001:4830:134:3::10]:42167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXVIu-0002IM-Eh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXVIt-0005aY-Ej
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:01:44 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXVIt-0005XB-8h
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:01:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id e12so2777739otl.5
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 10:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20181213175552.14857-1-wainersm@redhat.com>
In-Reply-To: <20181213175552.14857-1-wainersm@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 18:01:29 +0000
Message-ID: <CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
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
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 13 Dec 2018 at 17:57, Wainer dos Santos Moschetta
<wainersm@redhat.com> wrote:
>
> Eduardo Habkost pointed out a malformed block of comments on my
> patch [1] that I had ran checkpatch.pl and no warn/error was
> reported. Then I realized the script does not catch such as
> case (or it had a bug).
>
> It turns out that checkpatch.pl does not parse comment blocks (If I understood
> its code correctly...). So I implemented a checker that warns about:
> 1. block doesn't begin on its own line.
> Example:
>   /* blah blah
>    * and blah blah
>    */

I sent a patch to do this a little while back:
 https://patchwork.kernel.org/patch/10561557/

It didn't get applied because Paolo disagreed with having
our tools enforcing what our style guide says.

Personally I think we should just commit my patch, and then
we can stop having people manually pointing out where
submitters' patches don't match CODING_STYLE.

thanks
-- PMM
