Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA8DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2681F2070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2681F2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBNky-0002Ul-4x
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 14:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iBNiz-0001YB-4b
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iBNiy-0005xE-3U
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iBNix-0005x6-U7
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:33:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 404873071D50;
 Fri, 20 Sep 2019 18:33:43 +0000 (UTC)
Received: from localhost (ovpn-116-45.gru2.redhat.com [10.97.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60B71600C6;
 Fri, 20 Sep 2019 18:33:40 +0000 (UTC)
Date: Fri, 20 Sep 2019 15:33:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v2] target/i386: clean up comments over 80 chars per line
Message-ID: <20190920183339.GD5035@habkost.net>
References: <20190920053136.945-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920053136.945-1-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 20 Sep 2019 18:33:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 01:31:36PM +0800, Tao Xu wrote:
> Drop the duplicate definition of CPUID_7_0_ECX_VBMI. And add some
> comments, clean up comments over 80 chars per line.
> 
> There is an extra line in comment of CPUID_8000_0008_EBX_WBNOINVD,
> remove the extra enter and spaces.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
[...]
> -#define CPUID_7_0_ECX_AVX512BMI (1U << 1)
> -#define CPUID_7_0_ECX_VBMI     (1U << 1)  /* AVX-512 Vector Byte Manipulation Instrs */
[...]
> +/* AVX-512 Vector Byte Manipulation Instruction */
> +#define CPUID_7_0_ECX_VBMI              (1U << 1)

I'd prefer to have the macro name matching the feature name that
is already in feature_word_info[[FEAT_7_0_ECX].feat_names
("avx512vbmi").  It's also more similar to the name used in Intel
SDM (AVX512_VBMI).


[...]
> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
> index 4d957fe896..5041f48b8a 100644
> --- a/target/i386/hvf/x86_cpuid.c
> +++ b/target/i386/hvf/x86_cpuid.c
> @@ -89,7 +89,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>                  ebx &= ~CPUID_7_0_EBX_INVPCID;
>              }
>  
> -            ecx &= CPUID_7_0_ECX_AVX512BMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
> +            ecx &= CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
>              edx &= CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS;
>          } else {
>              ebx = 0;
> -- 
> 2.20.1
> 

-- 
Eduardo

