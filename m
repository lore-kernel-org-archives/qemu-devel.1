Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E06C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E1020836
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTExFPMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E1020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGgh-0002dY-LP
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52822)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hiGVO-0001iu-9h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hiGVN-0000Y2-Ct
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:59:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hiGVN-0000WV-3n
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:59:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so415401wma.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4ksgFXLm2V4picF6y8O98mbXx4FFmwubuHlJ5yJyT6c=;
 b=HTExFPMdNM4Z/DwAPwFp39QoW94zlCarNlymorXpRSKYyeEQvW568YgmE6GVfYwrLx
 yEsfqHcidogPCBGPb7L2R3npnFnW4sQRvV3kUkhE7DC7Fboh2U4/Ev6oZEw0MQNA1C2N
 UgK+dW+m8+pxXupc87LK0ipvq8QCXi/Yrgra8ZwsYzfXrvvS3oX3LRMUf03B4qKgCLze
 qaLqF/PLAVSPYSoolJ19MaagePmH5WSM1O7rUu2VrCV7lwzdGCmca3U+i7Ta/vix8Bs7
 Jn/p5x33933J8nxl5EVUIrN6F25HlACwTGCkQGBN0Z2due3lZIMZjuR05BVtKPKhujuh
 ZbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4ksgFXLm2V4picF6y8O98mbXx4FFmwubuHlJ5yJyT6c=;
 b=j66gPEl+gKsyf8baAC24qtytpTGshWlagaQSTcDiqNT6RZG9L7ej8h7Enib2Yji2/f
 tLkgZNn6syUwyrAExVQkybRzNE+UMfK0psmGVn39rrNUC77WR9kqixqBw+MsSLVI2I6I
 WV9z35FcyL18rRjO5Gf1riBSH5Tr7v3NxEtMWy8y6HOMdclh78WCUPHPK99Faq30gUVp
 Yb5Bga4gMkp4Q9MrKOUmvUSLvqSmKN9Yh0ZhwYYlVB7HXkM5koGagsaVM6T7omlBeOP+
 pT414M1VyAgeT/AUmJWhDeds+6nUT/lmdU07EvsY+6BaUugIPAgkFqh0f5WJ1y2ETj2E
 sxvQ==
X-Gm-Message-State: APjAAAUliYnnB8UFClKb0V9HFlwzKIQDmpZoKVpP+DqfUt+t3uqjWoQT
 I95BWzzsippof26rPDH5T0u/jUqyNUlsyg==
X-Google-Smtp-Source: APXvYqxT1XsQJFdgbnPw2GWd5Z4t4AzF8IFjgI7xof2PjMlSLaPlev6rw/EQagpxb1T7dyjNjnxcRg==
X-Received: by 2002:a1c:56d7:: with SMTP id k206mr3036715wmb.56.1562065159847; 
 Tue, 02 Jul 2019 03:59:19 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id f7sm16505397wrv.38.2019.07.02.03.59.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 03:59:19 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190702105115.9465-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7896f53a-69f1-8989-f932-734323d8a9b7@linaro.org>
Date: Tue, 2 Jul 2019 12:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190702105115.9465-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Correct VMOV_imm_dp
 handling of short vectors
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

On 7/2/19 12:51 PM, Peter Maydell wrote:
> Coverity points out (CID 1402195) that the loop in trans_VMOV_imm_dp()
> that iterates over the destination registers in a short-vector VMOV
> accidentally throws away the returned updated register number
> from vfp_advance_dreg(). Add the missing assignment. (We got this
> correct in trans_VMOV_imm_sp().)
> 
> Fixes: 18cf951af9a27ae573a
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

