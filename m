Received: from eggs.gnu.org ([2001:4830:134:3::10]:44998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqGJi-0000du-IH
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqGJf-0003k6-EU
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:47:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eqGJf-0003jq-83
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:47:31 -0500
Date: Mon, 26 Feb 2018 10:47:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180226104723.GH14196@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<20180223101032.GA31076@redhat.com>
	<CAHNT7NvMMAD6sAT60RnLgFXwdFPWHEXtysMQt04Qejnpw30Bkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHNT7NvMMAD6sAT60RnLgFXwdFPWHEXtysMQt04Qejnpw30Bkg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Sat, Feb 24, 2018 at 09:05:49AM +1300, Michael Clark wrote:
> Dear Daniel,
>=20
> We've had this discussion on a recent pull request where some code was
> going to be copied directly from hw/arm/virt.c to hw/riscv/virt.c and w=
e
> have subsequently relicensed the recipient file as GPLv2+. This code ha=
s
> not yet been incorporated into the port. Besides naming conventions and=
 use
> of some common APIs, however the logic in hw/riscv/virt.c is original w=
ork.
> Try diffing them. I wrote the device tree code from scratch and we have=
 a
> unique memory map, and the other functions are dervied from other RISC-=
V
> machines which are MIT licensed.
>=20
> - https://github.com/riscv/riscv-qemu/pull/109
>=20
> In any case, SiFive are happy to license their contributions as GPLv2+.
> We'll need to get the main contributors to agree to re-license to GPLv2=
+ or
> fall back to having GPLv2+ prefix the MIT license, as MIT is compatible
> with GPLv2+. Stefan O'Rear has commented that he is happy for his code =
to
> be GPLv2+ and so is SiFive, but we'll need to get confirmation from Sag=
ar,
> one of the main port contributors, and potentially the whole list of
> contributors to do complete due diligence on re-licensing. i.e. if we w=
ant
> to eradicate MIT license from the code-base.
>=20
> SiFive have made substantial changes to all of the non-GPLv2+ files in =
the
> port, and SiFive can license their contributions as GPLv2+ which would
> allow us to prefix all files in hw/riscv with GPLv2+. The only issue is
> that we must get approval from contributors to completely remove the MI=
T
> license, as the original contributors licensed their code under that
> license, as is the case for all of Fabrice's original code and many oth=
er
> parts of the code base e.g. GPEX hw/pci-host/gpex.c.
>=20
> SiFive have made substantial changes to all files in the RISC-V port, s=
o we
> would be empowered to at least prefix the MIT license with GPLv2+.
>=20
> Is that acceptable? the MIT terms are compatible with GPLv2+ as MIT is =
a
> "permissive-license".

I accept that MIT is compatible with GPLv2+, so that's not an immediate l=
egal
problem. The issue is that as we add more & more different licenses to QE=
MU,
it becomes a maintenance burden to developers, especially when doing code
refactoring across files. You have to be careful you're not taking a piec=
e
of GPLv2+ code and copying/moving it into a file that's MIT licensed, as
that would be non-compliant. We already suffer this problem with our mixt=
ure
of GPLv2-only and GPLv2+ and LGPLv2+ and BSD licensed code. So I'm person=
ally
loathe to see us add yet another license to the mix.

Ultimately though, Peter Maydall is the one who has the final say on whet=
her
we'll pull the patch series. So I'll defer to him for a definitive answer=
 on
whether its OK for riscv files to add MIT license to the mix, either long
term or as a temporary state.


>=20
> 'cc Sagar, Bastian, as they have been main contributors to the port in =
the
> past...
>=20
> Regards,
> Michael.
>=20
> On Fri, Feb 23, 2018 at 11:10 PM, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com>
> wrote:
>=20
> > On Fri, Feb 23, 2018 at 01:11:46PM +1300, Michael Clark wrote:
> > > QEMU RISC-V Emulation Support (RV64GC, RV32GC)
> > >
> > > This is hopefully the "fix remaining issues in-tree" release.
> >
> > This code seems to be a mixture of LGPLv2+ and MIT licensed code. The
> > preferred license for QEMU contributions is GPLv2+. Is there a reason
> > you need to diverge from this or can it be changed to be all GPLv2+ ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
