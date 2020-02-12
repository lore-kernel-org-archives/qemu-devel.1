Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D12C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801A0206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2jyi8a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801A0206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ntL-0006nL-Le
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j1nsV-0005zp-Q9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j1nsT-00045W-Ia
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:00:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j1nsT-00044u-EB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581498012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TqQh7dgkubIomz+Rv4207t0vGgmw8qZ9yOhDbGmYEJQ=;
 b=A2jyi8a4cRQZMlBazNIOggl42uhnxaTF7HNO1LrevMnvPT3Gr64TH5HuiSZ7Cuj7fvd6zE
 q2nTQ6rY3cenGVEIFkZshhEEX0B8xJTViOraQKEdkwXfkyBug1zVLj5QixZwvrQRvoZGbU
 GfoFhLA405BvBtzI3e616+CD78VeFlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-uTkPpipTNH-xfIZQzZhx4g-1; Wed, 12 Feb 2020 04:00:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2DF4800D53;
 Wed, 12 Feb 2020 09:00:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CEBA5D9E2;
 Wed, 12 Feb 2020 09:00:08 +0000 (UTC)
Date: Wed, 12 Feb 2020 10:00:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v3 4/4] target/i386: Add notes for versioned CPU models
Message-ID: <20200212100007.08b5b221@redhat.com>
In-Reply-To: <20200212081328.7385-5-tao3.xu@intel.com>
References: <20200212081328.7385-1-tao3.xu@intel.com>
 <20200212081328.7385-5-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: uTkPpipTNH-xfIZQzZhx4g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Feb 2020 16:13:28 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> Add which features are added or removed in this version. Remove the
