Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46304C1975A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 02:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170E920722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 02:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170E920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGCtu-0006uw-5A
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 22:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1jGCtL-0006VI-Mk
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 22:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1jGCtJ-0008H7-TC
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 22:32:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:53773)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1jGCtJ-0008Fq-M0
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 22:32:37 -0400
IronPort-SDR: OgmDAOgyDJYUsS2djo2hbv+wh2QE0HZjNrjWsD4UW7r7Ea3JJaWmvOHBZhtG/bTNbcjbe0r8yC
 8xutF3rLGy5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 19:32:28 -0700
IronPort-SDR: QEijlKvknbxLgrGUFdwEMza2LPjsaA1kcKB0hkGoJNCbYj0fZvesMfFqO1mzjxSLngUkVDj8Cv
 6oczYYBF8VSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,294,1580803200"; d="scan'208";a="445648650"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.238.4.86])
 ([10.238.4.86])
 by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2020 19:32:26 -0700
Subject: Re: [PATCH v2] target/i386: Add ARCH_CAPABILITIES related bits into
 Icelake-Server CPU model
To: Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200316095605.12318-1-xiaoyao.li@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <38253eb8-059c-5020-50cd-e90f7e8e4ae5@intel.com>
Date: Mon, 23 Mar 2020 10:32:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316095605.12318-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Xiaoyao,

May be you can add .note for this new version.

for example:

+                .version = 3,
+                .note = "ARCH_CAPABILITIES",
+                .props = (PropValue[]) {

On 3/16/2020 5:56 PM, Xiaoyao Li wrote:
> Current Icelake-Server CPU model lacks all the features enumerated by
> MSR_IA32_ARCH_CAPABILITIES.
> 
> Add them, so that guest of "Icelake-Server" can see all of them.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> v2:
>   - Add it as a new version.
> ---
>   target/i386/cpu.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 92fafa265914..5fba6a2ad6b3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3496,6 +3496,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                       { /* end of list */ }
>                   },
>               },
> +            {
> +                .version = 3,
> +                .props = (PropValue[]) {
> +                    { "arch-capabilities", "on" },
> +                    { "rdctl-no", "on" },
> +                    { "ibrs-all", "on" },
> +                    { "skip-l1dfl-vmentry", "on" },
> +                    { "mds-no", "on" },
> +                    { "pschange-mc-no", "on" },
> +                    { "taa-no", "on" },
> +                    { /* end of list */ }
> +                },
> +            },
>               { /* end of list */ }
>           }
>       },
> --
> 2.20.1
> 
> 

