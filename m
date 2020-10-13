Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C06C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4FB2532C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PI1dMTde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4FB2532C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNqt-0000Q2-CA
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNpC-0007nU-7V
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:10:58 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNpA-0008Me-Dj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:10:57 -0400
Received: by mail-pf1-x444.google.com with SMTP id a200so150054pfa.10
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=phxlW6lMRw6L9JtzX5buY0Bt3gqjM+ySf+wKEcRgy3M=;
 b=PI1dMTdebZMGv6Txic44lfk/OPUX1fftcb0kDrlp+xlA9ljXgcePkFkvGGCMtBy+ss
 Z1/mlDElSSw0AR3nX4KuTZR30TFYeqRf5R5V31TZZqiwghDfvnmS9l9HGFG64iprSFwm
 9VnZ7mIDqkL/pD/1D7zCF6XGwimCE/Kpno5sujbq2lXGDPLr+6V9CulzAP1LYgrOUMcc
 IaujTE7ZJNFroYAtBAQ/7IHkoUBD+3Le8+zf+7g6rjYOvXLYrHugyTOTJX91RtlKnfke
 EglyWn974ja0y89niKhMGfc++w/HAgDJh1JUiY7MYVciidIHD6XJmwGjuEixaFUG9Ong
 iA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=phxlW6lMRw6L9JtzX5buY0Bt3gqjM+ySf+wKEcRgy3M=;
 b=firdLjuYpHQ5PWZGKwF5i57y5FKxsiXsTa0UU2IIP0sa5jiHasgam+kVDygg6DKj4n
 PZc+QC6o8otBsJIXuGhMSk86t5iCGO0+P5uDRfAxiVVrNln0IUtMN9ROoV/ECK7X7bhm
 SeNFDuxJf1D2d8Ad7FIcUGI/06eSmIBUrFx9gbRqmE+UiE0eYo//NtNntPDr3ZI9HDeY
 LzOHUkpHcIvO3VdZn0SIx4ZLnXGKhajEexzYnPjowb0oodq0B/5hKMh7JU7r0DvxjU4V
 rntwdFHPBFcIFecj0JeRHPv+fDsL7FJapq85h9m9kyCfXX+zmYDNG1q9QlZnHMMZjxSN
 jkhg==
X-Gm-Message-State: AOAM531vdGAWXDmPm20UN6L+sMpztm15lSfCvBiOE8zPFvaSW5hMCLPx
 sS91YkQZuIHD+oLCZvShuewNmDVgBNS5i4If
X-Google-Smtp-Source: ABdhPJx7UbUr0TdCeZHmiuRn7zIKEeMxnktJIAdqk96xJwh3Ram7JBcTWImMtZo+ewnY0b3x4l+kmQ==
X-Received: by 2002:a05:6a00:2292:b029:156:8913:e424 with SMTP id
 f18-20020a056a002292b02901568913e424mr144373pfe.56.1602609053515; 
 Tue, 13 Oct 2020 10:10:53 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 38sm190729pgx.43.2020.10.13.10.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 10:10:52 -0700 (PDT)
Subject: Re: [PATCH 07/10] target/arm: Implement v8.1M low-overhead-loop
 instructions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-8-peter.maydell@linaro.org>
 <CAFEAcA_MN4pzkWV65+2VtUgMdayf6pa-RCLXiomCsntF+38hNQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a06ae91-68e1-47a7-c6aa-19c1e2c47dda@linaro.org>
Date: Tue, 13 Oct 2020 10:10:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_MN4pzkWV65+2VtUgMdayf6pa-RCLXiomCsntF+38hNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

On 10/12/20 12:56 PM, Peter Maydell wrote:
> On Mon, 12 Oct 2020 at 16:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> v8.1M's "low-overhead-loop" extension has three instructions
>> for looping:
>>  * DLS (start of a do-loop)
>>  * WLS (start of a while-loop)
>>  * LE (end of a loop)
>>
>> +static bool trans_WLS(DisasContext *s, arg_WLS *a)
>> +{
>> +    /* M-profile low-overhead while-loop start */
>> +    TCGv_i32 tmp;
>> +    TCGLabel *nextlabel;
>> +
>> +    if (!dc_isar_feature(aa32_lob, s)) {
>> +        return false;
>> +    }
>> +    if (a->rn == 13 || a->rn == 15) {
>> +        /* CONSTRAINED UNPREDICTABLE: we choose to UNDEF */
>> +        return false;
>> +    }
>> +
>> +    nextlabel = gen_new_label();
>> +    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[a->rn], 0, nextlabel);
>> +    gen_jmp(s, read_pc(s) + a->imm);
>> +
>> +    gen_set_label(nextlabel);
>> +    tmp = load_reg(s, a->rn);
>> +    store_reg(s, 14, tmp);
>> +    gen_jmp(s, s->base.pc_next);
>> +    return true;
>> +}
> 
> This turns out not to work, because gen_jmp() always generates
> a goto-tb for tb exit 0, and we hit the assert() that exit 0
> was not used twice. Here's a fixup to fold into this patch:

Indeed.  I was going to suggest that here you should use arm_gen_condlabel()
like you did for LE.  Which I think would be still cleaner than your fixup patch.


r~

