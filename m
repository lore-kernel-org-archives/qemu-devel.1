Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001FBC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37CB20878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdmjQFe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37CB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLsWQ-0001o7-Oe
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLsV0-00015c-8j
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:31:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:36932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLsUx-00076Q-3T
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:31:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id w7so4012176pfi.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lhZEn1PnlgT2KXGEnl0nEzNyvxivF4IWqU0gtYFSDig=;
 b=jdmjQFe4b9tiSs9qr/PWbPaDd7xYP/Gkj2JT2CBGVssWMJFn0d/aLKs/RPrc/EF589
 +YSG+VneMWo+GwDX/LaIlVEmAANHuaLzAftxXCEZ9/cejLu2dtpTGJJlZLP7ZrGcDct6
 SITDvShmsf2vRc79b4y+dNw+n/Sd8tZ7XerIwy9bjqbCzqWdNdr+seaHKAonK2WhGB9V
 w2frx/zIF4bD9l6WyxAYD69BBj88rHUtSeutFmDApFmO0w6/dx8tSsdEZ/kyz41+110l
 CBVyPvMzNZmzBO6pXJaA7CKpOP8U7PIeFvi4191CNn7Up4hokLyS73yqWNwAK1RFbk91
 FdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lhZEn1PnlgT2KXGEnl0nEzNyvxivF4IWqU0gtYFSDig=;
 b=I0V/JUFTD68w7cZpAMuJcqXvv1z+DdY+V4mFmmsTygoqlOz/EplperSijADIqYimNs
 iX37bAWMr7VdZjWTqmpdIzu0B5P1HRb+VeRIT9jTSfrjLdUSknbF7GBKTgQ7Zm5n71O6
 8rXRpOmNUjyjdJd0rowOxEzuM3TNTuIDeHsNupKUBhvbpFkO/9sLpLo40OrnrBAvDacq
 Pmcun5mMIB19OBsfPaJSUMiAh4P/rKj0ON2PrF4BgfPeaj9KUZTkaQqUBvetEMOgfljs
 yAYydvR9gmvm6d/SNPmQ4fD6eKBc4+Zm9lkyMV+81HfgjufhIxewsjgLuUWV+JC36cTS
 b33g==
X-Gm-Message-State: AOAM531VRJ+1ZZLPctDnKu6R3whso69tNAZiQElwfSJ49jZC7QLHHcji
 gTbs9jb/8koe2h0CBU40+xgADA==
X-Google-Smtp-Source: ABdhPJxKkPlkE2yQutrXS2NNLbvB2+xipHEVg9FEIS5f1O9+s4/7whSbSkulIyA8ZXh+gN9i54O+jA==
X-Received: by 2002:aa7:96bb:0:b029:142:440c:6ebc with SMTP id
 g27-20020aa796bb0000b0290142440c6ebcmr665872pfk.22.1601058669621; 
 Fri, 25 Sep 2020 11:31:09 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gg19sm2647920pjb.49.2020.09.25.11.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 11:31:08 -0700 (PDT)
Subject: Re: [RFC v4 53/70] target/riscv: rvv-1.0: floating-point slide
 instructions
To: Frank Chang <frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-54-frank.chang@sifive.com>
 <96b9fa44-5a1b-2ac0-04ae-fa4d2857096e@linaro.org>
 <CAE_xrPhUXcMrBmRDwVBwmwA0m3QgaSAm56pYCs5QCJHOeK+S2Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <90fabd0c-24d4-aa56-7817-fdc528d713ac@linaro.org>
Date: Fri, 25 Sep 2020 11:31:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPhUXcMrBmRDwVBwmwA0m3QgaSAm56pYCs5QCJHOeK+S2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 1:21 AM, Frank Chang wrote:
> I'm happy to reuse vslide1up_vx helper functions.
> 
> However, opfvf_trans() takes helper prototype of:
> /typedef void gen_helper_opfvf(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_ptr,
>                               TCGv_env, TCGv_i32);/
> but vslide1up_vx helper function's prototype is:
> /typedef void gen_helper_opivx(TCGv_ptr, TCGv_ptr, TCGv, TCGv_ptr,
>                               TCGv_env, TCGv_i32);/
> 
> The third argument has different types, not sure if it's worth it to sync them
> all to TCGv_i64.

Ah, yes.

It could be useful to always widen to TCGv_i64 -- that's what gvec does in
general.  But I certainly won't insist.


r~

