Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B0C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFD72071C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvE14luE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFD72071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUMoV-0007FF-1p
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 23:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMnq-0006SU-MB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMnp-0000dG-Tq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:57:30 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUMnp-0000bW-G8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:57:29 -0400
Received: by mail-pl1-x644.google.com with SMTP id s10so3257189plr.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 20:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=lONhPFJce+pXiX1zaQi741ujfZSuxX6lJAZkIMjg54g=;
 b=jvE14luE05q4l2cqgXhQMxY/+WJlfilh6Q+/nFWt6hmyGpCjVSFXAW4NT3R4dr3hMZ
 HAVRZ+RNPHtK8GSrCP61EY9Ftk/BsoCyt+b/dtrmEXX4GI48dKYT2jbtmP5QMBdHthLm
 lrpG3CHjyo9ZfX8236Y/PkP/e2Txt3EpwAZRIFwdQ16nScpAFVP5CzPebhkFj45qq7bi
 fDaW2vlQWKoTE1V4qp12DqItAuSAEH/MJnnFaQ4yPkAtjpJSmo4VZkm3BeI9EEv7Gqnp
 1VKc6vhXt47en3R33SicMSEWpqZA3KiK/HJhfKw2yvxraEYU9yCQ49TOSwRbxQLtEkgQ
 Z9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lONhPFJce+pXiX1zaQi741ujfZSuxX6lJAZkIMjg54g=;
 b=kY/18rb2dYMlqXc8ykntyikoAe45LQasfDuHJ1vO80A3FFWfIyDMF4hIM3ReR4uBjJ
 WsAkhsFzmL/jnwTMtQMh9Gkrkg7oCETQfal9AE4wTVoL12spqph9a2FgVND9TMeUT/t5
 QY7/O2eRp8+bPDbtjdLH5eegQD5/tMs2bTtDBEAnSjuY9Wbutzwt/3i0HLiovU0BMZTU
 N4VRrs3UsOTvqjO1bmdnJsIP/vFHMA6yZ+49OuLotv7J7qKLIF4k4RifTUHO934KFBt2
 DGn72X2HBcauyMmSwHpjk8i59hgRfqOaBfuIhYTjd26PGdtXsEqDbjNE9TdH79rMQxLl
 2Qtw==
X-Gm-Message-State: AGi0PuYpBODEJ40m9yARIfgyiyy6U78IWCyaz1awR/At62Oo+jHYkRHi
 ULLidZ9N/cmR77OcQKgZUz68s31PAeA=
X-Google-Smtp-Source: APiQypIXQnk96gvqC3v6nY8HZCNJmtG3EUCgeJao9qgmJcOOjkI4o/6hwm8n6L7g8q0kYOEIiifyYA==
X-Received: by 2002:a17:90a:f197:: with SMTP id
 bv23mr2351321pjb.3.1588305447620; 
 Thu, 30 Apr 2020 20:57:27 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d124sm1025045pfa.98.2020.04.30.20.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 20:57:27 -0700 (PDT)
Subject: Re: [PATCH 31/36] target/arm: Convert Neon VADD, VSUB, VABD
 3-reg-same insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-32-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <434ccdb4-1037-be3d-1477-b9bf1bf2f804@linaro.org>
Date: Thu, 30 Apr 2020 20:57:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-32-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::644
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
> +    TCGv_ptr fpstatus = get_fpstatus_ptr(1);
> +    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
> +        tmp = neon_load_reg(a->vn, pass);
> +        tmp2 = neon_load_reg(a->vm, pass);
> +        fn(tmp, tmp, tmp2, fpstatus);
> +        tcg_temp_free_i32(tmp2);
> +        neon_store_reg(a->vd, pass, tmp);
> +    }
> +    tcg_temp_free_ptr(fpstatus);
> +    return true;
> +}
> +
> +/*
> + * For all the functions using this macro, size == 1 means fp16,
> + * which is an architecture extension we don't implement yet.
> + */
> +#define DO_3S_FP(INSN,FUNC)                                         \
> +    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
> +    {                                                               \
> +        if (a->size != 0) {                                         \
> +            /* TODO fp16 support */                                 \
> +            return false;                                           \
> +        }                                                           \
> +        return do_3same_fp(s, a, FUNC);                             \
> +    }

We already have helper_gvec_fadd_s and helper_fsub_s to handle the whole vector
with one call.  Use with tcg_gen_gvec_3_ptr, with the status pointer as the 4th
argument.

Interestingly, I can't find the current use of this helper.  I must have been
starting on that translation but got stopped?  There's no current full-vector
helper for abd_f32, but it would take very few lines to add it.


r~

