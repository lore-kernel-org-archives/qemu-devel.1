Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63CFC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A9B24673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dT/wo+rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A9B24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4q40-0005r0-IQ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j4q3O-0005P3-Dh
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j4q3N-0004UX-GD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:56:02 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j4q3N-0004U8-9F
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:56:01 -0500
Received: by mail-pj1-x1044.google.com with SMTP id n96so1187976pjc.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v3LWMrwggRkUgp7OdVIwWeeFExXqHLmRK2hoSrW2VLM=;
 b=dT/wo+rtB26lOkKMpb4/EJGQwSvT7PHIwN0dsi4U3tDcMav9L75eUQHBk9SukHVlzh
 Dawz+e+vmrgvfS939nHfxHFER8O1gEVUxHTzAOjKCqWFvFp7Be3GDex9sOiufmkci8wW
 CIGtsdvM02EhlHHYOphsV8guxbcv4tbjSKmDuVx47J65RyayUXwfd4czN6q1V/DhtejH
 hWp+Q1wSOBGyVr60n9xd9CNqHjLHXlBBtiY4sNYTsReogb9AhuF4/RKStJ+2vSFIfDIa
 N9aAfDAKVNsKi0EiKrWLV4c53KnsxuVDMwCcSwxy/A7FddeJqXf1zV0emmQ8UnnlDJHs
 nDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v3LWMrwggRkUgp7OdVIwWeeFExXqHLmRK2hoSrW2VLM=;
 b=qYVVzmn7cAD2BsYmMPwBImutR56Y5hYr0I58Lropb3pJNJlQPmoGcVYoXSpC3vlHfs
 U7Yti1nocr4KzlyPAlYmn5SEv0agPVY0vw8ZEuNcQCqoj2julEu2xCVG0Af76TfTfA01
 +mlF3w5WtCsei1TM4jI4v2y9IylzbeCFOe+OEYSiUOEKIOj7Xvy0jnt6UPhstaNd+q58
 PwkUADdx/V7mVaIglPdSmbmEXyIkPHcpYZyaEkQCByGXxXzMkZ/HaDmwVuQV7kcBdwLV
 wQ5AN+jgznAa+SGoYBWbDf0/lV1oKndkXdsqxj/q/AgBOCSp/T7XxAlaZp18UT578vNQ
 +Q5g==
X-Gm-Message-State: APjAAAVYrnKWAFahxs2oh2fJyMX/RH7BjqCRedPM7al7sIpfVbRajs3U
 OpwuNF1g2ktZsffpdzPdKQTUG94WFxY=
X-Google-Smtp-Source: APXvYqyfLB7O6X5pzEhV+8YzAALe16ErN+un5l5HeHsuiry1TqylHjzxOgI1gac2PSmCtpjdv91l5Q==
X-Received: by 2002:a17:902:b598:: with SMTP id
 a24mr31419819pls.262.1582221358416; 
 Thu, 20 Feb 2020 09:55:58 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z10sm4371470pgf.35.2020.02.20.09.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 09:55:57 -0800 (PST)
Subject: Re: [PATCH 11/19] target/arm: Replace ARM_FEATURE_VFP4 with
 isar_feature_aa32_simdfmac
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-12-richard.henderson@linaro.org>
 <CAFEAcA-fDx8HAFcgx57FhnpHPY6GnC1PxRRW=sLRY=5dDysfiQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <42f05c86-a6a5-2a3f-e40a-da5152e171b6@linaro.org>
Date: Thu, 20 Feb 2020 09:55:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-fDx8HAFcgx57FhnpHPY6GnC1PxRRW=sLRY=5dDysfiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 8:37 AM, Peter Maydell wrote:
> This is tricky, because the SIMDFMAC register
> field indicates "do we have fused-multiply-accumulate
> for either VFP or Neon", so in a VFP-no-Neon core or
> a Neon-no-VFP core it will be 1 but can't be used on its
> own as a gate on "should this insn be present".
> 
> Currently in the part of arm_cpu_realize() which handles
> the user having selected vfp=off and/or neon=off we
> do allow (for AArch32 cores) both of those combinations.
> 
> trans_VFM_dp already tests aa32_fpdp_v2, so I think the
> main thing we need to do is add a test on aa32_fpsp_v2 to
> trans_VFM_sp.
> 
> We clear the SIMDFMAC field to 0 in the !has_neon condition,
> and I think that should actually be in the !neon && !vfp part.
> 
> I propose to squash in the following and beef up the commit message:

Good catch.  Makes sense.


r~

