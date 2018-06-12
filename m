Received: from eggs.gnu.org ([2001:4830:134:3::10]:41836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSlBG-000763-RC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fSlBB-0001ze-So
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:25:58 -0400
Date: Tue, 12 Jun 2018 17:25:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180612172548.43ab4143.cohuck@redhat.com>
In-Reply-To: <e4fc9a67-f3df-c040-8188-37eb3091db1a@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
	<4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
	<20180605151449.22aafbfc.cohuck@redhat.com>
	<e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
	<20180606142131.74ea2eb7.cohuck@redhat.com>
	<5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
	<20180607115442.6a779ed9.cohuck@redhat.com>
	<86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
	<20180608142022.7dd6a658.cohuck@redhat.com>
	<d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
	<20180608164514.2e8248f4.cohuck@redhat.com>
	<99ca65a2-ee33-6353-b6b7-aa4c07a34e2a@linux.ibm.com>
	<20180612115900.4aa319d1.cohuck@redhat.com>
	<d5416c61-252a-5bb8-aebe-46d883e5822e@linux.ibm.com>
	<e4fc9a67-f3df-c040-8188-37eb3091db1a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: pmorel@linux.ibm.com, Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 12 Jun 2018 16:08:42 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 06/12/2018 03:56 PM, Pierre Morel wrote:
> >> So,=C2=A0what=C2=A0are=C2=A0you=C2=A0proposing?=C2=A0Being=C2=A0more=
=C2=A0specific=C2=A0and=C2=A0stating=C2=A0that=C2=A0the
> >> scsw=C2=A0is=C2=A0not=C2=A0necessarily=C2=A0a=C2=A0real=C2=A0scsw,=C2=
=A0but=C2=A0merely=C2=A0a=C2=A0vehicle=C2=A0for=C2=A0sending=C2=A0a
> >> command?=C2=A0Or=C2=A0keeping=C2=A0it=C2=A0as=C2=A0it=C2=A0is=C2=A0now=
=C2=A0for=C2=A0ssch,=C2=A0and=C2=A0adding=C2=A0a=C2=A0second
> >> interface=C2=A0for=C2=A0hsch/csch=C2=A0(and=C2=A0maybe=C2=A0rsch,=C2=
=A0msch,=C2=A0...)?
> >> =20
> >=20
> >=20
> > I=C2=A0said=C2=A0no=C2=A0radical=C2=A0surgery,=C2=A0but=C2=A0after=C2=
=A0thinking=C2=A0more=C2=A0about=C2=A0it...
> > I=C2=A0am=C2=A0not=C2=A0sure.
> >=20
> > Let's=C2=A0explain=C2=A0this:
> >=20
> > I see 2 ways to proceed but my favorite is definitively to introduce ve=
rsioning.
> >=20
> >=20
> > Way=C2=A01)
> >=20
> > This=C2=A0was=C2=A0the=C2=A0way=C2=A0I=C2=A0first=C2=A0thought=C2=A0abo=
ut.
> > We=C2=A0keep=C2=A0the=C2=A0existing=C2=A0IO=C2=A0Regionand=C2=A0structu=
res,=C2=A0and=C2=A0are=C2=A0more
> > specific=C2=A0by=C2=A0stating=C2=A0that=C2=A0the=C2=A0io_region=C2=A0is=
=C2=A0a=C2=A0command=C2=A0region=C2=A0during=C2=A0write
> > entry=C2=A0and=C2=A0a=C2=A0status=C2=A0region=C2=A0during=C2=A0interrup=
t=C2=A0handling:
> > This=C2=A0allow=C2=A0us=C2=A0to=C2=A0use=C2=A0the=C2=A03=C2=A0bits=C2=
=A0of=C2=A0the=C2=A0FCTL=C2=A0field=C2=A0of=C2=A0the=C2=A0SCSW=C2=A0to=C2=
=A0pass
> > commands=C2=A0to=C2=A0the=C2=A0kernel=C2=A0and=C2=A0stay=C2=A0backward=
=C2=A0compatible. =20
> > The=C2=A0FCTL=C2=A0field=C2=A0has=C2=A03=C2=A0bits=C2=A0=3D>=C2=A0we=C2=
=A0can=C2=A0have=C2=A08=C2=A0commands. =20
> >=20
> > PRO:=C2=A0small=C2=A0change
> >=20
> > CONTRA:=C2=A0This=C2=A0is=C2=A0still=C2=A0confusing,=C2=A0we=C2=A0do=C2=
=A0not=C2=A0really=C2=A0solve=C2=A0this
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unclarity=C2=A0problem=
=C2=A0since=C2=A0QEMU=C2=A0view=C2=A0/=C2=A0documentation=C2=A0and
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Linux=C2=A0view=C2=A0/=
=C2=A0documentation=C2=A0differ=C2=A0or=C2=A0we=C2=A0update=C2=A0QEMU.
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Moreover=C2=A0this=C2=
=A0does=C2=A0not=C2=A0allow=C2=A0for=C2=A0long=C2=A0term=C2=A0extensions
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0and/or=C2=A0re-design.
> >=20
> >  =20
>=20
> I'm not really in favor of way 1. Conie's point with RSCH is a good one.
> And IMHO it speaks for a new interface for commands. Squeezing the RSCH
> command into the SCSW does not seem to be a good idea. Considering your
> proposal with the 3 bits, we could do something like: if in FCTL the
> start and the clear and the halt bits are set then we postulate that is
> request for a resume. But that would be quite confusing, and we would end
> up re-defining the semantic of the scsw_area -- in respect to what is
> documented Documentation/s390/vfio-ccw.txt, and also what is intuitive
> based on the uapi header.

