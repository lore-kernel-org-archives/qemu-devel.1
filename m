Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013CCC28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DF3207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DF3207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58486 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqMP-0006qG-JB
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:15:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYqFP-0000QU-HY
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYqFM-0003aO-EC
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hYqFM-0003TX-3j
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6ADC8F90F;
	Thu,  6 Jun 2019 11:07:43 +0000 (UTC)
Received: from work-vm (ovpn-116-119.ams2.redhat.com [10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B67E22A345;
	Thu,  6 Jun 2019 11:07:40 +0000 (UTC)
Date: Thu, 6 Jun 2019 12:07:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190606110737.GK2788@work-vm>
References: <38B8F53B-F993-45C3-9A82-796A0D4A55EC@oracle.com>
	<20190606084222.GA2788@work-vm>
	<862DD946-EB3C-405A-BE88-4B22E0B9709C@oracle.com>
	<20190606092358.GE2788@work-vm>
	<8F3FD038-12DB-44BC-A262-3F1B55079753@oracle.com>
	<20190606103958.GJ2788@work-vm>
	<B7A9A778-9BD5-449E-A8F3-5D8E3471F4A6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B7A9A778-9BD5-449E-A8F3-5D8E3471F4A6@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 06 Jun 2019 11:07:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QEMU/KVM migration backwards compatibility broken?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	kvm list <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Liran Alon (liran.alon@oracle.com) wrote:
>=20
>=20
> > On 6 Jun 2019, at 13:39, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
> >=20
> > * Liran Alon (liran.alon@oracle.com) wrote:
> >>=20
> >>=20
> >>> On 6 Jun 2019, at 12:23, Dr. David Alan Gilbert <dgilbert@redhat.co=
m> wrote:
> >>>=20
> >>> * Liran Alon (liran.alon@oracle.com) wrote:
> >>>>=20
> >>>>=20
> >>>>> On 6 Jun 2019, at 11:42, Dr. David Alan Gilbert <dgilbert@redhat.=
com> wrote:
> >>>>>=20
> >>>>> * Liran Alon (liran.alon@oracle.com) wrote:
> >>>>>> Hi,
> >>>>>>=20
> >>>>>> Looking at QEMU source code, I am puzzled regarding how migratio=
n backwards compatibility is preserved regarding X86CPU.
> >>>>>>=20
> >>>>>> As I understand it, fields that are based on KVM capabilities an=
d guest runtime usage are defined in VMState subsections in order to not =
send them if not necessary.
> >>>>>> This is done such that in case they are not needed and we migrat=
e to an old QEMU which don=E2=80=99t support loading this state, migratio=
n will still succeed
> >>>>>> (As .needed() method will return false and therefore this state =
won=E2=80=99t be sent as part of migration stream).
> >>>>>> Furthermore, in case .needed() returns true and old QEMU don=E2=80=
=99t support loading this state, migration fails. As it should because we=
 are aware that guest state
> >>>>>> is not going to be restored properly on destination.
> >>>>>>=20
> >>>>>> I=E2=80=99m puzzled about what will happen in the following scen=
ario:
> >>>>>> 1) Source is running new QEMU with new KVM that supports save of=
 some VMState subsection.
> >>>>>> 2) Destination is running new QEMU that supports load this state=
 but with old kernel that doesn=E2=80=99t know how to load this state.
> >>>>>>=20
> >>>>>> I would have expected in this case that if source .needed() retu=
rns true, then migration will fail because of lack of support in destinat=
ion kernel.
> >>>>>> However, it seems from current QEMU code that this will actually=
 succeed in many cases.
> >>>>>>=20
> >>>>>> For example, if msr_smi_count is sent as part of migration strea=
m (See vmstate_msr_smi_count) and destination have has_msr_smi_count=3D=3D=
false,
> >>>>>> then destination will succeed loading migration stream but kvm_p=
ut_msrs() will actually ignore env->msr_smi_count and will successfully l=
oad guest state.
> >>>>>> Therefore, migration will succeed even though it should have fai=
led=E2=80=A6
> >>>>>>=20
> >>>>>> It seems to me that QEMU should have for every such VMState subs=
ection, a .post_load() method that verifies that relevant capability is s=
upported by kernel
> >>>>>> and otherwise fail migration.
> >>>>>>=20
> >>>>>> What do you think? Should I really create a patch to modify all =
these CPUX86 VMState subsections to behave like this?
> >>>>>=20
> >>>>> I don't know the x86 specific side that much; but from my migrati=
on side
> >>>>> the answer should mostly be through machine types - indeed for sm=
i-count
> >>>>> there's a property 'x-migrate-smi-count' which is off for machine=
 types
