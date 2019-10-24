Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6D5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949DF21655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949DF21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdZl-00032P-9h
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1iNdIU-0007YQ-Cm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1iNdIR-0004IV-IO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:37:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:45981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1iNdIP-0004HL-Ti
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:36:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:36:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="373216700"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga005.jf.intel.com with ESMTP; 24 Oct 2019 06:36:52 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 24 Oct 2019 06:36:52 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 24 Oct 2019 06:36:52 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.96]) with mapi id 14.03.0439.000;
 Thu, 24 Oct 2019 21:36:50 +0800
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v4 2/2] i386: Add support to get/set/migrate Intel
 Processor Trace feature
Thread-Topic: [PATCH v4 2/2] i386: Add support to get/set/migrate Intel
 Processor Trace feature
Thread-Index: AQHVgKsg+eNsNdVZH0GZ6Dwyyz/Lp6dbpngw//+LOYCACWt2QIACHxuAgAL58ED//58DAIAAhvHw
Date: Thu, 24 Oct 2019 13:36:50 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E17382D885@SHSMSX104.ccr.corp.intel.com>
References: <1520182116-16485-1-git-send-email-luwei.kang@intel.com>
 <1520182116-16485-2-git-send-email-luwei.kang@intel.com>
 <20191012031407.GK4084@habkost.net>
 <82D7661F83C1A047AF7DC287873BF1E17382A209@SHSMSX104.ccr.corp.intel.com>
 <20191015132929.GY4084@habkost.net>
 <82D7661F83C1A047AF7DC287873BF1E17382BB76@SHSMSX104.ccr.corp.intel.com>
 <20191022214416.GA21651@habkost.net>
 <82D7661F83C1A047AF7DC287873BF1E17382D523@SHSMSX104.ccr.corp.intel.com>
 <20191024132414.GQ6744@habkost.net>
In-Reply-To: <20191024132414.GQ6744@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTRjMWQ3YzUtMmJkZS00OWQyLWFjOWEtNzljOTNkNzY1OTA3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTTV3ZVF4K2Fla0ZzSjNsZ2RsVUZcL1hQWVRoN2VxSjIzdVNEY0o4RGJaa2ZXTDg2RE5xV2dnNFQxNCtHQmpHSlkifQ==
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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

> > > > > > > > f9f4cd1..097c953 100644
> > > > > > > > --- a/target/i386/kvm.c
> > > > > > > > +++ b/target/i386/kvm.c
> > > > > > > > @@ -1811,6 +1811,25 @@ static int kvm_put_msrs(X86CPU *cpu,=
 int level)
