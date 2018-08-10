Received: from eggs.gnu.org ([2001:4830:134:3::10]:48579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo6vL-00077r-Hh
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo6vK-0000Jx-Ni
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:53:47 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fo6vK-0000JQ-GS
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:53:46 -0400
Received: by mail-oi0-x241.google.com with SMTP id 8-v6so15654463oip.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 05:53:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <14a92c80-4aec-bd60-68fd-d6a68c8a63b6@redhat.com>
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
	<CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
	<9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
	<CAFEAcA_4M195VD57LyNVyWTLos140v2e7ymvuiY+rtJ4ZTCXwg@mail.gmail.com>
	<14a92c80-4aec-bd60-68fd-d6a68c8a63b6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Aug 2018 13:53:25 +0100
Message-ID: <CAFEAcA-wiHi5KhYYSh5+invSZUW2xqk9J6SoZihQqqbmDfXusg@mail.gmail.com>
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

On 10 August 2018 at 13:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 10/08/2018 11:10, Peter Maydell wrote:
>>> So my proposal, which is actually consistent with what QEMU is doing, is
>>> the following:
>>>
>>> 1) the first line of a file should always be "/*", otherwise warn
>>>
>>> 2) a comment that starts with "/**" should have it on a lone line
>>>
>>> 3) every other multiline comment should start with
>>> "/*<whitespace><something>"
>> Personally I would prefer your suggestion, but as I say, there
>> was no consensus in the thread for it, and there was consensus
>> for "use the kernel's style here". I don't think we gain much
>> from reopening the debate at this point.
>
> What we lose is that 3000 more new warnings appear.  So if we make an
> exception and convert all of the comments, I'm okay.
>
> But otherwise, at least Eric, you, me (only now I admit), Thomas
> expressed a preference for the other style; on the other side it's
> Markus, Stefan, Conny and Alex, some of whom were okay with applying
> maintainer discretion; John and rth wanted a third one but disagreed on
> their second choice.  I appreciate your writing the patch, but I'm not
> sure that's consensus...

What I strongly want is that checkpatch should (a) catch stuff
I get wrong and (b) catch stuff that other people get wrong,
so I don't have to nitpick over coding style myself (which I
have done for multiline comment style in the past). So to me
the current situation (checkpatch doesn't warn at all about
out-of-style multiline comments) is no good.

Nobody runs checkpatch on the whole existing codebase anyway,
do they? So I think "3000 new warnings" is a red herring.

thanks
-- PMM
