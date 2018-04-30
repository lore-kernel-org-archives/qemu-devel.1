Received: from eggs.gnu.org ([2001:4830:134:3::10]:58384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDAMw-00051f-B6
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDAMv-00034T-58
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:05:34 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:33647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDAMu-00033z-Kj
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:05:33 -0400
Received: by mail-ot0-x22e.google.com with SMTP id l22-v6so9819474otj.0
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 08:05:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANCZdfq8mmNV0zZvbejBaJ=qiBEarqHSYNsVC6NPyTZfxXQMAg@mail.gmail.com>
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
	<CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
	<CANCZdfq8mmNV0zZvbejBaJ=qiBEarqHSYNsVC6NPyTZfxXQMAg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 16:05:11 +0100
Message-ID: <CAFEAcA9B1Ur3KoKvpF3tH8nxzLfW=m7F7QxHxo_cSkDL7Q0wMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Large patch set advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 April 2018 at 15:44, Warner Losh <imp@bsdimp.com> wrote:
> The testing aspect has me intrigued. How hard would it be to add testing
> done for bsd-user to your upstream tests? Before this project, I've only
> ever been a qemu user, and even then only around the edges so I'm not
> familiar with what's available. For the sake of argument, you can assume
> FreeBSD has its own testbed we use, some useful subset of which could be
> leveraged into an extended unit test.

The problem we've traditionally had is that when you're building
and testing qemu on host architecture A, you can't guarantee to
have a suitable cross building environment for architecture B
so that you can build the test guest executables you want to run
under QEMU to test whether qemu-B works. (For linux-user we're
currently looking at using docker to provide consistent working cross
environments, but that is work-in-progress.)

> Finally, another poster suggested that delete and repopulate would be an
> option. While I haven't made any final decisions on whether I want to go
> that way, I'd like to know from Peter if he would accept things that way. I
> think it may be easier for me to submit something like that, but on the
> other hand the boiling the patches down even from 300 to 190 (where the work
> stands at the moment) has identified some interesting issues I need to chase
> down (mostly relating to either inappropriate for upstreaming patches mixed
> in, or relating to what looks like a mismerge a few months ago due to git +
> long-lived-branch + merges having... I'll be nice and say 'challenges when
> changes collide').

If we definitely don't care about the current functionality of upstream
for any of the BSDs (and it sounds like we don't -- thanks for looking
into that), then I think the main concern is "what is easiest to code
review". Which approach gives the most digestible patches for code
review probably depends on how much of the existing code and structure
remains after all the changes; that's a judgement call you're probably
in a better position to make. Either way I would still like to see
patches that are each of a reasonable size and provide coherent chunks of
functionality.

thanks
-- PMM
