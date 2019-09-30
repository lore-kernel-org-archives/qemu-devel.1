Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDCDC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90AD92075D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AD92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEwmG-0004QA-OV
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 10:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@intel.com>) id 1iEwht-0001Y0-JZ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@intel.com>) id 1iEwhr-0006IW-3o
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:31:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:33976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@intel.com>) id 1iEwhq-0006EW-Rb
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:31:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Sep 2019 07:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; d="scan'208";a="202902781"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga002.jf.intel.com with ESMTP; 30 Sep 2019 07:31:11 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 07:31:11 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 07:31:09 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.96]) with mapi id 14.03.0439.000;
 Mon, 30 Sep 2019 22:31:07 +0800
From: "Hu, Robert" <robert.hu@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Subject: RE: [RFC] cpu_map: Remove pconfig from Icelake-Server CPU model
Thread-Topic: [RFC] cpu_map: Remove pconfig from Icelake-Server CPU model
Thread-Index: AQHVd5j2Si5res+zF0qQPynuvqJfHKdERmdA
Date: Mon, 30 Sep 2019 14:31:07 +0000
Message-ID: <9E79D1C9A97CFD4097BCE431828FDD31173BCF76@SHSMSX104.ccr.corp.intel.com>
References: <20190926214305.17690-1-ehabkost@redhat.com>
 <20190930102453.GO4884@orkuz.int.mamuti.net>
 <20190930141104.GA4084@habkost.net>
In-Reply-To: <20190930141104.GA4084@habkost.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzBiOTNmY2UtMjhlNC00MDY1LWIwMjItOGVlNzcyYjEzNjRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWE0xVzdQbnQzQjFOOUxZWm94eDQ2UkJNTnMxSllSUXRFMTVlT0hYZytuVHNNeG5IYmx4SG5kWEV3Unhmd1RkcCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Kang,
 Luwei" <luwei.kang@intel.com>, Robert Hoo <robert.hu@linux.intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Monday, September 30, 2019 22:11
> To: Jiri Denemark <jdenemar@redhat.com>
> Cc: libvir-list@redhat.com; qemu-devel@nongnu.org; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P. Berrang=E9 <berrange@redhat.com>; Kang,
> Luwei <luwei.kang@intel.com>; thomas.lendacky@amd.com; Robert Hoo
> <robert.hu@linux.intel.com>; Richard Henderson <rth@twiddle.net>; Jiri
> Denemark <jdenemar@redhat.com>; Huang, Kai <kai.huang@intel.com>; Hu,
> Robert <robert.hu@intel.com>
> Subject: Re: [RFC] cpu_map: Remove pconfig from Icelake-Server CPU model
>=20
> CCing qemu-devel and QEMU developers.
>=20
> On Mon, Sep 30, 2019 at 12:24:53PM +0200, Jiri Denemark wrote:
> > On Thu, Sep 26, 2019 at 18:43:05 -0300, Eduardo Habkost wrote:
> > > The pconfig feature never worked, and adding "pconfig=3Doff" to the
> > > QEMU command-line triggers a regression in QEMU 3.1.1 and 4.0.0.
> > >
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > > I'm sending this as an RFC because I couldn't test it properly, and
> > > because I don't know what are the consequences of changing cpu_map
> > > between libvirt versions.
> > > ---
> > >  src/cpu_map/x86_Icelake-Server.xml | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/src/cpu_map/x86_Icelake-Server.xml
> > > b/src/cpu_map/x86_Icelake-Server.xml
> > > index fb15977a59..188a781282 100644
> > > --- a/src/cpu_map/x86_Icelake-Server.xml
> > > +++ b/src/cpu_map/x86_Icelake-Server.xml
> > > @@ -56,7 +56,9 @@
> > >      <feature name=3D'pat'/>
> > >      <feature name=3D'pcid'/>
> > >      <feature name=3D'pclmuldq'/>
> > > -    <feature name=3D'pconfig'/>
> > > +    <!-- 'pconfig' was added by accident in QEMU 3.1.0 but never wor=
ked.
> > > +         It was removed in QEMU 3.1.1 and 4.0.0.  See QEMU commits
> > > +         76e5a4d58357 and 712f807e1965 for details -->
> > >      <feature name=3D'pdpe1gb'/>
> > >      <feature name=3D'pge'/>
> > >      <feature name=3D'pku'/>
> >
> > IIUC this never worked and a domain started with Icelake-Server CPU
> > model would actually end up running with pconfig=3Doff, right? In that
> > case removing pconfig from Icelake-Server would not cause any issues
> > when a domain is started. However, I'm afraid migration would be broken=
.
> >
> > If a domain is started by new libvirt (with this patch in) using
> > Icelake-Server CPU model possibly with additional features added or
> > removed, but without pconfig being explicitly mentioned, libvirt would
> > not disable pconfig when updating active definition according to the
> > actual CPU created by QEMU. This is because libvirt did not ask for
> > pconfig (either explicitly or implicitly via the CPU model). When such
> > domain gets migrated to an older libvirt (which thinks pconfig is part
> > of Icelake-Server), it will complain that QEMU disabled pconfig while
> > the source domain was running with pconfig enabled (which is an
> > incorrect result caused by inconsistent view of the CPU model).
> >
> > Thus we would need to add a hack which would explicitly disable
> > pconfig in the domain definition used for migration to make sure the
> > destination libvirtd knows pconfig was disabled. New libvirt would
> > just drop the disabled pconfig feature from the CPU definition before
> > starting a domain.
> >
> > [1] From this point of view we could just keep the CPU model in
> > libvirt untouched. This way pconfig would always be explicitly
> > disabled when a domain is running and the host-model CPU definition
> > would also show it as explicitly disabled.
> >
> > [2] However starting a domain with Icelake-Server so that it can be
> > migrated or saved/restored on QEMU in 3.1.1 and 4.0.0 would be
> > impossible. This can be solved by a different hack, which would drop
> > pconfig=3Doff from QEMU command line.
> >
> > [3] But if pconfig was removed from QEMU and never returned back, we
> > could remove it from any domain XML we see
> > (virQEMUCapsCPUFilterFeatures mentions several other features which we
> handle this way).
> >
> > That said, I think [3] would be the best option. But if QEMU cannot or
> > doesn't want to remove pconfig completely, I'd go with [1] as the hack
> > in [2] would be too ugly and confusing.
>=20
> From the QEMU side, [3] is better, as pconfig was added by accident in 3.=
1.0 and
> it would be simpler to not re-add it.
>=20
> This might be a problem if there are plans to eventually make KVM support
> pconfig, though.  Paolo, Robert, are there plans to support pconfig in KV=
M in the
> future?
[Robert Hoo]=20
Thanks Eduardo for efforts in resolving this issue, introduced from my Icel=
ake CPU
model patch.
I've no idea about PCONFIG's detail and plan. Let me sync with Huang, Kai a=
nd answer
you soon.
>=20
> --
> Eduardo

