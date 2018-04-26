Received: from eggs.gnu.org ([2001:4830:134:3::10]:47038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fBmvh-00073Z-Dh
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fBmve-0001k2-A6
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:51:45 -0400
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:55908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1fBmve-0001jh-1c
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:51:42 -0400
Received: by mail-it0-x231.google.com with SMTP id 144-v6so11159427iti.5
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 12:51:41 -0700 (PDT)
MIME-Version: 1.0
Sender: wlosh@bsdimp.com
In-Reply-To: <CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
	<CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 26 Apr 2018 13:51:40 -0600
Message-ID: <CANCZdfo+da8TRAxz=-69r-ert5b83FaXL=zkBWJGZ_w3n0oZeg@mail.gmail.com>
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

Yea, this isn't my first rodeo :)


> One question I do have is about the other BSDs: bsd-user at least
> in theory is supposed to support freebsd, netbsd and openbsd.
> Your patchsets should fix freebsd, but do you know what the status
> is of netbsd and openbsd? Upstream we do compiletest but no runtime
> testing; I think last time I tried it they didn't work very well,
> but it would be worth checking with the other BSDs downstream to
> see if they're using bsd-user and to make sure we don't break anything
> that is currently working for netbsd/openbsd...
>

I thought that was the empty set: I was under the impression that bsd-user
in upstream was basically totally broken and nothing non-trivial worked.
Since nothing is working, I'd posit that it follows that nobody could be
currently using it. I've certainly heard of no parallel efforts to make
similar changes for NetBSD/OpenBSD.

I have no plans to do any testing of NetBSD or OpenBSD binaries. The vast
majority of the patches are FreeBSD oriented, but the split is done such
that NetBSD and OpenBSD specific stuff can be augmented. Although
NetBSD/OpenBSD share a history with FreeBSD, only the first 150 syscalls or
so are the same. Around that time, the syscall numbers were assigned
independently, and the API/ABIs started to diverge, sometimes
significantly. The people that did the early work made sure that all the
BSDs could be supported, even if most of the focus has been on making
FreeBSD binaries work well.

Now, having said that, if somebody pops up and wants to do the work and
needs changes to make things work, I'm happy to work with them. I think
this is a reasonable approach, and matches what other projects I've been
involved with have expected.

Warner
