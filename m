Received: from eggs.gnu.org ([2001:4830:134:3::10]:38453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fspKj-0002HB-Oq
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fspKg-0008Vu-HL
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:07:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53417 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
	id 1fspKg-0007rC-4d
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:07:26 -0400
in-reply-to: <CAFEAcA-hb1yVNy=GHvksLJ5MuNEk-8UKROEyjvZRjV8muQ1YiQ@mail.gmail.com>
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
message-id: <26f7-5b7eb180-5-64cbfb80@151998282>
date: Thu, 23 Aug 2018 15:06:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?Pz09P3V0Zi04P3E/IFtQVUxMIHYzIDAwLzQ2XSBN?=
 =?utf-8?q?IPS_queue_August_21=2C_2018_v3?=
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


> -------- Original Message --------
> Subject: Re: [PULL v3 00/46] MIPS queue August 21, 2018 v3
> Date: Thursday, August 23, 2018 12:19 CEST
> From: Peter Maydell <peter.maydell@linaro.org>
> To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> CC: QEMU Developers <qemu-devel@nongnu.org>
> References: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt=
-rk.com>
>
>
>
> > On 21 August 2018 at 14:31, Aleksandar Markovic
> > <aleksandar.markovic@rt-rk.com> wrote:
> > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > >
> > > The following changes since commit 659b11e7a7239529cfdb4968418268=
ff9aa22d88:
> > >
> > > Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for=
-3.1-pull-request' into staging (2018-08-21 11:36:15 +0100)
> > >
> > > are available in the git repository at:
> > >
> > > https://github.com/AMarkovic/qemu tags/mips-queue-aug-21-2018
> > >
> > > for you to fetch changes up to 7bfa634d0a73b74f2b84a5cd13d055e612=
10c356:
> > >
> > > target/mips: Add definition of nanoMIPS I7200 CPU (2018-08-21 14:=
59:32 +0200)
> > >
> > > ----------------------------------------------------------------
> > > MIPS queue August 21, 2018 v3
> > >
> > > In v2, the initial ('since') commit was wrong.
> > > In v1, there were three missing "Reviewed-by" lines. Please use
> > >
> > > ----------------------------------------------------------------
> >
> > Hi; I'm afraid this fails to build on clang for the linux-user
> > targets:
> >
> > /home/petmay01/linaro/qemu-for-merges/target/mips/translate.c:1947:=
20:
> > error: unused function 'check=5Fcp0=5Fmt' [-Werror,-Wunused-functio=
n]
> > static inline void check=5Fcp0=5Fmt(DisasContext *ctx)
> > ^
> > 1 error generated.
> >
> > This function is only called inside #ifndef CONFIG=5FUSER=5FONLY
> > sections, but the function definition is not similarly guarded.
> >
> > thanks
> > -- PMM
>

OK. My bad. I am preparing a corrected pull request. Build tests are ru=
nning for each patch. If all is well, I am going to send v4 afterwards.=


Thanks,
Aleksandar

=C2=A0
