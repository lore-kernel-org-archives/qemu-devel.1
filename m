Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578992242C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yuvf0Smk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578992242C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKtI-0002fT-Jt
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvKsi-0002Cw-RR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:22:00 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:39744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvKsg-00070G-9Y
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:22:00 -0400
Received: by mail-pg1-x52e.google.com with SMTP id z5so7589807pgb.6
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HQ/jqj4l+Y6oRDJ+E+cXtneIopr0U6a/vMKRts+AgyQ=;
 b=Yuvf0SmkiTBUm8EWqBEX1goVpgXMF1dP17uDlneO3H4rqLmEvrZkH7Tmlt2JbZR21a
 7vaJs3p98iPgF06RBoZ4rBC8t3S+jxe/nPPqiFabtTPxFPdKYP6awzlz/Yoo6zAdLRud
 cJ03SJ6uDR+3IwHsmVL9jZHR0MSu/w9Xkcu8id/++mSQDj5/ifXdLursSPCPfldG+NjO
 gOvZ9FNAI/YS+wlE6kI/WtRVS1W9pBOK0WVT/clZELTnbLNP/dsxFFMzqmK39WckyiqL
 228IwbJBZrvTyq80WtUqHiF0jn5tiZcESrV0pyQKHLhoi930TofNLL6H2JPQ/g1gQqO9
 XNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HQ/jqj4l+Y6oRDJ+E+cXtneIopr0U6a/vMKRts+AgyQ=;
 b=gzMFTv6dg9704pxa4D14SZ6bx0ttgZnDCAXDCf5KGR0SDRVQ07muGF3m5uexR5DA8g
 jiV4iSHYgxMPNRyYeddr02LC1pNyiAPZl25d4XQg/K7JZ3Oxk/Kwm0cnNCKTIePx2JZN
 XZ4stDT7Qagmw5oWLeengDk2B4sCluLXRp9hK3ne3nCk1L/yzE32OhJfWOYOHcBOqF3L
 lqk6+uUe7vL1kJBYW0yaDwQ8DghvmnVsiwTkXEfz2SUj1naLTzuC134un3fL3TUr0npI
 Go6OV4qU+HbiBbpe2V07JtDY8XSliHDWzHjsT6BM4LdVRbeWTIbnN3LDsFPV1annbhWW
 j+6A==
X-Gm-Message-State: AOAM532BOVUWVQ2P+j6U8ze6SEBxoZrZug3o4gVtQxhZbKcLyBrtR4dF
 wy+lXTQ6qEezVqwe4GoZ6D90qQ==
X-Google-Smtp-Source: ABdhPJzb0qXTVg6C3sgzI7U7BhyJIMGcTiEiyUk5fQiQMCEaXZH/ZRvk0zHKkrfc7L+USB173Z6qdQ==
X-Received: by 2002:a63:e60b:: with SMTP id g11mr3523842pgh.188.1594732916207; 
 Tue, 14 Jul 2020 06:21:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id e191sm17319155pfh.42.2020.07.14.06.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:21:55 -0700 (PDT)
Subject: Re: [RFC 05/65] target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns
 from using gvec
To: Frank Chang <frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-6-frank.chang@sifive.com>
 <452e8bc7-4622-77c2-ec81-9aa6f25705fc@linaro.org>
 <CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ccc7311-02f4-821f-6272-73ab600a8cda@linaro.org>
Date: Tue, 14 Jul 2020 06:21:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 7:59 PM, Frank Chang wrote:
> The latest spec specified:
> 
> Only the low *lg2(SEW) bits* are read to obtain the shift amount from a
> *register value*.
> The *immediate* is treated as an *unsigned shift amount*, with a *maximum shift
> amount of 31*.

Which, I hope you will agree is underspecified, and should be reported as a bug
in the manual.

> Looks like the shift amount in the immediate value is not relevant with SEW
> setting.

How can it not be?  It is when the value comes from a register...

> If so, is it better to just use do_opivi_gvec() and implement the logic by our
> own rather than using gvec IR?

No, it is not.  What is the logic you would apply on your own?  There should be
a right answer.

If the answer is that out-of-range shift produces zero, which some
architectures use, then you can look at the immediate value, see that you must
supply zero, and then fill the vector with zeros from translate.  You need not
call a helper to perform N shifts when you know the result a-priori.

If the answer is that shift values are truncated, which riscv uses *everywhere
else*, then you should truncate the immediate value during translate.


r~

