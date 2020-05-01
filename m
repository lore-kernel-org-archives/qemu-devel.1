Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CA0C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 01:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B672074A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 01:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUBJ/Jxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B672074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUKum-0006tE-6F
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 21:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUKtx-0006K7-KS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 21:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUKtw-0003hX-0S
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 21:55:41 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUKtv-0003UQ-Bk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 21:55:39 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a31so1816871pje.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=g2I1azfbI5WiGRBzpvn83X0zELe2rRj3Vky+Ncm+dUI=;
 b=cUBJ/Jxng6lhC+IC//eI2KMQD8zeM6Z650Dhsg015mAAQH3XnQUc3WjsTBgOKPCfzv
 ujV3qgqOxXWIclZTeO0XVxutnz4kBTkeSKGo4PpDKinDg7hf/D/GHM0QLSfh/kHRAuOQ
 f58/eOQ5jmdQl695+8+8H4HvUMMy5+nA3WMfZ9tQ+SZW3ABQbJyn4TmdDCPKMMBkfLdB
 0OBfySFHf+FTI7uScVkCwxDKFcjI8keWYVxCM8+Kurm3Hx7cE7y7VSKBZomcyiZjiJB+
 aAvdNoREzi2zkWPk8OWDltbj5pD5bxCCjvsDv9lopiLt9xrtxEEc6eDTPFShUG0nsaXr
 4sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g2I1azfbI5WiGRBzpvn83X0zELe2rRj3Vky+Ncm+dUI=;
 b=O/WT2KDEGZVmAj7hUEZbUAegNFzQbSkWUpoX7Q3GARaizuzmBZKyODIIMOexFeQnEQ
 jVv+OdxBpXJrrHkOCQWee8wAHlG2wb9IJmamu7DArz1JgxQJsrRQct4nXNXl4qWqPQvs
 GJKqASvz7saBADd2wfTZOGarOX/W/6E1A3EFnY41G03eE2gx10n/aLTt4Q0yqRifyLfF
 g9gbdBJq7y/QErSeNGy3ZmxpxlUNsP+wSlBWXyrgIfDFpa///Am1XHa7CZfnYKTYUIk1
 wB6jw4sPHg4qq3LCibP/0HhXSNUIW51gbfPILvdfqY9Kxk9RYGs34kJ+780XbRDXFNwD
 Z6Kg==
X-Gm-Message-State: AGi0PuZi3Bx9lIO5tk0dBjrXw4Ke2auYqRAr83kpHld1cP0ljpUS+g9i
 C5/kkJs3Cj/Jy/pYpON5yxvdFNgLVV8=
X-Google-Smtp-Source: APiQypJHUHURkvxUUJI/JIPDM7rkGVetM3j1mskPN1wvlWabIIrPOqCynqorBMKyXQNq2yzU8b4Ruw==
X-Received: by 2002:a17:90b:3444:: with SMTP id
 lj4mr1905259pjb.37.1588298136677; 
 Thu, 30 Apr 2020 18:55:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w125sm814368pgw.22.2020.04.30.18.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 18:55:36 -0700 (PDT)
Subject: Re: [PATCH 26/36] target/arm: Convert Neon VQSHL, VRSHL, VQRSHL
 3-reg-same insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-27-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b1d8a9ec-a1ef-47af-f07f-3761a51945f1@linaro.org>
Date: Thu, 30 Apr 2020 18:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-27-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> +static bool do_3same_qs32(DisasContext *s, arg_3same *a, NeonGenTwoOpEnvFn *fn)
> +{
> +    /*
> +     * Saturating shift operations handled elementwise 32 bits at a
> +     * time which need to pass cpu_env to the helper and where the rn
> +     * and rm operands are reversed from the usual do_3same() order.
> +     */

Perhaps better to handle this as you did in "Convert Neon 64-bit element
3-reg-same insns", by adding a shim expander that adds env?

It would appear we can then merge

> +{
> +  VQSHL_S64_3s   1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same_64
> +  VQSHL_S_3s     1111 001 0 0 . .. .... .... 0100 . . . 1 .... @3same
> +}

back into a single pattern:

void gen_gvec_srshl(unsigned vece, uint32_t rd_ofs,
                    uint32_t rn_ofs, uint32_t rm_ofs,
                    uint32_t oprsz, uint32_t maxsz)
{
    static const GVecGen3 ops[4] = {
        { .fni4 = gen_helper_neon_rshl_s8 },
        { .fni4 = gen_helper_neon_rshl_s16 },
        { .fni4 = gen_helper_neon_rshl_s32 },
        { .fni8 = gen_helper_neon_rshl_s64 }
    };
    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
                   oprsz, maxsz, &ops[vece]);
}

I'm not 100% sure how best to handle the swapped operands issue.  I don't think
we want to do it here in gen_gvec_srshl, because we don't have the same reverse
operand problem in the aarch64 encoding, and I'm looking forward to re-using
this generator function in aa64 and sve2.

Maybe it would be better to have

@3same     .... ... . . . size:2 .... .... .... . q:1 . . .... \
           &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
@3same_rev .... ... . . . size:2 .... .... .... . q:1 . . .... \
           &3same vn=%vm_dp vm=%vn_dp vd=%vd_dp

and swap the operands to "normal" during decode.

FWIW, over in sve.decode, I prepared for reversed operands from the start (to
handle things like SUBR), so the formats have the register names in order:
@rd_rn_rm vs @rd_rm_rn.


r~

