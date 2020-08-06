Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80768C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C792173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/L8gJXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C792173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3n8Y-0005sX-Fu
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 17:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3n7r-0005Lm-Kq
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:08:35 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3n7q-0004Hu-1y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:08:35 -0400
Received: by mail-pj1-x1043.google.com with SMTP id d4so7314112pjx.5
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=NQqHrEQAf0O1U1Tu9OxX2PHBqUeD13E4LA1zBf4f3+w=;
 b=T/L8gJXeUqHRiryEWxm5EFvd+vBJUPaF+DLEkzMcuB+x9fxvjaCsaCf8ULRDnggfC3
 F5OzMgh+DTnvla6/xmF2wxuwo3MLl7w7wQRau7wCY5RHnYoz8G7mEIS2gu040T/rTyO7
 Ar86pWEl7ctLRxB27bE+fcfM7JNhUZHst007iUBopVDpP2Y1suCtj6UH+6O14/O6iZbp
 uLMneAtOh0opak8I9OW6qvWK2pIgpC7og2uV1xxfG20HVJGA6hN7mUz1Ingf8FlfAiFi
 okjN6SSMzxBstm9ool3EZORj2+cM3f1oL0AufY7cGK/llRTuQq/YhgPwMrdnMK7BCIiG
 Aykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NQqHrEQAf0O1U1Tu9OxX2PHBqUeD13E4LA1zBf4f3+w=;
 b=nQJUli0yKg0KH2fZPfvgqE1a08r4AVZjZYkGDyLUeXMa/0jbjVyWB01Y9dX+4jwoyc
 Svqln9020U7pz5lSaklAvJ4VGNr23wrTqN83B2NTW6lJBUPOI7OIhVyaoNbaAociec4+
 6Okkyfv5QEXE6yojoTKhmgaTvqfvod8q8C6n4ihbqdv8t9phHdT1tGUgatRv3MbXGHh3
 iHoNKM3FR50TPi11aDyKmMGbcKqNIbPrmjiIJ/ssTHT3CYitHTuOcZNHbc1hubwkElwt
 oTQElps2Oi37NtsOl+P9GhDV2oF0wXqFF+344tdGCKCPwZsHb/gMwsmRP0xCpzAWLOk0
 NlQw==
X-Gm-Message-State: AOAM531qd0buKV2QsSkT8DCiZTA0ZxIQi9I1ZCrj+XCdGT5EMstLTxJg
 1j10vrhU4wO+ssj4acFWNXOaKj1P5Ro=
X-Google-Smtp-Source: ABdhPJzBv/r9VRCjE4sRD3S8kPFs+H80E1QcuhDBFePeygvA0aSK4/YBQK7brcdbv9dfXrNkj0o1IA==
X-Received: by 2002:a17:902:7d8b:: with SMTP id
 a11mr8894886plm.342.1596748111596; 
 Thu, 06 Aug 2020 14:08:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x20sm8277193pgh.93.2020.08.06.14.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 14:08:30 -0700 (PDT)
Subject: Re: [PATCH 0/4] Refactor get_fpstatus_ptr() ready for AArch32 fp16
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200806104453.30393-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <130e85bb-2dfc-b983-bbd0-7f674e169c53@linaro.org>
Date: Thu, 6 Aug 2020 14:08:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104453.30393-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:44 AM, Peter Maydell wrote:
> Peter Maydell (4):
>   target/arm: Replace A64 get_fpstatus_ptr() with generic fpstatus_ptr()
>   target/arm: Make A32/T32 use new fpstatus_ptr() API
>   target/arm: Implement FPST_STD_F16 fpstatus
>   target/arm: Use correct FPST for VCMLA, VCADD on fp16

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

