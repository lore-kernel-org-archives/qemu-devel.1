Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20F0C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73339217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73339217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKMK6-0008Ll-HZ
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 08:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1iKMJ0-0007Rh-Iv
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1iKMIy-0006f9-Ok
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:52:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:61316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1iKMIy-0006eB-GH
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:52:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Oct 2019 05:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; d="scan'208";a="347064321"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga004.jf.intel.com with ESMTP; 15 Oct 2019 05:51:51 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 15 Oct 2019 05:51:51 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 15 Oct 2019 05:51:50 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX151.ccr.corp.intel.com ([10.239.6.50]) with mapi id 14.03.0439.000;
 Tue, 15 Oct 2019 20:51:49 +0800
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v4 2/2] i386: Add support to get/set/migrate Intel
 Processor Trace feature
Thread-Topic: [PATCH v4 2/2] i386: Add support to get/set/migrate Intel
 Processor Trace feature
Thread-Index: AQHVgKsg+eNsNdVZH0GZ6Dwyyz/Lp6dbpngw
Date: Tue, 15 Oct 2019 12:51:48 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E17382A209@SHSMSX104.ccr.corp.intel.com>
References: <1520182116-16485-1-git-send-email-luwei.kang@intel.com>
 <1520182116-16485-2-git-send-email-luwei.kang@intel.com>
 <20191012031407.GK4084@habkost.net>
In-Reply-To: <20191012031407.GK4084@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWUzYjc0YjktZTE2MC00MjgxLTgxMDgtZjUyMTk4YzgzNmM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicjBtTjVcL3dZSzBlS1lyOWV6cTA2bnRtaVdoWWxLaUdcLyt5dm9zVGErMllGXC9GTFdibHdTaWc3Q2I4ZEk5aEsyTSJ9
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

qemu> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c index
> > f9f4cd1..097c953 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -1811,6 +1811,25 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
> >                  kvm_msr_entry_add(cpu, MSR_MTRRphysMask(i), mask);
> >              }
> >          }
> > +        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
> > +            int addr_num =3D kvm_arch_get_supported_cpuid(kvm_state,
> > +                                                    0x14, 1, R_EAX) &
> > + 0x7;
> > +
> > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_CTL,
> > +                            env->msr_rtit_ctrl);
> > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_STATUS,
> > +                            env->msr_rtit_status);
> > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_OUTPUT_BASE,
> > +                            env->msr_rtit_output_base);
>=20
> This causes the following crash on some hosts:
>=20
>   qemu-system-x86_64: error: failed to set MSR 0x560 to 0x0
>   qemu-system-x86_64: target/i386/kvm.c:2673: kvm_put_msrs: Assertion `re=
t =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
>=20
> Checking for CPUID_7_0_EBX_INTEL_PT is not enough: KVM has additional con=
ditions that might prevent writing to this MSR
> (PT_CAP_topa_output && PT_CAP_single_range_output).  This causes QEMU to =
crash if some of the conditions aren't met.
>=20
> Writing and reading this MSR (and the ones below) need to be conditional =
on KVM_GET_MSR_INDEX_LIST.
>=20

Hi Eduardo,
    I found this issue can't be reproduced in upstream source code but can =
be reproduced on RHEL8.1. I haven't got the qemu source code of RHEL8.1. Bu=
t after adding some trace in KVM, I found the KVM has reported the complete=
 Intel PT CPUID information to qemu but the Intel PT CPUID (0x14) is lost w=
hen qemu setting the CPUID to KVM (cpuid level is 0xd). It looks like lost =
the below patch.

commit f24c3a79a415042f6dc195f029a2ba7247d14cac
Author: Luwei Kang <luwei.kang@intel.com>
Date:   Tue Jan 29 18:52:59 2019 -0500
    i386: extended the cpuid_level when Intel PT is enabled

    Intel Processor Trace required CPUID[0x14] but the cpuid_level
    have no change when create a kvm guest with
    e.g. "-cpu qemu64,+intel-pt".

Thanks,
Luwei Kang


