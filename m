Received: from eggs.gnu.org ([209.51.188.92]:55567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQo7-0006MH-5x
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQo6-00086S-E8
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:39:55 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goQo6-000868-4a
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:39:54 -0500
Received: by mail-oi1-x236.google.com with SMTP id x202so15693597oif.13
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 02:39:54 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
	<20190129103602.GB16847@redhat.com>
In-Reply-To: <20190129103602.GB16847@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 10:39:41 +0000
Message-ID: <CAFEAcA-8dkT01rHPjO8aC7eC1a6=cugdZRMnMVW_BUdd-AW+4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] building rst docs with sphinx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 29 Jan 2019 at 10:36, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> On Thu, Jan 24, 2019 at 06:56:09PM +0000, Peter Maydell wrote:
> > (1) configure: My thought is that we should just make
> > sphinx-build a requirement for the existing --enable-docs
> > switch (as texinfo and pod2man are currently). The
> > disadvantage is that we won't support a "build the half
> > of the docs you have the tools for and leave the others"
> > setup. The advantage, which I think is significant, is that
> > distros will naturally be directed to the missing build
> > dependency (either they're building with --enable-docs
> > and will get the configure message, or they aren't and
> > then their build will fail later because of missing docs
> > files when they try to put the built files into the package).
>
> Currently in Fedora RPMs we ship the man pages and the
> qemu-doc.html, qemu-ga-ref.html & qemu-qmp-ref.html files.
> I'm not really seeing stuff in docs/ that grabs me as very
> important to ship to users in Fedora RPMs. In fact I rather
> doubt anyone even looks at the HTML files we currently
> ship in the RPMs, as opposed to just looking in QEMU git.
> Aside from man pages, I imagine most users just turn to
> Google and/or qemu.org to find QEMU docs, not look inside
> the distro packages.
>
> IOW from a distro POV I think I'd probably find sphinx-build
> to be an undesirable mandatory dep.

The idea is that we would be aiming to transition all the
info that is currently in the other docs over to rST docs
(and also improve on the rST docs), i.e. we would want to
dump the current texinfo tooling eventually. It's true that
as build dep it doesn't bring much extra to the table to
start with, but that should change over time.

Is sphinx-build particularly nasty as a build-dep for distros,
or is it just "don't really want to add another thing" ?

thanks
-- PMM
