Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380BAC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 16:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC96206F6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 16:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC96206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIENs-0000yh-6j
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 12:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIEMk-0008Ox-OY
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 12:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIEMj-0000Hx-Dq
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 12:31:22 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jIEMi-000075-UE; Sat, 28 Mar 2020 12:31:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07656042|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.183342-0.000380833-0.816277;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03311; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H6k3Dvn_1585413065; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H6k3Dvn_1585413065) by smtp.aliyun-inc.com(10.147.40.2);
 Sun, 29 Mar 2020 00:31:06 +0800
Subject: Re: [PATCH v6 57/61] target/riscv: floating-point scalar move
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-58-zhiwei_liu@c-sky.com>
 <b3505142-78fb-4142-1fb0-aafc20c1788f@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <c388808c-5c5f-872d-24ec-c41417a229f3@c-sky.com>
Date: Sun, 29 Mar 2020 00:31:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b3505142-78fb-4142-1fb0-aafc20c1788f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/28 11:44, Richard Henderson wrote:
> On 3/17/20 8:06 AM, LIU Zhiwei wrote:
>> +/* Floating-Point Scalar Move Instructions */
>> +static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
>> +{
>> +    if (!s->vill && has_ext(s, RVF) &&
>> +        (s->mstatus_fs != 0) && (s->sew != 0)) {
>> +#ifdef HOST_WORDS_BIGENDIAN
>> +        int ofs = vreg_ofs(s, a->rs2) + ((7 >> s->sew) << s->sew);
>> +#else
>> +        int ofs = vreg_ofs(s, a->rs2);
>> +#endif
> Use endian_ofs from patch 55.
Yes, I forgot it.
>
>> +        switch (s->sew) {
>> +        case MO_8:
>> +            tcg_gen_ld8u_i64(cpu_fpr[a->rd], cpu_env, ofs);
>> +            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
>> +                            0xffffffffffffff00ULL);
>> +            break;
> MO_8 should be illegal.
Yes, it has been checked in s->sew != 0.
>
>> +        case MO_16:
>> +            tcg_gen_ld16u_i64(cpu_fpr[a->rd], cpu_env, ofs);
>> +            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
>> +                            0xffffffffffff0000ULL);
>> +            break;
>> +        case MO_32:
>> +            tcg_gen_ld32u_i64(cpu_fpr[a->rd], cpu_env, ofs);
>> +            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
>> +                            0xffffffff00000000ULL);
>> +            break;
>> +        default:
>> +            if (has_ext(s, RVD)) {
>> +                tcg_gen_ld_i64(cpu_fpr[a->rd], cpu_env, ofs);
>> +            } else {
>> +                tcg_gen_ld32u_i64(cpu_fpr[a->rd], cpu_env, ofs);
>> +                tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
>> +                                0xffffffff00000000ULL);
>> +            }
>> +            break;
> Maybe better with MO_64 and default: g_assert_not_reached().
>
>> +static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
>> +{
>> +    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
>> +        TCGv_ptr dest;
>> +        TCGv_i64 src1;
>> +        static gen_helper_vfmv_s_f * const fns[3] = {
>> +            gen_helper_vfmv_s_f_h,
>> +            gen_helper_vfmv_s_f_w,
>> +            gen_helper_vfmv_s_f_d
> You shouldn't need to duplicate the vmv_s_x_* helpers.
All these helpers will be away in v7.

Zhiwei
>
> r~


