Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B09C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035602080D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJzv67dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035602080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzd3-0003Ci-T2
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzbu-0002Cm-1I
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:56:42 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzbs-0006Vt-C0
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:56:41 -0500
Received: by mail-pl1-x644.google.com with SMTP id j5so8827686plk.7
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dg7x18WPma1VvH4BjHj7HmfS4Xe3X5EsexEREWB71zc=;
 b=EJzv67dv9Cn7Ng8EwKQ7BAktUdIAlPRzfAjq3oItxG+y4AZtZ1D0OOJwVGdrnsxUaw
 7D/j1qVvwdRJg2oGC7GSbPMt16hDhVIFM8KO1GGDcBtkt5jWSgOvsV7AFfvmxxevypEy
 mpohJhsOGjCXYsdzebq9DMdHigw8lOPg5SYU8tr1pGQoGd5//rrfelUxWs2gvuymPZ7b
 cQMfUaU3ZDh3N9VJXGrAT/WCyesvBMYCb3hYxtLOS0ZH4jFmk9jQhAm0RAwieqexGr2f
 PtKcZRr1tK93kl1BmsSeZhPJGDvhJCZUCMn2bOAwqq7Ms8qFpLxewC8MgLzYJPZhzLWZ
 iKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dg7x18WPma1VvH4BjHj7HmfS4Xe3X5EsexEREWB71zc=;
 b=QSjLmtmtIlTGABhD/V6+or4+B6Vzs03JRdO1ZRIlPih/xxOwFK10sUwnvBIJJ9QavB
 nQkulSajolPqQZxzpc6iHlT+P70nYdc9IAbAX4/XcKNXJnzDPqDUr4lFY/u9zKG+5Qov
 9Tnknjalkx5xn8K3J1YZvZo6cZisqkRf4/saKZ95u3O5UTnxEHsFc+asH0H+AFrEX/4Y
 oQ6+APb6N4ezQscNwvH6KcL0BrtYmitUg+JuODRgXskZs8/MvQ5VqgvzkOmGE8Smw8V7
 b2RtlSMMSWBR1L+3djLTWKAPoLpRn08nJdgi9ACi4vedjOMTC6XW8ocMeOSO/eszrmkk
 nWMw==
X-Gm-Message-State: AOAM531VVFAi7ET5T9LCi5UZTXzLCLtnJ5HBViUTkkNEFQDZgkqf48dJ
 TGDBOXm79JQiJrL6eohFG42GUmBK/QVb6A==
X-Google-Smtp-Source: ABdhPJykBW/IJ+ynDujF61vZyLPJpGx+esxNHwpZSNT3R3BqYOfJPY3Bhui+GYr7NOaYaLC1i3vcTA==
X-Received: by 2002:a17:902:e983:b029:d5:f465:55d5 with SMTP id
 f3-20020a170902e983b02900d5f46555d5mr26121758plb.60.1604422597815; 
 Tue, 03 Nov 2020 08:56:37 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id u11sm16532508pfk.164.2020.11.03.08.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 08:56:36 -0800 (PST)
Subject: Re: [PATCH 03/14] target/arm: use arm_hcr_el2_eff() where applicable
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-3-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <267b4dad-8c96-0931-1a50-39bfccffcc1b@linaro.org>
Date: Tue, 3 Nov 2020 08:56:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-3-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This will simplify accessing HCR conditionally in secure state.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/helper.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

