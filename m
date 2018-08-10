Received: from eggs.gnu.org ([2001:4830:134:3::10]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3RM-0004EC-RW
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3RL-0005EO-TV
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:10:36 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fo3RL-0005Du-OF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:10:35 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so14648882oiw.8
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 02:10:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
	<CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
	<9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Aug 2018 10:10:14 +0100
Message-ID: <CAFEAcA_4M195VD57LyNVyWTLos140v2e7ymvuiY+rtJ4ZTCXwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Thomas Huth <thuth@redhat.com>

On 10 August 2018 at 09:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This is one of the cases where we are decently consistent:
>
> Lone "/*" or "/**": 9986 cases
>         of which in the first column: 7617
>         of which the first line in the file (license headers): 2834
>         regex: ^[ \t]*/\*\*?[ \t]*$
>
> "/*" with the first line of the comment: 11246
>         of which in the first column: 4985
>         of which the first line in the file: 97
>         regex: ^[ \t]*/\*\*?+(?:(?!\*/).)+?$
>
> License headers almost always have the "lone /*" format.  Apart from
> license headers, 63% of the comments have the now-deprecated format.
>
> Inside functions, 73% of the comments have the now-deprecated format.
> Outside functions it's 50-50.  That's because there are 2024 doc
> comments, which in turn are 50% of the comments that are 1) outside the
> functions 2) using a lone "/*".
>
> So my proposal, which is actually consistent with what QEMU is doing, is
> the following:
>
> 1) the first line of a file should always be "/*", otherwise warn
>
> 2) a comment that starts with "/**" should have it on a lone line
>
> 3) every other multiline comment should start with
> "/*<whitespace><something>"

Personally I would prefer your suggestion, but as I say, there
was no consensus in the thread for it, and there was consensus
for "use the kernel's style here". I don't think we gain much
from reopening the debate at this point.

thanks
-- PMM
