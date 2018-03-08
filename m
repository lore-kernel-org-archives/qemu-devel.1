Received: from eggs.gnu.org ([2001:4830:134:3::10]:44060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ettne-0006cT-42
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ettna-0000gP-J8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:33:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ettna-0000fv-Di
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:33:26 -0500
Date: Thu, 8 Mar 2018 11:33:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308113313.GK4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_G1tHrBZ=GxAy0b-SLbYU2-XOAUNL0D=8MQeL0Roz_cQ@mail.gmail.com>
	<CAHNT7NtRnSB-GYHp=v3iM7+_72y43YpZesbYCrnTvCikTiUMuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHNT7NtRnSB-GYHp=v3iM7+_72y43YpZesbYCrnTvCikTiUMuw@mail.gmail.com>
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
To: Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Thu, Mar 08, 2018 at 11:10:00AM +0000, Michael Clark wrote:
> On Thu, 8 Mar 2018 at 11:02 PM, Peter Maydell <peter.maydell@linaro.org=
>
> wrote:
>=20
> > On 6 March 2018 at 19:46, Michael Clark <mjc@sifive.com> wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > The following changes since commit
> > f32408f3b472a088467474ab152be3b6285b2d7b:
> > >
> > >   misc: don't use hwaddr as a type in trace events (2018-03-06 14:2=
4:30
> > +0000)
> > >
> > > are available in the git repository at:
> > >
> > >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-=
v8.2
> > >
> > > for you to fetch changes up to 7051b081bf6796e5e84406f6223a7c4900bf=
7298:
> > >
> > >   RISC-V - Remove support for adhoc non-standard X_COP local-interr=
upt
> > (2018-03-07 08:36:03 +1300)
> >
> >
> > Hi -- I would have applied this, but some of the commits
> > have no signed-off-by lines.
> >
> > This is important, and I've already asked for it once. We cannot
> > accept anything that doesn't have a clear record in the commit
> > message of everybody (person or company) who's contributed code
> > to it, indicating that they're happy for their copyrighted
> > contributions to be taken into QEMU under our license. Lists
> > of names without emails in the cover letter are not sufficient.
> >
> > In fact a lot of the last part of this patchset looks like
> > unreviewed changes/fixes that if we were going to have them we
> > should have squashed into the correct patches and resent the
> > series for review. Please don't do this. Code review is an
> > important part of how the QEMU project works.
>=20
>=20
> You must be looking at the wrong tag. There are multiple sign-offs in a=
ll
> 23 commits. The tag is riscv-qemu-upstream-v8.2. Sagar and Bastian
> contacted me out of band to add their sign-offs. Please look at the com=
mits
> again and tell me which commit id doesn=E2=80=99t have a sign-off on th=
at tag (23
> commits iirc)

I've just looked at the "riscv-qemu-upstream-v8.2" tag and confirm that
the sign-offs all appear present and corrrect to me.

There's checkpatch failures on several commits, but you've documented
rationale for ignoring the genuine failures, and the other failures are
false positives.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
