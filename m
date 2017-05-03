Received: from eggs.gnu.org ([2001:4830:134:3::10]:38845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5sHN-0005o9-SC
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5sHK-0002FT-Kl
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:17:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d5sHK-0002E8-BD
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:17:06 -0400
Date: Wed, 3 May 2017 12:17:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170503111659.GA2077@work-vm>
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
	<1493749518.4241.225.camel@intel.com>
	<CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
	<b6e0d6d2-d276-c66d-ae5e-c6502cbe0b5c@linux.vnet.ibm.com>
	<20170503084136.GC4121@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170503084136.GC4121@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Patrick Ohly <patrick.ohly@intel.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Tue, May 02, 2017 at 03:35:48PM -0400, Stefan Berger wrote:
> > On 05/02/2017 02:50 PM, Marc-Andr=E9 Lureau wrote:
> > > Hi
> > >=20
> > > On Tue, May 2, 2017 at 10:25 PM Patrick Ohly <patrick.ohly@intel.co=
m
> > > <mailto:patrick.ohly@intel.com>> wrote:
> > >=20
> > >     On Tue, 2017-05-02 at 13:19 -0400, Stefan Berger wrote:
> > >     > On 05/02/2017 01:09 PM, Marc-Andr=E9 Lureau wrote:
> > >     > > On Tue, May 2, 2017 at 8:59 PM Stefan Berger
> > >     <stefanb@linux.vnet.ibm.com <mailto:stefanb@linux.vnet.ibm.com>=
>
> > >     > > wrote:
> > >     > >
> > >     > >> And who is going to implement that qemu-swtpm? Obviously t=
his
> > >     discussion
> > >     > >> doesn't contribute to progress if nobody is doing that in =
the
> > >     end.
> > >     > >>
> > >     > > The same persons who try to push for that emulated TPM code=
.
> > >     The easiest
> > >     > > approach would be to copy/adapt the swtpm code in qemu, if =
the
> > >     licence is
> > >     > > compatible. I can help with that if there is a consensus it=
's
> > >     a better
> > >     > > approach.
> > >     >
> > >     >
> > >     > It's a matter of time and at least I don't have time for that=
.
> > >=20
> > >     Neither do I, and nor (I believe) does Amarnath. The approach w=
ith
> > >     using
> > >     the existing swtpm project seemed attractive to us exactly beca=
use it
> > >     avoids having to write and maintain more than just the glue cod=
e
> > >     between
> > >     the two projects.
> > >=20
> > >=20
> > > The main argument is not about having more or less code in qemu to
> > > maintain, but yes this is a concern (although giving up that mainte=
nance
> > > to a seperate project with mostly Stefan-alone isn't a much better
> > > alternative). btw, is the project actually used by something else t=
han
> > > qemu? (I am not talking about developpers/testing). If not, then it
> > > makes sense to make it part of qemu.
> >=20
> > The intention would be to use it for RunC as well (plus higher layers
> > afterwards): https://github.com/opencontainers/runc/pull/1082
> >=20
> > >=20
> > > But it's mostly a technical reason, to avoid having to rely on a fo=
reign
> > > protocol and project with all the compatibility constrains.
> >=20
> > I understand. Ideally swtpm-0.1 would be equivalent to 1.0 with all f=
eatures
> > available and no further protocol extensions necessary. In practice t=
hat may
> > look different.
> >=20
> > >=20
> > > In the end, we may decide to start with a separate project, and cha=
nge
> > > it in the future if it's problematic (that would break some cases, =
such
> > > as being able to freely switch the helper). Tbh, I am not so happy =
with
> > > the code quality of swtpm, and I haven't looked closely at libtpms.
> > > Having a qemu-swtpm as part of qemu would probably help improve it =
too,
> > > and bring a few more developers for maintainance...
> >=20
> > libtpms combines a few source codes with some glue around it. The cod=
ing
> > style is different for TPM 1.2 and TPM 2 code for example and the cod=
e bases
> > are in the 10s of thousands of line. In the case of TPM 2 it 'lives f=
rom'
> > TCG code drops and thus there is no reformatting of source code etc.
> >=20
> > If someone wants to get started on qemu-swtpm that's certainly cool b=
ut over
> > the years it's just been quite difficult to find developers for it to=
 share
> > the burden. All that said, someone should state whether this series i=
s a go
> > or no-go because of the external project it requires.
>=20
> I think it is *good* that it uses the external swtpm project and do not
> want to see it reimplemented inside QEMU, particularly with the interes=
t
> for swtpm to be used in container contexts via RunC. Such common infras=
tructure
> for both containers & QEMU will be important given the increasing conve=
rgance
> of technology across containers & VMs.

I agree; there aren't that many people who understand the details of TPMs=
,
reimplementing one in QEMU isn't something you'd want to do.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
