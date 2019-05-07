Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E195EC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B796D2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B796D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNzpc-000633-OG
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 09:08:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNzoh-0005iM-Gy
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNzog-0005al-5j
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:07:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hNzof-0005Zw-U9
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:07:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86893883BC;
	Tue,  7 May 2019 13:07:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D15AE61B7D;
	Tue,  7 May 2019 13:07:25 +0000 (UTC)
Date: Tue, 7 May 2019 14:07:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190507130722.GQ27205@redhat.com>
References: <20190507124853.9015-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190507124853.9015-1-tao3.xu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 07 May 2019 13:07:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add some MSR based features on
 Cascadelake-Server CPU model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: ehabkost@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
	robert.hu@intel.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 08:48:53PM +0800, Tao Xu wrote:
> As noted in
> http://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02212.html

Rather than pointing to the mailing list post, please just refer
to the git commit hash that patch was merged under, which IIUC
is c7a88b52f62b30c04158eeb07f73e3f72221b6a8.

> Because MSR based feature has been supported by QEMU,
> we add CPUID_7_0_EDX_ARCH_CAPABILITIES on Cascadelake-Server CPU
> model, and add IA32_ARCH_CAPABILITIES MSR based features (RDCL_NO,
> IBRS_ALL and SKIP_L1DFL_VMENTRY).
> 
> And "014018e19b i386: Make arch_capabilities migratable" has been
> in QEMU upstream, the CPUID_7_0_EDX_ARCH_CAPABILITIES can be
> safely added into CPU Model.
> 
> Changes in v2:
>     - rebased patch to latest qemu base
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  hw/i386/pc.c      | 7 ++++++-
>  target/i386/cpu.c | 6 +++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d98b737b8f..27c3d25436 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -115,7 +115,12 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>  static size_t pvh_start_addr;
>  
> -GlobalProperty pc_compat_4_0[] = {};
> +GlobalProperty pc_compat_4_0[] = {
> +    { "Cascadelake-Server" "-" TYPE_X86_CPU, "arch-capabilities", "off" },
> +    { "Cascadelake-Server" "-" TYPE_X86_CPU, "rdctl-no", "off" },
> +    { "Cascadelake-Server" "-" TYPE_X86_CPU, "ibrs-all", "off" },
> +    { "Cascadelake-Server" "-" TYPE_X86_CPU, "skip-l1dfl-vmentry", "off" },
> +};
>  const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
>  
>  GlobalProperty pc_compat_3_1[] = {
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 722c5514d4..2aa0a8f9ba 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2536,7 +2536,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_7_0_ECX_PKU |
>              CPUID_7_0_ECX_AVX512VNNI,
>          .features[FEAT_7_0_EDX] =
> -            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD |
> +            CPUID_7_0_EDX_ARCH_CAPABILITIES,
>          /* Missing: XSAVES (not supported by some Linux versions,
>                  * including v4.1 to v4.12).
>                  * KVM doesn't yet expose any XSAVES state save component,
> @@ -2548,6 +2549,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =
>              CPUID_6_EAX_ARAT,
> +        .features[FEAT_ARCH_CAPABILITIES] =
> +            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
> +            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
>          .xlevel = 0x80000008,
>          .model_id = "Intel Xeon Processor (Cascadelake)",
>      },
> -- 
> 2.17.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

