Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F19C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C19206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C19206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGxJ-0008EP-29
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48059)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1haGrg-0002uv-CJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1haGrc-0005tM-6O
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1haGrX-0005dW-SL
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:45:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 343823086225;
 Mon, 10 Jun 2019 09:44:51 +0000 (UTC)
Received: from work-vm (ovpn-117-16.ams2.redhat.com [10.36.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C8E65C219;
 Mon, 10 Jun 2019 09:44:47 +0000 (UTC)
Date: Mon, 10 Jun 2019 10:44:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190610094444.GB22439@work-vm>
References: <20190606084222.GA2788@work-vm>
 <862DD946-EB3C-405A-BE88-4B22E0B9709C@oracle.com>
 <20190606092358.GE2788@work-vm>
 <8F3FD038-12DB-44BC-A262-3F1B55079753@oracle.com>
 <20190606103958.GJ2788@work-vm>
 <B7A9A778-9BD5-449E-A8F3-5D8E3471F4A6@oracle.com>
 <20190606110737.GK2788@work-vm>
 <3F6B41CD-C7E2-4A61-875C-F61AE45F2A58@oracle.com>
 <20190606133138.GM2788@work-vm>
 <041C1ABE-48B4-487A-B0EF-67F0FBFCA8BE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <041C1ABE-48B4-487A-B0EF-67F0FBFCA8BE@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 10 Jun 2019 09:44:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QEMU/KVM migration backwards compatibility broken?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
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
> > On 6 Jun 2019, at 16:31, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
> >=20
> >>>=20
> >>> So we still need to tie subsections to machine types; that way
> >>> you don't send them to old qemu's and there for you don't have the
> >>> problem of the qemu receiving something it doesn't know.
> >>=20
> >> I agree that if there is no way to skip a VMState subsection in the =
stream, then we must
> >> have a way to specify to source QEMU to prevent sending this subsect=
ion to destination=E2=80=A6
> >>=20
> >> I would suggest though that instead of having a flag tied to machine=
-type, we will have a QMP command
> >> that can specify names of subsections we explicitly wish to be skipp=
ed sending to destination even if their .needed() method returns true.
> >=20
> > I don't like the thought of generically going behind the devices back=
;
> > it's pretty rare to have to do this, so adding a qmp command to tweak
> > properties that we've already got seems to make more sense to me.
> >=20
> >> This seems like a more explicit approach and doesn=E2=80=99t come wi=
th the down-side of forever not migrating this VMState subsection
> > Dave
>=20
> If I understand you correctly, this is what you propose:
> 1) Have a .post_load() method for VMState subsections that depend on ke=
rnel capability to fail migration in case capability do not exist.

Yes (wehther it fails or prints a warning depends on how significant the
capability is; if it's a guest crash then fail is probably best).

> 2) For specific problematic VMState subsections, add property such that=
 it=E2=80=99s .needed() method will return false in case the property is =
set to false (value is true by default).
> 3) Have a QMP command that allows dynamically changing the value of the=
se properties.
> 4) Properties values are still tied to machine-type? I think not right?

Property values are initialised from the machine type; in your case
where you want to upgrade to use a new feature then you can use
(3) to change it.

> I instead propose the following:
> 1) Same as (1) above.
> 2) Add a MigrationParameter (and matching MigrationCapability) named =E2=
=80=9Cavoid_state=E2=80=9D that specifies list of subsection names to avo=
id sending in migration even if their .needed() method will return false.=
 i.e. We will modify migration/vmstate.c to not even call .needed() metho=
d of such subsection.
>=20
> I believe the second proposal have the following advantages:
> 1) Less error-prone: .needed() methods are written only once and don=E2=
=80=99t need to take into account additional properties when calculating =
if they are required or not. Just depend on guest state.
> 2) Generic: We don=E2=80=99t require additional patch to add a new prop=
erty to support avoiding sending some subsection in case it doesn=E2=80=99=
t matter for some workload. As we have discovered only late after msr_smi=
_count was added (by me) at that point. Second approach allows avoid send=
ing any subsection that is deemed not important to guest workload by migr=
ation admin.
> 3) Not tied to machine-type: Properties are usually tied to machine-typ=
e as they need to remain same forever for the lifetime of the guest. Howe=
ver, migration parameters are per-migration and are meant to be tweaked a=
nd changed. This allows a guest that used to run on old QEMU and moved to=
 new QEMU to now have better state saved for it=E2=80=99s next future mig=
rations.
>=20
> Currently we indeed have very rare cases like this ([git grep \"x-migra=
te | wc -l] product only 4 results=E2=80=A6) but I=E2=80=99m not sure it=E2=
=80=99s not only because we haven=E2=80=99t analysed carefully the case o=
f
> restored properties that it=E2=80=99s property depend on kernel capabil=
ity.
>=20
> As a start thought, we can start by at least agreeing to implement (1) =
and consider the property VS MigrationParameter discussion for a later ti=
me.
>=20
> What do you think?

I still don't like exposing a list of migration subsections into an
interface.

Dave

> -Liran
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

