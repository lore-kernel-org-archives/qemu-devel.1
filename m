Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB396C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE41E214AE
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCHEdZ/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE41E214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhGl-0004mb-0z
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38663)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh3V-0000wX-9x
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh3T-0000cj-2L
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:31:09 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh3Q-0000aE-SQ
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:31:06 -0400
Received: by mail-ot1-x342.google.com with SMTP id r10so4925100otd.4
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zhimUqTFYux+e19jXVSmtxmLIMGmKegJ58FRgEvqCVU=;
 b=RCHEdZ/FNPEC4khCeuXSTq8CyTfblIBv6hmDnOXGhrJuqPMlfWVLtVEZOhEo2ZJv/u
 PJBi9Pklvyj7eYx8RlURcgC7sJoPuiIJBLO2sMAcQpORpnw+hGFsEsfb9PsHmjB8P7Fx
 dldeSPDASUBm7cGRIyiWc/SRrmZWqQyD7+Devf6W6/3wJxVl2iL8hU7YXCXnaDtxLBnX
 5bXspOyyEqMjeXWgGZy0sjXY7mTBCsmVY38tfyebvC1XQtIrVb0yXEnFVClPEccMLqp9
 RFcPcPMKIt4YNGUU8hIZ8dbdQfnmNFe+7lNQ39XxR2U0TWrQmiqXehAPiJu9JW5FlEDH
 yB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zhimUqTFYux+e19jXVSmtxmLIMGmKegJ58FRgEvqCVU=;
 b=Y13MgqqVw/k6ZjEWaYYkyDqpgs3u9E6F5zA9SZiHhHQuSjA3RDqdf/j9+TZgXwcFOL
 ZgEQ/rAXq2OPebWxOJEM7kgdg3+QLXFLCJEGXZD8vu4Bs96AJV1TOdhsV3dST3hmno6R
 KD/Rfvi0oluydp5/4uekFbsAVsYkr+g3160/6+gKQDf2lbinMrY7fk/EVW5PovzL+0S6
 sI7D8ZKukQQO+7Vyjrsv6wBcLGV0nXyj3PPM+JnVpAoxWdcIkRpOWPh/B8aiyYvoXTOL
 Vg5ZKbm9Hy6GkUGi/7dfFXH3i/hwgMYMSnB4U3gUC/4Yo83yU4+omMwym9SM5hztNiaY
 o06w==
X-Gm-Message-State: APjAAAX3JNx12Mjh1X2BTSFxSInOhPHDVUfVHQXkgSSWUOEzNxvLwLLZ
 0Y+2bW+vpBdfPiJpI/xAdO51EjSOyT/CXA==
X-Google-Smtp-Source: APXvYqzMhRCXKOhwqkp7s0QdAI8pEkECPO8dlw1q58dZjiZk9cRlrb5GqnK1VTniTnXz2ODduETDsw==
X-Received: by 2002:a9d:2c26:: with SMTP id f35mr24244141otb.362.1560022262636; 
 Sat, 08 Jun 2019 12:31:02 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id f109sm387961otf.34.2019.06.08.12.30.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:31:02 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-41-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <948b4878-acb7-b0e1-510a-a682023864ea@linaro.org>
Date: Sat, 8 Jun 2019 14:22:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-41-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 40/42] target/arm: Convert VCVT
 fp/fixed-point conversion insns to decodetree
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

On 6/6/19 12:46 PM, Peter Maydell wrote:
> Convert the VCVT (between floating-point and fixed-point) instructions
> to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 124 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c         |  57 +--------------
>  target/arm/vfp.decode          |  10 +++
>  3 files changed, 136 insertions(+), 55 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

