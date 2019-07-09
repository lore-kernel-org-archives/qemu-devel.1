Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37542C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71FE21670
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71FE21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hksxt-0007w0-O2
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 12:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35118)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <xiaoyao.li@linux.intel.com>) id 1hksvu-0007J4-Je
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@linux.intel.com>) id 1hksvt-00074r-48
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:25:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:12712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@linux.intel.com>)
 id 1hksvp-0006qU-S8
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:25:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jul 2019 09:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; d="scan'208";a="176545338"
Received: from lxy-dell.sh.intel.com ([10.239.159.145])
 by orsmga002.jf.intel.com with ESMTP; 09 Jul 2019 09:25:20 -0700
Message-ID: <636bad06254a55eacc4b33c72d48c419271e3833.camel@linux.intel.com>
From: Xiaoyao Li <xiaoyao.li@linux.intel.com>
To: Tao Xu <tao3.xu@intel.com>, ehabkost@redhat.com, rth@twiddle.net, 
 pbonzini@redhat.com
Date: Wed, 10 Jul 2019 00:20:26 +0800
In-Reply-To: <4c09858a-1bb3-13d3-333a-07639db9a03d@intel.com>
References: <20190709044420.14525-1-tao3.xu@intel.com>
 <8ac04db5-0a69-c74e-dab4-14159b8d22b6@linux.intel.com>
 <4c09858a-1bb3-13d3-333a-07639db9a03d@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH] target/i386: Introduce Denverton CPU model
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-07-09 at 22:27 +0800, Tao Xu wrote:
> On 7/9/2019 4:39 PM, Xiaoyao Li wrote:
> > On 7/9/2019 12:44 PM, Tao Xu wrote:
> > > Denverton-Server is the Atom Processor of Intel Harrisonville platform.
> > > 
> > > For more information:
> > > https://ark.intel.com/content/www/us/en/ark/products/\
> > > codename/63508/denverton.html
> > > 
> > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > > ---
> > >   target/i386/cpu.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 45 insertions(+)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 805ce95247..4efaff9918 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -2471,6 +2471,51 @@ static X86CPUDefinition builtin_x86_defs[] = {
> > >           .xlevel = 0x80000008,
> > >           .model_id = "Intel Xeon Processor (Icelake)",
> > >       },
> > > +    {
> > > +        .name = "Denverton-Server",
> > > +        .level = 21,
> > > +        .vendor = CPUID_VENDOR_INTEL,
> > > +        .family = 6,
> > > +        .model = 95,
> > > +        .stepping = 1,
> > > +        .features[FEAT_1_EDX] =
> > > +            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
> > > +            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
> > > +            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | 
> > > CPUID_CMOV |
> > > +            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | 
> > > CPUID_FXSR |
> > > +            CPUID_SSE | CPUID_SSE2,
> > > +        .features[FEAT_1_ECX] =
> > > +            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_MONITOR |
> > > +            CPUID_EXT_VMX | CPUID_EXT_SSSE3 | CPUID_EXT_CX16 |
> > > +            CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_X2APIC |
> > > +            CPUID_EXT_MOVBE | CPUID_EXT_POPCNT | 
> > > CPUID_EXT_TSC_DEADLINE_TIMER |
> > > +            CPUID_EXT_AES | CPUID_EXT_XSAVE | CPUID_EXT_RDRAND,
> > > +        .features[FEAT_8000_0001_EDX] =
> > > +            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
> > > +            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
> > > +        .features[FEAT_8000_0001_ECX] =
> > > +            CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
> > > +        .features[FEAT_7_0_EBX] =
> > > +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_SMEP | 
> > > CPUID_7_0_EBX_ERMS |
> > > +            CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_RDSEED | 
> > > CPUID_7_0_EBX_SMAP |
> > > +            CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_SHA_NI,
> > > +        .features[FEAT_7_0_EDX] =
> > > +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_ARCH_CAPABILITIES |
> > > +            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> > 
> > The output of CPUID_7_0:EDX is 0 in my Denverton machine, of which the 
> > stepping is 0 and microcode is 0xe.
> > 
> > Maybe we need to remove these 3 flag in the initial Denverton cpu model 
> > and add these features as 2nd version alias as Denverton-Server-IBRS? (I 
> > don't if SPEC_CTRL_SSBD and ARCH_CAPABILITIES belong to IBRS, may be we 
> > need 3rd version for these?)
> > 
> 
> I am wondering if we cover all the stepping of CPU, all existing CPU 
> model should be add initial stepping cpu model. The same circumstance 
> occurred before because Cascadelake CPU stepping 5 haven't AVX512_VNNI, 
> then updated to stepping 6. Denverton has been released in Q3'2017, the 
> customer may not use the early stepping machine.
> 
Focusing on spec_ctrl, my question is: Does Denverton with stepping 1 have this
feature regardless of microcode.