> >>>>> pre 2.11 (see hw/i386/pc.c pc_compat_2_11) - so if you've got an =
old
> >>>>> kernel you should stick to the old machine types.
> >>>>>=20
> >>>>> There's nothing guarding running the new machine type on old-kern=
els;
> >>>>> and arguably we should have a check at startup that complains if
> >>>>> your kernel is missing something the machine type uses.
> >>>>> However, that would mean that people running with -M pc   would f=
ail
> >>>>> on old kernels.
> >>>>>=20
> >>>>> A post-load is also a valid check; but one question is whether,
> >>>>> for a particular register, the pain is worth it - it depends on t=
he
> >>>>> symptom that the missing state causes.  If it's minor then you mi=
ght
> >>>>> conclude it's not worth a failed migration;  if it's a hung or
> >>>>> corrupt guest then yes it is.   Certainly a warning printed is wo=
rth
> >>>>> it.
> >>>>>=20
> >>>>> Dave
> >>>>=20
> >>>> I think we should have flags that allow user to specify which VMSt=
ate subsections user explicitly allow to avoid restore even though they a=
re required to fully restore guest state.
> >>>> But it seems to me that the behaviour should be to always fail mig=
ration in case we load a VMState subsections that we are unable to restor=
e unless user explicitly specified this is ok
> >>>> for this specific subsection.
> >>>> Therefore, it seems that for every VMState subsection that it=E2=80=
=99s restore is based on kernel capability we should:
> >>>> 1) Have a user-controllable flag (which is also tied to machine-ty=
pe?) to explicitly allow avoid restoring this state if cannot. Default sh=
ould be =E2=80=9Cfalse=E2=80=9D.
> >>>> 2) Have a .post_load() method that verifies we have required kerne=
l capability to restore this state, unless flag (1) was specified as =E2=80=
=9Ctrue=E2=80=9D.
> >>>=20
> >>> This seems a lot of flags; users aren't going to know what to do wi=
th
> >>> all of them; I don't see what will set/control them.
> >>=20
> >> True but I think users will want to specify only for a handful of VM=
State subsections that it is OK to not restore them even thought hey are =
deemed needed by source QEMU.
> >> We can create flags only for those VMState subsections.
> >> User should set these flags explicitly on QEMU command-line. As a =E2=
=80=9C-cpu=E2=80=9D property? I don=E2=80=99t think these flags should be=
 tied to machine-type.
> >=20
> > I don't see who is going to work out these flags and send them.
> >=20
> >>>=20
> >>>> Note that above mentioned flags is different than flags such as =E2=
=80=9Cx-migrate-smi-count=E2=80=9D.
> >>>> The purpose of =E2=80=9Cx-migrate-smi-count=E2=80=9D flag is to av=
oid sending the VMState subsection to begin with in case we know we migra=
te to older QEMU which don=E2=80=99t even have the relevant VMState subse=
ction. But it is not relevant for the case both source and destination ru=
ns QEMU which understands the VMState subsection but run on kernels with =
different capabilities.
> >>>>=20
> >>>> Also note regarding your first paragraph, that specifying flags ba=
sed on kernel you are running on doesn=E2=80=99t help for the case discus=
sed here.
> >>>> As source QEMU is running on new kernel. Unless you meant that sou=
rce QEMU should use relevant machine-type based on the destination kernel=
.
> >>>> i.e. You should launch QEMU with old machine-type as long as you h=
ave hosts in your migration pool that runs with old kernel.
> >>>=20
> >>> That's what I meant; stick to the old machine-type unless you know =
it's
> >>> safe to use a newer one.
> >>>=20
> >>>> I don=E2=80=99 think it=E2=80=99s the right approach though. As th=
ere is no way to change flags such as =E2=80=9Cx-migrate-smi-count=E2=80=9D=
 dynamically after all hosts in migration pool have been upgraded.
