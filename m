Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C13C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1067020684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1067020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57075 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYoeQ-0006Om-6m
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 05:25:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYocw-0005R9-Bs
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYocu-0006k1-RL
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hYocu-0006iK-Ih
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:24:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B1A12F8BE9;
	Thu,  6 Jun 2019 09:24:03 +0000 (UTC)
Received: from work-vm (ovpn-116-119.ams2.redhat.com [10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0669E51F2A;
	Thu,  6 Jun 2019 09:24:01 +0000 (UTC)
Date: Thu, 6 Jun 2019 10:23:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190606092358.GE2788@work-vm>
References: <38B8F53B-F993-45C3-9A82-796A0D4A55EC@oracle.com>
	<20190606084222.GA2788@work-vm>
	<862DD946-EB3C-405A-BE88-4B22E0B9709C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <862DD946-EB3C-405A-BE88-4B22E0B9709C@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 06 Jun 2019 09:24:03 +0000 (UTC)
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
> > On 6 Jun 2019, at 11:42, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
> >=20
> > * Liran Alon (liran.alon@oracle.com) wrote:
> >> Hi,
> >>=20
> >> Looking at QEMU source code, I am puzzled regarding how migration ba=
ckwards compatibility is preserved regarding X86CPU.
> >>=20
> >> As I understand it, fields that are based on KVM capabilities and gu=
est runtime usage are defined in VMState subsections in order to not send=
 them if not necessary.
> >> This is done such that in case they are not needed and we migrate to=
 an old QEMU which don=E2=80=99t support loading this state, migration wi=
ll still succeed
> >> (As .needed() method will return false and therefore this state won=E2=
=80=99t be sent as part of migration stream).
> >> Furthermore, in case .needed() returns true and old QEMU don=E2=80=99=
t support loading this state, migration fails. As it should because we ar=
e aware that guest state
> >> is not going to be restored properly on destination.
> >>=20
> >> I=E2=80=99m puzzled about what will happen in the following scenario=
:
> >> 1) Source is running new QEMU with new KVM that supports save of som=
e VMState subsection.
> >> 2) Destination is running new QEMU that supports load this state but=
 with old kernel that doesn=E2=80=99t know how to load this state.
> >>=20
> >> I would have expected in this case that if source .needed() returns =
true, then migration will fail because of lack of support in destination =
kernel.
> >> However, it seems from current QEMU code that this will actually suc=
ceed in many cases.
> >>=20
> >> For example, if msr_smi_count is sent as part of migration stream (S=
ee vmstate_msr_smi_count) and destination have has_msr_smi_count=3D=3Dfal=
se,
> >> then destination will succeed loading migration stream but kvm_put_m=
srs() will actually ignore env->msr_smi_count and will successfully load =
guest state.
> >> Therefore, migration will succeed even though it should have failed=E2=
=80=A6
> >>=20
> >> It seems to me that QEMU should have for every such VMState subsecti=
on, a .post_load() method that verifies that relevant capability is suppo=
rted by kernel
> >> and otherwise fail migration.
> >>=20
> >> What do you think? Should I really create a patch to modify all thes=
e CPUX86 VMState subsections to behave like this?
> >=20
> > I don't know the x86 specific side that much; but from my migration s=
ide
> > the answer should mostly be through machine types - indeed for smi-co=
unt
> > there's a property 'x-migrate-smi-count' which is off for machine typ=
es
> > pre 2.11 (see hw/i386/pc.c pc_compat_2_11) - so if you've got an old
> > kernel you should stick to the old machine types.
> >=20
> > There's nothing guarding running the new machine type on old-kernels;
> > and arguably we should have a check at startup that complains if
> > your kernel is missing something the machine type uses.
> > However, that would mean that people running with -M pc   would fail
> > on old kernels.
> >=20
> > A post-load is also a valid check; but one question is whether,
> > for a particular register, the pain is worth it - it depends on the
> > symptom that the missing state causes.  If it's minor then you might
> > conclude it's not worth a failed migration;  if it's a hung or
> > corrupt guest then yes it is.   Certainly a warning printed is worth
> > it.
> >=20
> > Dave
>=20
> I think we should have flags that allow user to specify which VMState s=
ubsections user explicitly allow to avoid restore even though they are re=
quired to fully restore guest state.
> But it seems to me that the behaviour should be to always fail migratio=
n in case we load a VMState subsections that we are unable to restore unl=
ess user explicitly specified this is ok
> for this specific subsection.
> Therefore, it seems that for every VMState subsection that it=E2=80=99s=
 restore is based on kernel capability we should:
> 1) Have a user-controllable flag (which is also tied to machine-type?) =
to explicitly allow avoid restoring this state if cannot. Default should =
be =E2=80=9Cfalse=E2=80=9D.
> 2) Have a .post_load() method that verifies we have required kernel cap=
ability to restore this state, unless flag (1) was specified as =E2=80=9C=
true=E2=80=9D.

This seems a lot of flags; users aren't going to know what to do with
all of them; I don't see what will set/control them.

> Note that above mentioned flags is different than flags such as =E2=80=9C=
x-migrate-smi-count=E2=80=9D.
> The purpose of =E2=80=9Cx-migrate-smi-count=E2=80=9D flag is to avoid s=
ending the VMState subsection to begin with in case we know we migrate to=
 older QEMU which don=E2=80=99t even have the relevant VMState subsection=
. But it is not relevant for the case both source and destination runs QE=
MU which understands the VMState subsection but run on kernels with diffe=
rent capabilities.
>=20
> Also note regarding your first paragraph, that specifying flags based o=
n kernel you are running on doesn=E2=80=99t help for the case discussed h=
ere.
> As source QEMU is running on new kernel. Unless you meant that source Q=
EMU should use relevant machine-type based on the destination kernel.
> i.e. You should launch QEMU with old machine-type as long as you have h=
osts in your migration pool that runs with old kernel.

That's what I meant; stick to the old machine-type unless you know it's
safe to use a newer one.

> I don=E2=80=99 think it=E2=80=99s the right approach though. As there i=
s no way to change flags such as =E2=80=9Cx-migrate-smi-count=E2=80=9D dy=
namically after all hosts in migration pool have been upgraded.
>=20
> What do you think?

I don't have an easy answer.  The users already have to make sure they
use a machine type that's old enough for all the QEMUs installed in
their cluster; making sure it's also old enough for their oldest
kernel isn't too big a difference - *except* that it's much harder to
tell which kernel corresponds to which feature/machine type etc - so
how does a user know what the newest supported machine type is?
Failing at startup when selecting a machine type that the current
kernel can't support would help that.

Dave

> -Liran
>=20
> >=20
> >> Thanks,
> >> -Liran
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

