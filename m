Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F9C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6732081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DX71T34X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6732081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Q50-0007PX-B7
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8Q0j-0002r2-6Z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8Q0h-0008G6-Dw
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:23:49 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:33308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8Q0h-0008Fr-5a
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:23:47 -0400
Received: by mail-qk1-x743.google.com with SMTP id x134so24656945qkb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lTaz5rz8rDx0RTM1bBhKp5TwSIQinble2f6b8mrjTNU=;
 b=DX71T34XZ9azLd2JPF9ZDU2u2I8CgDr/2rqKk08XkZehNEpksX5nKUsUZW/HKW+b5l
 aouC277++rzx3sa3oD/APGvaVyjsH0TeN8crsex06AbfIL5wvYQEyDjL/lu7sI3vRC29
 xtfOyWnA13K6Rsci7ijUVMQVIKySWpDjrl5K8YHQuJ9NxuNqczanb3Hz+yArtlQuIa23
 2hRoEEr5ye0YAnAbExMmgWxvqGHP64KW895sgOuhl4ISGQrS+YvW+hntHMoZqsZ9KEyB
 Gg3GgdcRbwTHMZXITOcrVjJRo9+z7V3lSVhqECgZoZQkqs1tna9sAdTzzEDeTrDJsVN1
 3Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lTaz5rz8rDx0RTM1bBhKp5TwSIQinble2f6b8mrjTNU=;
 b=AYbJs4wBUO/RE9QaxT0W8Cc4sVvEYxbSoeKxpRDN42CY2dPidJpgCrhYvxwMxSpxry
 hGfnUy2WVQOkkBBa4PfufBhhoruk/PVX89+M3iA4gc7TTvtaHvXj+u4lVja+qwMaWOL0
 SB63oPOB7ocByhEqWwshYc0fqN+r98DkD43z9cwu5Ka8GaISqp9V+IGvGJ8qaV810jIA
 03b12kfofG3BBmam/8szPXYX3udrnZ1iRJt2d8ajY4mQtrqh5Il96mKLnTNjEdP/Zrne
 xzDAPk1LZiyl20sQ9Wq5VJUAT9cLkKtoETWW0yiZjRXIvY3lOmNiLVBnDGttr4OUIjpp
 MU4g==
X-Gm-Message-State: APjAAAVj949qANrTgkAyJkyIYDODife/2G3ts89aB9oTHfMDpIHI0YEP
 tRV+jBsV1NGsek2O9GEGTcfkeg==
X-Google-Smtp-Source: APXvYqzkjRwRps2VCVEw8vm9piXSnWPMKPJP79fWmhCnOYziUWP3QqsLPSqm5ojyzHIWu+v7UB8PAA==
X-Received: by 2002:ae9:eb51:: with SMTP id b78mr4629300qkg.452.1568298225660; 
 Thu, 12 Sep 2019 07:23:45 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id i30sm6690708qte.27.2019.09.12.07.23.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 07:23:44 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 riku.voipio@iki.fi, laurent@vivier.eu, wenmeng_zhang@c-sky.com
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-6-git-send-email-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4da4da5b-afb8-c9be-99af-0544c6eeb233@linaro.org>
Date: Thu, 12 Sep 2019 10:23:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568183141-67641-6-git-send-email-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PATCH v2 05/17] RISC-V: add vector extension load
 and store instructions
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> +static bool  vector_lmul_check_reg(CPURISCVState *env, uint32_t lmul,
> +        uint32_t reg, bool widen)
> +{
> +    int legal = widen ? (lmul * 2) : lmul;
> +
> +    if ((lmul != 1 && lmul != 2 && lmul != 4 && lmul != 8) ||
> +        (lmul == 8 && widen)) {
> +        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
> +        return false;
> +    }
> +
> +    if (reg % legal != 0) {
> +        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
> +        return false;
> +    }
> +    return true;
> +}

These exceptions will not do the right thing.

You cannot call helper_raise_exception from another helper, or from something
called from another helper, as here.  You need to use riscv_raise_exception, as
you do elsewhere in this patch, with a GETPC() value passed down from the
outermost helper.

Ideally you would check these conditions at translate time.
I've mentioned how to do this in reply to your v1.


> +void VECTOR_HELPER(vlbu_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,> +    uint32_t rs1, uint32_t rd)

You should pass the rs1 register by value, not by index.

> +{> +    int i, j, k, vl, vlmax, lmul, width, dest, read;> +> +    vl =
env->vfp.vl;> +> +    lmul   = vector_get_lmul(env);> +    width =
vector_get_width(env);> +    vlmax = vector_get_vlmax(env);> +> +    if
(vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {> +
riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());> +
return;> +    }> +    if (lmul * (nf + 1) > 32) {> +
riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());> +
return;> +    }
Again, these exceptions should ideally be identified at translate time.

I also think that you should have at least two different helpers: one that
checks the vector mask and one that doesn't.  If you check the above conditions
at translate time then you'll also want to split the helpers based on element
width.

You could also meaningfully split nf == 0 vs nf != 0.  You will, in any case,
need to check at translate time whether the Zvlsseg extension is enabled before
allowing nf != 0.


