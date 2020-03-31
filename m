Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F38C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52369206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52369206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCRE-0001Ub-4z
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@linux.intel.com>) id 1jJCQc-0000zj-FW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@linux.intel.com>) id 1jJCQa-0000ZD-SD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:39:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:42822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
 id 1jJCQa-0000W7-KF
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:39:20 -0400
IronPort-SDR: pcyFJJYI35haKgvQtmy2Ts13XazHvoraNaPUYSjtrjJ13U/SrHgO3HHgMbWFNCNkxyyQoEHM8A
 dHfqDvnPKedg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 01:39:18 -0700
IronPort-SDR: ytlY1rNGWRHo7W6uIy8UeYHGMSJ9uWMXpVMA0NphYwQ7Br2f2lS9I8QiTYyV6z9K7/F+8QDMHr
 zncb0CQl91JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="422222320"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga005.jf.intel.com with ESMTP; 31 Mar 2020 01:39:16 -0700
Message-ID: <4a3d0ea9a1be2057dad882c4f5bab9f41f14e26f.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/4] target/i386: add the missing features for
 Icelake-Server CPU model
From: Robert Hoo <robert.hu@linux.intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <rth@twiddle.net>, Eduardo
 Habkost <ehabkost@redhat.com>
Date: Tue, 31 Mar 2020 16:39:16 +0800
In-Reply-To: <20200328030625.16428-4-chenyi.qiang@intel.com>
References: <20200328030625.16428-1-chenyi.qiang@intel.com>
 <20200328030625.16428-4-chenyi.qiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 2020-03-28 at 11:06 +0800, Chenyi Qiang wrote:
> Add the SHA_NI and AVX512IFMA feature bits in FEAT_7_0_EBX, RDPID
> feature bit in FEAT_7_0_ECX and FSRM feature bit in FEAT_7_0_EDX.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>  target/i386/cpu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b01421c6bb..babb074abf 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3552,6 +3552,16 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                      { /* end of list */ }
>                  },
>              },
> +            {
> +                .version = 3,
> +                .props = (PropValue[]) {
> +                    { "sha-ni", "on" },
> +                    { "avx512ifma", "on" },
> +                    { "rdpid", "on" },
> +                    { "fsrm", "on" },
> +                    { /* end of list */ }
> +                },
> +            },
>              { /* end of list */ }
I think these 4 new CPUIDs addition is to catch up latest 
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
 on updates.
This is actually fix to previous v1 definitions.
So my 2 cents:
1. add 1 more version: include v2's hle and rtm properties off
2. make the hle-rtm-disable inclusion version or this v3 default
version of icelake.
Anyway, v1 is not suitable for default choice.

Then questions comes to how to make non-v1 default.
Perhaps:

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 34b511f..d4eb3d6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5453,7 +5453,7 @@ static void
x86_register_cpudef_types(X86CPUDefinition *def)
     /* Unversioned model: */
     m = g_new0(X86CPUModel, 1);
     m->cpudef = def;
-    m->version = CPU_VERSION_AUTO;
+    m->version = CPU_VERSION_LATEST;
     m->is_alias = true;
     x86_register_cpu_model_type(def->name, m);

I think for builtin_x86_defs[] definitions, latest version is usually
preferable/suitable.
How would Paolo, Eduardo like it?
>          }
>      },


