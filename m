Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE54C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0316F206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 12:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0316F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIuV6-0001QH-1b
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 08:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iIuUA-0000b2-Qj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iIuU7-0006RS-8L
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iIuU6-0006QF-U7
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 08:57:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A8898666C;
 Fri, 11 Oct 2019 12:57:29 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E7C85DA60;
 Fri, 11 Oct 2019 12:57:24 +0000 (UTC)
Date: Fri, 11 Oct 2019 09:57:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH] target/i386: Remove MPX support on Snowridge CPU model
Message-ID: <20191011125723.GP4084@habkost.net>
References: <20191011071844.108924-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011071844.108924-1-xiaoyao.li@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 11 Oct 2019 12:57:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

On Fri, Oct 11, 2019 at 03:18:44PM +0800, Xiaoyao Li wrote:
> MPX support is being phased out by Intel. Following other CPU models
> like Skylake, Icelake and Cascadelake, do not enable it by default.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> I'm not sure is there anyone already use Snowridge CPU model and whether to
> add it in pc_compat_4_1, since Snowridge has not been released yet.

We have a CPU model versioning mechanism now, please implement this using the
new system.  e.g.:

        .versions = (X86CPUVersionDefinition[]) {
            { .version = 1 },
            {
                .version = 2,
                .props = (PropValue[]) {
                    { "mpx", "off" },
                    { /* end of list */ }
                }
            },
            { /* end of list */ }
        }

Then machine-type compat properties won't be needed anymore.

> 
> ---
>  hw/i386/pc.c      | 4 +++-
>  target/i386/cpu.c | 1 -
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bcda50efcc23..97eb7ac32588 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -105,7 +105,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>  static size_t pvh_start_addr;
>  
> -GlobalProperty pc_compat_4_1[] = {};
> +GlobalProperty pc_compat_4_1[] = {
> +    { "Snowridge" "-" TYPE_X86_CPU, "mpx", "on" },
> +};
>  const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
>  
>  GlobalProperty pc_compat_4_0[] = {};
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 44f1bbdcac76..885bea76205d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2762,7 +2762,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_7_0_EBX_FSGSBASE |
>              CPUID_7_0_EBX_SMEP |
>              CPUID_7_0_EBX_ERMS |
> -            CPUID_7_0_EBX_MPX |  /* missing bits 13, 15 */
>              CPUID_7_0_EBX_RDSEED |
>              CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
>              CPUID_7_0_EBX_CLWB |
> -- 
> 2.19.1
> 

-- 
Eduardo

