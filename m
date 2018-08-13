Received: from eggs.gnu.org ([2001:4830:134:3::10]:42251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.tribble@gmail.com>) id 1fp9lk-0003WB-8k
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.tribble@gmail.com>) id 1fp9li-00078v-Sg
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:08:12 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f]:45260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.tribble@gmail.com>)
	id 1fp9li-00078d-Lc
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:08:10 -0400
Received: by mail-ua1-x92f.google.com with SMTP id k8-v6so8516713uaq.12
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 03:08:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180813083408.GG22904@redhat.com>
References: <5B7054D9.9000209@gmx.com> <20180813083408.GG22904@redhat.com>
From: Peter Tribble <peter.tribble@gmail.com>
Date: Mon, 13 Aug 2018 11:08:09 +0100
Message-ID: <CAEgYsbEQpnVn-hWgQxBmCfiTnU7eOdA+sdscpAHo=+KH17bnuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU on Solaris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michele Denber <mdenber@gmx.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Aug 13, 2018 at 9:34 AM, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:

> On Sun, Aug 12, 2018 at 11:40:09AM -0400, Michele Denber wrote:
> > After configuring QEMU on my Sun I got this message:
> >
> > "Host OS SunOS support is not currently maintained.
> > The QEMU project intends to remove support for this host OS in
> > a future release if nobody volunteers to maintain it and to
> > provide a build host for our continuous integration setup.
> > configure has succeeded and you can continue to build, but
> > if you care about QEMU on this platform you should contact
> > us upstream at qemu-devel@nongnu.org."
> >
> > Well I do care about QEMU on my platform so I'd like to volunteer to
> provide
> > a host for support.  I can provide you with a free account on my Sun
> Oracle
> > Enterprise M3000 quad-core 2.75 GHz. SPARC64 VII running Solaris 10
> Update
> > 11.  I've got plenty of spare CPU cycles and lots of free disk.  Please
> let
> > me know.
>
> Copying Peter, as he would need access to a Solaris host to do GIT
> pre-merge
> build testing.
>
> Then there's the question of what ordinary developers would use for their
> own
> testing if they needed to work on some portability issue. We've got suppo=
rt
> in tree for running builds against VM images for the various *BSDs, and
> have
> mingw cross build toolchain for Windows. Is it possible to provide
> free-to-use
> VM disk images for Solaris build testing, or are software licensing
> requirements
> going to get in the way of developers using them ?
>
> There is OpenIndiana that forked off OpenSolaris, but I'm unclear how far
> OpenIndiana and commercial Solaris have diverged since then ?
>

>From the point of view of software such as qemu, divergences should be
slight
(there are going to be changes around packaging, shipped compilers, but
that's
true for different Linux distros in the same family). If it builds and
works on
Solaris, it'll build and work on one of the illumos distributions, and vice
versa.
(Although I note that's Solaris 10 mentioned above, which is now EOL, and
may be a little more problematic due to its age.)

You can certainly run illumos (such as OpenIndiana or Tribblix) in a VM
easily,
and freely. I can help with that.

That's for x86, of course. Building on a SPARC platform is a different
matter
entirely. (Although that's one of the reasons some of us are interested in
qemu
in the first place.)

Thanks,

--=20
-Peter Tribble
http://www.petertribble.co.uk/ - http://ptribble.blogspot.com/
