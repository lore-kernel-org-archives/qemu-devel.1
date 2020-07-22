Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD37C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D306820787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNVYAwI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D306820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyJB3-0006jn-4b
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 14:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyJAU-0006Gx-CG
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:08:38 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:45131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyJAS-0003ff-QQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:08:37 -0400
Received: by mail-pf1-x434.google.com with SMTP id z3so1684699pfn.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Njuw91hrPNy4PbhKHvD8/7E47zPQs5c+jFpI52u0HD4=;
 b=QNVYAwI8OaB+R6YFFcurPNxmtf9xmgNXxGUmEo3edDb5WUWTTHih8GhoSFuvb+OHvp
 +vxFIqt1qqRCbXFj9iFdMEFDyMaTk11Ty3Jd32aMJh+9ZD4LM+UT2yc4Xn3bw8IhCoiG
 KjH48+Rr1EvVvRSmUxY2jL4MGsNdlpOeirGA4Jdv5Q+t24gA42wpNPwUH2Z8oRReyRfr
 Na0mo28P9roeDnWZb13TqOqlGJVddFZtOTbAXYizuWhDZGiFbJXopbcgVilkYGiTCkDC
 fv9U/B4uU0q9pLDWzZqbXh5Ftot753f1qPbzKpNpcHE366uii1XJgG1CUJlRABkazTEr
 3fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Njuw91hrPNy4PbhKHvD8/7E47zPQs5c+jFpI52u0HD4=;
 b=jTTTy6KU0hFBeW9sW/t9Ca755aYDywtE4J5a8GLAcBY5LD/QFS8qIzPD4385WCq1D7
 PJ1ud2mFI4DkrwAJ41XbcjRPDdbfZSy1JBPxdEMcTalTlg5suVtnk6620tGqAPS8+ze9
 rP3c0WeUTiwZuFs5eXXeSrGknXP5xAGJMtmLgU3uwXyYS5FBUTNahElu/RJ9bSy6ph6M
 wk0taOpSH4oV3/B0a7b1eYQHHvDV8EwTbY+s9L3sNl7txNo+f1D1/Fl1GUMR/Rn7Pyen
 S1Sc0S+h67fZ15K8jSxqTcOwHoZtEzne/JPpESLb3Epy27zXJPNqK5zUdU50Ct4r55s+
 XnVw==
X-Gm-Message-State: AOAM530XCg7se7OzwIpXKzAQ0ezf3myaJss4jKSj+bnIglJL7CSwu2F/
 +gZWDEH6nVCFUMvhsUehvl6nBw==
X-Google-Smtp-Source: ABdhPJwq0SsRTGSN+TzNHuBYlhEHcRtVuAVwGepegAyedty2UdBVNF9BHLwjTNJbM02Es8A4373TaA==
X-Received: by 2002:a63:7542:: with SMTP id f2mr877769pgn.151.1595441315129;
 Wed, 22 Jul 2020 11:08:35 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 e195sm240530pfh.218.2020.07.22.11.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 11:08:34 -0700 (PDT)
Subject: Re: [RFC v2 18/76] target/riscv: introduce more imm value modes in
 translator functions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-19-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <271fbe17-4a2a-2c21-9885-215134aa1be6@linaro.org>
Date: Wed, 22 Jul 2020 11:08:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-19-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> +#define IMM_ZX          0   /* Zero-extended */
> +#define IMM_SX          1   /* Sign-extended */
> +#define IMM_TRUNC_SEW   2   /* Truncate to log(SEW) bits */
> +#define IMM_TRUNC_2SEW  3   /* Truncate to log(2*SEW) bits */

Please use an enum.

> +    case IMM_TRUNC_SEW:
> +        src1 = tcg_const_tl(
> +            extract64(imm, 0, 5) & ((1 << (s->sew + 3)) - 1) & 0x1f);
> +        break;
> +    case IMM_TRUNC_2SEW:
> +        src1 = tcg_const_tl(
> +            extract64(imm, 0, 5) & ((2 << (s->sew + 3)) - 1) & 0x1f);
> +        break;

Either the extract or the "& 0x1f" is redundant.  Remove one.

It would be worth splitting the integer arithmetic out to a helper function so
that you don't have to replicate it again in do_opivi_gvec.


r~

