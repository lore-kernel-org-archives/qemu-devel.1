Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC318C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC14252BA
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9SaiOPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC14252BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNMz-0006Uj-9u
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNLh-0005Av-8X
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:40:29 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNLd-0004Ps-Pp
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:40:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id d6so99886plo.13
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=jZuOVfZXzmXfUNZZhGowe0arajdOtS7smUegqSksugA=;
 b=G9SaiOPmJ12PQ3QSRrqsp6L+EolKTrwbjkx6wZQ7YuBNYTtt7ZlV2KEBTw3Gy683q9
 ID5taL4KeeNWjEx/bUJrHszuMBwcpJ07arAMr3Nf2ZQbnqFARuPQ4y0UeaRAHPAOMe8X
 nm2VmPvyd8los5ycYmGUYRNqT0nik7YtYsVXnfroh4mPZfdlTEP3OhAp4LzHBhEANkon
 zLmo4mFAp1iY3PVgVhC6FenksKlonWYAGcF1eqtqppkATI7etiuYqpPed+/wOkMLFsGN
 wL6zc0/9GGpHzGpfnJKswHPTYmiztI6KMtXPh1io0IfJR25Gkx2c2Qf0MwpJynq/4bUr
 grWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jZuOVfZXzmXfUNZZhGowe0arajdOtS7smUegqSksugA=;
 b=stCts4YVHBlZPyi60uFrbaVtoQbjsEskQZ14Lg/5aK9QU3VC1OUXU/c5X19NPQbKVn
 0WUFOtVfsfLR8lSvPsYBywL1M3bZSQfMTASOBev98N4lEtTUUNUXaUMcJEEuICZaM8z+
 SrQ04fTqJFx5uTFagshA9zenPvL+368mIVrclBpLwJ56hf2o0xdjzrPycZIERgO7Xpp1
 jAX+NkZihPF1xAaB/Inyn1bJoWbkjY2viFf07MhaY0rb+CBHzq7vDQzC7wqG/He9DIrU
 Pp1M9+xDWG49bIACUc+OQ/aim6WsK/aBMQyBH0BHgIxgY+ZRsJOf1g2To/hokKK4FDtX
 J6Lw==
X-Gm-Message-State: AOAM533jzV0O1QWpN0olvdEVQDSaSzI2Q459L9igjm74sQDKmZK9Zz1W
 /VgBFzDVbffsO75KkG9i3bULSzyq36kNmQBZ
X-Google-Smtp-Source: ABdhPJxHwqv4VquVVp/8yQ8dobf7wdBqlgzdOOL4C7sOfrhMhB7vgqzU3nD//ZoXLOfiyKED4IurYg==
X-Received: by 2002:a17:902:8307:b029:d3:89e2:7866 with SMTP id
 bd7-20020a1709028307b02900d389e27866mr644910plb.42.1602607221979; 
 Tue, 13 Oct 2020 09:40:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 128sm132999pfd.110.2020.10.13.09.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 09:40:20 -0700 (PDT)
Subject: Re: [PATCH 04/10] target/arm: Make the t32 insn[25:23]=111 group
 non-overlapping
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bad2de7a-68db-ad0a-0976-ebf475992e17@linaro.org>
Date: Tue, 13 Oct 2020 09:40:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012153746.9996-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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

On 10/12/20 8:37 AM, Peter Maydell wrote:
> The t32 decode has a group which represents a set of insns
> which overlap with B_cond_thumb because they have [25:23]=111
> (which is an invalid condition code field for the branch insn).
> This group is currently defined using the {} overlap-OK syntax,
> but it is almost entirely non-overlapping patterns. Switch
> it over to use a non-overlapping group.
> 
> For this to be valid syntactically, CPS must move into the same
> overlapping-group as the hint insns (CPS vs hints was the
> only actual use of the overlap facility for the group).
> 
> The non-overlapping subgroup for CLREX/DSB/DMB/ISB/SB is no longer
> necessary and so we can remove it (promoting those insns to
> be members of the parent group).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Just a minor bit of tidying that I did while I was trying to
> work out whether the v8.1M loop/branch insns needed to go in
> this group. (As it turns out, they don't.)
> ---
>  target/arm/t32.decode | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Nice cleanup, thanks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

