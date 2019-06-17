Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DCC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6D42084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PA2lHNY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6D42084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0XJ-0001Ao-2Q
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40133)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0WL-0008W4-1y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0WI-0002WB-If
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:54:36 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0WG-0002Ti-Oz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:54:33 -0400
Received: by mail-pg1-x542.google.com with SMTP id f21so6575107pgi.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VaMtCuN5DX2vrk7FCjExxTysTHc2r5PaLYKFGuexdoQ=;
 b=PA2lHNY5bW3TxRc4YqbwT1IiQUMjoLad0L3URCmyFpJMcTd2eGw1y6trzfDSCAwqUA
 w8YJIBCvWKuksWJk+JhY30SWE0107ygIlHMwlj6sLb3WZQ6FaxuvwRBRHSGBNb94cIv5
 8XZPhWua6UVPqrMcA/Q+ljLGGARAc++xfEEEJgIhcrH6mJkc3ElYK7I94WevVNW7dTSo
 LNP53z/V0h2q/ow5dFi0HMLplHPtfsBMMA3XB/K/6ociM8KnV9wefoS0NCmR9jwlVNt+
 8RaoNytp7JtaojwAjQ+95KTIKiM/Cf2iDrZb6ied1GBiapkth31ZcDkLwwGELbvNxq3G
 fWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VaMtCuN5DX2vrk7FCjExxTysTHc2r5PaLYKFGuexdoQ=;
 b=BKobjh/0YLDhHPXA8DQMz4aUg3ckVrTfaIKWLWnlzgruWSnQ+KgxzB1vXEVAO3cwGE
 Ayv3woNSWhfOwmTAU4a3cD8XPMNCC3kIBv2zStMOKDeJXgEpxNINp47k036Ztt3z4Rt1
 lEYnRZYPIMRzyzy0ZivXWMTMF86nH1bFYr7ZLRdf4kCt9O4ZooLJQEg1WK3qC/vjrbRk
 p9G2/goVkx3cXDhTi3asmlur86dCzm67PzlN8jW2k24o8EPYIrQxGA2plUsB8E1U8u7C
 VW6/SJCqmWDrOrTWZW/0YTV8t9ZtWSrwnRm0huz84zi8ZP6+xx5gz0Phwhacv+2JSSB5
 1WEQ==
X-Gm-Message-State: APjAAAU1tqsB35/3veCHkx3R1yZRAUX7kPDl1Jqvc0PvG80i+igX0cHv
 2nFLwB4qhV+WCCWtPKKRU4MhIA==
X-Google-Smtp-Source: APXvYqyXGECZN9bQ64SuJurqmzKtVlpo98/KIK1foT3CkZ3gCa9CvRWRSjDo2g0wXY9w7bmpoZabbg==
X-Received: by 2002:a17:90a:9289:: with SMTP id
 n9mr1615460pjo.35.1560812070301; 
 Mon, 17 Jun 2019 15:54:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id w14sm6117694pfn.47.2019.06.17.15.54.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:54:29 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-41-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ef191b63-9553-920d-dbee-80caca80bc5f@linaro.org>
Date: Mon, 17 Jun 2019 15:54:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-41-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v3 40/50] linux-user: support -plugin option
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
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> [ cota: s/instrument/plugin ]
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  linux-user/main.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


