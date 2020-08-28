Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD730C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6E0207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R82+2AAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6E0207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBlGa-0002g2-N4
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 16:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBlFU-0001zH-6M
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:45:24 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBlFS-0005Io-Gq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:45:23 -0400
Received: by mail-pg1-x544.google.com with SMTP id v15so987688pgh.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=OmqsRQtTXhM6bGO6amKdqqdEAbO10Ga7F96OOZZfOcA=;
 b=R82+2AAOL6rO83syfVe0Kkph2OzoKobmYfnPZvd6EFchD38w0UQCO0peWNAEjnxnNQ
 lDffFP0kI+DKAk4xIoYEutDeIwOBMZ7wKYRo2VPVVkwfdPO2NTsG0Uhck+CpNvEYTUrR
 kSszSstJ+whOwESg0jYQvpGz6es7jfRjGwVOyFezNS+cQeCSWjQpAOTDOiajFEysAKca
 CedHaYQoSSWA7+j3Vh5J2wBH+jSt7G3TTUTHwWcT6jcPJFEO8Fij8HMYFa4N47Ut2rhV
 tBUGpOhPR0VOgt+m8lcy8084tUs8HVfKXK7lBNkaoXLvPBwtXmNrgihbeZQlDxNEURcF
 Rb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OmqsRQtTXhM6bGO6amKdqqdEAbO10Ga7F96OOZZfOcA=;
 b=GOJFlYZWfv0u3ngbkWH0Jz8SodhVMB6njPo1rvyn9eghukVjPkS2qV0aE1vNaaTFOq
 4gzfEXAxLu5/RK6n/a303YNcFLyjuEQnH4vfHsmfUsuFa5ed23v8IEyRYAiMX+5Sq16T
 zS5o7BjqxVGaneLp+taDyZHB+Be63VaD059N/MAv1bhgm+2PdiQeyONHfXPeMnvQkcqX
 +qvs3gCXeIFZ50/O+QDiQ/s4dwa4wRQBKST1GysO6z0mTsGb7tsZvcoa7Afpy5q951EL
 yjRFuk0JSDN0uxfFREexMdmv+UCw8Fycntk/A0a53nhBRyaXIde8zcWh2fVdjM982u/F
 Fyeg==
X-Gm-Message-State: AOAM532kxo1DT3Zlbt6wToejyp1jNOSNQQTeZ8C6XsxLH2v5j7Ld3dYx
 Twu9H7CDVmCUVM89uVWuHd7QmjUlOk/0dw==
X-Google-Smtp-Source: ABdhPJyZx5KIdDmgtCP9J2HXsfdj30YqPniJd3Q/+tkXEPW0BCREldAwsufT6m38t9M6w3lcwVVAQg==
X-Received: by 2002:a62:7bca:: with SMTP id w193mr672765pfc.152.1598647519689; 
 Fri, 28 Aug 2020 13:45:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e17sm306982pfm.60.2020.08.28.13.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 13:45:18 -0700 (PDT)
Subject: Re: [PATCH v2 26/45] target/arm: Implement fp16 for VCEQ, VCGE, VCGT
 comparisons
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-27-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <725e1cc7-632e-cab1-19a4-431901cef51e@linaro.org>
Date: Fri, 28 Aug 2020 13:45:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-27-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Convert the Neon floating-point vector comparison ops VCEQ,
> VCGE and VCGT over to using a gvec helper and use this to
> implement the fp16 case.
> 
> (We put the float16_ceq() etc functions above the DO_2OP()
> macro definition because later when we convert the
> compare-against-zero instructions we'll want their
> definitions to be visible at that point in the source file.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  9 +++++++
>  target/arm/vec_helper.c         | 44 +++++++++++++++++++++++++++++++++
>  target/arm/translate-neon.c.inc |  6 ++---
>  3 files changed, 56 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


