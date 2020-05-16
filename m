Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B2AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 02:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F93D20671
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 02:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jweuqlnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F93D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZm9i-0000Yx-V0
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 22:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZm97-0008SJ-Gl
 for qemu-devel@nongnu.org; Fri, 15 May 2020 22:01:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZm95-0004WZ-VK
 for qemu-devel@nongnu.org; Fri, 15 May 2020 22:01:49 -0400
Received: by mail-pg1-x541.google.com with SMTP id b8so1848644pgi.11
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 19:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=IF3tXI1TMlEtzrjtBcqcUgSSgHp1vkmBfAtiEG8puJk=;
 b=JweuqlnbW+MdHk53bM7bwmIS5qtjr7dG1Gekxzx5x65FTrM9i5g2IVGRiDfchSdoe+
 2gzKtFX76d3bJB3QL8zL+KdJultNGhwmfi/8WLaA37hEj/yEVkXn/WRR5fzGeDhvwKrT
 +ZGNucKmMkFpx2BHVZwAXVmnsMjvxaLVsoJZRawiT+ZrwA2iSlitZFpReyzZ6odeCKbI
 JCpv67OX8bIfyg/5kWhZLAD4Urohb6tkwh8RqiJxb9fiPNGXwfp2VDBPdAp27ssY2wdj
 vcVMyK0zsh3yQDgI2wsg/Tv61xFyx4notr5L88cUbJTa9i3RrDTjWq2VSPmCNBJ6ltAT
 ax5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IF3tXI1TMlEtzrjtBcqcUgSSgHp1vkmBfAtiEG8puJk=;
 b=WSsrh9h4eKu0fM3HUZdCJCcHXxQasRuxpa1YxwBzIbYWThyZpvoAij6WiTltiJqXCl
 BHDz4/iQYgrg8OYV6vCBq5nu31uXIxc9jhZsOG00u1BV/TIVBYfOwD8r0LKIfhPmTCoi
 MDLmja8YOFP+VtINcJWg1toPijOPP+tiGZXfgkPfxToSbO97Byl7RO+WZknDkurcLzSi
 b780mMlYat90YubfMN3U/jLycHjMYK9QCp7gfPaer9zwRfn5XnZ6su3mWTD8X95WJ7SG
 iwxLyxV26h6rKnFTFktjCpcKuo4K6Vj0FTZb7FnI8L3ft15M53qS61W+Jn05iMkyEewM
 chgA==
X-Gm-Message-State: AOAM530rvTHYySeqfhNfbdEPvZQuj/GME0bNWOznhZtor293/VPNvNCK
 Rqp+D0lt5rxENoIYwakiv21tZa7gIx0=
X-Google-Smtp-Source: ABdhPJwqDa6R+jXqTOCO2h9f44b2BtTrgZh29rOnYhZkzqXLbSXoR0R+4DnRmiVdqY+f4tEO8kyM7g==
X-Received: by 2002:a63:5724:: with SMTP id l36mr5947364pgb.317.1589594506191; 
 Fri, 15 May 2020 19:01:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o21sm2420550pjr.37.2020.05.15.19.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 19:01:44 -0700 (PDT)
Subject: Re: [PATCH 06/10] target/arm: Convert Neon narrowing shifts with
 op==8 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200515142056.21346-1-peter.maydell@linaro.org>
 <20200515142056.21346-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f025a15-5ce6-37f1-9ff7-7cb4f202a320@linaro.org>
Date: Fri, 15 May 2020 19:01:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142056.21346-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/15/20 7:20 AM, Peter Maydell wrote:
> Convert the Neon narrowing shifts where op==8 to decodetree:
>  * VSHRN
>  * VRSHRN
>  * VQSHRUN
>  * VQRSHRUN
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  32 ++++++
>  target/arm/translate-neon.inc.c | 168 ++++++++++++++++++++++++++++++++
>  target/arm/translate.c          |   1 +
>  3 files changed, 201 insertions(+)
> 
> diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
> index 6456b53a690..f8d19c5819c 100644
> --- a/target/arm/neon-dp.decode
> +++ b/target/arm/neon-dp.decode
> @@ -208,6 +208,10 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
>  
>  @2reg_shift      .... ... . . . ...... .... .... . q:1 . . .... \
>                   &2reg_shift vm=%vm_dp vd=%vd_dp
> +@2reg_shift_q0   .... ... . . . ...... .... .... . 0 . . .... \
> +                 &2reg_shift vm=%vm_dp vd=%vd_dp q=0
> +@2reg_shift_q1   .... ... . . . ...... .... .... . 1 . . .... \
> +                 &2reg_shift vm=%vm_dp vd=%vd_dp q=1

I'm not sure this part makes sense.  Correct, you cannot leave the q field
unset and continue to use &2reg_shift, but the insn field q is decode.  We wind
up with VSHRN having q=0 and VRSHRN having q=1, which is a distinction without
meaning.

While we could perhaps reasonably set q to a consistent constant, the only
driving reason to do so would be to share code with do_vector_2sh or
do_2shift_env_*.

But since we can't do that, due to the expansion algorithm, I think it would be
better to create a new &2reg_shift_nq that does not contain the q field.

The rest of the code looks good.


r~

