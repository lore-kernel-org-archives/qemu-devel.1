Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E1DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6724620720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6724620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxvRt-00074S-KH
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 12:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jxvRK-0006et-4s
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:48:26 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:38780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jxvRI-00025V-6c
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:48:25 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 06LGmKhj023011
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2020 18:48:20 +0200
Received: from [167.87.32.116] ([167.87.32.116])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06LGmJgQ007466;
 Tue, 21 Jul 2020 18:48:20 +0200
Subject: Re: [PATCH for-5.1] target/arm: Always pass cacheattr in
 S1_ptw_translate
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200721163528.80080-1-richard.henderson@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a75baf9-1343-4d0a-7911-e745de12edfd@siemens.com>
Date: Tue, 21 Jul 2020 18:48:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721163528.80080-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=194.138.37.39;
 envelope-from=jan.kiszka@siemens.com; helo=lizzard.sbs.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 12:48:21
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21.07.20 18:35, Richard Henderson wrote:
> When we changed the interface of get_phys_addr_lpae to require
> the cacheattr parameter, this spot was missed.  The compiler is
> unable to detect the use of NULL vs the nonnull attribute here.
> 
> Fixes: 7e98e21c098
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 19 ++++++-------------
>   1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c69a2baf1d..8ef0fb478f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10204,21 +10204,11 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
>           int s2prot;
>           int ret;
>           ARMCacheAttrs cacheattrs = {};
> -        ARMCacheAttrs *pcacheattrs = NULL;
> -
> -        if (env->cp15.hcr_el2 & HCR_PTW) {
> -            /*
> -             * PTW means we must fault if this S1 walk touches S2 Device
> -             * memory; otherwise we don't care about the attributes and can
> -             * save the S2 translation the effort of computing them.
> -             */
> -            pcacheattrs = &cacheattrs;
> -        }
>   
>           ret = get_phys_addr_lpae(env, addr, MMU_DATA_LOAD, ARMMMUIdx_Stage2,
>                                    false,
>                                    &s2pa, &txattrs, &s2prot, &s2size, fi,
> -                                 pcacheattrs);
> +                                 &cacheattrs);
>           if (ret) {
>               assert(fi->type != ARMFault_None);
>               fi->s2addr = addr;
> @@ -10226,8 +10216,11 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
>               fi->s1ptw = true;
>               return ~0;
>           }
> -        if (pcacheattrs && (pcacheattrs->attrs & 0xf0) == 0) {
> -            /* Access was to Device memory: generate Permission fault */
> +        if ((env->cp15.hcr_el2 & HCR_PTW) && (cacheattrs.attrs & 0xf0) == 0) {
> +            /*
> +             * PTW set and S1 walk touched S2 Device memory:
> +             * generate Permission fault.
> +             */
>               fi->type = ARMFault_Permission;
>               fi->s2addr = addr;
>               fi->stage2 = true;
> 

Jup:

Tested-by: Jan Kiszka <jan.kiskza@siemens.com>

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

