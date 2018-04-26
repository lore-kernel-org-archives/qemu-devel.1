Received: from eggs.gnu.org ([2001:4830:134:3::10]:58776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBc0j-0007Y7-Np
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBc0i-0002s9-L1
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:12:13 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:41621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBc0i-0002rj-GA
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:12:12 -0400
Received: by mail-ot0-x235.google.com with SMTP id t1-v6so8521757oth.8
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 01:12:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 09:11:51 +0100
Message-ID: <CAFEAcA9ycYWLJfog5ieugos2DzQGQHU5iyEAutPWCA7Pfr5HpQ@mail.gmail.com>
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
To: Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 April 2018 at 20:57, Warner Losh <imp@bsdimp.com> wrote:
> I=E2=80=99ve foolishly volunteered to rebase all the changes that the bad=
-user
> mode folks have done to a recent master rev to get these changes upstream=
ed.
> A number of people have been working on this for a long time. It=E2=80=99=
s possible
> now to run almost any FreeBSD binary from all the architectures. We use i=
t
> to do =E2=80=98native=E2=80=99 builds of tens of thousands of packages in=
 a chroot (so
> building FreeBSD/arm packages on a FreeBSD amd64 box). The diffs are quit=
e
> large (on the order of 42k lines), so I anticipate some bumps in moving
> this stuff upstream.

So, first up, thanks for agreeing to do this. It sounds from your
mail like you're already pretty well aware of the usual pitfalls
with this kind of work, and I don't really have much to add that's
QEMU specific that nobody else has said already.

One question I do have is about the other BSDs: bsd-user at least
in theory is supposed to support freebsd, netbsd and openbsd.
Your patchsets should fix freebsd, but do you know what the status
is of netbsd and openbsd? Upstream we do compiletest but no runtime
testing; I think last time I tried it they didn't work very well,
but it would be worth checking with the other BSDs downstream to
see if they're using bsd-user and to make sure we don't break anything
that is currently working for netbsd/openbsd...

thanks
-- PMM
