Received: from eggs.gnu.org ([2001:4830:134:3::10]:35634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1crscv-0001ya-JY
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 16:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1crscs-0005ZQ-AY
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 16:49:33 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:32700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1crscs-0005Z2-1r
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 16:49:30 -0400
Message-ID: <1490474958.11328.86.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Sat, 25 Mar 2017 21:49:18 +0100
In-Reply-To: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 2017-03-16 at 15:23 +0000, Peter Maydell wrote:
> OK, here's a concrete proposal for deprecating/dropping out of
> date host OS and architecture support.
>=20
> We'll put this in the ChangeLog 'Future incompatible changes'
> section:
> -----
> * Removal of support for untested host OS and architectures:
>=20
> The QEMU Project intends to drop support in a future release for any
> host OS or architecture which we do not have access to a build and test
> machine for. This affects the following host OSes:
> =C2=A0* Native CYGWIN building
> =C2=A0* GNU/kFreeBSD
> =C2=A0* FreeBSD
> =C2=A0* DragonFly BSD
> =C2=A0* NetBSD
> =C2=A0* OpenBSD
> =C2=A0* Solaris
> =C2=A0* AIX
> =C2=A0* Haiku
> and the following host CPU architectures:
> =C2=A0* ia64
> =C2=A0* sparc

Can we please keep the Sparc support in for a while still?

There is an increasing recognition of the value of better support for=C2=A0
QEMU within Oracle and hopefully we can get some traction on this in not to=
o
long.

I have colleagues currently looking at various ways forward
both in the direction of implementing support for newer Sparc architectures=
 in
QEMU and also investigating support for native KVM support for Linux on Spa=
rc.

When it comes to build platforms, a legitimate need to be able to keep anyt=
hing
running, I don't have any authority to promise away hardware or other forms=
 of
Sparc access, but I have been told that that part can be worked out in some=
 way
if we get enough support for this internally.=C2=A0

Thanks,
Knut

> Specifically, if we do not have a build and test system available
> to us by the time we release QEMU 2.10, we will remove support in the
> release that follows 2.10.
> -----
>=20
> I'm not sure here if we want to just have this as a bald list,
> or to have some kind of two tier setup with OSes we expect to
> dump in one tier and OSes where we're really trolling for a build
> machine in the other tier (the "unlikely to dump" category would
> get most of the BSD variants in it). Putting out a changelog
> that says "we're gonna drop all the BSDs" seems like it might
> produce a lot of yelling?
>=20
> Should "native CYGWIN" be in the drop list? I only test
> mingw cross compile, but configure has a separate section for
> CYGWIN in its $targetos case statement.
>=20
> It would also not be too difficult to make configure warn when it
> is run on the deprecated OS or architecture, so we should probably
> sneak that into 2.9.
>=20
> (Technically right this instant 'mips' and 's390' would be in the
> 'dump' list, since I don't personally have access yet. But we have
> a plan for s390, and it turns out there is a mips machine in the
> gcc compile farm which I'm just checking out.)
>=20
> thanks
> -- PMM
>=20
