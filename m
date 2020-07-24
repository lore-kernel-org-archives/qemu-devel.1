Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67768C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FFE20714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 02:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FFE20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jynfL-0004HX-Ga
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 22:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jynec-0003nr-Nm; Thu, 23 Jul 2020 22:41:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jyneZ-0000ZX-Nm; Thu, 23 Jul 2020 22:41:46 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08397704|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.259679-0.000715711-0.739605;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03300; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.I6ivuYm_1595558492; 
Received: from 30.225.208.37(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I6ivuYm_1595558492)
 by smtp.aliyun-inc.com(10.147.44.129);
 Fri, 24 Jul 2020 10:41:33 +0800
Subject: Re: [PATCH v2 3/7] target/riscv: Generate nanboxed results from
 trans_rvf.inc.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-4-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <2332ee30-e099-dbab-9642-97433bcfede0@c-sky.com>
Date: Fri, 24 Jul 2020 10:41:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724002807.441147-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 22:31:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/7/24 8:28, Richard Henderson wrote:
> Make sure that all results from inline single-precision scalar
> operations are properly nan-boxed to 64-bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rvf.inc.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
> index c7057482e8..264d3139f1 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -167,6 +167,7 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
>           tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2], cpu_fpr[a->rs1],
>                               0, 31);
>       }
> +    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>       mark_fs_dirty(ctx);
>       return true;
>   }
> @@ -183,6 +184,7 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
>           tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
>           tcg_temp_free_i64(t0);
>       }
> +    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>       mark_fs_dirty(ctx);
>       return true;
>   }
> @@ -199,6 +201,7 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
>           tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
>           tcg_temp_free_i64(t0);
>       }
> +    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>       mark_fs_dirty(ctx);
>       return true;
>   }
> @@ -369,6 +372,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
>   #else
>       tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
>   #endif
> +    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>   
>       mark_fs_dirty(ctx);
>       tcg_temp_free(t0);
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Zhiwei