> changed model-id in versioned CPU models, to keep the model name
> unchanged at /proc/cpuinfo inside the VM.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Changes in v2:
>     - correct the note of Cascadelake v3 (Xiaoyao)
> ---
>  target/i386/cpu.c | 54 ++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 81a039beb6..739ef4ce91 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2278,10 +2278,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              {
>                  .version = 2,
>                  .alias = "Nehalem-IBRS",
> +                .note = "IBRS",
>                  .props = (PropValue[]) {
>                      { "spec-ctrl", "on" },
> -                    { "model-id",
> -                      "Intel Core i7 9xx (Nehalem Core i7, IBRS update)" },
>                      { /* end of list */ }
>                  }
>              },
> @@ -2359,10 +2358,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              {
>                  .version = 2,
>                  .alias = "Westmere-IBRS",
> +                .note = "IBRS",
>                  .props = (PropValue[]) {
>                      { "spec-ctrl", "on" },
> -                    { "model-id",
> -                      "Westmere E56xx/L56xx/X56xx (IBRS update)" },
>                      { /* end of list */ }
>                  }
>              },
> @@ -2445,10 +2443,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              {
>                  .version = 2,
>                  .alias = "SandyBridge-IBRS",
> +                .note = "IBRS",
>                  .props = (PropValue[]) {
>                      { "spec-ctrl", "on" },
> -                    { "model-id",
> -                      "Intel Xeon E312xx (Sandy Bridge, IBRS update)" },
>                      { /* end of list */ }
>                  }
>              },
> @@ -2537,10 +2534,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              {
>                  .version = 2,
>                  .alias = "IvyBridge-IBRS",
> +                .note = "IBRS",
>                  .props = (PropValue[]) {
>                      { "spec-ctrl", "on" },
> -                    { "model-id",
> -                      "Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)" },
>                      { /* end of list */ }
>                  }
>              },
> @@ -2634,17 +2630,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              {
>                  .version = 2,
>                  .alias = "Haswell-noTSX",
> +                .note = "no TSX",
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
>                      { "rtm", "off" },
>                      { "stepping", "1" },
> -                    { "model-id", "Intel Core Processor (Haswell, no TSX)", },
>                      { /* end of list */ }
>                  },
>              },
>              {
>                  .version = 3,
>                  .alias = "Haswell-IBRS",
> +                .note = "IBRS",
>                  .props = (PropValue[]) {
>                      /* Restore TSX features removed by -v2 above */
>                      { "hle", "on" },
> @@ -2655,21 +2652,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                       */
>                      { "stepping", "4" },
>                      { "spec-ctrl", "on" },
> -                    { "model-id",
> -                      "Intel Core Processor (Haswell, IBRS)" },
>                      { /* end of list */ }
>                  }
>              },
>              {
>                  .version = 4,
>                  .alias = "Haswell-noTSX-IBRS",
> +                .note = "no TSX, IBRS",
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
>                      { "rtm", "off" },
>                      /* spec-ctrl was already enabled by -v3 above */
>                      { "stepping", "1" },
> -                    { "model-id",
> -                      "Intel Core Processor (Haswell, no TSX, IBRS)" },
>                      { /* end of list */ }
>                  }
>              },
> @@ -2765,35 +2759,33 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              {
>                  .version = 2,
>                  .alias = "Broadwell-noTSX",
> +                .note = "no TSX",
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
>                      { "rtm", "off" },
> -                    { "model-id", "Intel Core Processor (Broadwell, no TSX)", },
>                      { /* end of list */ }
>                  },
>              },
>              {
>                  .version = 3,
>                  .alias = "Broadwell-IBRS",
> +                .note = "IBRS",
>                  .props = (PropValue[]) {
>                      /* Restore TSX features removed by -v2 above */
>                      { "hle", "on" },
>                      { "rtm", "on" },
>                      { "spec-ctrl", "on" },
> -                    { "model-id",
> -                      "Intel Core Processor (Broadwell, IBRS)" },
>                      { /* end of list */ }
>                  }
>              },
>              {
>                  .version = 4,
>                  .alias = "Broadwell-noTSX-IBRS",
> +                .note = "no TSX, IBRS",
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
>                      { "rtm", "off" },
>                      /* spec-ctrl was already enabled by -v3 above */
> -                    { "model-id",
> -                      "Intel Core Processor (Broadwell, no TSX, IBRS)" },
>                      { /* end of list */ }
>                  }
>              },
> @@ -2893,22 +2885,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              { .version = 1 },
>              {
>                  .version = 2,
> +                .note = "IBRS",
>                  .alias = "Skylake-Client-IBRS",
>                  .props = (PropValue[]) {
>                      { "spec-ctrl", "on" },
> -                    { "model-id",
> -                      "Intel Core Processor (Skylake, IBRS)" },
>                      { /* end of list */ }
>                  }
>              },
>              {
>                  .version = 3,
>                  .alias = "Skylake-Client-noTSX-IBRS",
> +                .note = "no TSX, IBRS",
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
>                      { "rtm", "off" },
> -                    { "model-id",
> -                      "Intel Core Processor (Skylake, IBRS, no TSX)" },
>                      { /* end of list */ }
>                  }
>              },
> @@ -3016,24 +3006,22 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              {
>                  .version = 2,
>                  .alias = "Skylake-Server-IBRS",
> +                .note = "IBRS",
>                  .props = (PropValue[]) {
>                      /* clflushopt was not added to Skylake-Server-IBRS */
>                      /* TODO: add -v3 including clflushopt */
>                      { "clflushopt", "off" },
>                      { "spec-ctrl", "on" },
> -                    { "model-id",
> -                      "Intel Xeon Processor (Skylake, IBRS)" },
>                      { /* end of list */ }
>                  }
>              },
>              {
>                  .version = 3,
>                  .alias = "Skylake-Server-noTSX-IBRS",
> +                .note = "no TSX, IBRS",
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
>                      { "rtm", "off" },
> -                    { "model-id",
> -                      "Intel Xeon Processor (Skylake, IBRS, no TSX)" },
>                      { /* end of list */ }
>                  }
>              },
> @@ -3142,6 +3130,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .versions = (X86CPUVersionDefinition[]) {
>              { .version = 1 },
>              { .version = 2,
> +              .note = "ARCH_CAPABILITIES",

what's ARCH_CAPABILITIES?

>                .props = (PropValue[]) {
>                    { "arch-capabilities", "on" },
>                    { "rdctl-no", "on" },
> @@ -3153,6 +3142,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              },
>              { .version = 3,
>                .alias = "Cascadelake-Server-noTSX",
> +              .note = "ARCH_CAPABILITIES, no TSX",
>                .props = (PropValue[]) {
>                    { "hle", "off" },
>                    { "rtm", "off" },
> @@ -3374,6 +3364,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              { .version = 1 },
>              {
>                  .version = 2,
> +                .note = "no TSX",
>                  .alias = "Icelake-Client-noTSX",
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
> @@ -3491,6 +3482,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              { .version = 1 },
>              {
>                  .version = 2,
> +                .note = "no TSX",
>                  .alias = "Icelake-Server-noTSX",
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
> @@ -3598,6 +3590,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              { .version = 1 },
>              {
>                  .version = 2,
> +                .note = "no MPX, no MONITOR",
>                  .props = (PropValue[]) {
>                      { "monitor", "off" },
>                      { "mpx", "off" },
> @@ -3727,14 +3720,15 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              { .version = 1 },
>              {
>                  .version = 2,
> +                .note = "no MPX",
>                  .props = (PropValue[]) {
>                      { "mpx", "off" },
> -                    { "model-id", "Intel Atom Processor (Snowridge, no MPX)" },
>                      { /* end of list */ },
>                  },
>              },
>              {
>                  .version = 3,
> +                .note = "no MPX, no MONITOR",
>                  .props = (PropValue[]) {
>                      /* mpx was already removed by -v2 above */
>                      { "monitor", "off" },
> @@ -3856,6 +3850,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              { .version = 1 },
>              {
>                  .version = 2,
> +                .note = "no MONITOR",
>                  .props = (PropValue[]) {
>                      { "monitor", "off" },
>                      { /* end of list */ },
> @@ -3980,15 +3975,15 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              {
>                  .version = 2,
>                  .alias = "EPYC-IBPB",
> +                .note = "IBPB",
>                  .props = (PropValue[]) {
>                      { "ibpb", "on" },
> -                    { "model-id",
> -                      "AMD EPYC Processor (with IBPB)" },
>                      { /* end of list */ }
>                  }
>              },
>              {
>                  .version = 3,
> +                .note = "IBPB, no MONITOR",
>                  .props = (PropValue[]) {
>                      /* ibpb was already enabled by -v2 above */
>                      { "monitor", "off" },
> @@ -4051,6 +4046,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              { .version = 1 },
>              {
>                  .version = 2,
> +                .note = "no MONITOR",
>                  .props = (PropValue[]) {
>                      { "monitor", "off" },
>                      { /* end of list */ },


