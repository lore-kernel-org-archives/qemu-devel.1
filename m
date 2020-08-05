Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD6CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36914206D4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwkIgt6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36914206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39jp-0005hQ-8x
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 23:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39jD-0005HR-MY
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 23:04:31 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39jC-0004lx-2F
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 23:04:31 -0400
Received: by mail-pl1-x641.google.com with SMTP id p1so24463946pls.4
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 20:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=qSGzqtNfzMq1VerllI7V7AXdUOzzqT6OEtosVIVaLl8=;
 b=HwkIgt6p6SY7f48d9iX83vpXhTBtgFT6QNFtK6Lg+/jK/GkhtNtbqt0ALtSdRbzkKi
 FqxLAuOk6iP1OzU1wtDGqsS0CmxoOaiWBw8H19PIip1vXM/HF9m9UHAPZmeLeDhSpifd
 iNmUy60AHKfhb3XdSBQQKStvA/E+faJzbCYGFA5zM2QPXyreGrW+0bKA4p75uTRRPU2W
 y7MPcsFNnUgFUtzpcA87MvUBWeCw+g8lQzKAyoBGYb33wJzrUgodNQXemhRf1Z8uLO3S
 rKFjiY7xU9UNkW4fzZ7QvdBKFTs17+BMCzMai2nrHIRWeCOFc6JpxNlYEcNTZqSwOTKv
 ddxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qSGzqtNfzMq1VerllI7V7AXdUOzzqT6OEtosVIVaLl8=;
 b=MFquK02ZBjgDESoMGLMTkxioFDStdRhOoZyRzNQ9s9MS278oxZ0YwVep7+OSgNmzYl
 XSYTDWnhRULmbX77ulgcYPeRffk9SrO6OuOFVi5foeK3fS89ZjX8fbp6d/wPhDnAEE/u
 He67EXfGSHGpxNMVCLeiIbMI77q2SiN93/36mI+xo+Pf4m11cjX+Lfv8ZkpfIDfsODMP
 FU5TNsRkSwxJfNyNC3eFXN75vbfVsx+Q41pPCG3ivvNVleOU3hCZlifJx4M7BV0U2inz
 ifDQ5mDUX/YaAEusP/6p2aZy/dI4B4F1mx2O4n1v+GVxvZ24CX7AxzRNBW4Tp6mf7tCg
 KFXA==
X-Gm-Message-State: AOAM532xj4NdTzJ5vcQc4k1VatZ521n9yH/Q/qIinqctd2nfql+2JNdP
 Tj5oymjoe3om7ltNVWxngeJBLrqluls=
X-Google-Smtp-Source: ABdhPJxkiSh9ngkOFR2KX7r5i3iuHJr2qUuLxZu+vWr60b/pU4FY3laFy72rB33gPdKSFGUhQG7vlg==
X-Received: by 2002:a17:90a:ea82:: with SMTP id
 h2mr1135684pjz.75.1596596667829; 
 Tue, 04 Aug 2020 20:04:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e20sm693883pjr.28.2020.08.04.20.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 20:04:26 -0700 (PDT)
Subject: Re: [PATCH 5/7] target/arm: Do M-profile NOCP checks early and via
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803111849.13368-1-peter.maydell@linaro.org>
 <20200803111849.13368-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e5da2812-8d41-9db9-bd2e-2d716c016508@linaro.org>
Date: Tue, 4 Aug 2020 20:04:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803111849.13368-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 4:18 AM, Peter Maydell wrote:
> For M-profile CPUs, the architecture specifies that the NOCP
> exception when a coprocessor is not present or disabled should cover
> the entire wide range of coprocessor-space encodings, and should take
> precedence over UNDEF exceptions.  (This is the opposite of
> A-profile, where checking for a disabled FPU has to happen last.)
> 
> Implement this with decodetree patterns that cover the specified
> ranges of the encoding space.  There are a few instructions (VLLDM,
> VLSTM, and in v8.1 also VSCCLRM) which are in copro-space but must
> not be NOCP'd: these must be handled also in the new m-nocp.decode so
> they take precedence.
> 
> This is a minor behaviour change: for unallocated insn patterns in
> the VFP area (cp=10,11) we will now NOCP rather than UNDEF when the
> FPU is disabled.
> 
> As well as giving us the correct architectural behaviour for v8.1M
> and the recommended behaviour for v8.0M, this refactoring also
> removes the old NOCP handling from the remains of the 'legacy
> decoder' in disas_thumb2_insn(), paving the way for cleaning that up.
> 
> Since we don't currently have a v8.1M feature bit or any v8.1M CPUs,
> the minor changes to this logic that we'll need for v8.1M are marked
> up with TODO comments.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +        /* M-profile handled this earlier, in disas_m_profile_nocp() */

That's not the function name you settled upon.


r~

