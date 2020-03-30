Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73708C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 03:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4029020786
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 03:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4029020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIlUk-0004uF-EP
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 23:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Colin.Xu@intel.com>) id 1jIlUB-0004Tt-MR
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 23:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Colin.Xu@intel.com>) id 1jIlU9-0003k4-VU
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 23:53:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:13989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Colin.Xu@intel.com>) id 1jIlU9-0003de-Kl
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 23:53:13 -0400
IronPort-SDR: YE9ACylJ80R6eo1fO0CU/P0FCL3zEcacnREWEXmCBK2LxJO9XAYd042XRCW9AMPN3pDG9PSmC0
 NQJme1M4ZADg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 20:53:08 -0700
IronPort-SDR: h7f8p33iKHHJzTl+rTD7fHHv1WCbb9w4zWtingcw0WmUU/sM/HEG3hj4GeBZLEJAX+HSht47ec
 atKpI66ovgPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; d="scan'208";a="421798675"
Received: from coxu-arch-shz.sh.intel.com (HELO [10.239.160.30])
 ([10.239.160.30])
 by orsmga005.jf.intel.com with ESMTP; 29 Mar 2020 20:53:07 -0700
Subject: Re: [PATCH v2] [Qemu-devel] target/i386: HAX: Enable ROM/ROM device
 memory region support
To: hang.yuan@linux.intel.com, qemu-devel@nongnu.org
References: <1585538712-28300-1-git-send-email-hang.yuan@linux.intel.com>
From: Colin Xu <Colin.Xu@intel.com>
Message-ID: <54b6f6c0-6419-2bc2-c915-9c7a83ab8dea@intel.com>
Date: Mon, 30 Mar 2020 11:53:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585538712-28300-1-git-send-email-hang.yuan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.31
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
Reply-To: Colin.Xu@intel.com
Cc: wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks good to me.

Reviewed-by: Colin Xu <colin.xu@intel.com>

On 2020-03-30 11:25, hang.yuan@linux.intel.com wrote:
> From: Hang Yuan <hang.yuan@linux.intel.com>
>
> Add ROM and ROM device memory region support in HAX. Their memory region is
> read only and write access will generate EPT violation. The violation will be
> handled in the HAX kernel with the following patch.
>
> https://github.com/intel/haxm/commit/33ceea09a1655fca12c47f1e112b1d269357ff28
>
> v2: fix coding style problems
>
> Signed-off-by: Hang Yuan <hang.yuan@linux.intel.com>
> ---
>   target/i386/hax-mem.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
> index 6bb5a24917..a8bfd37977 100644
> --- a/target/i386/hax-mem.c
> +++ b/target/i386/hax-mem.c
> @@ -175,13 +175,10 @@ static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
>       uint64_t host_va;
>       uint32_t max_mapping_size;
>   
> -    /* We only care about RAM and ROM regions */
> -    if (!memory_region_is_ram(mr)) {
> -        if (memory_region_is_romd(mr)) {
> -            /* HAXM kernel module does not support ROMD yet  */
> -            warn_report("Ignoring ROMD region 0x%016" PRIx64 "->0x%016" PRIx64,
> -                        start_pa, start_pa + size);
> -        }
> +    /* We only care about RAM/ROM regions and ROM device */
> +    if (memory_region_is_rom(mr) || (memory_region_is_romd(mr))) {
> +        flags |= HAX_RAM_INFO_ROM;
> +    } else if (!memory_region_is_ram(mr)) {
>           return;
>       }
>   

-- 
Best Regards,
Colin Xu