> +
> +    vector_lmul_check_reg(env, lmul, rd, false);
> +
> +    for (i = 0; i < vlmax; i++) {
> +        dest = rd + (i / (VLEN / width));
> +        j = i % (VLEN / width);

This division is exactly why I suggested making vreg[] one contiguous array of
elements instead of a two-dimensional array.  I think the distinction of 32
VLEN-sized registers should be reserved for cpu dumps and gdbstub.


> +        k = nf;
> +        if (i < env->vfp.vstart) {
> +            continue;

Surely you should hoist this check outside the loop.

> +        } else if (i < vl) {
> +            switch (width) {
> +            case 8:
> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
> +                    while (k >= 0) {
> +                        read = i * (nf + 1)  + k;
> +                        env->vfp.vreg[dest + k * lmul].u8[j] =
> +                            cpu_ldub_data(env, env->gpr[rs1] + read);

You must not modify vreg[x] before you've recognized all possible exceptions,
e.g. validating that a subsequent access will not trigger a page fault.
Otherwise you will have a partially modified register value when the exception
handler is entered.

Without a stride, and without a predicate mask, this can be done with at most
two calls to probe_access (one per page).  This is the simplification that
makes splitting the helper into two very helpful.

With a stride or with a predicate mask requires either
(1) temporary storage for the loads, and copy back to env at the end, or
(2) use probe_access for each load, and then perform the actual loads directly
into env.

FWIW, ARM SVE uses (1), as probe_access is very new.


> +                        k--;
> +                    }
> +                    env->vfp.vstart++;
> +                }
> +                break;
> +            case 16:
> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
> +                    while (k >= 0) {
> +                        read = i * (nf + 1)  + k;
> +                        env->vfp.vreg[dest + k * lmul].u16[j] =
> +                            cpu_ldub_data(env, env->gpr[rs1] + read);

I don't see anything in these assignments to vreg[x].uN[y] that take the
endianness of the host into account.

You need to think about how the architecture defines the overlap of elements --
particularly across vlset -- and make adjustments.

I can imagine, if you have explicit tests for this, your tests are passing
because the architecture defines a little-endian based indexing of the register
file, and you have only run tests on a little-endian host, like x86_64.

For ARM, we define the representation as a little-endian indexed array of
host-endian uint64_t.  This means that a big-endian host needs to adjust the
address of any element smaller than 64-bit.  E.g.

#ifdef HOST_WORDS_BIGENDIAN
#define H1(x)   ((x) ^ 7)
#define H2(x)   ((x) ^ 3)
#define H4(x)   ((x) ^ 1)
#else
#define H1(x)   (x)
#define H2(x)   (x)
#define H4(x)   (x)
#endif

    env->vfp.vreg[reg + k * lmul].u16[H2(j)]


> +            case 64:
> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
> +                    while (k >= 0) {
> +                        read = i * (nf + 1)  + k;
> +                        env->vfp.vreg[dest + k * lmul].u64[j] =
> +                            cpu_ldub_data(env, env->gpr[rs1] + read);
> +                        k--;
> +                    }
> +                    env->vfp.vstart++;
> +                }
> +                break;
> +            default:
> +                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());

Ideally, this condition is detected at translate time.
You must detect this condition before making any changes to cpu state.
Moreover, the SIGILL should not be skipped because of VSTART.


> +static target_ulong vector_get_index(CPURISCVState *env, int rs1, int rs2,
> +    int index, int mem, int width, int nf)
> +{
> +    target_ulong abs_off, base = env->gpr[rs1];

You should be passing rs1 by value, not by index.

> +    target_long offset;
> +    switch (width) {
> +    case 8:
> +        offset = sign_extend(env->vfp.vreg[rs2].s8[index], 8) + nf * mem;
> +        break;
> +    case 16:
> +        offset = sign_extend(env->vfp.vreg[rs2].s16[index], 16) + nf * mem;
> +        break;
> +    case 32:
> +        offset = sign_extend(env->vfp.vreg[rs2].s32[index], 32) + nf * mem;
> +        break;
> +    case 64:
> +        offset = env->vfp.vreg[rs2].s64[index] + nf * mem;
> +        break;
> +    default:
> +        helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
> +        return 0;
> +    }
> +    if (offset < 0) {
> +        abs_off = ~offset + 1;

You have been hanging around hardware people too much.
In software we normally write this "-offset".  ;-)

> +        if (base >= abs_off) {
> +            return base - abs_off;
> +        }
> +    } else {
> +        if ((target_ulong)((target_ulong)offset + base) >= base) {
> +            return (target_ulong)offset + base;
> +        }
> +    }

Why all the extra casting here?  They are exactly what is implied by C.

> +    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST);
> +    return 0;

(1) This exception call won't work, as above,
(2) Where does this condition against wraparound come from?
    I don't see it in the specification.
(3) You certainly cannot detect this after having written a
    previous element to the register file.

[ Skipping lots of functions that are basically the same. ]

> +void VECTOR_HELPER(vsxe_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
> +    uint32_t rs1, uint32_t rs2, uint32_t rd)

Pass rs1 by value.

> +            case 8:
> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
> +                    while (k >= 0) {
> +                        addr = vector_get_index(env, rs1, src2, j, 1, width, k);
> +                        cpu_stb_data(env, addr,
> +                            env->vfp.vreg[dest + k * lmul].s8[j]);

Must probe_access all of the memory before any stores.
Unlike loads, you don't have the option of storing into a temporary.
Which suggests a common subroutine to perform the probe(s), rather
than bother with a temporary for loads.

> +void VECTOR_HELPER(vsuxe_v)(CPURISCVState *env, uint32_t nf, uint32_t vm,
> +    uint32_t rs1, uint32_t rs2, uint32_t rd)
> +{
> +    return VECTOR_HELPER(vsxe_v)(env, nf, vm, rs1, rs2, rd);

You can't do this and expect the GETPC() for the exceptions raised by vsxe_v to
operate properly.  You must define a common helper function and pass in
GETPC(), or preferably not have this second helper function at all.  There's no
reason why you cannot call vsxe_v for implementing vsuxe_v.  It's merely
laziness within the macros you set up in trans_rvv.inc.c.

> +    env->vfp.vstart = 0;
> +}

Dead code after the return, in any case.


r~

