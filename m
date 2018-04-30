Received: from eggs.gnu.org ([2001:4830:134:3::10]:53913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fDA2w-0007xs-Ua
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fDA2s-0006T8-Tz
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:44:55 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:40453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1fDA2s-0006SD-Mb
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:44:50 -0400
Received: by mail-io0-x230.google.com with SMTP id g14-v6so6746153ioc.7
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 07:44:50 -0700 (PDT)
MIME-Version: 1.0
Sender: wlosh@bsdimp.com
In-Reply-To: <CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
	<CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 30 Apr 2018 08:44:48 -0600
Message-ID: <CANCZdfq8mmNV0zZvbejBaJ=qiBEarqHSYNsVC6NPyTZfxXQMAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Large patch set advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Apr 26, 2018 at 2:11 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 25 April 2018 at 20:57, Warner Losh <imp@bsdimp.com> wrote:
> > I=E2=80=99ve foolishly volunteered to rebase all the changes that the b=
ad-user
> > mode folks have done to a recent master rev to get these changes
> upstreamed.
> > A number of people have been working on this for a long time. It=E2=80=
=99s
> possible
> > now to run almost any FreeBSD binary from all the architectures. We use
> it
> > to do =E2=80=98native=E2=80=99 builds of tens of thousands of packages =
in a chroot (so
> > building FreeBSD/arm packages on a FreeBSD amd64 box). The diffs are
> quite
> > large (on the order of 42k lines), so I anticipate some bumps in moving
> > this stuff upstream.
>
> So, first up, thanks for agreeing to do this. It sounds from your
> mail like you're already pretty well aware of the usual pitfalls
> with this kind of work, and I don't really have much to add that's
> QEMU specific that nobody else has said already.
>
> One question I do have is about the other BSDs: bsd-user at least
> in theory is supposed to support freebsd, netbsd and openbsd.
> Your patchsets should fix freebsd, but do you know what the status
> is of netbsd and openbsd? Upstream we do compiletest but no runtime
> testing; I think last time I tried it they didn't work very well,
> but it would be worth checking with the other BSDs downstream to
> see if they're using bsd-user and to make sure we don't break anything
> that is currently working for netbsd/openbsd...
>

I've made inquiries. People are aware of the sbruno branch I'm working to
merge. The consensus is that for NetBSD and OpenBSD both the current
upstream code as well as the current sbruno branch code's status is totally
broken. The sbruno branch people have said looks interesting, but doesn't
materially change what's working.

The testing aspect has me intrigued. How hard would it be to add testing
done for bsd-user to your upstream tests? Before this project, I've only
ever been a qemu user, and even then only around the edges so I'm not
familiar with what's available. For the sake of argument, you can assume
FreeBSD has its own testbed we use, some useful subset of which could be
leveraged into an extended unit test.

Finally, another poster suggested that delete and repopulate would be an
option. While I haven't made any final decisions on whether I want to go
that way, I'd like to know from Peter if he would accept things that way. I
think it may be easier for me to submit something like that, but on the
other hand the boiling the patches down even from 300 to 190 (where the
work stands at the moment) has identified some interesting issues I need to
chase down (mostly relating to either inappropriate for upstreaming patches
mixed in, or relating to what looks like a mismerge a few months ago due to
git + long-lived-branch + merges having... I'll be nice and say 'challenges
when changes collide').

Thanks for all the advice so far and not giving me too much grief over my
epic typos :).

Warner
