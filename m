Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF474C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71262081B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgKJ5Z75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71262081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i99jl-0008Nl-Nb
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 11:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i99io-0007oG-7t
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i99in-00014c-7J
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:12:21 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i99in-00014K-0b
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:12:21 -0400
Received: by mail-ed1-x544.google.com with SMTP id i1so29507062edv.4
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3D8YcELWFXsmBw9WwLmt9pF6ot+q0OYHvEKNkAfGDQ8=;
 b=PgKJ5Z75Lw9qcJiSmOpT+Askd6fw19G73mPhNcXal6x+PEmOawNZLKZnFtqdAOxuVT
 rr8ognbG5WZ2A3VVILp8ISzOy0Vxx4Pgag1c7XsgzmvMgThnpw+5ulYZQnm1ZzddFOm8
 ozEq2cz/u1hrnj+x8IyrOaXMGFsL9Z9Hc9yC5LeKwsNEJoImgws6PI00cAFrVADIRb6n
 e39mem+hTs/DEtw8N8KuLdfogw7l93mkU8FDpLNz5xC7UxuueEPy1ivlkfJUlE/gsmJF
 myp/aK7B6ER2xYusvX+Ulcg3Xs/qnAwEEV4AZE6SYSD5PRQyRwmkusKaEMduhuCd0igO
 8Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3D8YcELWFXsmBw9WwLmt9pF6ot+q0OYHvEKNkAfGDQ8=;
 b=isalo50tmznvyPQGo9D7z3pOf7IJdjRnci3gxn2MpERNkfCXX6vwZnVcvI4hp2k5HS
 2OKthIpT2gsXMupMsN5rNfBfwlZYlsJlhOTUPLg9KBbym1LgXeCQqO1B5AoB6j3hWw39
 gd0e98TR1w4hYL2wg+vh91LcpSmkR2PhoCdBaTt5AXFL6S51VEu+naWEqzgYCG8VLnSp
 hIzdujaLaEoWrawg6mq6h34rSNQRJPvymM7hoQR6BBYaa2weq2jbVgiAoYsnWhJa5Kt4
 OdUMwqB7OSoJtgA6IGIT9q+99uMUHa+yTlBj3ryWuxcaN3HCRFWuUa3+75+QI0Q9iQIl
 psVA==
X-Gm-Message-State: APjAAAXl5pqrxlN6NUiJn59h73ntrQ8RVtNuVwfNAWvEZzNAWpdFSY7i
 QBi1aMZQEQ3SvtjLd02nG853zQ==
X-Google-Smtp-Source: APXvYqzo47th+OLsjHBrQzjUbjy8f9VshctK2fdcKsPcmxxE2B2lX/ES1R2fgOXk3ws43z/QTXj+lA==
X-Received: by 2002:a17:906:27cf:: with SMTP id
 k15mr3501654ejc.150.1568473939266; 
 Sat, 14 Sep 2019 08:12:19 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.18])
 by smtp.gmail.com with ESMTPSA id k8sm5981461edn.52.2019.09.14.08.12.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 08:12:18 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190913134935.29696-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6ef910fa-d387-faf3-4647-209beaf7886a@linaro.org>
Date: Sat, 14 Sep 2019 11:12:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913134935.29696-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] tests/tcg: add float_madds test to
 multiarch
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
Cc: 1841592@bugs.launchpad.net, pc@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 9:49 AM, Alex Bennée wrote:
> +                    /* must be built with -O2 to generate fused op */
> +                    r = a * b + c;

I would prefer to use fmaf() or __builtin_fmaf() here.

Although you'll need to link with -lm just in case the
target doesn't support an instruction for fmaf and so
the builtin expands to the standard library call.

I also like Paul's suggestion to use hex float constants.


r~

