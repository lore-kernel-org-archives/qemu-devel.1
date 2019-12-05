Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A7C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B68205ED
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 08:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B68205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icmmk-0004BM-1l
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 03:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1icmky-0002xS-L8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1icmkw-0002CU-Ex
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:45:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:24848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1icmkw-0001te-3A
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 03:45:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Dec 2019 00:44:57 -0800
X-IronPort-AV: E=Sophos;i="5.69,280,1571727600"; d="scan'208";a="205703274"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.123])
 ([10.239.13.123])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
 05 Dec 2019 00:44:56 -0800
Subject: Re: [PATCH RESEND 4/4] target/i386: Add notes for versioned CPU models
To: qemu-devel@nongnu.org
References: <20191202063233.28523-1-tao3.xu@intel.com>
 <20191202063233.28523-5-tao3.xu@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <689d3cc9-5325-1664-76fa-6f2a2b2b4c04@intel.com>
Date: Thu, 5 Dec 2019 16:44:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202063233.28523-5-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/2019 2:32 PM, Tao Xu wrote:
> Add which features are added or removed in this version. Remove the
> changed model-id in versioned CPU models.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>   target/i386/cpu.c | 50 +++++++++++++++++++++++------------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7b3bd6d4db..c82fbfd02e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c

[...]

> @@ -3141,6 +3133,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>           .versions = (X86CPUVersionDefinition[]) {
>               { .version = 1 },
>               { .version = 2,
> +              .note = "ARCH_CAPABILITIES",

Here ARCH_CAPABILITIES doesn't tell what bits in 
MSR_IA32_ARCH_CAPABILITIES this version has, which makes it meaningless.

Maybe
	.note = "ARCH_CAPABLITIES(rdctl-no, ibrs-all, skip-l1dfl-vmentry, mds-no)",

is better?

>                 .props = (PropValue[]) {
>                     { "arch-capabilities", "on" },
>                     { "rdctl-no", "on" },
> @@ -3152,6 +3145,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>               },
>               { .version = 3,
>                 .alias = "Cascadelake-Server-noTSX",
> +              .note = "no TSX",
>                 .props = (PropValue[]) {
>                     { "hle", "off" },
>                     { "rtm", "off" },