> >>>>=20
> >>>> What do you think?
> >>>=20
> >>> I don't have an easy answer.  The users already have to make sure t=
hey
> >>> use a machine type that's old enough for all the QEMUs installed in
> >>> their cluster; making sure it's also old enough for their oldest
> >>> kernel isn't too big a difference - *except* that it's much harder =
to
> >>> tell which kernel corresponds to which feature/machine type etc - s=
o
> >>> how does a user know what the newest supported machine type is?
> >>> Failing at startup when selecting a machine type that the current
> >>> kernel can't support would help that.
> >>>=20
> >>> Dave
> >>=20
> >> First, machine-type express the set of vHW behaviour and properties =
that is exposed to guest.
> >> Therefore, machine-type shouldn=E2=80=99t change for a given guest l=
ifetime (including Live-Migrations).
> >> Otherwise, guest will experience different vHW behaviour and propert=
ies before/after Live-Migration.
> >> So I think machine-type is not relevant for this discussion. We shou=
ld focus on flags which specify
> >> migration behaviour (such as =E2=80=9Cx-migrate-smi-count=E2=80=9D w=
hich can also be controlled by machine-type but not only).
> >=20
> > Machine type specifies two things:
> >  a) The view from the guest
> >  b) Migration compatibility
> >=20
> > (b) is explicitly documented in qemu's docs/devel/migration.rst, see =
the
> > subsection on subsections.
> >=20
> >> Second, this strategy results in inefficient migration management. C=
onsider the following scenario:
> >> 1) Guest running on new_qemu+old_kernel migrate to host with new_qem=
u+new_kernel.
> >> Because source is old_kernel than destination QEMU is launched with =
(x-migrate-smi-count =3D=3D false).
> >> 2) Assume at this point fleet of hosts have half of hosts with old_k=
ernel and half with new_kernel.
> >> 3) Further assume that guest workload indeed use msr_smi_count and t=
herefore relevant VMState subsection should be sent to properly preserve =
guest state.
> >> 4) From some reason, we decide to migrate again the guest in (1).
> >> Even if guest is migrated to a host with new_kernel, then QEMU still=
 avoids sending msr_smi_count VMState subsection because it is launched w=
