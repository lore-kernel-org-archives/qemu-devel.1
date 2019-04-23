Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E8C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 23:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47577206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 23:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFcsgH5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47577206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ55d-0006Nl-Ju
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 19:44:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ54J-0005fi-VB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4qc-0002a9-19
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:29:10 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:44549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ4qb-0002Xk-Dz
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:29:09 -0400
Received: by mail-pg1-x536.google.com with SMTP id z16so3753740pgv.11
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mqFFm8SS23sNsFKYjpQxHkuSPY2Dl+H9E8nKXHxPsPU=;
	b=sFcsgH5c25/negQFTqZqTXF24y5nA5w9X4Zv1tlcH6q3zATgr/gPfQ5S+YpYWtYPCc
	GqaGKlQdPlmm4nA5Hdl1lUJjSenGKF+is7VRI5KZXBb/JCt3Uk9oXSctlkih1Qi8ObiW
	d2IYjrM/OiZlemWqZ7lT43Gtb0GFWv79ioLD4hi/JydlhoppmU39yfRTCwpAbcnVcCO/
	70+tKdcpKHFR4tRPljmUoP+hNt06cC+/PMzYCtKV8I3UWoiIu2stLJi6uQjOxj4fdeeQ
	RIN8e/dYpYVztIj8JJ69CVBMQQY+IYPA2Fl2dX/h3BLlitxjGEFxiZ4w7Q2gqnCklcjS
	1o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mqFFm8SS23sNsFKYjpQxHkuSPY2Dl+H9E8nKXHxPsPU=;
	b=p5HS7TgpXO0gpbbzxMvnIgaM9PallOMRYonCUDO3PzMQ4+dpJGE4vIoHK4GAJe+/UF
	wRe85o0KCTKIo8FJ4AkSoH2o/hnkTb2zBN8EpQGyuNRezPdLbKxctS8ZZDqyU0jdPwM5
	e+aWWwOoO+6zpxi7SP6Md9Zy8PmcTL/mxOZihJMT68FBkkGC0LphdXWFa+cTAYBtkG4p
	J0y/sCezTa1Pedo/F3OywzhkuOTszgv+dz4PLBy6WzSIthetMCgwAAEAHqbrzGnFlMcd
	0+U7w7Qi9p8B4GFWhVNoPnqK1WCcFx9X06Mq7YIS/2An7CVkocl6ymwUbuk4mGNzPrup
	onAQ==
X-Gm-Message-State: APjAAAWd/tUPunCeUtJXY+BCMFZ3GaYAIgQLSx9JuVfBy21aI4qaQEc4
	HK+cARkly5fZWLDnCrpdfbZaWUUYePw=
X-Google-Smtp-Source: APXvYqzw8ZKOxFHaXa0enB4o0q8uRbfFLeMyqJXBKWansiiPlM+Tc1+dB4g8h4dpxCIgyicDo/4RRw==
X-Received: by 2002:a62:4115:: with SMTP id o21mr29709813pfa.153.1556062146672;
	Tue, 23 Apr 2019 16:29:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	b63sm46258854pfj.54.2019.04.23.16.29.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 16:29:05 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <eabbae98-49a9-2d7e-5ad0-d1d45fa470f8@linaro.org>
Date: Tue, 23 Apr 2019 16:29:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::536
Subject: Re: [Qemu-devel] [PATCH 15/26] target/arm: Handle floating point
 registers in exception return
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423232903.szwXrd3Eg7ugdrChjK7MlIeecVhgMYXYfs6bJwIznI8@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Handle floating point registers in exception return.
> This corresponds to pseudocode functions ValidateExceptionReturn(),
> ExceptionReturn(), PopStack() and ConsumeExcStackFrame().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 142 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


