Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE814C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E862065D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wcsY3MTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E862065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYugt-00057t-Sn
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuff-00048j-CN
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:55:53 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYufe-00089Q-7Z
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:55:50 -0400
Received: by mail-pj1-x1044.google.com with SMTP id z15so2006970pjb.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=bcqeH5QwNT88kDHw25bchRVnVdP4xarT+DvNx3L4FJY=;
 b=wcsY3MTR8k3WSd0YAZyE21KSfAvDFZAc0VDWF3pBPn82ffXWeV2FoNbUTPMRINp+89
 Ef9VDtzykFHTrdHgZCN1J6vfaoryWc9sNbJDNm1D8a02QysOPeFqqe3AFjg3lskedgte
 EIaeDtK1q+KO/xQdNL0pUyhYkujybErgeMU9CdJgrbSSj6G4go5jXoQ2ul94diEJHAou
 D28uNZtq5/VlOKI2fOIItIa0QuMJND65rDX5dIxRWfHkwk3IuuBK5d7MCxOtTIGUh09S
 a4qMKKe6vbIIbXtq36PVJyKLfIFn0INIs1R1qXVpu6cLZnBcM/WkCyHtFtLu9fO50/H8
 3b4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bcqeH5QwNT88kDHw25bchRVnVdP4xarT+DvNx3L4FJY=;
 b=rQiiYDLx0L7v+fjstW1bjLfVO+YP934ElHQqxyievTrWFnFJ/5DupYn7HcNyBAqoE0
 sDFOrfaQAv/cS+tswQygjrTfqHE6CJgyoP29ZM7yrzWZ2NMATKDOOcTTDjDMaQs2flLV
 JDSbbkax3VnGc8IwTLKXQRSF1lDXThjwx259GVQLtvPlj1/9DJ2jAJaJSthTbLMJeIT/
 7sy+Xn5bBxuqxOrYxjVj0Pimedg+9eICm4CvXSoopyxte10Qhw/439EY1fOzq15bhYYV
 8eN2FQQhnNWoEoawE1IKtvDcDdcq4d9gr7YhSSONc77xsf/5nS9y+bl2uaxaVM+Ewaxj
 CkGA==
X-Gm-Message-State: AGi0PuZjdyTwdeOcZrH5SfB/NCOwKFROHqtfDveD1jXcQ1zW3yIVLAWZ
 ulCJvBYVEVGl6HHQfL2qGGeBDLP+Yis=
X-Google-Smtp-Source: APiQypKHl8fQst8PJ8fzj6nv9sbU9d+0aYNzyBI5GqGHmY7rDCV3dS79i2p6b2s1B2c1uFJU1J4HIA==
X-Received: by 2002:a17:90a:6f22:: with SMTP id
 d31mr33336092pjk.14.1589388948498; 
 Wed, 13 May 2020 09:55:48 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t21sm202249pgu.39.2020.05.13.09.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 09:55:47 -0700 (PDT)
Subject: Re: [PATCH v2 07/17] target/arm: Convert Neon VQSHL, VRSHL, VQRSHL
 3-reg-same insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200512163904.10918-1-peter.maydell@linaro.org>
 <20200512163904.10918-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2050bf0-ea3a-9e5c-09a5-f5578fdcc69d@linaro.org>
Date: Wed, 13 May 2020 09:55:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512163904.10918-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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

On 5/12/20 9:38 AM, Peter Maydell wrote:
> Convert the VQSHL, VRSHL and VQRSHL insns in the 3-reg-same
> group to decodetree. We have already implemented the size==0b11
> case of these insns; this commit handles the remaining sizes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 47 +++++++++++++++++++++++----------
>  target/arm/translate-neon.inc.c | 43 ++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 22 +++------------
>  3 files changed, 79 insertions(+), 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I think I'll come back and clean up this split 64/32-bit decode, as well as
converting to pointer-to-qc, but this works for now.


r~