ith (x-migrate-smi-count =3D=3D false).
> >>=20
> >> Therefore, I think it makes more sense that source QEMU will always =
send all VMState subsection that are deemed needed (i.e. .nedeed() return=
s true)
> >> and let receive-side decide if migration should fail if this subsect=
ion was sent but failed to be restored.
> >> The only case which I think sender should limit the VMState subsecti=
on it sends to destination is because source is running older QEMU
> >> which is not even aware of this VMState subsection (Which is to my u=
nderstanding the rational behind using =E2=80=9Cx-migrate-smi-count=E2=80=
=9D and tie it up to machine-type).
> >=20
> > But we want to avoid failed migrations if we can; so in general we do=
n't
> > want to be sending subsections to destinations that can't handle them=
.
> > The only case where it's reasonable is when there's a migration bug s=
uch
> > that the behaviour in the guest is really nasty; if there's a choice
> > between a failed migration or a hung/corrupt guest I'll take a failed
> > migration.
> >=20
> >> Third, let=E2=80=99s assume all hosts in fleet was upgraded to new_k=
ernel. How do I modify all launched QEMUs on these new hosts to now have =
=E2=80=9Cx-migrate-smi-count=E2=80=9D set to true?
> >> As I would like future migrations to do send this VMState subsection=
. Currently there is no QMP command to update these flags.
> >=20
> > I guess that's possible - it's pretty painful though; you're going to
> > have to teach your management layer about features/fixes of the kerne=
ls
> > and which flags to tweak in qemu.  Having said that, if you could do =
it,
> > then you'd avoid having to restart VMs to pick up a few fixes.
> >=20
> >> Fourth, I think it=E2=80=99s not trivial for management-plane to be =
aware with which flags it should set on destination QEMU based on current=
ly running kernels on fleet.
> >> It=E2=80=99s not the same as machine-type, as already discussed abov=
e doesn=E2=80=99t change during the entire lifetime of guest.
> >=20
> > Right, which is why I don't see your idea of adding flags will work.
> > I don't see how anything will figure out what the right flags to use
> > are.
> > (Getting the management layers to do sane things with the cpuid flags
> > is already a nightmare, and they're fairly well understood).
> >=20
> >> I=E2=80=99m also not sure it is a good idea that we currently contro=
l flags such as =E2=80=9Cx-migrate-smi-count=E2=80=9D from machine-type.
> >> As it means that if a guest was initially launched using some old QE=
MU, it will *forever* not migrate some VMState subsection during all it=E2=
=80=99s Live-Migrations.
> >> Even if all hosts and all QEMUs on fleet are capable of migrating th=
is state properly.
> >> Maybe it is preferred that this flag was specified as part of =E2=80=
=9Cmigrate=E2=80=9D command itself in case management-plane knows it wish=
es to migrate even though dest QEMU
> >> is older and doesn=E2=80=99t understand this specific VMState subsec=
tion.
> >>=20
> >> I=E2=80=99m left pretty confused about QEMU=E2=80=99s migration comp=
atibility strategy...
> >=20
> > The compatibility strategy is the machine type;  but yes it does
> > have a problem when it's not really just a qemu version - but also
> > kernel (and external libraries, etc).
> > My general advice is that users should be updating their kernels and
> > qemus together; but I realise there's lots of cases where that
> > doesn't work.
> >=20
> > Dave
>=20
> I think it=E2=80=99s not practical advise to expect users to always upg=
rade kernel and QEMU together.
> In fact, users prefer to upgrade them separately to avoid doing major u=
pgrades at once and to better pin-point root-cause of issues.

It's tricky; for distro-based users, hitting 'update' and getting both
makes a lot of sense; but as you say you ened to let them do stuff
individually if they want to, so they can track down problems.
There's also a newer problem which is people want to run the QEMU in
containers on hosts that have separate update schedules - the kernel
version relationship is then much more fluid.

> Compiling all above very useful discussion (thanks for this!), I may ha=
ve a better suggestion that doesn=E2=80=99t require any additional flags:
> 1) Source QEMU will always send all all VMState subsections that is dee=
med by source QEMU as required to not break guest semantic behaviour.
> This is done by .needed() methods that examine guest runtime state to u=
nderstand if this state is required to be sent or not.

So that's as we already do.

> 2) Destination QEMU will provide a generic QMP command which allows to =
set names of VMState subsections that if accepted on migration stream
> and failed to be loaded (because either subsection name is not implemen=
ted or because .post_load() method failed) then the failure should be ign=
ored
> and migration should continue as usual. By default, the list of this na=
mes will be empty.

The format of the migration stream means that you can't skip an unknown
subsection; it's not possible to resume parsing the stream without
knowing what was supposed to be there. [This is pretty awful
but my last attempts to rework it hit a dead end]

So we still need to tie subsections to machine types; that way
you don't send them to old qemu's and there for you don't have the
problem of the qemu receiving something it doesn't know.

Still, you could skip things where the destination kernel doesn't know
about it.

> 3) Destination QEMU will implement .post_load() method for all these VM=
State subsections that depend on kernel capability to be restored properl=
y
> such that it will fail subsection load in case kernel capability is not=
 present. (Note that this load failure will be ignored if subsection name=
 is specified in (2)).
>=20
> Above suggestion have the following properties:
> 1) Doesn=E2=80=99t require any flag to be added to QEMU.

There's no logical difference between 'flags' and 'names of subsections'
- they're got the same problem in someone somewhere knowing which are
  safe.

> 2) Moves all control on whether to fail migration because of failure to=
 load VMState subsection to receiver side. Sender always attempts to send=
 max state he believes is required.
> 3) We remove coupling of migration compatibility from machine-type.
>=20
> What do you think?

Sorry, can't do (3) - we need to keep the binding for subsections to
machine types for qemu compatibility;  I'm open for something for
kernel compat, but not when it's breaking the qemu subsection
checks.

Dave

>=20
> -Liran
>=20
> >=20
> >> -Liran
> >>=20
> >>>=20
> >>>> -Liran
> >>>>=20
> >>>>>=20
> >>>>>> Thanks,
> >>>>>> -Liran
> >>>>> --
> >>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>>=20
> >>> --
> >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