Agreed. Making scsw_area something like an scsw but still different is
bound to be confusing, even if documented, and I'm not sure it covers
all our bases anyway. Just using the halt/clear bits might have been
feasible, but as that does not cover rsch, we need something different
anyway.

>=20
> >=20
> > Way=C2=A02)
> >=20
> > We=C2=A0use=C2=A0the=C2=A0device=C2=A0VFIO=C2=A0versioning=C2=A0using=
=C2=A0the=C2=A0capability=C2=A0chain=C2=A0to=C2=A0advertise
> > a=C2=A0new=C2=A0interface.
> >=20
> > This=C2=A0the=C2=A0preferred=C2=A0way,=C2=A0it=C2=A0is=C2=A0sane,=C2=A0=
allows=C2=A0for=C2=A0the=C2=A0userland=C2=A0backward
> > compatibility=C2=A0and=C2=A0allows=C2=A0to=C2=A0have=C2=A0a=C2=A0new=C2=
=A0command=C2=A0interface,=C2=A0extensible
> > for=C2=A0future=C2=A0use.
> >=20
> > In=C2=A0this=C2=A0case=C2=A0we=C2=A0can=C2=A0extend=C2=A0the=C2=A0inter=
face=C2=A0to=C2=A0be=C2=A0any=C2=A0kind=C2=A0we=C2=A0want
> > in=C2=A0a=C2=A0next=C2=A0version,=C2=A0pwrite=C2=A0with=C2=A0new=C2=A0i=
o_region,=C2=A0mmap=C2=A0on=C2=A0new
> > IO=C2=A0regions,=C2=A0status=C2=A0region...
> >=20
> > PRO:=C2=A0Extensible=C2=A0and=C2=A0also=C2=A0goes=C2=A0in=C2=A0the=C2=
=A0VFIO=C2=A0INFO=C2=A0extension=C2=A0direction
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0proposed=C2=A0by=C2=A0Alex
> >  =20
>=20
>=20
> Sounds much better. I imagine the coexistence of old and new like this.
> Both the old and the new QEMU would supply the the SCSW area with the old
> documented semantics -- the SCSW of the virtual subchannel. But with the
> new version an explicit command would be supplied via the command region
> (also for  SSCH). Maybe the SCSW can still end up being useful for
> something in the kernel module too (maybe there are some  optimization
> that can be done based on the QEMU SCSW).

