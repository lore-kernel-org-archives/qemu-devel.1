Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B49C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A2F2184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A2F2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijeu-0003b8-RV
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hije2-0002mx-JI
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hije0-0007dS-VR
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:06:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hije0-0007bm-N8
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:06:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA3D881F0E;
 Wed,  3 Jul 2019 18:06:09 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6815B8E641;
 Wed,  3 Jul 2019 18:06:09 +0000 (UTC)
Date: Wed, 3 Jul 2019 15:06:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20190703180607.GW5198@habkost.net>
References: <20190702153535.9851-1-ehabkost@redhat.com>
 <20190702153535.9851-41-ehabkost@redhat.com>
 <3ac827c6-6a54-2755-3189-156cae3d4a89@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3ac827c6-6a54-2755-3189-156cae3d4a89@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 03 Jul 2019 18:06:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v3 40/42] i386: Add Cascadelake-Server-v2
 CPU model
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 03, 2019 at 09:16:57AM +0800, Xiaoyao Li wrote:
> Hi, Eduardo
>=20
> On 7/2/2019 11:35 PM, Eduardo Habkost wrote:
> > Add new version of Cascadelake-Server CPU model, setting
> > stepping=3D5 and enabling the IA32_ARCH_CAPABILITIES MSR
> > with some flags.
> >=20
> > The new feature will introduce a new host software requirement,
> > breaking our CPU model runnability promises.  This means we can't
> > enable the new CPU model version by default in QEMU 4.1, because
> > management software isn't ready yet to resolve CPU model aliases.
> > This is why "pc-*-4.1" will keep returning Cascadelake-Server-v1
> > if "-cpu Cascadelake-Server" is specified.
> >=20
> > Includes a test case to ensure the right combinations of
> > machine-type + CPU model + command-line feature flags will work
> > as expected.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > Message-Id: <20190628002844.24894-10-ehabkost@redhat.com>
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >   target/i386/cpu.c                          | 14 +++++
> >   tests/acceptance/x86_cpu_model_versions.py | 73 +++++++++++++++++++=
+++
> >   2 files changed, 87 insertions(+)
> >=20
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 9b16cffb22..0298396a91 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2343,6 +2343,20 @@ static X86CPUDefinition builtin_x86_defs[] =3D=
 {
> >               CPUID_6_EAX_ARAT,
> >           .xlevel =3D 0x80000008,
> >           .model_id =3D "Intel Xeon Processor (Cascadelake)",
> > +        .versions =3D (X86CPUVersionDefinition[]) {
> > +            { .version =3D 1 },
> > +            { .version =3D 2,
> > +              .props =3D (PropValue[]) {
> > +                  { "stepping", "5" },
> > +                  { "arch-capabilities", "on" },
> > +                  { "rdctl-no", "on" },
> > +                  { "ibrs-all", "on" },
> > +                  { "skip-l1dfl-vmentry", "on" },
> > +                  { /* end of list */ }
> > +              },
> > +            },
> > +            { /* end of list */ }
> > +        }
>=20
> seems you forgot to fix the stepping and add feature "mds-no".

I plan to fix it in a follow up patch to avoid holding the
current pull request for another day.

--=20
Eduardo

