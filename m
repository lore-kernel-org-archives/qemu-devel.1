Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E004CC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F4120872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F4120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsbA-0003EG-Vv
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:38:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYsUt-0006qg-CW
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYsUo-0002sM-UR
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:32:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hYsUm-0001V4-Tu
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7BA7B2DE8;
	Thu,  6 Jun 2019 13:31:43 +0000 (UTC)
Received: from work-vm (ovpn-116-119.ams2.redhat.com [10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF2C8473C3;
	Thu,  6 Jun 2019 13:31:41 +0000 (UTC)
Date: Thu, 6 Jun 2019 14:31:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190606133138.GM2788@work-vm>
References: <38B8F53B-F993-45C3-9A82-796A0D4A55EC@oracle.com>
	<20190606084222.GA2788@work-vm>
	<862DD946-EB3C-405A-BE88-4B22E0B9709C@oracle.com>
	<20190606092358.GE2788@work-vm>
	<8F3FD038-12DB-44BC-A262-3F1B55079753@oracle.com>
	<20190606103958.GJ2788@work-vm>
	<B7A9A778-9BD5-449E-A8F3-5D8E3471F4A6@oracle.com>
	<20190606110737.GK2788@work-vm>
	<3F6B41CD-C7E2-4A61-875C-F61AE45F2A58@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3F6B41CD-C7E2-4A61-875C-F61AE45F2A58@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 06 Jun 2019 13:31:43 +0000 (UTC)
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
> > On 6 Jun 2019, at 14:07, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:

<snip>

> > It's tricky; for distro-based users, hitting 'update' and getting bot=
h
> > makes a lot of sense; but as you say you ened to let them do stuff
> > individually if they want to, so they can track down problems.
> > There's also a newer problem which is people want to run the QEMU in
> > containers on hosts that have separate update schedules - the kernel
> > version relationship is then much more fluid.
> >=20
> >> Compiling all above very useful discussion (thanks for this!), I may=
 have a better suggestion that doesn=E2=80=99t require any additional fla=
gs:
> >> 1) Source QEMU will always send all all VMState subsections that is =
deemed by source QEMU as required to not break guest semantic behaviour.
> >> This is done by .needed() methods that examine guest runtime state t=
o understand if this state is required to be sent or not.
> >=20
> > So that's as we already do.
>=20
> Besides the fact that today we also expect to add a flag tied to machin=
e-type for every new VMState subsection we add that didn=E2=80=99t exist =
on previous QEMU versions...
>=20
> >=20
> >> 2) Destination QEMU will provide a generic QMP command which allows =
to set names of VMState subsections that if accepted on migration stream
> >> and failed to be loaded (because either subsection name is not imple=
mented or because .post_load() method failed) then the failure should be =
ignored
> >> and migration should continue as usual. By default, the list of this=
 names will be empty.
> >=20
> > The format of the migration stream means that you can't skip an unkno=
wn
> > subsection; it's not possible to resume parsing the stream without
> > knowing what was supposed to be there. [This is pretty awful
> > but my last attempts to rework it hit a dead end]
>=20
> Wow=E2=80=A6 That is indeed pretty awful.
> I thought every VMState subsection have a header with a length field=E2=
=80=A6 :(

No, no length - it's just a header saying it's a subsection with the
name, then just unformatted data (that had better match what you
expect!).

> Why did your last attempts to add such a length field to migration stre=
am protocol failed?

There's a lot of stuff that's open coded rather than going through
VMState's, so you don't know how much data they'll end up generating.
So the only way to do that is to write to a buffer and then get the
length and dump the buffer.  Actually all that's rare in subsections
but does happen elsewhere.  I got some of some of those nasty cases
but I got stuck trying to get rid of some of the other opencoding
(and still keep it compatible).

> >=20
> > So we still need to tie subsections to machine types; that way
> > you don't send them to old qemu's and there for you don't have the
> > problem of the qemu receiving something it doesn't know.
>=20
> I agree that if there is no way to skip a VMState subsection in the str=
eam, then we must
> have a way to specify to source QEMU to prevent sending this subsection=
 to destination=E2=80=A6
>=20
> I would suggest though that instead of having a flag tied to machine-ty=
pe, we will have a QMP command
> that can specify names of subsections we explicitly wish to be skipped =
sending to destination even if their .needed() method returns true.

I don't like the thought of generically going behind the devices back;
it's pretty rare to have to do this, so adding a qmp command to tweak
properties that we've already got seems to make more sense to me.

> This seems like a more explicit approach and doesn=E2=80=99t come with =
the down-side of forever not migrating this VMState subsection
Dave

> for the entire lifetime of guest.
>=20
> >=20
> > Still, you could skip things where the destination kernel doesn't kno=
w
> > about it.
> >=20
> >> 3) Destination QEMU will implement .post_load() method for all these=
 VMState subsections that depend on kernel capability to be restored prop=
erly
> >> such that it will fail subsection load in case kernel capability is =
not present. (Note that this load failure will be ignored if subsection n=
ame is specified in (2)).
> >>=20
> >> Above suggestion have the following properties:
> >> 1) Doesn=E2=80=99t require any flag to be added to QEMU.
> >=20
> > There's no logical difference between 'flags' and 'names of subsectio=
ns'
> > - they're got the same problem in someone somewhere knowing which are
> >  safe.
>=20
> I agree. But creating additional flags does come with a development and=
 testing overhead and makes code less intuitive.
> I would have prefer to use subsection names.
>=20
> >=20
> >> 2) Moves all control on whether to fail migration because of failure=
 to load VMState subsection to receiver side. Sender always attempts to s=
end max state he believes is required.
> >> 3) We remove coupling of migration compatibility from machine-type.
> >>=20
> >> What do you think?
> >=20
> > Sorry, can't do (3) - we need to keep the binding for subsections to
> > machine types for qemu compatibility;  I'm open for something for
> > kernel compat, but not when it's breaking the qemu subsection
> > checks.
> >=20
> > Dave
>=20
> Agree. I have proposed now above how to not break qemu subsection check=
s while still not tie this to machine-type.
> Please tell me what you think on that approach. :)
>=20
> We can combine that approach together with implementing the mentioned .=
post_load() methods and maybe it solves the discussion at hand here.
>=20
> -Liran
>=20
> >=20
> >>=20
> >> -Liran
> >>=20
> >>>=20
> >>>> -Liran
> >>>>=20
> >>>>>=20
> >>>>>> -Liran
> >>>>>>=20
> >>>>>>>=20
> >>>>>>>> Thanks,
> >>>>>>>> -Liran
> >>>>>>> --
> >>>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>>>>=20
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

