Received: from eggs.gnu.org ([2001:4830:134:3::10]:41202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5sOu-00070f-O6
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5sOs-0005cw-6h
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:24:56 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:33418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5sOr-0005cb-RK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:24:54 -0400
Received: by mail-wm0-x229.google.com with SMTP id n198so21488472wmg.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 04:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
	<1493749518.4241.225.camel@intel.com>
	<CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
	<b6e0d6d2-d276-c66d-ae5e-c6502cbe0b5c@linux.vnet.ibm.com>
	<20170503084136.GC4121@redhat.com> <20170503111659.GA2077@work-vm>
In-Reply-To: <20170503111659.GA2077@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 03 May 2017 11:24:42 +0000
Message-ID: <CAJ+F1CJ2JnLS2BbMWES0HQ3-iJUzXrrj21RVPo70d04xpWbgDQ@mail.gmail.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Patrick Ohly <patrick.ohly@intel.com>, qemu-devel@nongnu.org

Hi

On Wed, May 3, 2017 at 3:17 PM Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Tue, May 02, 2017 at 03:35:48PM -0400, Stefan Berger wrote:
> > > On 05/02/2017 02:50 PM, Marc-Andr=C3=A9 Lureau wrote:
> > > > Hi
> > > >
> > > > On Tue, May 2, 2017 at 10:25 PM Patrick Ohly <patrick.ohly@intel.co=
m
> > > > <mailto:patrick.ohly@intel.com>> wrote:
> > > >
> > > >     On Tue, 2017-05-02 at 13:19 -0400, Stefan Berger wrote:
> > > >     > On 05/02/2017 01:09 PM, Marc-Andr=C3=A9 Lureau wrote:
> > > >     > > On Tue, May 2, 2017 at 8:59 PM Stefan Berger
> > > >     <stefanb@linux.vnet.ibm.com <mailto:stefanb@linux.vnet.ibm.com>=
>
> > > >     > > wrote:
> > > >     > >
> > > >     > >> And who is going to implement that qemu-swtpm? Obviously
> this
> > > >     discussion
> > > >     > >> doesn't contribute to progress if nobody is doing that in
> the
> > > >     end.
> > > >     > >>
> > > >     > > The same persons who try to push for that emulated TPM code=
.
> > > >     The easiest
> > > >     > > approach would be to copy/adapt the swtpm code in qemu, if
> the
> > > >     licence is
> > > >     > > compatible. I can help with that if there is a consensus it=
's
> > > >     a better
> > > >     > > approach.
> > > >     >
> > > >     >
> > > >     > It's a matter of time and at least I don't have time for that=
.
> > > >
> > > >     Neither do I, and nor (I believe) does Amarnath. The approach
> with
> > > >     using
> > > >     the existing swtpm project seemed attractive to us exactly
> because it
> > > >     avoids having to write and maintain more than just the glue cod=
e
> > > >     between
> > > >     the two projects.
> > > >
> > > >
> > > > The main argument is not about having more or less code in qemu to
> > > > maintain, but yes this is a concern (although giving up that
> maintenance
> > > > to a seperate project with mostly Stefan-alone isn't a much better
> > > > alternative). btw, is the project actually used by something else
> than
> > > > qemu? (I am not talking about developpers/testing). If not, then it
> > > > makes sense to make it part of qemu.
> > >
> > > The intention would be to use it for RunC as well (plus higher layers
> > > afterwards): https://github.com/opencontainers/runc/pull/1082
> > >
> > > >
> > > > But it's mostly a technical reason, to avoid having to rely on a
> foreign
> > > > protocol and project with all the compatibility constrains.
> > >
> > > I understand. Ideally swtpm-0.1 would be equivalent to 1.0 with all
> features
> > > available and no further protocol extensions necessary. In practice
> that may
> > > look different.
> > >
> > > >
> > > > In the end, we may decide to start with a separate project, and
> change
> > > > it in the future if it's problematic (that would break some cases,
> such
> > > > as being able to freely switch the helper). Tbh, I am not so happy
> with
> > > > the code quality of swtpm, and I haven't looked closely at libtpms.
> > > > Having a qemu-swtpm as part of qemu would probably help improve it
> too,
> > > > and bring a few more developers for maintainance...
> > >
> > > libtpms combines a few source codes with some glue around it. The
> coding
> > > style is different for TPM 1.2 and TPM 2 code for example and the cod=
e
> bases
> > > are in the 10s of thousands of line. In the case of TPM 2 it 'lives
> from'
> > > TCG code drops and thus there is no reformatting of source code etc.
> > >
> > > If someone wants to get started on qemu-swtpm that's certainly cool
> but over
> > > the years it's just been quite difficult to find developers for it to
> share
> > > the burden. All that said, someone should state whether this series i=
s
> a go
> > > or no-go because of the external project it requires.
> >
> > I think it is *good* that it uses the external swtpm project and do not
> > want to see it reimplemented inside QEMU, particularly with the interes=
t
> > for swtpm to be used in container contexts via RunC. Such common
> infrastructure
> > for both containers & QEMU will be important given the increasing
> convergance
> > of technology across containers & VMs.
>
> I agree; there aren't that many people who understand the details of TPMs=
,
> reimplementing one in QEMU isn't something you'd want to do.
>

It's not about reimplementing TPM emulation. swtpm is a small utility
talking to libtpms doing the heavy work. swtpm could quite easily be
copied/adapted to fit in qemu if it's only meant to be used by qemu.
However, it seems the helper is going to be used by other projects, so it
make sense to make it a seperate project. Nevertheless, I think we should
carefully review the protocol and the compatibility situation before
committing this work, it's a major burden ahead..

>
> > Regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
--=20
Marc-Andr=C3=A9 Lureau
