Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EFFC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 05:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A9B20679
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 05:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A9B20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQOaS-0003S9-QW
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 01:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43658 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jQO7g-0005Ru-8U
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:33:33 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jQO7a-0006wP-QQ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:33:27 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47215)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jQO7Y-0006s7-1v
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:33:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0774741-0.000961262-0.921565;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.HKBbQvS_1587357193; 
Received: from 30.225.208.25(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HKBbQvS_1587357193)
 by smtp.aliyun-inc.com(10.147.41.178);
 Mon, 20 Apr 2020 12:33:13 +0800
Subject: Re: [PATCH 6/7] tcg: Remove tcg_gen_gvec_dup{8,16,32,64}i
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-7-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <48913f9c-6b9f-6f54-5b16-c058ffab642a@c-sky.com>
Date: Mon, 20 Apr 2020 12:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418150411.1831-7-richard.henderson@linaro.org>
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
> These interfaces are now unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei
> ---
>   include/tcg/tcg-op-gvec.h |  5 -----
>   tcg/tcg-op-gvec.c         | 28 ----------------------------
>   2 files changed, 33 deletions(-)
>
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index eb0d47a42b..fa8a0c8d03 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -320,11 +320,6 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
>   void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
>                             uint32_t m, TCGv_i64);
>   
> -void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t s, uint32_t m, uint8_t x);
> -void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t s, uint32_t m, uint16_t x);
> -void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t s, uint32_t m, uint32_t x);
> -void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t s, uint32_t m, uint64_t x);
> -
>   void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
>                          int64_t shift, uint32_t oprsz, uint32_t maxsz);
>   void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index de16c027b3..5a6cc19812 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1541,34 +1541,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
>       }
>   }
>   
> -void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t oprsz,
> -                         uint32_t maxsz, uint64_t x)
> -{
> -    check_size_align(oprsz, maxsz, dofs);
> -    do_dup(MO_64, dofs, oprsz, maxsz, NULL, NULL, x);
> -}
> -
> -void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t oprsz,
> -                         uint32_t maxsz, uint32_t x)
> -{
> -    check_size_align(oprsz, maxsz, dofs);
> -    do_dup(MO_32, dofs, oprsz, maxsz, NULL, NULL, x);
> -}
> -
> -void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t oprsz,
> -                         uint32_t maxsz, uint16_t x)
> -{
> -    check_size_align(oprsz, maxsz, dofs);
> -    do_dup(MO_16, dofs, oprsz, maxsz, NULL, NULL, x);
> -}
> -
> -void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz,
> -                         uint32_t maxsz, uint8_t x)
> -{
> -    check_size_align(oprsz, maxsz, dofs);
> -    do_dup(MO_8, dofs, oprsz, maxsz, NULL, NULL, x);
> -}
> -
>   void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
>                             uint32_t maxsz, uint64_t x)
>   {


