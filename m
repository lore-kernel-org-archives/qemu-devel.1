Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14837ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC56D206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC56D206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIuuP-0004Ey-2v
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1iIutQ-0003EY-HG
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1iIutL-0008SD-Bn
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:23:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:18516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1iIutJ-0008Ln-57
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:23:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Oct 2019 06:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; d="scan'208";a="193534282"
Received: from lxy-dell.sh.intel.com ([10.239.159.46])
 by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2019 06:23:28 -0700
Message-ID: <28fc2886186f10954ac773100bdd4ca3c483d362.camel@intel.com>
Subject: Re: [PATCH] target/i386: Remove MPX support on Snowridge CPU model
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 11 Oct 2019 21:16:28 +0800
In-Reply-To: <20191011125723.GP4084@habkost.net>
References: <20191011071844.108924-1-xiaoyao.li@intel.com>
 <20191011125723.GP4084@habkost.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-10-11 at 09:57 -0300, Eduardo Habkost wrote:
> On Fri, Oct 11, 2019 at 03:18:44PM +0800, Xiaoyao Li wrote:
> > MPX support is being phased out by Intel. Following other CPU models
> > like Skylake, Icelake and Cascadelake, do not enable it by default.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> > I'm not sure is there anyone already use Snowridge CPU model and whether to
> > add it in pc_compat_4_1, since Snowridge has not been released yet.
> 
> We have a CPU model versioning mechanism now, please implement this using the
> new system.  e.g.:
> 
>         .versions = (X86CPUVersionDefinition[]) {
>             { .version = 1 },
>             {
>                 .version = 2,
>                 .props = (PropValue[]) {
>                     { "mpx", "off" },
>                     { /* end of list */ }
>                 }
>             },
>             { /* end of list */ }
>         }
> 
> Then machine-type compat properties won't be needed anymore.

Since Snowridge CPU hasn't been released yet and I guess there might be no real
user use this CPU model. So do we really need to add v2? Can we just remove the
mpx feature in the original version?

> > 
> > ---
> >  hw/i386/pc.c      | 4 +++-
> >  target/i386/cpu.c | 1 -
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index bcda50efcc23..97eb7ac32588 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -105,7 +105,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
> >  /* Physical Address of PVH entry point read from kernel ELF NOTE */
> >  static size_t pvh_start_addr;
> >  
> > -GlobalProperty pc_compat_4_1[] = {};
> > +GlobalProperty pc_compat_4_1[] = {
> > +    { "Snowridge" "-" TYPE_X86_CPU, "mpx", "on" },
> > +};
> >  const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
> >  
> >  GlobalProperty pc_compat_4_0[] = {};
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 44f1bbdcac76..885bea76205d 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2762,7 +2762,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
> >              CPUID_7_0_EBX_FSGSBASE |
> >              CPUID_7_0_EBX_SMEP |
> >              CPUID_7_0_EBX_ERMS |
> > -            CPUID_7_0_EBX_MPX |  /* missing bits 13, 15 */
> >              CPUID_7_0_EBX_RDSEED |
> >              CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
> >              CPUID_7_0_EBX_CLWB |
> > -- 
> > 2.19.1
> > 
> 
> 


