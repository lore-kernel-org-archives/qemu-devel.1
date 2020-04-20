Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CDBC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 03:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DDD2145D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 03:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DDD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQMx1-0004gQ-6L
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 23:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55488 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jQMvu-0004DH-5l
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 23:17:18 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jQMvs-0007Zr-Jc
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 23:17:17 -0400
Received: from mail142-34.mail.alibaba.com ([198.11.142.34]:58354)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jQMvr-0007Ys-Oq
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 23:17:16 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436564|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0116556-0.000374556-0.98797;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03308; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.HK8pB6i_1587352622; 
Received: from 30.225.208.25(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HK8pB6i_1587352622)
 by smtp.aliyun-inc.com(10.147.41.178);
 Mon, 20 Apr 2020 11:17:02 +0800
Subject: Re: [PATCH 1/7] tcg: Add tcg_gen_gvec_dup_imm
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-2-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <e0575813-2a41-3cc6-fced-64808b853399@c-sky.com>
Date: Mon, 20 Apr 2020 11:17:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418150411.1831-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=198.11.142.34; envelope-from=zhiwei_liu@c-sky.com;
 helo=mail142-34.mail.alibaba.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/19
 23:17:09
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Received-From: 198.11.142.34
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
> Add a version of tcg_gen_dup_* that takes both immediate and
> a vector element size operand.  This will replace the set of
> tcg_gen_gvec_dup{8,16,32,64}i functions that encode the element
> size within the function name.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei
> ---
>   include/tcg/tcg-op-gvec.h | 2 ++
>   tcg/tcg-op-gvec.c         | 7 +++++++
>   2 files changed, 9 insertions(+)
>
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index 74534e2480..eb0d47a42b 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -313,6 +313,8 @@ void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, uint32_t aofs,
>   
>   void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
>                             uint32_t s, uint32_t m);
> +void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t s,
> +                          uint32_t m, uint64_t imm);
>   void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
>                             uint32_t m, TCGv_i32);
>   void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 327d9588e0..593bb4542e 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1569,6 +1569,13 @@ void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz,
>       do_dup(MO_8, dofs, oprsz, maxsz, NULL, NULL, x);
>   }
>   
> +void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                          uint32_t maxsz, uint64_t x)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);
> +}
> +
>   void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         uint32_t oprsz, uint32_t maxsz)
>   {