We need to keep the old interface anyway. But yes, I think capabilities
are the way to go.

>=20
>=20
> > CONTRA:=C2=A0I=C2=A0see=C2=A0none=C2=A0outer=C2=A0more=C2=A0work=C2=A0t=
o=C2=A0do=C2=A0(but=C2=A0is=C2=A0it=C2=A0a=C2=A0problem?)
> >=20
> >  =20
> The problem I see is that designing a good interface usually hard.

I fear that this is always the case :)

> I could help with review, but I don't have the resources to commit
> to more than that.

I'm looking into the halt/clear thing anyway. But review is appreciated.

>=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Extra=C2=A0argumentation=C2=A0for=C2=A0versioning=C2=A0support
> >=20
> >=20
> > Suppose=C2=A0a=C2=A0future=C2=A0implementation=C2=A0with=C2=A04=C2=A0ma=
pped=C2=A0regions=C2=A0like
> > the=C2=A0following:
> >=20
> > -=C2=A0A=C2=A0Status=C2=A0region=C2=A0(RO=C2=A0updated=C2=A0as=C2=A0res=
ult=C2=A0of=C2=A0command=C2=A0and=C2=A0IRQ)

scsw/pmcw/anything else? Would also accommodate the path handling
stuff, I think.

> >=20
> > -=C2=A0A=C2=A0command=C2=A0region=C2=A0(WO=C2=A0where=C2=A0the=C2=A0use=
r=C2=A0send=C2=A0its=C2=A0commands)
> >  =C2=A0=C2=A0userland=C2=A0write=C2=A0here=C2=A0to=C2=A0trigger=C2=A0IO=
=C2=A0(quite=C2=A0as=C2=A0currently)
> >=20
> > -=C2=A0A=C2=A0CCW=C2=A0program=C2=A0region=C2=A0(RW=C2=A0where=C2=A0the=
=C2=A0CCW=C2=A0chain=C2=A0is=C2=A0handled)
> >  =C2=A0=C2=A0most=C2=A0handling=C2=A0done=C2=A0from=C2=A0userspace,=C2=
=A0last=C2=A0translations=C2=A0in=C2=A0kernel,
> >  =C2=A0=C2=A0double=C2=A0buffering...

I'm not sure about that. But in any case, we can add this later on. We
need to keep the orb as it is now, and that should already cover our
current use cases.

> >=20
> > -=C2=A0A=C2=A0performance=C2=A0/=C2=A0measurement=C2=A0/=C2=A0statistic=
s=C2=A0region=C2=A0(RO)
> >  =C2=A0=C2=A0This=C2=A0is=C2=A0updated=C2=A0asynchronously=C2=A0by=C2=
=A0hardware=C2=A0and/or=C2=A0driver

For channel measurements, for example? Makes sense. (I recall that
there's also a measurement infrastructure triggered via CHSC, but I
don't have the documentation.)

> >=20
> > This=C2=A0is=C2=A0purely=C2=A0theoretical=C2=A0and=C2=A0we=C2=A0do=C2=
=A0not=C2=A0need=C2=A0to=C2=A0do=C2=A0all=C2=A0at=C2=A0once
> > but=C2=A0if=C2=A0we=C2=A0want=C2=A0to=C2=A0extend=C2=A0the=C2=A0impleme=
ntation=C2=A0without=C2=A0problems
> > and=C2=A0continue=C2=A0backward=C2=A0compatibility=C2=A0the=C2=A0versio=
ning=C2=A0and=C2=A0capability
> > handling=C2=A0is=C2=A0a=C2=A0must. =20
>=20
> I'm not sure about this.

We can think about this later, the capabilities infrastructure enables
us to do so.
