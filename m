Received: from eggs.gnu.org ([2001:4830:134:3::10]:44649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ettqf-0008Cc-6c
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ettqb-00023Y-L0
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:36:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ettqb-00023A-FT
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:36:33 -0500
Date: Thu, 8 Mar 2018 11:36:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308113630.GL4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_G1tHrBZ=GxAy0b-SLbYU2-XOAUNL0D=8MQeL0Roz_cQ@mail.gmail.com>
	<CAHNT7NtRnSB-GYHp=v3iM7+_72y43YpZesbYCrnTvCikTiUMuw@mail.gmail.com>
	<CAFEAcA9xMj_Wq_mxJU-vhUDidUKk+UVtCNGeGK-Hx_bcqkjMug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9xMj_Wq_mxJU-vhUDidUKk+UVtCNGeGK-Hx_bcqkjMug@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Thu, Mar 08, 2018 at 11:19:30AM +0000, Peter Maydell wrote:
> On 8 March 2018 at 11:10, Michael Clark <mjc@sifive.com> wrote:
> >
> > On Thu, 8 Mar 2018 at 11:02 PM, Peter Maydell <peter.maydell@linaro.o=
rg>
> > wrote:
> >>
> >> On 6 March 2018 at 19:46, Michael Clark <mjc@sifive.com> wrote:
> >> > -----BEGIN PGP SIGNED MESSAGE-----
> >> > Hash: SHA1
> >> >
> >> > The following changes since commit
> >> > f32408f3b472a088467474ab152be3b6285b2d7b:
> >> >
> >> >   misc: don't use hwaddr as a type in trace events (2018-03-06 14:=
24:30
> >> > +0000)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream=
-v8.2
> >> >
> >> > for you to fetch changes up to 7051b081bf6796e5e84406f6223a7c4900b=
f7298:
> >> >
> >> >   RISC-V - Remove support for adhoc non-standard X_COP local-inter=
rupt
> >> > (2018-03-07 08:36:03 +1300)
> >>
> >>
> >> Hi -- I would have applied this, but some of the commits
> >> have no signed-off-by lines.
> >>
> >> This is important, and I've already asked for it once. We cannot
> >> accept anything that doesn't have a clear record in the commit
> >> message of everybody (person or company) who's contributed code
> >> to it, indicating that they're happy for their copyrighted
> >> contributions to be taken into QEMU under our license. Lists
> >> of names without emails in the cover letter are not sufficient.
> >>
> >> In fact a lot of the last part of this patchset looks like
> >> unreviewed changes/fixes that if we were going to have them we
> >> should have squashed into the correct patches and resent the
> >> series for review. Please don't do this. Code review is an
> >> important part of how the QEMU project works.
> >
> >
> > You must be looking at the wrong tag. There are multiple sign-offs in=
 all 23
> > commits. The tag is riscv-qemu-upstream-v8.2. Sagar and Bastian conta=
cted me
> > out of band to add their sign-offs. Please look at the commits again =
and
> > tell me which commit id doesn=E2=80=99t have a sign-off on that tag (=
23 commits
> > iirc)
>=20
> I'm looking at the one this email tells me to pull:
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v8.2
>   changes up to 7051b081bf6796e5e84406f6223a7c4900bf7298
>=20
> Commit 7051b081bf6796e5e84406f6223a7c4900bf7298,
> 9390ed5f4ca5fd3bde10ee2dcf4e7d915d1c189d,
> b38548c4057fb670950a4b94efe5c03b8aba4118,
> etc etc all have no signoff.

There's something peculiar going on when fetching the PR.

I did a 'git fetch riscv/riscv-qemu-upstream-v8.2' which pulled into
FETCH_HEAD. If i do 'git log FETCH_HEAD' then I see those commits
you mention as missing signoff.  If I instead do 'git log riscv-qemu-upst=
ream-v8.2'
then all the commits have signoffs - it ranges=20
4dc62b15323bb6338c4b426f76e92be55f87db8c...25fa194b7b11901561532e435beb83=
d046899f7a.

I'm confused why pulling the tag is populating extra commits into
FETCH_HEAD, that are seemingly not part of the tag.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
