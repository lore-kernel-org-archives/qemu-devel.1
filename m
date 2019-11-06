Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41D7C5DF60
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 00:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4766421929
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 00:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4766421929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS9co-0004x2-KE
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 19:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1iS9br-0004YC-JP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 19:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1iS9bo-0005Qk-Uq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 19:55:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:35099)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1iS9bo-0005Lf-NT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 19:55:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Nov 2019 16:55:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; d="scan'208";a="226389863"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by FMSMGA003.fm.intel.com with ESMTP; 05 Nov 2019 16:55:35 -0800
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 Nov 2019 16:55:35 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 Nov 2019 16:55:34 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.149]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 08:55:33 +0800
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v1 Resend] target/i386: set the CPUID level to 0x14 on
 old machine-type
Thread-Topic: [PATCH v1 Resend] target/i386: set the CPUID level to 0x14 on
 old machine-type
Thread-Index: AQHVjvWkxxh7+tauRUewq5YPMhgQA6d8l5eAgAC2cVA=
Date: Wed, 6 Nov 2019 00:55:32 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E173838407@SHSMSX104.ccr.corp.intel.com>
References: <1572416882-41378-1-git-send-email-luwei.kang@intel.com>
 <20191105211303.GK3812@habkost.net>
In-Reply-To: <20191105211303.GK3812@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGMzZjkxZWItZWZjYy00ZjFjLTk2MDUtNjY3YmM5MzFlNTA5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNmtaQis3VmtrSWhiMTBNOHRrdlFEZlFsVUxNeHNnQ0dtbU43YkVTdnB4bVN1dFFFbUNaS3FHZlp2SkQwOUZMQSJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > The CPUID level need to be set to 0x14 manually on old machine-type if
> > Intel PT is enabled in guest. e.g. in Qemu 3.1 -machine pc-i440fx-3.1
> > -cpu qemu64,+intel-pt will be CPUID[0].EAX(level)=3D7 and
> > CPUID[7].EBX[25](intel-pt)=3D1.
> >
> > Some Intel PT capabilities are exposed by leaf 0x14 and the missing
> > capabilities will cause some MSRs access failed.
> > This patch add a warning message to inform the user to extend the
> > CPUID level.
>=20
> Note that a warning is not an acceptable fix for a QEMU crash.
> We still need to fix the QEMU crash reported at:
> https://lore.kernel.org/qemu-devel/20191024141536.GU6744@habkost.net/
>=20
>=20
> >
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
>=20
> The subject line says "v1", but this patch is different from the
> v1 you sent earlier.
>=20
> If you are sending a different patch, please indicate it is a new version=
.  Please also
> indicate what changed between different patch versions, to help review.

Got it. I fix a code style problem in resending patch (remove the '\n').

ERROR: Error messages should not contain newlines
#36: FILE: target/i386/cpu.c:5448:
+                            "by \"-cpu ...,+intel-pt,level=3D0x14\"\n");
total: 1 errors, 0 warnings, 14 lines checked

>=20
> > ---
> >  target/i386/cpu.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > a624163..f67c479 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -5440,8 +5440,12 @@ static void x86_cpu_expand_features(X86CPU
> > *cpu, Error **errp)
> >
> >          /* Intel Processor Trace requires CPUID[0x14] */
> >          if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
> > -             kvm_enabled() && cpu->intel_pt_auto_level) {
>=20
> Not directly related to the warning: do you know why we have a
> kvm_enabled() check here?  It seems unnecessary.  We want CPUID level to =
be correct
> for all accelerators.

Intel PT virtualization enabling in KVM guest need some hardware enhancemen=
t and
EPT must be enabled in KVM.  I think it can't work for e.g. tcg pure simula=
tion accelerator.

>=20
> > -            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14)=
;
> > +             kvm_enabled()) {
> > +            if (cpu->intel_pt_auto_level)
> > +                x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0=
x14);
> > +            else
> > +                warn_report("Intel PT need CPUID leaf 0x14, please set=
 "
> > +                            "by \"-cpu ...,+intel-pt,level=3D0x14\"");
>=20
> The warning shouldn't be triggered if level is already >=3D 0x14.
>=20
> It is probably a good idea to mention that this happens only on
> pc-*-3.1 and older, as updating the machine-type is a better solution to =
the problem
> than manually setting the "level"
> property.
>=20
> This will print the warning multiple times if there are multiple VCPUs.  =
You can use
> warn_report_once() to avoid that.

Got it. Will fix.

As you mentioned in this email " a warning is not an acceptable fix for a Q=
EMU crash."
We can't change the configuration of the old machine type because it may br=
eak the
ABI compatibility. May I add more check on Intel PT, if CPUID[7].EBX[25] (i=
ntel-pt) =3D 1
and level is <0x14, mask off this feature? Or do you have any other suggest=
ions?

Thanks,
Luwei Kang

>=20
> >          }
> >
> >          /* CPU topology with multi-dies support requires CPUID[0x1F]
> > */
> > --
> > 1.8.3.1
> >
>=20
> --
> Eduardo


