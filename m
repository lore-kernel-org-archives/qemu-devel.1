Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C01C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69124206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69124206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJJX-0007AL-Nb
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 09:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40415)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hiJIN-0006YU-12
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hiJIL-0006sr-Pn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:58:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hiJIL-0006rz-GA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:58:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDF4230C319F
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 13:57:59 +0000 (UTC)
Received: from redhat.com (ovpn-112-16.ams2.redhat.com [10.36.112.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 153307E119;
 Tue,  2 Jul 2019 13:57:56 +0000 (UTC)
Date: Tue, 2 Jul 2019 14:57:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190702135753.GW21569@redhat.com>
References: <20190628002844.24894-1-ehabkost@redhat.com>
 <20190628002844.24894-8-ehabkost@redhat.com>
 <20190702094525.GN21569@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190702094525.GN21569@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 02 Jul 2019 13:57:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 7/9] i386: Make unversioned CPU models
 be aliases
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 10:45:25AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jun 27, 2019 at 09:28:42PM -0300, Eduardo Habkost wrote:
> > This will make unversioned CPU models behavior depend on the
> > machine type:
> >=20
> > * "pc-*-4.0" and older will not report them as aliases.
> >   This is done to keep compatibility with older QEMU versions
> >   after management software starts translating aliases.
> >=20
> > * "pc-*-4.1" will translate unversioned CPU models to -v1.
> >   This is done to keep compatibility with existing management
> >   software, that still relies on CPU model runnability promises.
> >=20
> > * "none" will translate unversioned CPU models to their latest
> >   version.  This is planned become the default in future machine
> >   types (probably in pc-*-4.3).
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Patch v1 was "[PATCH 4/6] i386: Infrastructure for versioned CPU
> > models", and was split into multiple patches.
> >=20
> > Changes v1 -> v2:
> > * Make version numbers simple integers, completely independent
> >   from machine type versions
> > * New X86CPUVersion typedef
> > * New CPU_VERSION_* defines to make X86CPUModel::version
> >   semantics clearer
> > ---
> >  include/hw/i386/pc.h                       |   3 +
> >  target/i386/cpu.h                          |  12 ++
> >  hw/i386/pc.c                               |   3 +
> >  hw/i386/pc_piix.c                          |   4 +
> >  hw/i386/pc_q35.c                           |   4 +
> >  target/i386/cpu.c                          |  52 ++++++++-
> >  tests/acceptance/x86_cpu_model_versions.py | 126 +++++++++++++++++++=
++
> >  7 files changed, 203 insertions(+), 1 deletion(-)



> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 57232aed6b..397e1fdd2f 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -367,8 +367,10 @@ static void pc_q35_machine_options(MachineClass =
*m)
> > =20
> >  static void pc_q35_4_1_machine_options(MachineClass *m)
> >  {
> > +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> >      pc_q35_machine_options(m);
> >      m->alias =3D "q35";
> > +    pcmc->default_cpu_version =3D 1;
>=20
> How will this work in future if we need to introduce a v2 of some,
> but not all CPU models, and then further a v3 of some others.
>=20
> Can we select Haswell-v1,  Skylake-Server-v2, CascadeLake-v3
> as defaults in some way ?

Answered in reply to a later patch so

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

