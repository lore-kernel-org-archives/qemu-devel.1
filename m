Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D60FC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 05:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4F6206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 05:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4F6206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQOrU-0003Pg-Vm
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 01:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45222 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jQOGx-0007oI-1z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:43:07 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jQOGp-0003iI-Lk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:43:01 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49984)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jQOGn-0003XG-4D
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:42:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07868958|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.105535-0.000872474-0.893593;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03307; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.HKBefbF_1587357762; 
Received: from 30.225.208.25(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HKBefbF_1587357762)
 by smtp.aliyun-inc.com(10.147.43.230);
 Mon, 20 Apr 2020 12:42:43 +0800
Subject: Re: [PATCH 7/7] tcg: Add tcg_gen_gvec_dup_tl
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-8-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <6926b983-95bc-4f42-67dc-a706a035526c@c-sky.com>
Date: Mon, 20 Apr 2020 12:42:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418150411.1831-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/19
 23:17:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: peter.maydell@linaro.org, david@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/4/18 23:04, Richard Henderson wrote:
> For use when a target needs to pass a configure-specific
> target_ulong value to duplicate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei
> ---
>   include/tcg/tcg-op-gvec.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index fa8a0c8d03..d89f91f40e 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -320,6 +320,12 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
>   void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
>                             uint32_t m, TCGv_i64);
>   
> +#if TARGET_LONG_BITS == 64
> +# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
> +#else
> +# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
> +#endif
> +
>   void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
>                          int64_t shift, uint32_t oprsz, uint32_t maxsz);
>   void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,


