Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B19C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B3E20786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B3E20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhAk-0002RW-Et
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jGh9q-0001pB-3q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jGh9o-0003PE-Fw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:51:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:32826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jGh9o-00039c-30; Tue, 24 Mar 2020 06:51:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0747145|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0111356-0.000973425-0.987891;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07381; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H4Wkce9_1585047088; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H4Wkce9_1585047088)
 by smtp.aliyun-inc.com(10.147.42.16); Tue, 24 Mar 2020 18:51:29 +0800
Subject: Re: [PATCH v5 57/60] target/riscv: vector slide instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-58-zhiwei_liu@c-sky.com>
 <28063df7-bf38-d136-2d32-39651692c4c6@linaro.org>
 <88b87d58-5387-9d0d-b1a0-5705171f2e83@c-sky.com>
 <76b6c079-15b2-08f1-f8e2-570efb6cfae5@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <a99c100f-4b32-810a-97d7-ee54f5f65cda@c-sky.com>
Date: Tue, 24 Mar 2020 18:51:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <76b6c079-15b2-08f1-f8e2-570efb6cfae5@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 2020/3/17 1:42, Richard Henderson wrote:
> On 3/16/20 1:04 AM, LIU Zhiwei wrote:
>>> As a preference, I think you can do away with this helper.
>>> Simply use the slideup helper with argument 1, and then
>>> afterwards store the integer register into element 0.  You should be able to
>>> re-use code from vmv.s.x for that.
>> When I try it, I find it is some difficult, because  vmv.s.x will clean
>> the elements (0 < index < VLEN/SEW).
> Well, two things about that:
>
> (1) The 0.8 version of vmv.s.x does *not* zero the other elements, so we'll
> want to be prepared for that.
>
> (2) We have 8 insns that, in the end come down to a direct element access,
> possibly with some other processing.
>
> So we'll want basic helper functions that can locate an element by immediate
> offset and by variable offset:
>
> /* Compute the offset of vreg[idx] relative to cpu_env.
>     The index must be in range of VLMAX. */
> int vec_element_ofsi(int vreg, int idx, int sew);
>
> /* Compute a pointer to vreg[idx].
>     If need_bound is true, mask idx into VLMAX,
>     Otherwise we know a-priori that idx is already in bounds. */
> void vec_element_ofsx(DisasContext *s, TCGv_ptr base,
>                        TCGv idx, int sew, bool need_bound);
>
> /* Load idx >= VLMAX ? 0 : vreg[idx] */
> void vec_element_loadi(DisasContext *s, TCGv_i64 val,
>                         int vreg, int idx, int sew);
> void vec_element_loadx(DisasContext *s, TCGv_i64 val,
>                         int vreg, TCGv idx, int sew);
>
> /* Store vreg[imm] = val.
>     The index must be in range of VLMAX.  */
> void vec_element_storei(DisasContext *s, int vreg, int imm,
>                          TCGv_i64 val);
> void vec_element_storex(DisasContext *s, int vreg,
>                          TCGv idx, TCGv_i64 val);
>
> (3) It would be handy to have TCGv cpu_vl.
Do you mean I should define cpu_vl as a global TCG varible like cpu_pc?
So that I can check vl==0 in translation time.

Or just a temp variable?
>
> Then:
>
> vext.x.v:
>      If rs1 == 0,
>          Use vec_element_loadi(s, x[rd], vs2, 0, s->sew).
>      else
>          Use vec_element_loadx(s, x[rd], vs2, x[rs1], true).
>
> vmv.s.x:
>      over = gen_new_label();
>      tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
>      For 0.7.1:
>          Use tcg_gen_dup8i to zero all VLMAX elements of vd.
>          If rs1 == 0, goto done.
>      Use vec_element_storei(s, vs2, 0, x[rs1]).
>   done:
>      gen_set_label(over);
>
> vfmv.f.s:
>      Use vec_element_loadi(x, f[rd], vs2, 0).
>      NaN-box f[rd] as necessary for SEW.
>
> vfmv.s.f:
>      tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
>      For 0.7.1:
>          Use tcg_gen_dup8i to zero all VLMAX elements of vd.
>      Let tmp = f[rs1], nan-boxed as necessary for SEW.
>      Use vec_element_storei(s, vs2, 0, tmp).
>      gen_set_label(over);
>
> vslide1up.vx:
>      Ho hum, I forgot about masking.  Some options:
>      (1) Call a helper just as you did in your original patch.
>      (2) Call a helper only for !vm, for vm as below.

Sorry, I don't get it why I need a helper for !vm.
I think I can  call vslideup w/1 whether !vm or vm, then a store to vd[0].

Zhiwei
>      (3) Call vslideup w/1.
>          tcg_gen_brcondi(TCG_COND_EQ, cpu_vl, 0, over);
>          If !vm,
>              // inline test for v0[0]
>              vec_element_loadi(s, tmp, 0, 0, MO_8);
>              tcg_gen_andi_i64(tmp, tmp, 1);
>              tcg_gen_brcondi(TCG_COND_EQ, tmp, 0, over);
>          Use vec_element_store(s, vd, 0, x[rs1]).
>          gen_set_label(over);
>
> vslide1down.vx:
>      For !vm, this is complicated enough for a helper.
>      If using option 3 for vslide1up, then the store becomes:
>      tcg_gen_subi_tl(tmp, cpu_vl, 1);
>      vec_element_storex(s, base, tmp, x[rs1]);
>
> vrgather.vx:
>      If !vm or !vl_eq_vlmax, use helper.
>      vec_element_loadx(s, tmp, vs2, x[rs1]);
>      Use tcg_gen_gvec_dup_i64 to store to tmp to vd.
>
> vrgather.vi:
>      If !vm or !vl_eq_vlmax, use helper.
>      If imm >= vlmax,
>          Use tcg_gen_dup8i to zero vd;
>      else,
>          ofs = vec_element_ofsi(s, vs2, imm, s->sew);
>          tcg_gen_gvec_dup_mem(sew, vreg_ofs(vd),
>                               ofs, vlmax, vlmax);
>
>
> r~


