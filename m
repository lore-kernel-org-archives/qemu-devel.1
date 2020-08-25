Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C905C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CC520715
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pA1dICU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CC520715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdM1-0000Ol-Fk
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdLM-0008Gp-Q6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:06:48 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAdLJ-0004ga-PS
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:06:47 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ep8so1633664pjb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=kJEcbaf28P/KD5jILeDCqI2O0wX7kBvNU1uqxYW9ECw=;
 b=pA1dICU9HNosP4Efw+3S/ejIdkR8/v4AYna5HOZ5KoYgwSpHz3zYPPha9iIzQUf42K
 rkUoq0WURQ2AmUKtzDbAfeqV+kadGs+qM8V4KqkpfBJZh2e/ydch1v7Hy/5VTLTVnSGK
 fwCck65xp5VYklm3zp7ws0+oeo6xXFRIK1efQvSob5hm5DkcGqSx5J7Nsb/J0OsU6M2I
 p6s9yMVZmsxKPN4XHPJY4c5hA5FF/0Ez5yI/kzl+OCBZrGDoHWvBPkgz+mwUPcu2mavs
 3xZzRy9nz585WRR5jCvDZZixmc99sb0sJ+KGb6vf/xnZQRxKqoQCzG0WcXqh4CJ91UOs
 dbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kJEcbaf28P/KD5jILeDCqI2O0wX7kBvNU1uqxYW9ECw=;
 b=jClOyVKPkFHLPd2HXaMTkuWcTsQkjU5u+58GIAh0ma+iW67dH5wKsQTeMSYz/8+q9A
 K91icHGiU9qOHQ6GHend3/7uxXT+rXme/gkAhANFuPEKvOgVL3ofppXMFREPpeMuBe1l
 qeJu1ZySc1y+cHhiFdUfSROj1Irg6Z7UrLnTPX++EQ+ZP0loJK07y5TAW3E41JOvsymj
 FpypiVqFnT0rvhAwppCPpSe7HdXyuRz23yyfRhxg5rVZgjiM73ETbL3eAaY+/3qEHPHg
 7teN2lnT/mp/VvPWK24+5UFjI3KKl3wDMukPXKwa5whk628XH/aXoUUgzBOUWk6DsNhx
 Y6gA==
X-Gm-Message-State: AOAM531RPgvb/IKrIyxlqOZWh3WnYe9HnjwK+0k6f0H1ATFMQ3NozhEg
 RHWZTNHNiCW5FSjZEHGC3hDsGEWFjUoaxA==
X-Google-Smtp-Source: ABdhPJyX64A5saYRgCXVckzYjyw3WnTvNfmQvj180DKpoM5PqTA4jDkpRGqbtYQV7VZ4ToJiAN/bvg==
X-Received: by 2002:a17:90b:788:: with SMTP id l8mr2568982pjz.25.1598378803430; 
 Tue, 25 Aug 2020 11:06:43 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id b185sm15999003pfg.71.2020.08.25.11.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:06:42 -0700 (PDT)
Subject: Re: [PATCH 02/22] target/arm: Use correct ID register check for
 aa32_fp16_arith
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a7f9574-2d82-9c32-ca37-e5fad0e9bb42@linaro.org>
Date: Tue, 25 Aug 2020 11:06:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 7:29 AM, Peter Maydell wrote:
> The aa32_fp16_arith feature check function currently looks at the
> AArch64 ID_AA64PFR0 register. This is (as the comment notes) not
> correct. The bogus check was put in mostly to allow testing of the
> fp16 variants of the VCMLA instructions and it was something of
> a mistake that we allowed them to exist in master.
> 
> Switch the feature check function to testing VMFR1.FPHP, which is
> what it ought to be.
> 
> This will remove emulation of the VCMLA and VCADD insns from
> AArch32 code running on an AArch64 '-cpu max' using system emulation.
> (They were never enabled for aarch32 linux-user and system-emulation.)
> Since we weren't advertising their existence via the AArch32 ID
> register, well-behaved guests wouldn't have been using them anyway.
> 
> Once we have implemented all the AArch32 support for the FP16 extension
> we will advertise it in the MVFR1 ID register field, which will reenable
> these insns along with all the others.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't expect that any guests will have been using these insns,
> but in any case the fp16 work will be all done before the next
> QEMU release and the insns re-enabled...
> ---
>  target/arm/cpu.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Cc qemu-stable, for the bug fix?
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


