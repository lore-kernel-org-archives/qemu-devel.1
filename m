Received: from eggs.gnu.org ([2001:4830:134:3::10]:44547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5sbm-0003Td-2d
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5sbj-0003tl-Q8
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:38:14 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5sbj-0003tK-F2
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:38:11 -0400
Received: by mail-wm0-x22c.google.com with SMTP id r190so54725541wme.1
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 04:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
	<1493749518.4241.225.camel@intel.com>
	<CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
	<b6e0d6d2-d276-c66d-ae5e-c6502cbe0b5c@linux.vnet.ibm.com>
	<20170503084136.GC4121@redhat.com> <20170503111659.GA2077@work-vm>
	<CAJ+F1CJ2JnLS2BbMWES0HQ3-iJUzXrrj21RVPo70d04xpWbgDQ@mail.gmail.com>
	<20170503112948.GA3985@redhat.com>
In-Reply-To: <20170503112948.GA3985@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 03 May 2017 11:37:59 +0000
Message-ID: <CAJ+F1CJn7=OJfCgisEEwpcivvC4V2q9wN08frSHwG4WXVw2Y2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Patrick Ohly <patrick.ohly@intel.com>, qemu-devel@nongnu.org

Hi

On Wed, May 3, 2017 at 3:29 PM Daniel P. Berrange <berrange@redhat.com>
wrote:

> On Wed, May 03, 2017 at 11:24:42AM +0000, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, May 3, 2017 at 3:17 PM Dr. David Alan Gilbert <
> dgilbert@redhat.com>
> > wrote:
> >
> > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > On Tue, May 02, 2017 at 03:35:48PM -0400, Stefan Berger wrote:
> > > > > On 05/02/2017 02:50 PM, Marc-Andr=C3=A9 Lureau wrote:
> > > > > > Hi
> > > > > >
> > > > > > On Tue, May 2, 2017 at 10:25 PM Patrick Ohly <
> patrick.ohly@intel.com
> > > > > > <mailto:patrick.ohly@intel.com>> wrote:
> > > > > >
> > > > > >     On Tue, 2017-05-02 at 13:19 -0400, Stefan Berger wrote:
> > > > > >     > On 05/02/2017 01:09 PM, Marc-Andr=C3=A9 Lureau wrote:
> > > > > >     > > On Tue, May 2, 2017 at 8:59 PM Stefan Berger
> > > > > >     <stefanb@linux.vnet.ibm.com <mailto:
> stefanb@linux.vnet.ibm.com>>
> > > > > >     > > wrote:
> > > > > >     > >
> > > > > >     > >> And who is going to implement that qemu-swtpm? Obvious=
ly
> > > this
> > > > > >     discussion
> > > > > >     > >> doesn't contribute to progress if nobody is doing that
> in
> > > the
> > > > > >     end.
> > > > > >     > >>
> > > > > >     > > The same persons who try to push for that emulated TPM
> code.
> > > > > >     The easiest
> > > > > >     > > approach would be to copy/adapt the swtpm code in qemu,
> if
> > > the
> > > > > >     licence is
> > > > > >     > > compatible. I can help with that if there is a consensu=
s
> it's
> > > > > >     a better
> > > > > >     > > approach.
> > > > > >     >
> > > > > >     >
> > > > > >     > It's a matter of time and at least I don't have time for
> that.
> > > > > >
> > > > > >     Neither do I, and nor (I believe) does Amarnath. The approa=
ch
> > > with
> > > > > >     using
> > > > > >     the existing swtpm project seemed attractive to us exactly
> > > because it
> > > > > >     avoids having to write and maintain more than just the glue
> code
> > > > > >     between
> > > > > >     the two projects.
> > > > > >
> > > > > >
> > > > > > The main argument is not about having more or less code in qemu
> to
> > > > > > maintain, but yes this is a concern (although giving up that
> > > maintenance
> > > > > > to a seperate project with mostly Stefan-alone isn't a much
> better
> > > > > > alternative). btw, is the project actually used by something el=
se
> > > than
> > > > > > qemu? (I am not talking about developpers/testing). If not, the=
n
> it
> > > > > > makes sense to make it part of qemu.
> > > > >
> > > > > The intention would be to use it for RunC as well (plus higher
> layers
> > > > > afterwards): https://github.com/opencontainers/runc/pull/1082
> > > > >
> > > > > >
> > > > > > But it's mostly a technical reason, to avoid having to rely on =
a
> > > foreign
> > > > > > protocol and project with all the compatibility constrains.
> > > > >
> > > > > I understand. Ideally swtpm-0.1 would be equivalent to 1.0 with a=
ll
> > > features
> > > > > available and no further protocol extensions necessary. In practi=
ce
> > > that may
> > > > > look different.
> > > > >
> > > > > >
> > > > > > In the end, we may decide to start with a separate project, and
> > > change
> > > > > > it in the future if it's problematic (that would break some
> cases,
> > > such
> > > > > > as being able to freely switch the helper). Tbh, I am not so
> happy
> > > with
> > > > > > the code quality of swtpm, and I haven't looked closely at
> libtpms.
> > > > > > Having a qemu-swtpm as part of qemu would probably help improve
> it
> > > too,
> > > > > > and bring a few more developers for maintainance...
> > > > >
> > > > > libtpms combines a few source codes with some glue around it. The
> > > coding
> > > > > style is different for TPM 1.2 and TPM 2 code for example and the
> code
> > > bases
> > > > > are in the 10s of thousands of line. In the case of TPM 2 it 'liv=
es
> > > from'
> > > > > TCG code drops and thus there is no reformatting of source code
> etc.
> > > > >
> > > > > If someone wants to get started on qemu-swtpm that's certainly co=
ol
> > > but over
> > > > > the years it's just been quite difficult to find developers for i=
t
> to
> > > share
> > > > > the burden. All that said, someone should state whether this
> series is
> > > a go
> > > > > or no-go because of the external project it requires.
> > > >
> > > > I think it is *good* that it uses the external swtpm project and do
> not
> > > > want to see it reimplemented inside QEMU, particularly with the
> interest
> > > > for swtpm to be used in container contexts via RunC. Such common
> > > infrastructure
> > > > for both containers & QEMU will be important given the increasing
> > > convergance
> > > > of technology across containers & VMs.
> > >
> > > I agree; there aren't that many people who understand the details of
> TPMs,
> > > reimplementing one in QEMU isn't something you'd want to do.
> > >
> >
> > It's not about reimplementing TPM emulation. swtpm is a small utility
> > talking to libtpms doing the heavy work. swtpm could quite easily be
> > copied/adapted to fit in qemu if it's only meant to be used by qemu.
> > However, it seems the helper is going to be used by other projects, so =
it
> > make sense to make it a seperate project. Nevertheless, I think we shou=
ld
> > carefully review the protocol and the compatibility situation before
> > committing this work, it's a major burden ahead..
>
> Yes, I agree that reviewing the protocol is a very neccessary step, to
> ensure it is going to be forwards compatible in a manner suitable for
> QEMU.
>
> In particular we need to understand what, if any, relationship there
> needs to be wrt machine types & live migration stability. eg if a
> VM is booted and the protocol negotiates version X, and we then live
> migrate to a host with a newer swtpm, we need to ensure that the
> protocol doesn't negotiate something that leads to guest OS incompatiblit=
y
> problems in accessing the TPM.
>
>
Not only the protocol, but the management aspect of this helper too. See
the commit message for instance for the preparatory swtpm steps and
arguments.

If it would be part of qemu, there are more chances we could make it speak
qmp for instance, which would likely help in the future.


> basically similar scenario to that which we have had with vhost-user
> and version compatibility with external vhost-user server implementations
> across live migration.
>
>
Yes, this is already quite painful and not very well tested, I would rather
avoid this situation even at the cost of small code duplication...
--=20
Marc-Andr=C3=A9 Lureau
