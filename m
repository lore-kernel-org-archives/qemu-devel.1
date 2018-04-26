Received: from eggs.gnu.org ([2001:4830:134:3::10]:47395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fBmxc-0007mJ-Lx
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fBmxZ-0002fd-Jv
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:53:44 -0400
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:37312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1fBmxZ-0002fQ-DY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 15:53:41 -0400
Received: by mail-it0-x22d.google.com with SMTP id 71-v6so25340035ith.2
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 12:53:41 -0700 (PDT)
MIME-Version: 1.0
Sender: wlosh@bsdimp.com
In-Reply-To: <28c598cc-40e4-8191-a48c-5edf8eeb9cf0@gmx.com>
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
	<CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
	<28c598cc-40e4-8191-a48c-5edf8eeb9cf0@gmx.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 26 Apr 2018 13:53:40 -0600
Message-ID: <CANCZdfpWBLRbdY3rf8LwuxNPxMbB_HCZP6oBPJ4Kone6AeL5cQ@mail.gmail.com>
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
To: Kamil Rytarowski <n54@gmx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Apr 26, 2018 at 5:22 AM, Kamil Rytarowski <n54@gmx.com> wrote:

> On 26.04.2018 10:11, Peter Maydell wrote:
> > On 25 April 2018 at 20:57, Warner Losh <imp@bsdimp.com> wrote:
> >> I=E2=80=99ve foolishly volunteered to rebase all the changes that the =
bad-user
> >> mode folks have done to a recent master rev to get these changes
> upstreamed.
> >> A number of people have been working on this for a long time. It=E2=80=
=99s
> possible
> >> now to run almost any FreeBSD binary from all the architectures. We us=
e
> it
> >> to do =E2=80=98native=E2=80=99 builds of tens of thousands of packages=
 in a chroot (so
> >> building FreeBSD/arm packages on a FreeBSD amd64 box). The diffs are
> quite
> >> large (on the order of 42k lines), so I anticipate some bumps in movin=
g
> >> this stuff upstream.
> >
> > So, first up, thanks for agreeing to do this. It sounds from your
> > mail like you're already pretty well aware of the usual pitfalls
> > with this kind of work, and I don't really have much to add that's
> > QEMU specific that nobody else has said already.
> >
> > One question I do have is about the other BSDs: bsd-user at least
> > in theory is supposed to support freebsd, netbsd and openbsd.
> > Your patchsets should fix freebsd, but do you know what the status
> > is of netbsd and openbsd? Upstream we do compiletest but no runtime
> > testing; I think last time I tried it they didn't work very well,
> > but it would be worth checking with the other BSDs downstream to
> > see if they're using bsd-user and to make sure we don't break anything
> > that is currently working for netbsd/openbsd...
> >
>
> I'm looking forward to see it updated for FreeBSD first. We can
> reschedule NetBSD part for later.
>
> Feel free to CC me for code review.
>

Sure. Will do. Do you have NetBSD patches against the git repo as well?

Warner
