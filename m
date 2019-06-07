Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59ECC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7891D212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hec9sf6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7891D212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKTP-0007uF-PM
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33165)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZIet-0002Tb-CV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZIer-0006Ij-Np
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:28:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZIer-00068I-GE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:28:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id 203so1948846oid.13
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 10:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FcPMB1Arg6zfPt0d37PTD3eMaTlMz5e1OvwO5yTXkwk=;
 b=Hec9sf6J5rc1X5o1gl8UvVRMb+GBUFRNwPdrOMxzukIUi3KRYwPPHJQp+hqXtsjNV3
 JUTJgc+jhdqf5104zdbni2HhOJkU63WxcFPSvdCF8mzzE6iTBbZWYtXE0o23+thEM6wj
 8v07TEmqBlJ8LQM6cyLRKXrtVlfmJcW2KsXuvTM3jZM9R5SdsecVWHhKebqjMqNjbsXX
 Uey/PKfmsz7ngNOJLW49VSXPPxsFrF7gsI23MrX+SL5hTXSwD3Nd25RTY56EEctF0eRM
 naM8+lIB/rm8gCe0VMSAkr5na1IpPt5AaB8vsWUwaoGE1pfb4r8uzBUWOmbdBqtwja4D
 LWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FcPMB1Arg6zfPt0d37PTD3eMaTlMz5e1OvwO5yTXkwk=;
 b=mWkTVDj2shpsO8jgxdnhbQo5KWYJ+8wXEZu5/rarsBAm/ZN4umwnlkNWsApfYzfD9D
 sSuKQQtPjwQJSwOINDjvaoWRQZa4TCtgB76dYUAVlv7hGcIw+JydgN3POn7+q7RTAw4l
 uiTKmiiJ4Cu6m6ss5JZbtcPaLRsmo6+2ZnIKwsd9qfkrt36y5LOPRdfO7YJe3mU2OivL
 8gnVHw3sBvvocFK/GN0TYLg5TdPUzcIFcR7UeeFI9gRb7UpJgno5meZzgBY+V4tH3EYy
 TL8kddohIF7OX8Wv8sXH3x/wiKbs1S3ejTgYdKSMgUDYZHSnDt6QRLppE4Wt2w8dyiGd
 fE9A==
X-Gm-Message-State: APjAAAW3WTG8CeF1dlfojIXOQLXf2rSfHLIkrjANd3AorstGOBctA2V8
 T0ZX+vPNg3VxZvo31x7s/MtH/twSQtDuUg==
X-Google-Smtp-Source: APXvYqwsG0hZ5ckdpEAWiA3x39Her/kZU20X/CZxnG6pnpfxbuGiS7NAzAR0vuvCIZuPNZpwu1Qg3w==
X-Received: by 2002:aca:1817:: with SMTP id h23mr4415858oih.84.1559928483887; 
 Fri, 07 Jun 2019 10:28:03 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id z16sm922000ote.50.2019.06.07.10.28.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 10:28:03 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <47d526bc-7b7f-b2ae-2f6f-1e8fdde7e2e7@linaro.org>
Date: Fri, 7 Jun 2019 12:27:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 12/42] target/arm: Convert
 "double-precision" register moves to decodetree
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the "double-precision" register moves to decodetree:
> this covers VMOV scalar-to-gpreg, VMOV gpreg-to-scalar and VDUP.
> 
> Note that the conversion process has tightened up a few of the
> UNDEF encoding checks: we now correctly forbid:
>  * VMOV-to-gpr with U:opc1:opc2 == 10x00 or x0x10
>  * VMOV-from-gpr with opc1:opc2 == 0x10
>  * VDUP with B:E == 11
>  * VDUP with Q == 1 and Vn<0> == 1
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The accesses of elements < 32 bits could be improved by doing
> direct ld/st of the right size rather than 32-bit read-and-shift
> or read-modify-write, but we leave this for later cleanup,
> since this series is generally trying to stick to fixing
> the decode.
> --
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

