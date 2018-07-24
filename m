Received: from eggs.gnu.org ([2001:4830:134:3::10]:50146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fhsCZ-0004Q5-NE
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fhsCV-00073A-LR
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:57:47 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1fhsCV-000731-FU
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:57:43 -0400
Received: by mail-ua0-f194.google.com with SMTP id c12-v6so1773868uan.3
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 00:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180717195553.9111-1-alex.bennee@linaro.org>
	<87o9eytgju.fsf@linaro.org>
In-Reply-To: <87o9eytgju.fsf@linaro.org>
From: Fam Zheng <famz@redhat.com>
Date: Tue, 24 Jul 2018 15:57:06 +0800
Message-ID: <CAK1Eb9=_s=9U+0SXhDEcNaN_RAkN5+sBTo4OtfnqcJYJv=4q-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for 3.0 00/18] docker fixes (and one tcg
 test tweak)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: cota@braap.org, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, balrogg@gmail.com, aurelien@aurel32.net, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jul 23, 2018 at 6:03 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Hi,
> >
> > I've missed the boat for today's rc1 but I'd like to get this merged
> > before rc2. The new docker.py change is technically new functionality
> > but I'm counting it as a usability bug fix as it replaces a random
> > back trace failure with a preemptive failure and message mentioning
> > binfmt_misc configuration. This would have saved Richard a lot of head
> > scratching as he tried to setup a powerpc-user setup to test his
> > setcontext fix (he had a custom binfmt_misc pointing to his src tree).
> >
> > Finally we also drop the runcom test. It was cute that it got
> > resurrected but it is ultimately a pointless test for something I'm
> > sure no one actually uses.
> >
> > There will be a follow-up RFC series after this that cleans-up some of
> > the rough edges when your host is not an x86_64 box but that series
> > won't be targeting the 3.0 release.
> >
> > : The following patches need review
> > : patch docker/disable debian powerpc user cross.patch
> > : patch docker/drop QEMU_TARGET check fallback in EXECUTABLE.patch
> > : patch docker/Update debootstrap script after Debian migrat.patch
> > : patch docker/ignore distro versioning of debootstrap.patch
> > : patch docker/perform basic binfmt_misc validation in docke.patch
> > : patch tests/tcg remove runcom test.patch
>
> Ping?

I had questions about patch 13 and 17. Otherwise looks good.
=E2=80=8B Maybe you can drop them for now (including patch 9) and send the =
PULL for
the rest.=E2=80=8B
I don't know if we can catch up -rc2 but I guess the testing fixes are
fairly safe to sneak in. :)

(My development machine is affected by
an
 office power outage, and I was
=E2=80=8B also=E2=80=8B
 busy with upgrading patchew.org. Sorry for the
=E2=80=8B =E2=80=8B
late reply
!)

Fam
