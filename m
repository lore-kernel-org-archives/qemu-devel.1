Received: from eggs.gnu.org ([209.51.188.92]:49285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzOVZ-0000W3-Mk
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzOVY-0007NK-Sb
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:26:05 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzOVX-0007Iq-2o
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:26:04 -0500
Received: by mail-ot1-x343.google.com with SMTP id n71so18175544ota.10
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 08:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20190228145624.24885-1-peter.maydell@linaro.org>
	<20190228145624.24885-10-peter.maydell@linaro.org>
	<7ec8917a-eabd-6a14-3c1f-38b1d429c900@redhat.com>
In-Reply-To: <7ec8917a-eabd-6a14-3c1f-38b1d429c900@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 16:25:39 +0000
Message-ID: <CAFEAcA-oRrH81xcYazGgDfiEmORcACtC6S6a96ZMoOMwy20QAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/11] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Thu, 28 Feb 2019 at 15:49, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 2/28/19 3:56 PM, Peter Maydell wrote:
> >  if test "$docs" !=3D "no" ; then
> > -  if has makeinfo && has pod2man; then
> > +  if has makeinfo && has pod2man && has sphinx-build; then
>
> Unrelated to your patch, I tried that on fresh Fedora image where no
> python2 installed (on purpose). sphinx-build is not included in the
> suggested python3-sphinx. Once python2-sphinx installed (which pull a
> lot of py2 packages) I could test your series.

Yeah, Fedora gives the Python 3 version of the tool a silly name.
I'm told newer Fedora fix this.

> Again, not related to your patch, but 'make install-sphinxdocs' clone
> libfdt + capstone, requires C compiler to build libfdt.a and C++ to
> build libcapstone.a. Once both build we can generate the doc.

Yes, this sounds like an unrelated thing -- our makefiles
sometimes does more work than you expect because of some
things that we do up front (like building anything in
GENERATED_FILES, or doing this subdirs stuff). You can see
that sometimes when you do 'make clean' and it builds a
bunch of stuff before deleting it.

> > +# Sphinx builds all its documentation at once in one invocation
> > +# and handles "don't rebuild things unless necessary" itself.
> > +# The '.doctrees' files are cached information to speed this up.
>
> Can you add .doctrees to .gitignore?

Sure. I tend to forget about this because I never do in-tree
builds, so anything in the build directory doesn't show up
in git status separately.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks for the review.

-- PMM