> > > > > > > >                  kvm_msr_entry_add(cpu, MSR_MTRRphysMask(i)=
, mask);
> > > > > > > >              }
> > > > > > > >          }
> > > > > > > > +        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_IN=
TEL_PT) {
> > > > > > > > +            int addr_num =3D kvm_arch_get_supported_cpuid(=
kvm_state,
> > > > > > > > +                                                    0x14,
> > > > > > > > + 1,
> > > > > > > > + R_EAX) & 0x7;
> > > > > > > > +
> > > > > > > > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_CTL,
> > > > > > > > +                            env->msr_rtit_ctrl);
> > > > > > > > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_STATUS,
> > > > > > > > +                            env->msr_rtit_status);
> > > > > > > > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_OUTPUT_BA=
SE,
> > > > > > > > +                            env->msr_rtit_output_base);
> > > > > > >
> > > > > > > This causes the following crash on some hosts:
> > > > > > >
> > > > > > >   qemu-system-x86_64: error: failed to set MSR 0x560 to 0x0
> > > > > > >   qemu-system-x86_64: target/i386/kvm.c:2673: kvm_put_msrs: A=
ssertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
> > > > > > >
> > > > > > > Checking for CPUID_7_0_EBX_INTEL_PT is not enough: KVM has
> > > > > > > additional conditions that might prevent writing to this MSR
> > > > > > > (PT_CAP_topa_output && PT_CAP_single_range_output).  This
> > > > > causes QEMU to crash if some of the conditions aren't met.
> > > > > > >
> > > > > > > Writing and reading this MSR (and the ones below) need to be =
conditional on KVM_GET_MSR_INDEX_LIST.
> > > > > > >
> > > > > >
> > > > > > Hi Eduardo,
> > > > > >     I found this issue can't be reproduced in upstream source
> > > > > > code but can be reproduced on RHEL8.1. I haven't got the qemu
> > > > > > source
> > > > > code of RHEL8.1. But after adding some trace in KVM, I found the
> > > > > KVM has reported the complete Intel PT CPUID information to qemu
> > > > > but the Intel PT CPUID (0x14) is lost when qemu setting the
> > > > > CPUID
> > > to KVM (cpuid level is 0xd). It looks like lost the below patch.
> > > > > >
> > > > > > commit f24c3a79a415042f6dc195f029a2ba7247d14cac
> > > > > > Author: Luwei Kang <luwei.kang@intel.com>
> > > > > > Date:   Tue Jan 29 18:52:59 2019 -0500
> > > > > >     i386: extended the cpuid_level when Intel PT is enabled
> > > > > >
> > > > > >     Intel Processor Trace required CPUID[0x14] but the cpuid_le=
vel
> > > > > >     have no change when create a kvm guest with
> > > > > >     e.g. "-cpu qemu64,+intel-pt".
> > > > >
> > > > > Thanks for the pointer.  This may avoid triggering the bug in
> > > > > the default configuration, but we still need to make the MSR
> > > > > writing conditional on KVM_GET_MSR_INDEX_LIST.  Older
> > > > > machine-types have x-intel-pt-auto-level=3Doff, and the user may
> > > > > set `level`
> > > manually.
> > > >
> > > > Hi Eduardo,
> > > > Sorry for a delay reply because my mail filter. I tried with the
> > > > Q35 machine type and default, all looks work well (With some old
> > > > cpu type
> > > > + "intel_pt" also work well).  KVM will check the Intel PT work
> > > > + mode
> > > > and HW to decide if Intel PT can be exposed to guest, only
> > > > extended the CPUID level is useless. If the guest doesn't support
> > > > Intel PT, any MSR read or write will cause #GP. Please remind me
> > > > if I lost something.
> > >
> > > I understand you have tried q35 and pc, but have you tried with older=
 machine-type versions?
> > >
> > > Commit f24c3a79a415 doesn't change behavior on pc-*-3.1 and older, so=
 it only avoids triggering the crash in the default case.
> > > Doesn't QEMU crash if running:
> > > "-cpu qemu64,+intel-pt -machine pc-i440fx-3.1"?
> > >
> > > KVM rejecting MSR writes when something is missing is correct.
> > > QEMU trying to write the MSR when something is missing (and crashing =
because of that) is a bug.
> >
> > Hi Eduardo,
> >     Yes, you are right. Intel PT is only set in leaf 0x7.ebx but leaf 0=
x14 is lost because of the leaf number still 0xd (should 0x14).
> >     May I remove the "off" like this?
>=20
> We can't.  This is necessary to keep guest ABI compatibility.
> Instead, we need to make QEMU not crash if xlevel is too low, because xle=
vel can be configured by the user.

Thanks Eduardo.  But I think it is a little complex for user. User found cr=
ash but how does he know it need to configure the xlevel or others?
If we want to the old machine type support PT can we add some code to exten=
d the level to 0x14? Or old machine type can't support PT,  mask off this f=
eature from leaf 0x07.ebx[25] directly and output some messages?

Luwei Kang

>=20
> >
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -132,7 +132,6 @@ GlobalProperty pc_compat_3_1[] =3D {
> >      { "Icelake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
> >      { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
> >      { "Cascadelake-Server" "-" TYPE_X86_CPU, "stepping", "5" },
> > -    { TYPE_X86_CPU, "x-intel-pt-auto-level", "off" },
> >  };
> >  const size_t pc_compat_3_1_len =3D G_N_ELEMENTS(pc_compat_3_1);
> >
> > Thanks,
> > Luwei Kang
> >
> > >
> > > --
> > > Eduardo
> >
>=20
> --
> Eduardo


