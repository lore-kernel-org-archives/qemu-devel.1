Received: from eggs.gnu.org ([2001:4830:134:3::10]:42282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5sTn-00082O-SO
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5sTm-00080a-2G
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:29:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d5sTl-0007zc-PF
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:29:57 -0400
Date: Wed, 3 May 2017 12:29:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170503112948.GA3985@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
	<1493749518.4241.225.camel@intel.com>
	<CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
	<b6e0d6d2-d276-c66d-ae5e-c6502cbe0b5c@linux.vnet.ibm.com>
	<20170503084136.GC4121@redhat.com> <20170503111659.GA2077@work-vm>
	<CAJ+F1CJ2JnLS2BbMWES0HQ3-iJUzXrrj21RVPo70d04xpWbgDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJ2JnLS2BbMWES0HQ3-iJUzXrrj21RVPo70d04xpWbgDQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Patrick Ohly <patrick.ohly@intel.com>, qemu-devel@nongnu.org

On Wed, May 03, 2017 at 11:24:42AM +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, May 3, 2017 at 3:17 PM Dr. David Alan Gilbert <dgilbert@redhat.=
com>
> wrote:
>=20
> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > On Tue, May 02, 2017 at 03:35:48PM -0400, Stefan Berger wrote:
> > > > On 05/02/2017 02:50 PM, Marc-Andr=C3=A9 Lureau wrote:
> > > > > Hi
> > > > >
> > > > > On Tue, May 2, 2017 at 10:25 PM Patrick Ohly <patrick.ohly@inte=
l.com
> > > > > <mailto:patrick.ohly@intel.com>> wrote:
> > > > >
> > > > >     On Tue, 2017-05-02 at 13:19 -0400, Stefan Berger wrote:
> > > > >     > On 05/02/2017 01:09 PM, Marc-Andr=C3=A9 Lureau wrote:
> > > > >     > > On Tue, May 2, 2017 at 8:59 PM Stefan Berger
> > > > >     <stefanb@linux.vnet.ibm.com <mailto:stefanb@linux.vnet.ibm.=
com>>
> > > > >     > > wrote:
> > > > >     > >
> > > > >     > >> And who is going to implement that qemu-swtpm? Obvious=
ly
> > this
> > > > >     discussion
> > > > >     > >> doesn't contribute to progress if nobody is doing that=
 in
> > the
> > > > >     end.
> > > > >     > >>
> > > > >     > > The same persons who try to push for that emulated TPM =
code.
> > > > >     The easiest
> > > > >     > > approach would be to copy/adapt the swtpm code in qemu,=
 if
> > the
> > > > >     licence is
> > > > >     > > compatible. I can help with that if there is a consensu=
s it's
> > > > >     a better
> > > > >     > > approach.
> > > > >     >
> > > > >     >
> > > > >     > It's a matter of time and at least I don't have time for =
that.
> > > > >
> > > > >     Neither do I, and nor (I believe) does Amarnath. The approa=
ch
> > with
> > > > >     using
> > > > >     the existing swtpm project seemed attractive to us exactly
> > because it
> > > > >     avoids having to write and maintain more than just the glue=
 code
> > > > >     between
> > > > >     the two projects.
> > > > >
> > > > >
> > > > > The main argument is not about having more or less code in qemu=
 to
> > > > > maintain, but yes this is a concern (although giving up that
> > maintenance
> > > > > to a seperate project with mostly Stefan-alone isn't a much bet=
ter
> > > > > alternative). btw, is the project actually used by something el=
se
> > than
> > > > > qemu? (I am not talking about developpers/testing). If not, the=
n it
> > > > > makes sense to make it part of qemu.
> > > >
> > > > The intention would be to use it for RunC as well (plus higher la=
yers
> > > > afterwards): https://github.com/opencontainers/runc/pull/1082
> > > >
> > > > >
> > > > > But it's mostly a technical reason, to avoid having to rely on =
a
> > foreign
> > > > > protocol and project with all the compatibility constrains.
> > > >
> > > > I understand. Ideally swtpm-0.1 would be equivalent to 1.0 with a=
ll
> > features
> > > > available and no further protocol extensions necessary. In practi=
ce
> > that may
> > > > look different.
> > > >
> > > > >
> > > > > In the end, we may decide to start with a separate project, and
> > change
> > > > > it in the future if it's problematic (that would break some cas=
es,
> > such
> > > > > as being able to freely switch the helper). Tbh, I am not so ha=
ppy
> > with
> > > > > the code quality of swtpm, and I haven't looked closely at libt=
pms.
> > > > > Having a qemu-swtpm as part of qemu would probably help improve=
 it
> > too,
> > > > > and bring a few more developers for maintainance...
> > > >
> > > > libtpms combines a few source codes with some glue around it. The
> > coding
> > > > style is different for TPM 1.2 and TPM 2 code for example and the=
 code
> > bases
> > > > are in the 10s of thousands of line. In the case of TPM 2 it 'liv=
es
> > from'
> > > > TCG code drops and thus there is no reformatting of source code e=
tc.
> > > >
> > > > If someone wants to get started on qemu-swtpm that's certainly co=
ol
> > but over
> > > > the years it's just been quite difficult to find developers for i=
t to
> > share
> > > > the burden. All that said, someone should state whether this seri=
es is
> > a go
> > > > or no-go because of the external project it requires.
> > >
> > > I think it is *good* that it uses the external swtpm project and do=
 not
> > > want to see it reimplemented inside QEMU, particularly with the int=
erest
> > > for swtpm to be used in container contexts via RunC. Such common
> > infrastructure
> > > for both containers & QEMU will be important given the increasing
> > convergance
> > > of technology across containers & VMs.
> >
> > I agree; there aren't that many people who understand the details of =
TPMs,
> > reimplementing one in QEMU isn't something you'd want to do.
> >
>=20
> It's not about reimplementing TPM emulation. swtpm is a small utility
> talking to libtpms doing the heavy work. swtpm could quite easily be
> copied/adapted to fit in qemu if it's only meant to be used by qemu.
> However, it seems the helper is going to be used by other projects, so =
it
> make sense to make it a seperate project. Nevertheless, I think we shou=
ld
> carefully review the protocol and the compatibility situation before
> committing this work, it's a major burden ahead..

Yes, I agree that reviewing the protocol is a very neccessary step, to
ensure it is going to be forwards compatible in a manner suitable for
QEMU.

In particular we need to understand what, if any, relationship there
needs to be wrt machine types & live migration stability. eg if a
VM is booted and the protocol negotiates version X, and we then live
migrate to a host with a newer swtpm, we need to ensure that the
protocol doesn't negotiate something that leads to guest OS incompatiblit=
y
problems in accessing the TPM.

basically similar scenario to that which we have had with vhost-user
and version compatibility with external vhost-user server implementations
across live migration.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
