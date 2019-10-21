Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8856FCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575552084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575552084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMQn4-00043d-Hr
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 02:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1iMQmA-0003eA-Bb
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1iMQm7-0004lQ-VN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:02:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:53286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1iMQm7-0004jo-Nu
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:02:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Oct 2019 23:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; d="scan'208";a="222361367"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2019 23:02:31 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 20 Oct 2019 23:02:31 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Oct 2019 23:02:30 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 20 Oct 2019 23:02:30 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX152.ccr.corp.intel.com ([10.239.6.52]) with mapi id 14.03.0439.000;
 Mon, 21 Oct 2019 14:02:29 +0800
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v4 2/2] i386: Add support to get/set/migrate Intel
 Processor Trace feature
Thread-Topic: [PATCH v4 2/2] i386: Add support to get/set/migrate Intel
 Processor Trace feature
Thread-Index: AQHVgKsg+eNsNdVZH0GZ6Dwyyz/Lp6dbpngw//+LOYCACWt2QA==
Date: Mon, 21 Oct 2019 06:02:28 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E17382BB76@SHSMSX104.ccr.corp.intel.com>
References: <1520182116-16485-1-git-send-email-luwei.kang@intel.com>
 <1520182116-16485-2-git-send-email-luwei.kang@intel.com>
 <20191012031407.GK4084@habkost.net>
 <82D7661F83C1A047AF7DC287873BF1E17382A209@SHSMSX104.ccr.corp.intel.com>
 <20191015132929.GY4084@habkost.net>
In-Reply-To: <20191015132929.GY4084@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTk4OWUwODctY2U0Ni00NDhmLTkzMGItOTRiOTc5NjVhMzNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVjRobHg4aGRkZVh2MGlxQ0RYMTIyNDNWd0RtMmdPb2NGUGpxVDlJTjVaMUx5cGU0T3JTUk9RNU9NemhQK1dVYyJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > > f9f4cd1..097c953 100644
> > > > --- a/target/i386/kvm.c
> > > > +++ b/target/i386/kvm.c
> > > > @@ -1811,6 +1811,25 @@ static int kvm_put_msrs(X86CPU *cpu, int lev=
el)
> > > >                  kvm_msr_entry_add(cpu, MSR_MTRRphysMask(i), mask);
> > > >              }
> > > >          }
> > > > +        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) =
{
> > > > +            int addr_num =3D kvm_arch_get_supported_cpuid(kvm_stat=
e,
> > > > +                                                    0x14, 1,
> > > > + R_EAX) & 0x7;
> > > > +
> > > > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_CTL,
> > > > +                            env->msr_rtit_ctrl);
> > > > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_STATUS,
> > > > +                            env->msr_rtit_status);
> > > > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_OUTPUT_BASE,
> > > > +                            env->msr_rtit_output_base);
> > >
> > > This causes the following crash on some hosts:
> > >
> > >   qemu-system-x86_64: error: failed to set MSR 0x560 to 0x0
> > >   qemu-system-x86_64: target/i386/kvm.c:2673: kvm_put_msrs: Assertion=
 `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
> > >
> > > Checking for CPUID_7_0_EBX_INTEL_PT is not enough: KVM has
> > > additional conditions that might prevent writing to this MSR (PT_CAP_=
topa_output && PT_CAP_single_range_output).  This
> causes QEMU to crash if some of the conditions aren't met.
> > >
> > > Writing and reading this MSR (and the ones below) need to be conditio=
nal on KVM_GET_MSR_INDEX_LIST.
> > >
> >
> > Hi Eduardo,
> >     I found this issue can't be reproduced in upstream source code but =
can be reproduced on RHEL8.1. I haven't got the qemu source
> code of RHEL8.1. But after adding some trace in KVM, I found the KVM has =
reported the complete Intel PT CPUID information to qemu
> but the Intel PT CPUID (0x14) is lost when qemu setting the CPUID to KVM =
(cpuid level is 0xd). It looks like lost the below patch.
> >
> > commit f24c3a79a415042f6dc195f029a2ba7247d14cac
> > Author: Luwei Kang <luwei.kang@intel.com>
> > Date:   Tue Jan 29 18:52:59 2019 -0500
> >     i386: extended the cpuid_level when Intel PT is enabled
> >
> >     Intel Processor Trace required CPUID[0x14] but the cpuid_level
> >     have no change when create a kvm guest with
> >     e.g. "-cpu qemu64,+intel-pt".
>=20
> Thanks for the pointer.  This may avoid triggering the bug in the default=
 configuration, but we still need to make the MSR writing
> conditional on KVM_GET_MSR_INDEX_LIST.  Older machine-types have x-intel-=
pt-auto-level=3Doff, and the user may set `level`
> manually.

Hi Eduardo,
    Sorry for a delay reply because my mail filter. I tried with the Q35 ma=
chine type and default, all looks work well (With some old cpu type + "inte=
l_pt" also work well).  KVM will check the Intel PT work mode and HW to dec=
ide if Intel PT can be exposed to guest, only extended the CPUID level is u=
seless. If the guest doesn't support Intel PT, any MSR read or write will c=
ause #GP. Please remind me if I lost something.

Thanks,
Luwei Kang

>=20
> --
> Eduardo

