Received: from eggs.gnu.org ([209.51.188.92]:60980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkYAU-0004hj-PS
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkYAS-0005QW-Mw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:42:58 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:34985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkYAQ-0005LG-Nl
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:42:55 -0500
Received: by mail-oi1-x229.google.com with SMTP id v6so9615509oif.2
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
	<20190117183002.GA21582@flamenco>
	<CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
	<20190117200805.GA14264@flamenco> <87va2lyibo.fsf@linaro.org>
In-Reply-To: <87va2lyibo.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 17:42:41 +0000
Message-ID: <CAFEAcA_DzOnc6HmPhbtCoru2N-cRZr4rgHAsTamFG_F8oQg0mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 18 Jan 2019 at 17:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Emilio G. Cota <cota@braap.org> writes:
>
> > On Thu, Jan 17, 2019 at 18:55:33 +0000, Peter Maydell wrote:
> >> configure has logic to check whether it can use particular
> >> warning enable/disable flags. Newer gcc (and I hope clang
> >> but forget) will happily silently allow -Wno-random-new-thing
> >> even if they don't support -Wrandom-new-thing) but I'm not
> >> sure our minimum compiler version is yet new enough to
> >> be able to rely on that (indeed the warning messages suggest
> >> it is not).
> >
> > I figured that -Wno-unitialized is documented to work on both
> > gcc and clang, and the change in testfloat drops the need
> > for no-discarded-qualifiers, so we can go with this without
> > messing with configure.
>
> Works for me, OK with you Peter?

If it builds on all the build machines it's ok. If it doesn't
I'll bounce the pullreq and you can figure out a different
approach :-)

thanks
-- PMM
