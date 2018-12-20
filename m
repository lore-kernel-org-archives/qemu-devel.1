Received: from eggs.gnu.org ([2001:4830:134:3::10]:43302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ga2KW-0006KD-Br
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ga2KU-0002pD-91
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:41:52 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ga2KQ-0002iy-D7
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:41:48 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so2638389otm.13
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 09:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20181220123655.30475-1-pbonzini@redhat.com>
	<CAFEAcA_=kHDpwcwnEaVEAfD8fQ_UkjKcs_+k_DpQpo9KvF_nhg@mail.gmail.com>
In-Reply-To: <CAFEAcA_=kHDpwcwnEaVEAfD8fQ_UkjKcs_+k_DpQpo9KvF_nhg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Dec 2018 17:41:32 +0000
Message-ID: <CAFEAcA-AKFxFOdd8PMKC0aMb_NPvhu0KMVcgOP+wUNfy5Qh84g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 20 Dec 2018 at 17:38, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 20 Dec 2018 at 12:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit e85c577158a2e8e252414959da9ef15c12ee=
c63d:
> >
> >   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2=
018-12-17' into staging (2018-12-18 14:31:06 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to b4e8bbb9ae50045160957e7ab66c4f1cae535ea4=
:
> >
> >   avoid TABs in files that only contain a few (2018-12-19 16:03:22 +010=
0)
> >
> > ----------------------------------------------------------------
> > * HAX support for Linux hosts (Alejandro)
> > * esp bugfixes (Guenter)
> > * Windows build cleanup (Marc-Andr=C3=A9)
> > * checkpatch logic improvements (Paolo)
> > * coalesced range bugfix (Paolo)
> > * switch testsuite to TAP (Paolo)
> > * QTAILQ rewrite (Paolo)
> > * block/iscsi.c cancellation fixes (Stefan)
> > * improve selection of the default accelerator (Thomas)
>
> This seemed to work on most of my test hosts but something
> weird happened here: hyperlong repetitive command line and
> looks like make got an "fwrite(): Resource temporarily unavailable"
> halfway through writing it out??
>
> This was on my x86-64 Linux Ubuntu system, clang build
> which I configure with '--cc=3Dclang' '--cxx=3Dclang++' '--enable-gtk'
> '--extra-cflags=3D-fsanitize=3Dundefined  -fno-sanitize=3Dshift-base -Wer=
ror';
> the error is during the 'make -C build/clang check V=3D1' phase.

Checking my logfiles I think that the previous pull request
apply attempt also failed this way, but I didn't notice
because of the other failures on other hosts. It may be
the combination of the huge command line and the way my
test setup uses GNU parallel and ssh to capture the make
output into a logfile.

thanks
-- PMM
